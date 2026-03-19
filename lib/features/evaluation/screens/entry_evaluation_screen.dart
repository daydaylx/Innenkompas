import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:innenkompass/app/router.dart';
import 'package:innenkompass/application/providers/database_provider.dart';
import 'package:innenkompass/application/providers/evaluation_providers.dart';
import 'package:innenkompass/application/providers/intervention_providers.dart';
import 'package:innenkompass/application/providers/new_situation_providers.dart';
import 'package:innenkompass/core/config/ai_evaluation_config.dart';
import 'package:innenkompass/core/constants/app_constants.dart';
import 'package:innenkompass/core/constants/intervention_types.dart';
import 'package:innenkompass/core/constants/system_states.dart';
import 'package:innenkompass/data/db/app_database.dart';
import 'package:innenkompass/domain/models/ai_evaluation.dart';
import 'package:innenkompass/domain/models/intervention_library.dart';
import 'package:innenkompass/domain/services/ai_evaluation_service.dart';
import 'package:innenkompass/domain/services/pattern_analyzer.dart';
import 'package:innenkompass/shared/widgets/app_scaffold.dart';
import 'package:innenkompass/shared/widgets/buttons/app_primary_button.dart';
import 'package:innenkompass/shared/widgets/buttons/app_secondary_button.dart';

/// Zeigt die Sofort-Auswertung für einen gespeicherten Eintrag.
class EntryEvaluationScreen extends ConsumerStatefulWidget {
  const EntryEvaluationScreen({
    super.key,
    required this.entryId,
  });

  final int entryId;

  @override
  ConsumerState<EntryEvaluationScreen> createState() =>
      _EntryEvaluationScreenState();
}

class _EntryEvaluationScreenState extends ConsumerState<EntryEvaluationScreen> {
  String? _selectedActionKey;
  bool _isSavingAction = false;
  bool _isRequestingAi = false;
  bool _aiConsentChecked = false;
  int _aiRequestToken = 0;

