import 'dart:convert';

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
import 'package:innenkompass/core/constants/system_states.dart';
import 'package:innenkompass/data/db/app_database.dart';
import 'package:innenkompass/domain/models/ai_reflection.dart';
import 'package:innenkompass/domain/models/ai_evaluation.dart';
import 'package:innenkompass/domain/services/ai_reflection_policy.dart';
import 'package:innenkompass/domain/services/ai_evaluation_service.dart';
import 'package:innenkompass/domain/services/intervention_resolver.dart';
import 'package:innenkompass/domain/services/pattern_analyzer.dart';
import 'package:innenkompass/shared/widgets/app_scaffold.dart';
import 'package:innenkompass/shared/widgets/ai/ai_reflection_result_card.dart';
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
    final patternHintAsync =
        ref.watch(evaluationPatternHintProvider(widget.entryId));
    final contentAsync = ref.watch(evaluationContentProvider);
    final aiConfig = ref.watch(aiEvaluationConfigProvider);
    final hasAiService = ref.watch(aiEvaluationServiceProvider) != null;
    final hasAiReflectionService =
        ref.watch(aiReflectionServiceProvider) != null;

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
              final resolvedIntervention = _resolveInterventionForEntry(entry);
              final hasIntervention = resolvedIntervention != null;

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
                    patternHintAsync.maybeWhen(
                      data: (hint) => (hint == null || hint.trim().isEmpty)
                          ? const SizedBox.shrink()
                          : Padding(
                              padding: const EdgeInsets.only(
                                bottom: AppConstants.spacingMedium,
                              ),
                              child: _PatternHintCard(text: hint),
                            ),
                      orElse: () => const SizedBox.shrink(),
                    ),
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
                    _buildAiReflectionSection(
                      context: context,
                      entry: entry,
                      aiConfig: aiConfig,
                      hasAiService: hasAiReflectionService,
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
                                  entry,
                                  resolvedIntervention!,
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
    SituationEntryData entry,
    ResolvedInterventionRecommendation recommendation,
  ) async {
    _detachAiRequest();
    await _persistSelectedAction(actionKey);
    if (!mounted) return;

    await _persistResolvedInterventionReference(entry, recommendation);
    if (!mounted) return;

    ref.read(interventionFlowStateProvider.notifier).startIntervention(
        recommendation.intervention,
        entryId: widget.entryId);
    context.push(
      AppRoutes.intervention,
      extra: {'interventionId': recommendation.interventionId},
    );
  }

  Future<void> _finishWithoutIntervention() async {
    _detachAiRequest();
    final actionKey = _selectedActionKey;
    await _persistSelectedAction(actionKey);
    ref.read(newSituationFlowControllerProvider.notifier).reset();
    if (!mounted) return;
    context.go(AppRoutes.home);
  }

  ResolvedInterventionRecommendation? _resolveInterventionForEntry(
    SituationEntryData entry,
  ) {
    return InterventionResolver.resolveForStoredEntry(
      storedInterventionId: entry.interventionId,
      storedInterventionTypeRaw: entry.interventionType,
      systemStateRaw: entry.systemState,
      primaryEmotionRaw: entry.primaryEmotion,
      intensity: entry.intensity,
    );
  }

  Future<void> _persistResolvedInterventionReference(
    SituationEntryData entry,
    ResolvedInterventionRecommendation recommendation,
  ) async {
    final storedType = InterventionResolver.typeForStoredReference(
      interventionId: entry.interventionId,
      interventionTypeRaw: entry.interventionType,
    );
    final hasMatchingReference =
        entry.interventionId == recommendation.interventionId &&
            storedType == recommendation.interventionType;
    if (hasMatchingReference) {
      return;
    }

    final db = ref.read(databaseProvider);
    await db.updateInterventionReference(
      entryId: widget.entryId,
      interventionId: recommendation.interventionId,
      interventionType: recommendation.interventionType.name,
    );
    ref.invalidate(evaluationEntryProvider(widget.entryId));
    ref.invalidate(interventionEntryProvider(widget.entryId));
    ref.invalidate(narrativeInsightsProvider);
  }

  Widget _buildAiReflectionSection({
    required BuildContext context,
    required SituationEntryData entry,
    required AiEvaluationConfig aiConfig,
    required bool hasAiService,
  }) {
    final policy = AiReflectionPolicy.evaluateEntry(entry);
    final reflectionStatus =
        AiReflectionStatus.fromRaw(entry.aiReflectionStatus);
    final reflectionMode = AiReflectionMode.fromRaw(entry.aiReflectionMode);
    final result = _storedAiReflectionResult(entry);
    final phase = AiReflectionPhase.fromRaw(entry.aiReflectionPhase);
    final lastErrorMessage = entry.aiReflectionLastErrorMessage?.trim();
    final children = <Widget>[
      const Text(
        'Die KI hilft beim Strukturieren deines Eintrags. Bei hoher Anspannung bleibt der Fokus zuerst auf Stabilisierung, nicht auf tiefer Analyse.',
      ),
    ];

    if (!aiConfig.isEnabled || !hasAiService) {
      children.addAll([
        const SizedBox(height: AppConstants.spacingMedium),
        const Text(
          'Wenn die KI gerade nicht erreichbar ist, erstellt die App eine reduzierte lokale Verdichtung statt die Nachreflexion abzubrechen.',
        ),
      ]);
    }

    if (policy.hintText != null) {
      children.addAll([
        const SizedBox(height: AppConstants.spacingMedium),
        Text(policy.hintText!),
      ]);
    }

    if (reflectionStatus == AiReflectionStatus.completed && result != null) {
      children.addAll([
        const SizedBox(height: AppConstants.spacingMedium),
        _AiReflectionMetaLine(
          mode: reflectionMode,
          status: reflectionStatus,
          completedAt: entry.aiReflectionCompletedAt,
          provider: entry.aiReflectionProvider,
          model: entry.aiReflectionModel,
        ),
        const SizedBox(height: AppConstants.spacingMedium),
        AiReflectionResultCard(result: result),
      ]);
    } else if (reflectionStatus == AiReflectionStatus.deferred &&
        reflectionMode == null) {
      children.addAll([
        const SizedBox(height: AppConstants.spacingMedium),
        _buildReflectionStatusNotice(
          context,
          icon: Icons.schedule_outlined,
          text: entry.aiReflectionDeferredUntil == null
              ? 'Für spätere Nachreflexion vorgemerkt.'
              : 'Für spätere Nachreflexion vorgemerkt. Sinnvoll erneut ab ${_formatTimestamp(entry.aiReflectionDeferredUntil!)}.',
        ),
      ]);
    } else if ((reflectionStatus == AiReflectionStatus.inProgress ||
            reflectionStatus == AiReflectionStatus.deferred) &&
        reflectionMode != null) {
      children.addAll([
        const SizedBox(height: AppConstants.spacingMedium),
        _buildReflectionStatusNotice(
          context,
          icon: reflectionStatus == AiReflectionStatus.inProgress
              ? Icons.timelapse_outlined
              : Icons.schedule_outlined,
          text: switch (reflectionStatus) {
            AiReflectionStatus.inProgress => phase ==
                    AiReflectionPhase.failedComplete
                ? 'Die Nachreflexion im Modus „${reflectionMode.label}“ wurde begonnen, die letzte Verdichtung ist aber fehlgeschlagen. Du kannst sie fortsetzen.'
                : 'Eine Nachreflexion im Modus „${reflectionMode.label}“ wurde bereits begonnen und kann fortgesetzt werden.',
            AiReflectionStatus.deferred =>
              'Der Modus „${reflectionMode.label}“ ist für eine spätere Nachreflexion vorgemerkt.',
            _ => '',
          },
        ),
      ]);
    }

    if (lastErrorMessage != null &&
        lastErrorMessage.isNotEmpty &&
        reflectionStatus != AiReflectionStatus.completed) {
      children.addAll([
        const SizedBox(height: AppConstants.spacingMedium),
        _buildReflectionStatusNotice(
          context,
          icon: Icons.info_outline,
          text: lastErrorMessage,
        ),
      ]);
    }

    if (policy.isBlockedByCrisis) {
      children.addAll([
        const SizedBox(height: AppConstants.spacingMedium),
        const Text(
          'Für akute Kriseneinträge bleibt die KI-Nachreflexion deaktiviert. Hier zählt zuerst Stabilisierung und Sicherheit.',
        ),
      ]);
    } else if (reflectionStatus != AiReflectionStatus.completed) {
      children.add(const SizedBox(height: AppConstants.spacingMedium));
      if ((reflectionStatus == AiReflectionStatus.inProgress ||
              reflectionStatus == AiReflectionStatus.deferred) &&
          reflectionMode != null) {
        children.add(
          AppPrimaryButton(
            onPressed: () => _openAiReflection(reflectionMode),
            label: reflectionStatus == AiReflectionStatus.inProgress
                ? 'Nachreflexion fortsetzen'
                : 'Jetzt mit ${reflectionMode.label} weiter sortieren',
          ),
        );
      } else {
        children.addAll(
          policy.availableModes.map(
            (mode) => _AiReflectionModeTile(
              mode: mode,
              onTap: () => _openAiReflection(mode),
            ),
          ),
        );
      }

      if (policy.canDefer) {
        children.addAll([
          const SizedBox(height: AppConstants.spacingSmall),
          AppSecondaryButton(
            onPressed: () => _deferAiReflection(reflectionMode),
            label: 'Später mit Abstand reflektieren',
          ),
        ]);
      }
    }

    return _SectionCard(
      title: 'Mit KI weiter sortieren',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
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

  Future<void> _deferAiReflection(AiReflectionMode? mode) async {
    final now = DateTime.now().toUtc();
    await ref.read(databaseProvider).markAiReflectionDeferred(
          entryId: widget.entryId,
          mode: mode,
          deferredAt: now,
          resumeSuggestedAt: now.add(const Duration(hours: 6)),
        );
    ref.invalidate(evaluationEntryProvider(widget.entryId));
    _showMessage('Für spätere Nachreflexion vorgemerkt.');
  }

  void _openAiReflection(AiReflectionMode mode) {
    context.push(
      AppRoutes.entryAiReflection
          .replaceFirst(':id', '${widget.entryId}')
          .replaceFirst(':mode', mode.name),
    );
  }

  AiReflectionResult? _storedAiReflectionResult(SituationEntryData entry) {
    final summary = entry.aiReflectionSummary?.trim() ?? '';
    final likelyCore = entry.aiReflectionLikelyCore?.trim() ?? '';
    final earlyTurningPoint = entry.aiReflectionEarlyTurningPoint?.trim() ?? '';
    final alternative = entry.aiReflectionAlternative?.trim() ?? '';
    final nextStep = entry.aiReflectionNextStep?.trim() ?? '';
    final mantra = entry.aiReflectionMantra?.trim();

    if (summary.isEmpty ||
        likelyCore.isEmpty ||
        earlyTurningPoint.isEmpty ||
        alternative.isEmpty ||
        nextStep.isEmpty) {
      return null;
    }

    return AiReflectionResult(
      summary: summary,
      likelyCore: likelyCore,
      earlyTurningPoint: earlyTurningPoint,
      alternative: alternative,
      nextStep: nextStep,
      mantra: (mantra == null || mantra.isEmpty) ? null : mantra,
    );
  }

  Widget _buildReflectionStatusNotice(
    BuildContext context, {
    required IconData icon,
    required String text,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.spacingMedium),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: AppConstants.spacingSmall),
          Expanded(child: Text(text)),
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

  static String _formatTimestamp(DateTime timestamp) {
    final local = timestamp.toLocal();
    final day = local.day.toString().padLeft(2, '0');
    final month = local.month.toString().padLeft(2, '0');
    final hour = local.hour.toString().padLeft(2, '0');
    final minute = local.minute.toString().padLeft(2, '0');
    return '$day.$month.${local.year}, $hour:$minute';
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
    return _EntryEvaluationScreenState._formatTimestamp(timestamp);
  }
}

class _AiReflectionMetaLine extends StatelessWidget {
  const _AiReflectionMetaLine({
    required this.mode,
    required this.status,
    required this.completedAt,
    this.provider,
    this.model,
  });

  final AiReflectionMode? mode;
  final AiReflectionStatus status;
  final DateTime? completedAt;
  final String? provider;
  final String? model;

  @override
  Widget build(BuildContext context) {
    final parts = <String>[
      if (mode != null) 'Modus: ${mode!.label}',
      'Status: ${_statusLabel(status)}',
      if ((provider ?? '').trim().isNotEmpty) 'Provider: ${provider!.trim()}',
      if ((model ?? '').trim().isNotEmpty) 'Modell: ${model!.trim()}',
      if (completedAt != null)
        _EntryEvaluationScreenState._formatTimestamp(completedAt!),
    ];
    return Text(
      parts.join(' · '),
      style: Theme.of(context).textTheme.bodySmall,
    );
  }

  static String _statusLabel(AiReflectionStatus status) {
    switch (status) {
      case AiReflectionStatus.notStarted:
        return 'Noch nicht gestartet';
      case AiReflectionStatus.inProgress:
        return 'In Bearbeitung';
      case AiReflectionStatus.completed:
        return 'Abgeschlossen';
      case AiReflectionStatus.deferred:
        return 'Für später markiert';
    }
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

class _PatternHintCard extends StatelessWidget {
  const _PatternHintCard({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingMedium),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2),
            child: Icon(Icons.repeat_rounded, size: 18),
          ),
          const SizedBox(width: AppConstants.spacingSmall),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
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

class _AiReflectionModeTile extends StatelessWidget {
  const _AiReflectionModeTile({
    required this.mode,
    required this.onTap,
  });

  final AiReflectionMode mode;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: AppConstants.spacingSmall),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spacingMedium,
          vertical: 4,
        ),
        title: Text(
          mode.label,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(mode.shortDescription),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
