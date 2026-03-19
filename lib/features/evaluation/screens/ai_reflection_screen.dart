import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/colors.dart';
import '../../../application/providers/database_provider.dart';
import '../../../application/providers/evaluation_providers.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/db/app_database.dart';
import '../../../data/services/ai_reflection_request_codec.dart';
import '../../../domain/models/ai_reflection.dart';
import '../../../domain/services/ai_reflection_local_fallback.dart';
import '../../../domain/services/ai_reflection_service.dart';
import '../../../shared/widgets/ai/ai_reflection_result_card.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../../shared/widgets/buttons/app_primary_button.dart';
import '../../../shared/widgets/buttons/app_secondary_button.dart';
import '../../../shared/widgets/cards/app_card.dart';

class AiReflectionScreen extends ConsumerStatefulWidget {
  const AiReflectionScreen({
    super.key,
    required this.entryId,
    required this.mode,
  });

  final int entryId;
  final AiReflectionMode mode;

  @override
  ConsumerState<AiReflectionScreen> createState() => _AiReflectionScreenState();
}

class _AiReflectionScreenState extends ConsumerState<AiReflectionScreen> {
  final TextEditingController _replyController = TextEditingController();
  Future<AiReflectionStartState>? _startFuture;
  AiReflectionStartState? _startState;
  AiReflectionResult? _completedResult;
  bool _isCompleting = false;

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final entryAsync = ref.watch(evaluationEntryProvider(widget.entryId));
    final theme = Theme.of(context);

    return AppScaffold(
      title: widget.mode.label,
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: _cancelReflection,
      ),
      body: entryAsync.when(
        data: (entry) {
          if (entry == null) {
            return const Center(child: Text('Eintrag nicht gefunden.'));
          }

          _startFuture ??= _ensureSessionStarted(entry);

          if (_completedResult != null) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(AppConstants.spacingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppCard(
                    variant: AppCardVariant.glass,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ergebnis gespeichert',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: AppConstants.spacingSmall),
                        Text(
                          'Die KI-Nachreflexion wurde an diesem Eintrag gespeichert und ist in der Detailansicht wieder sichtbar.',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingLarge),
                  AiReflectionResultCard(result: _completedResult!),
                  const SizedBox(height: AppConstants.spacingLarge),
                  AppPrimaryButton(
                    onPressed: () => context.pop(),
                    label: 'Zur Auswertung',
                  ),
                ],
              ),
            );
          }

          return FutureBuilder<AiReflectionStartState>(
            future: _startFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return _buildErrorState(
                  context: context,
                  message: _errorMessage(snapshot.error),
                );
              }

              final startState = snapshot.data;
              if (startState == null) {
                return _buildErrorState(
                  context: context,
                  message:
                      'Die KI-Nachreflexion konnte nicht gestartet werden.',
                );
              }