  @override
  void dispose() {
    _aiRequestToken++;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final entryAsync = ref.watch(evaluationEntryProvider(widget.entryId));
    final contentAsync = ref.watch(evaluationContentProvider);
    final aiConfig = ref.watch(aiEvaluationConfigProvider);
    final hasAiService = ref.watch(aiEvaluationServiceProvider) != null;

    return AppScaffold(
      title: 'Deine Auswertung',
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: _finishWithoutIntervention,
      ),
      body: entryAsync.when(
        data: (entry) {
          if (entry == null) {
            return const Center(
              child: Text('Eintrag nicht gefunden.'),
            );
          }

          return contentAsync.when(
            data: (content) {
              final tipIds = _decodeTipIds(entry.suggestedTipIds);
              final statusKeys = _decodeTipIds(entry.evaluationStatusKeys);
              final nextActionOptions = [
                entry.suggestedNextActionKey,
                entry.selectedNextActionKey,
              ]
                  .whereType<String>()
                  .followedBy(
                    PatternAnalyzer.nextActionFallbacks(
                      suggestedNextActionKey: entry.suggestedNextActionKey,
                      systemStateName: entry.systemState,
                    ),
                  )
                  .toSet()
                  .take(3)
                  .toList(growable: false);

              final selectedActionKey = _selectedActionKey ??
                  entry.selectedNextActionKey ??
                  entry.suggestedNextActionKey;

              final hasIntervention = entry.interventionType != null;

              return SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  AppConstants.spacingMedium,
                  AppConstants.spacingSmall,
                  AppConstants.spacingMedium,
                  AppConstants.spacingXLarge,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (statusKeys.isNotEmpty) ...[
                      Wrap(
                        spacing: AppConstants.spacingSmall,
                        runSpacing: AppConstants.spacingSmall,
                        children: statusKeys
                            .map(
                              (statusKey) => Chip(
                                label: Text(content.statusLabelFor(statusKey)),
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: AppConstants.spacingMedium),
                    ],
                    _InfoCard(
                      title: 'Was auffällt',
                      icon: Icons.visibility_outlined,
                      body: content.standOutFor(
                        entry.evaluationHeadlineKey ?? 'reflection_reachable',
                      ),
                    ),
                    const SizedBox(height: AppConstants.spacingMedium),
                    _InfoCard(
                      title: 'Was dahinter liegen könnte',
                      icon: Icons.psychology_alt_outlined,
                      body: content.backgroundFor(
                        entry.evaluationMeaningKey ?? 'background_unknown',
                      ),
                    ),
                    const SizedBox(height: AppConstants.spacingMedium),
                    _InfoCard(
                      title: 'Was jetzt hilfreicher ist als weitere Analyse',
                      icon: Icons.self_improvement_outlined,
                      body: content.helpfulNowFor(
                        entry.evaluationHelpfulNowKey ??
                            'helpful_choose_small_step',
                      ),
                    ),
                    const SizedBox(height: AppConstants.spacingMedium),
                    _InfoCard(
                      title: 'Lernpunkt / frühester möglicher Abzweig',
                      icon: Icons.alt_route_outlined,
                      body: content.learningPointFor(
                        entry.evaluationLearningPointKey ??
                            'learning_build_pause',
                      ),
                    ),
                    const SizedBox(height: AppConstants.spacingLarge),
                    _SectionCard(
                      title: 'Praktische Tipps',
                      child: Column(
                        children: tipIds
                            .map((tipId) => _TipRow(
                                  text: content.tipFor(tipId),
                                ))
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: AppConstants.spacingMedium),
                    _SectionCard(
                      title: 'Nächster Schritt',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if ((entry.nextStep ?? '').isNotEmpty) ...[
                            Text(
                              'Dein notierter Schritt',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 4),
                            Text(entry.nextStep!),
                            const SizedBox(height: AppConstants.spacingMedium),
                          ],
                          ...nextActionOptions.map(
                            (actionKey) => RadioListTile<String>(
                              value: actionKey,
                              groupValue: selectedActionKey,
                              onChanged: (value) {
                                if (value == null) return;
                                setState(() {
                                  _selectedActionKey = value;
                                });
                              },
                              title: Text(content.nextActionFor(actionKey)),
                              subtitle:
                                  actionKey == entry.suggestedNextActionKey
                                      ? const Text('Lokal vorgeschlagen')
                                      : null,
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppConstants.spacingMedium),
                    _buildAiSection(
                      context: context,
                      entry: entry,
                      aiConfig: aiConfig,
                      hasAiService: hasAiService,
                    ),
                    const SizedBox(height: AppConstants.spacingLarge),
                    if (hasIntervention)
                      AppPrimaryButton(
                        onPressed: _isSavingAction
                            ? null
                            : () => _startIntervention(
                                  selectedActionKey,
                                  entry.interventionType!,
                                ),
                        label: 'Passende Übung starten',
                        isLoading: _isSavingAction,
                      ),
                    if (hasIntervention)
                      const SizedBox(height: AppConstants.spacingSmall),
                    AppSecondaryButton(
                      onPressed:
                          _isSavingAction ? null : _finishWithoutIntervention,
                      label:
                          hasIntervention ? 'Für jetzt abschließen' : 'Fertig',
                    ),
                  ],
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(
              child: Text('Fehler beim Laden der Auswertung: $error'),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Fehler beim Laden des Eintrags: $error'),
        ),
      ),
    );
  }

  Future<void> _persistSelectedAction(String? actionKey) async {
    if (actionKey == null) {
      return;
    }

    setState(() {
      _isSavingAction = true;
    });
    try {
      final db = ref.read(databaseProvider);
      await db.updateSelectedNextAction(
        entryId: widget.entryId,
        selectedNextActionKey: actionKey,
      );
      ref.invalidate(evaluationEntryProvider(widget.entryId));
      ref.invalidate(narrativeInsightsProvider);
    } finally {
      if (mounted) {
        setState(() {
          _isSavingAction = false;
        });
      }
    }
  }

  Future<void> _startIntervention(
    String? actionKey,
    String interventionTypeRaw,
  ) async {
    _detachAiRequest();
    await _persistSelectedAction(actionKey);
    if (!mounted) return;

    final interventionType = InterventionType.values
        .where((type) => type.name == interventionTypeRaw)
        .firstOrNull;
    if (interventionType == null) {
      await _finishWithoutIntervention();
      return;
    }

    final intervention =
        InterventionLibrary.getByType(interventionType).firstOrNull;
    if (intervention == null) {
      await _finishWithoutIntervention();
      return;
    }

    ref
        .read(interventionFlowStateProvider.notifier)
        .startIntervention(intervention, entryId: widget.entryId);
    context.push(AppRoutes.intervention);
  }

  Future<void> _finishWithoutIntervention() async {
    _detachAiRequest();
    final actionKey = _selectedActionKey;
    await _persistSelectedAction(actionKey);
    ref.read(newSituationFlowControllerProvider.notifier).reset();
    if (!mounted) return;
    context.go(AppRoutes.home);
  }

  Widget _buildAiSection({
    required BuildContext context,
    required SituationEntryData entry,
    required AiEvaluationConfig aiConfig,
    required bool hasAiService,
  }) {
    final aiStatus = AiEvaluationStatus.fromRaw(entry.aiEvaluationStatus);
    final aiContent = AiEvaluationContent.tryParse(entry.aiEvaluationText);
    final consentGranted = entry.aiEvaluationConsentGiven || _aiConsentChecked;
    final isStalePending = aiStatus?.isPendingStale(
          requestedAt: entry.aiEvaluationRequestedAt,
        ) ??
        false;
    final aiBlocked =
        entry.isCrisis || entry.systemState == SystemState.crisis.name;
    final isLoading = _isRequestingAi ||
        (aiStatus == AiEvaluationStatus.pending && !isStalePending);

    if (aiBlocked) {
      return const _SectionCard(
        title: 'Freie KI-Einordnung',
        child: Text(
          'Für Einträge mit akuter Krise bleibt es bewusst bei der lokalen Auswertung. '
          'Die freie KI-Einordnung ist hier deaktiviert.',
        ),
      );
    }

    if (!aiConfig.isEnabled || !hasAiService) {
      return const _SectionCard(
        title: 'Freie KI-Einordnung',
        child: Text(
          'Diese Build-Konfiguration hat noch keine funktionsfähige KI-Konfiguration hinterlegt. '
          'Die lokale Auswertung funktioniert trotzdem vollständig.',
        ),
      );
    }

    if (isLoading) {
      return const _SectionCard(
        title: 'Freie KI-Einordnung',
        child: Row(
          children: [
            SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            SizedBox(width: AppConstants.spacingMedium),
            Expanded(
              child: Text(
                'Die freie Einordnung wird gerade erstellt und danach direkt an diesem Eintrag gespeichert.',
              ),
            ),
          ],
        ),
      );
    }

    if (isStalePending) {
      return _SectionCard(
        title: 'Freie KI-Einordnung',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Die letzte KI-Anfrage wurde nicht abgeschlossen. Du kannst die Einordnung erneut anfordern.',
            ),
            if (entry.aiEvaluationConsentGiven) ...[
              const SizedBox(height: AppConstants.spacingSmall),
              const Text(
                'Für den neuen Versuch wird deine bereits gespeicherte Datenfreigabe verwendet.',
              ),
            ],
            const SizedBox(height: AppConstants.spacingMedium),
            AppPrimaryButton(
              onPressed: consentGranted && !_isRequestingAi
                  ? () => _requestAiEvaluation(entry)
                  : null,
              label: 'Erneut anfordern',
              isLoading: _isRequestingAi,
            ),
          ],
        ),
      );
    }

    if (aiStatus == AiEvaluationStatus.success && aiContent != null) {
      return _SectionCard(
        title: 'Freie KI-Einordnung',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _AiMetaLine(
              provider: entry.aiEvaluationProvider ?? aiConfig.provider,
              model: entry.aiEvaluationModel ?? aiConfig.model,
              completedAt: entry.aiEvaluationCompletedAt,
            ),
            const SizedBox(height: AppConstants.spacingMedium),
            _AiParagraph(
              label: 'Was auffällt',
              text: aiContent.wasAuffaellt,
            ),
            const SizedBox(height: AppConstants.spacingMedium),
            _AiParagraph(
              label: 'Einordnung',
              text: aiContent.einordnung,
            ),
            const SizedBox(height: AppConstants.spacingMedium),
            _AiParagraph(
              label: 'Praktisch hilfreich',
              text: aiContent.praktischHilfreich,
            ),
            if (aiContent.hasVorsichtshinweis) ...[
              const SizedBox(height: AppConstants.spacingMedium),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppConstants.spacingMedium),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(
                    AppConstants.borderRadius,
                  ),
                ),
                child: Text(
                  aiContent.vorsichtshinweis!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ],
        ),
      );
    }

    if (aiStatus == AiEvaluationStatus.failed) {
      return _SectionCard(
        title: 'Freie KI-Einordnung',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Die freie KI-Einordnung konnte für diesen Eintrag zuletzt nicht geladen werden. '
              'Die lokale Auswertung bleibt vollständig erhalten.',
            ),
            if (entry.aiEvaluationConsentGiven) ...[
              const SizedBox(height: AppConstants.spacingSmall),
              const Text(
                'Für einen neuen Versuch wird deine bereits gespeicherte Datenfreigabe verwendet.',
              ),
            ],
            const SizedBox(height: AppConstants.spacingMedium),
            AppPrimaryButton(
              onPressed:
                  _isRequestingAi ? null : () => _requestAiEvaluation(entry),
              label: 'Erneut anfordern',
              isLoading: _isRequestingAi,
            ),
          ],
        ),
      );
    }

    return _SectionCard(
      title: 'Freie KI-Einordnung',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Optional kannst du dir zu diesem Eintrag eine freie KI-Einordnung holen. '
            'Sie ergänzt die lokale Regel-Auswertung, ersetzt aber keine Diagnose oder Krisenhilfe.',
          ),
          const SizedBox(height: AppConstants.spacingMedium),
          CheckboxListTile(
            value: consentGranted,
            onChanged: entry.aiEvaluationConsentGiven
                ? null
                : (value) {
                    setState(() {
                      _aiConsentChecked = value ?? false;
                    });
                  },
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            title: const Text(
              'Ich stimme zu, dass dieser Eintrag inklusive Freitexten an die konfigurierte KI-Verbindung gesendet und am Eintrag gespeichert wird.',
            ),
          ),
          const SizedBox(height: AppConstants.spacingSmall),
          AppPrimaryButton(
            onPressed: consentGranted && !_isRequestingAi
                ? () => _requestAiEvaluation(entry)
                : null,
            label: 'KI-Einordnung anfordern',
            isLoading: _isRequestingAi,
          ),
        ],
      ),
    );
  }

  Future<void> _requestAiEvaluation(SituationEntryData entry) async {
    if (entry.isCrisis || entry.systemState == SystemState.crisis.name) {
      _showMessage(
        'Für akute Kriseneinträge bleibt die freie KI-Einordnung deaktiviert.',
      );
      return;
    }

    final service = ref.read(aiEvaluationServiceProvider);
    if (service == null) {
      _showMessage(
        'In dieser Build-Konfiguration ist noch keine funktionsfähige KI-Konfiguration hinterlegt.',
      );
      return;
    }

    final consentGranted = entry.aiEvaluationConsentGiven || _aiConsentChecked;
    if (!consentGranted) {
      _showMessage(
          'Bitte bestätige zuerst die Datenfreigabe für diesen Eintrag.');
      return;
    }

    setState(() {
      _isRequestingAi = true;
    });

    final db = ref.read(databaseProvider);
    final container = ProviderScope.containerOf(context, listen: false);
    final requestedAt = DateTime.now();
    final requestToken = ++_aiRequestToken;
    await db.markAiEvaluationPending(
      entryId: widget.entryId,
      consentGiven: true,
      requestedAt: requestedAt,
    );
    container.invalidate(evaluationEntryProvider(widget.entryId));

    if (!_isCurrentAiRequest(requestToken)) {
      await _markAiRequestAbandoned(db: db, container: container);
      return;
    }

    try {
      final response = await service.evaluateEntry(entry: entry);
      if (!_isCurrentAiRequest(requestToken)) {
        await _markAiRequestAbandoned(db: db, container: container);
        return;
      }

      await db.saveAiEvaluationSuccess(
        entryId: widget.entryId,
        provider: response.provider,
        model: response.model,
        schemaVersion: response.schemaVersion,
        content: response.content,
        completedAt: response.completedAt,
      );
      container.invalidate(evaluationEntryProvider(widget.entryId));

      if (_isCurrentAiRequest(requestToken) && mounted) {
        setState(() {
          _aiConsentChecked = false;
        });
        _showMessage('Die freie KI-Einordnung wurde gespeichert.');
      }
    } on AiEvaluationException catch (error) {
      if (!_isCurrentAiRequest(requestToken)) {
        await _markAiRequestAbandoned(db: db, container: container);
        return;
      }

      await db.markAiEvaluationFailed(
        entryId: widget.entryId,
        completedAt: DateTime.now(),
      );
      container.invalidate(evaluationEntryProvider(widget.entryId));
      _showMessage(error.message);
    } catch (_) {
      if (!_isCurrentAiRequest(requestToken)) {
        await _markAiRequestAbandoned(db: db, container: container);
        return;
      }

      await db.markAiEvaluationFailed(
        entryId: widget.entryId,
        completedAt: DateTime.now(),
      );
      container.invalidate(evaluationEntryProvider(widget.entryId));
      _showMessage(
          'Die freie KI-Einordnung konnte gerade nicht gespeichert werden.');
    } finally {
      if (_isCurrentAiRequest(requestToken) && mounted) {
        setState(() {
          _isRequestingAi = false;
        });
      }
    }
  }

  bool _isCurrentAiRequest(int token) => token == _aiRequestToken;

  void _detachAiRequest() {
    if (!_isRequestingAi) {
      return;
    }

    _aiRequestToken++;
    if (mounted) {
      setState(() {
        _isRequestingAi = false;
      });
    }
  }

  Future<void> _markAiRequestAbandoned({
    required AppDatabase db,
    required ProviderContainer container,
  }) async {
    await db.markAiEvaluationFailed(
      entryId: widget.entryId,
      completedAt: DateTime.now(),
    );
    container.invalidate(evaluationEntryProvider(widget.entryId));
  }

  void _showMessage(String message) {
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  List<String> _decodeTipIds(String? raw) {
    if (raw == null || raw.isEmpty) {
      return const [];
    }

    try {
      final decoded = jsonDecode(raw);
      if (decoded is List) {
        return decoded.whereType<String>().toList(growable: false);
      }
    } catch (_) {
      return const [];
    }

    return const [];
  }
}

class _AiMetaLine extends StatelessWidget {
  const _AiMetaLine({
    required this.provider,
    required this.model,
    required this.completedAt,
  });

  final String provider;
  final String model;
  final DateTime? completedAt;

  @override
  Widget build(BuildContext context) {
    final timestamp =
        completedAt == null ? null : _formatTimestamp(completedAt!);
    return Text(
      timestamp == null
          ? 'Provider: $provider · Modell: $model'
          : 'Provider: $provider · Modell: $model · $timestamp',
      style: Theme.of(context).textTheme.bodySmall,
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final local = timestamp.toLocal();
    final day = local.day.toString().padLeft(2, '0');
    final month = local.month.toString().padLeft(2, '0');
    final hour = local.hour.toString().padLeft(2, '0');
    final minute = local.minute.toString().padLeft(2, '0');
    return '$day.$month.${local.year}, $hour:$minute';
  }
}

class _AiParagraph extends StatelessWidget {
  const _AiParagraph({
    required this.label,
    required this.text,
  });

  final String label;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 4),
        Text(text),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.title,
    required this.icon,
    required this.body,
  });

  final String title;
  final IconData icon;
  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20),
                const SizedBox(width: AppConstants.spacingSmall),
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.spacingSmall),
            Text(
              body,
              style: theme.textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: AppConstants.spacingSmall),
            child,
          ],
        ),
      ),
    );
  }
}

class _TipRow extends StatelessWidget {
  const _TipRow({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.spacingSmall),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2),
            child: Icon(Icons.check_circle_outline, size: 18),
          ),
          const SizedBox(width: AppConstants.spacingSmall),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