              final start = startState.content;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(AppConstants.spacingMedium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppCard(
                      variant: AppCardVariant.glass,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.mode.title,
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: AppConstants.spacingSmall),
                          Text(
                            widget.mode.shortDescription,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppConstants.spacingLarge),
                    Text(
                      'Schritt 1 von 2',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppConstants.spacingSmall),
                    AppCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Was die KI aus dem Eintrag sieht',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: AppConstants.spacingSmall),
                          Text(start.observation),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppConstants.spacingMedium),
                    AppCard(
                      variant: AppCardVariant.soft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Fokussierte Rückfrage',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: AppConstants.spacingSmall),
                          Text(start.question),
                          if (start.helperStarters.isNotEmpty) ...[
                            const SizedBox(height: AppConstants.spacingMedium),
                            Wrap(
                              spacing: AppConstants.spacingSmall,
                              runSpacing: AppConstants.spacingSmall,
                              children: start.helperStarters
                                  .map(
                                    (starter) => ActionChip(
                                      label: Text(starter),
                                      onPressed: () {
                                        final current =
                                            _replyController.text.trim();
                                        setState(() {
                                          _replyController.text =
                                              current.isEmpty
                                                  ? '$starter '
                                                  : '$current $starter ';
                                          _replyController.selection =
                                              TextSelection.collapsed(
                                            offset:
                                                _replyController.text.length,
                                          );
                                        });
                                      },
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: AppConstants.spacingMedium),
                    TextField(
                      controller: _replyController,
                      maxLines: 5,
                      maxLength: 320,
                      decoration: InputDecoration(
                        hintText: 'Antworte kurz und so konkret wie möglich.',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            AppConstants.borderRadius,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppConstants.spacingLarge),
                    Row(
                      children: [
                        Expanded(
                          child: AppSecondaryButton(
                            onPressed: _cancelReflection,
                            label: 'Abbrechen',
                          ),
                        ),
                        const SizedBox(width: AppConstants.spacingMedium),
                        Expanded(
                          child: AppSecondaryButton(
                            onPressed: _deferReflection,
                            label: 'Später merken',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppConstants.spacingMedium),
                    AppPrimaryButton(
                      onPressed: _isCompleting
                          ? null
                          : () => _completeReflection(entry),
                      isLoading: _isCompleting,
                      label: 'Verdichten',
                    ),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Fehler beim Laden des Eintrags: $error'),
        ),
      ),
    );
  }

  Widget _buildErrorState({
    required BuildContext context,
    required String message,
  }) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.spacingMedium),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppConstants.spacingLarge),
          AppPrimaryButton(
            onPressed: () async {
              await ref.read(databaseProvider).clearAiReflectionInProgress(
                    entryId: widget.entryId,
                  );
              setState(() {
                _startState = null;
                _startFuture = null;
                _replyController.clear();
              });
            },
            label: 'Erneut versuchen',
          ),
          const SizedBox(height: AppConstants.spacingSmall),
          AppSecondaryButton(
            onPressed: _deferReflection,
            label: 'Später merken',
          ),
        ],
      ),
    );
  }

  Future<AiReflectionStartState> _ensureSessionStarted(
    SituationEntryData entry,
  ) async {
    final inputHash = computeAiReflectionInputHash(
      entry: entry,
      mode: widget.mode,
    );
    final cached = _cachedStartStateFor(
      entry: entry,
      inputHash: inputHash,
    );
    if (cached != null) {
      _startState = cached;
      return cached;
    }

    final sessionId = _newSessionId();
    final startedAt = DateTime.now().toUtc();
    final db = ref.read(databaseProvider);
    await db.markAiReflectionInProgress(
      entryId: entry.id,
      mode: widget.mode,
      sessionId: sessionId,
      inputHash: inputHash,
      startedAt: startedAt,
    );
    ref.invalidate(evaluationEntryProvider(entry.id));

    final service = ref.read(aiReflectionServiceProvider);

    try {
      final startState = service == null
          ? AiReflectionLocalFallback.buildStartState(
              entry: entry,
              mode: widget.mode,
              sessionId: sessionId,
              inputHash: inputHash,
              startedAt: startedAt,
            )
          : await _loadStartStateFromService(
              service: service,
              entry: entry,
              sessionId: sessionId,
              inputHash: inputHash,
              startedAt: startedAt,
            );

      final persisted = await db.saveAiReflectionStartContent(
        entryId: entry.id,
        sessionId: startState.sessionId,
        inputHash: startState.inputHash,
        mode: widget.mode,
        content: startState.content,
        provider: startState.provider,
        model: startState.model,
        schemaVersion: startState.schemaVersion,
        startedAt: startState.startedAt,
      );
      if (!persisted) {
        throw const AiReflectionException(
          'Die Nachreflexion wurde zwischenzeitlich verändert. Bitte starte sie neu.',
          code: AiReflectionErrorCode.staleSession,
        );
      }

      ref.invalidate(evaluationEntryProvider(entry.id));
      _startState = startState;

      if (service == null && mounted) {
        _showMessage(
          'Die Rückfrage wurde lokal vorbereitet, weil gerade keine KI-Verbindung verfügbar ist.',
        );
      }

      return startState;
    } on AiReflectionException catch (error) {
      if (AiReflectionLocalFallback.shouldUseFallback(error) &&
          service != null) {
        final fallback = AiReflectionLocalFallback.buildStartState(
          entry: entry,
          mode: widget.mode,
          sessionId: sessionId,
          inputHash: inputHash,
          startedAt: startedAt,
        );
        final persisted = await db.saveAiReflectionStartContent(
          entryId: entry.id,
          sessionId: fallback.sessionId,
          inputHash: fallback.inputHash,
          mode: widget.mode,
          content: fallback.content,
          provider: fallback.provider,
          model: fallback.model,
          schemaVersion: fallback.schemaVersion,
          startedAt: fallback.startedAt,
        );
        if (!persisted) {
          throw const AiReflectionException(
            'Die Nachreflexion wurde zwischenzeitlich verändert. Bitte starte sie neu.',
            code: AiReflectionErrorCode.staleSession,
          );
        }

        ref.invalidate(evaluationEntryProvider(entry.id));
        _startState = fallback;
        if (mounted) {
          _showMessage(
            'Die Rückfrage wurde lokal vorbereitet, weil die KI gerade nicht erreichbar war.',
          );
        }
        return fallback;
      }

      await db.markAiReflectionFailed(
        entryId: entry.id,
        sessionId: sessionId,
        inputHash: inputHash,
        phase: AiReflectionPhase.failedStart,
        errorCode: error.code,
        message: error.message,
        keepInProgress: false,
      );
      ref.invalidate(evaluationEntryProvider(entry.id));
      rethrow;
    } catch (_) {
      await db.markAiReflectionFailed(
        entryId: entry.id,
        sessionId: sessionId,
        inputHash: inputHash,
        phase: AiReflectionPhase.failedStart,
        errorCode: AiReflectionErrorCode.unknown,
        message: 'Die KI-Nachreflexion konnte nicht gestartet werden.',
        keepInProgress: false,
      );
      ref.invalidate(evaluationEntryProvider(entry.id));
      rethrow;
    }
  }

  Future<void> _completeReflection(SituationEntryData entry) async {
    final reply = _replyController.text.trim();
    if (reply.isEmpty) {
      _showMessage('Bitte antworte erst kurz auf die fokussierte Rückfrage.');
      return;
    }

    setState(() {
      _isCompleting = true;
    });

    final service = ref.read(aiReflectionServiceProvider);

    try {
      final startState =
          _startState ?? await (_startFuture ?? _ensureSessionStarted(entry));
      _startState = startState;

      final markedPending =
          await ref.read(databaseProvider).markAiReflectionCompletePending(
                entryId: entry.id,
                sessionId: startState.sessionId,
                inputHash: startState.inputHash,
              );
      if (!markedPending) {
        throw const AiReflectionException(
          'Die Nachreflexion wurde zwischenzeitlich verändert. Bitte starte sie neu.',
          code: AiReflectionErrorCode.staleSession,
        );
      }
      ref.invalidate(evaluationEntryProvider(entry.id));

      final response = await _completeWithServiceOrFallback(
        entry: entry,
        reply: reply,
        service: service,
      );

      final persisted =
          await ref.read(databaseProvider).saveAiReflectionCompleted(
                entryId: entry.id,
                mode: widget.mode,
                sessionId: startState.sessionId,
                inputHash: startState.inputHash,
                provider: response.provider,
                model: response.model,
                schemaVersion: response.schemaVersion,
                result: response.result,
                completedAt: response.completedAt,
              );
      if (!persisted) {
        throw const AiReflectionException(
          'Die Nachreflexion wurde zwischenzeitlich verändert. Bitte starte sie neu.',
          code: AiReflectionErrorCode.staleSession,
        );
      }

      ref.invalidate(evaluationEntryProvider(entry.id));
      if ((response.provider == AiReflectionLocalFallback.provider) &&
          mounted) {
        _showMessage(
          'Die Verdichtung wurde lokal gespeichert, weil die KI gerade nicht erreichbar war.',
        );
      }
      setState(() {
        _completedResult = response.result;
      });
    } on AiReflectionException catch (error) {
      final startState = _startState;
      if (startState != null) {
        await ref.read(databaseProvider).markAiReflectionFailed(
              entryId: entry.id,
              sessionId: startState.sessionId,
              inputHash: startState.inputHash,
              phase: AiReflectionPhase.failedComplete,
              errorCode: error.code,
              message: error.message,
              keepInProgress: error.code != AiReflectionErrorCode.staleSession,
            );
        ref.invalidate(evaluationEntryProvider(entry.id));
      }
      _showMessage(error.message);
    } catch (_) {
      _showMessage(
        'Die KI-Nachreflexion konnte gerade nicht abgeschlossen werden.',
      );
    } finally {
      if (mounted) {
        setState(() {
          _isCompleting = false;
        });
      }
    }
  }

  Future<AiReflectionCompleteResponse> _completeWithServiceOrFallback({
    required SituationEntryData entry,
    required String reply,
    required AiReflectionService? service,
  }) async {
    if (service == null) {
      return _buildLocalCompleteResponse(
        entry: entry,
        reply: reply,
      );
    }

    try {
      return await service.completeReflection(
        entry: entry,
        mode: widget.mode,
        userReply: reply,
      );
    } on AiReflectionException catch (error) {
      if (AiReflectionLocalFallback.shouldUseFallback(error)) {
        return _buildLocalCompleteResponse(
          entry: entry,
          reply: reply,
        );
      }
      rethrow;
    }
  }

  AiReflectionCompleteResponse _buildLocalCompleteResponse({
    required SituationEntryData entry,
    required String reply,
  }) {
    return AiReflectionCompleteResponse(
      provider: AiReflectionLocalFallback.provider,
      model: AiReflectionLocalFallback.model,
      schemaVersion: AiReflectionLocalFallback.schemaVersion,
      completedAt: DateTime.now().toUtc(),
      result: AiReflectionLocalFallback.buildResult(
        entry: entry,
        mode: widget.mode,
        userReply: reply,
      ),
    );
  }

  Future<void> _deferReflection() async {
    final now = DateTime.now().toUtc();
    await ref.read(databaseProvider).markAiReflectionDeferred(
          entryId: widget.entryId,
          mode: widget.mode,
          deferredAt: now,
          resumeSuggestedAt: now.add(const Duration(hours: 6)),
        );
    ref.invalidate(evaluationEntryProvider(widget.entryId));
    if (!mounted) {
      return;
    }
    _showMessage('Für spätere Nachreflexion vorgemerkt.');
    context.pop();
  }

  Future<void> _cancelReflection() async {
    await ref.read(databaseProvider).clearAiReflectionInProgress(
          entryId: widget.entryId,
        );
    ref.invalidate(evaluationEntryProvider(widget.entryId));
    if (!mounted) {
      return;
    }
    context.pop();
  }

  String _errorMessage(Object? error) {
    if (error is AiReflectionException) {
      return error.message;
    }
    return 'Die KI-Nachreflexion konnte nicht gestartet werden.';
  }

  Future<AiReflectionStartState> _loadStartStateFromService({
    required AiReflectionService service,
    required SituationEntryData entry,
    required String sessionId,
    required String inputHash,
    required DateTime startedAt,
  }) async {
    final response = await service.startReflection(
      entry: entry,
      mode: widget.mode,
    );
    return AiReflectionStartState(
      sessionId: sessionId,
      inputHash: inputHash,
      content: response.content,
      provider: response.provider,
      model: response.model,
      schemaVersion: response.schemaVersion,
      startedAt: startedAt,
    );
  }

  AiReflectionStartState? _cachedStartStateFor({
    required SituationEntryData entry,
    required String inputHash,
  }) {
    final status = AiReflectionStatus.fromRaw(entry.aiReflectionStatus);
    final phase = AiReflectionPhase.fromRaw(entry.aiReflectionPhase);
    final sessionId = entry.aiReflectionSessionId?.trim();
    final observation = entry.aiReflectionStartObservation?.trim();
    final question = entry.aiReflectionStartQuestion?.trim();

    if (entry.aiReflectionMode != widget.mode.name ||
        entry.aiReflectionInputHash != inputHash ||
        sessionId == null ||
        sessionId.isEmpty ||
        observation == null ||
        observation.isEmpty ||
        question == null ||
        question.isEmpty ||
        (status != AiReflectionStatus.inProgress &&
            status != AiReflectionStatus.deferred) ||
        (phase != AiReflectionPhase.readyForReply &&
            phase != AiReflectionPhase.completePending &&
            phase != AiReflectionPhase.failedComplete)) {
      return null;
    }

    return AiReflectionStartState(
      sessionId: sessionId,
      inputHash: inputHash,
      content: AiReflectionStartContent(
        observation: observation,
        question: question,
        helperStarters: _decodeStartHelperStarters(
          entry.aiReflectionStartHelperStarters,
        ),
      ),
      provider: _nonEmptyOrFallback(
        entry.aiReflectionProvider,
        AiReflectionLocalFallback.provider,
      ),
      model: _nonEmptyOrFallback(
        entry.aiReflectionModel,
        AiReflectionLocalFallback.model,
      ),
      schemaVersion: entry.aiReflectionSchemaVersion ??
          AiReflectionLocalFallback.schemaVersion,
      startedAt: entry.aiReflectionStartedAt ?? DateTime.now().toUtc(),
    );
  }

  List<String> _decodeStartHelperStarters(String? raw) {
    if (raw == null || raw.trim().isEmpty) {
      return const [];
    }

    try {
      final decoded = jsonDecode(raw);
      if (decoded is List) {
        return decoded
            .whereType<String>()
            .map((value) => value.trim())
            .where((value) => value.isNotEmpty)
            .toList(growable: false);
      }
    } catch (_) {
      return const [];
    }

    return const [];
  }

  String _newSessionId() {
    final random = Random.secure().nextInt(1 << 32).toRadixString(16);
    final micros = DateTime.now().toUtc().microsecondsSinceEpoch;
    return 'air-$micros-$random';
  }

  String _nonEmptyOrFallback(String? value, String fallback) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return fallback;
    }
    return trimmed;
  }

  void _showMessage(String message) {
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
