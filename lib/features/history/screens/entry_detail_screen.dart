import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:innenkompass/app/theme/colors.dart';
import 'package:innenkompass/application/providers/database_provider.dart';
import 'package:innenkompass/application/providers/evaluation_providers.dart';
import 'package:innenkompass/core/constants/app_constants.dart';
import 'package:innenkompass/core/constants/context_types.dart';
import 'package:innenkompass/core/constants/emotion_types.dart';
import 'package:innenkompass/core/constants/fact_interpretation_results.dart';
import 'package:innenkompass/core/constants/impulse_types.dart';
import 'package:innenkompass/core/constants/pattern_familiarity.dart';
import 'package:innenkompass/core/constants/problem_timing.dart';
import 'package:innenkompass/core/constants/system_reaction_types.dart';
import 'package:innenkompass/core/constants/tipping_point_awareness.dart';
import 'package:innenkompass/core/constants/trigger_as_last_drop.dart';
import 'package:innenkompass/data/db/app_database.dart';
import 'package:innenkompass/domain/models/ai_evaluation.dart';
import 'package:innenkompass/shared/widgets/app_scaffold.dart';

part 'entry_detail_screen.g.dart';

class EntryDetailScreen extends ConsumerStatefulWidget {
  const EntryDetailScreen({
    super.key,
    required this.entryId,
  });

  final int entryId;

  @override
  ConsumerState<EntryDetailScreen> createState() => _EntryDetailScreenState();
}

class _EntryDetailScreenState extends ConsumerState<EntryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final entryAsync = ref.watch(entryByIdProvider(widget.entryId));
    final contentAsync = ref.watch(evaluationContentProvider);

    return AppScaffold(
      title: 'Eintragdetails',
      actions: [
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: _showDeleteDialog,
          tooltip: 'Löschen',
        ),
      ],
      body: entryAsync.when(
        data: (entry) {
          if (entry == null) {
            return const Center(child: Text('Eintrag nicht gefunden'));
          }

          final bodyReactions = _decodeStringList(
            entry.initialBodyReactions ?? entry.bodySymptoms,
          );
          final additionalEmotions =
              _decodeStringList(entry.additionalEmotions);
          final thoughtPatterns = _decodeStringList(entry.thoughtPatterns);
          final actualBehaviorTags =
              _decodeStringList(entry.actualBehaviorTags);
          final touchedThemes = _decodeStringList(entry.touchedThemes);
          final neededSupports = _decodeStringList(entry.neededSupports);
          final evaluationStatusKeys =
              _decodeStringList(entry.evaluationStatusKeys);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.spacingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader(
                  Icons.calendar_today,
                  _formatDateTime(entry.timestamp),
                ),
                const SizedBox(height: AppConstants.spacingMedium),
                _buildCard(
                  title: 'Situation',
                  icon: Icons.description_outlined,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.situationDescription.isEmpty
                            ? 'Für diesen Eintrag wurde die Situation nicht separat beschrieben.'
                            : entry.situationDescription,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: AppConstants.spacingSmall),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          Chip(
                            label: Text(_getContextLabel(entry.context)),
                            avatar: Text(_getContextEmoji(entry.context)),
                          ),
                          if (_involvedLabel(entry).isNotEmpty)
                            Chip(
                              label: Text(_involvedLabel(entry)),
                              avatar:
                                  const Icon(Icons.people_outline, size: 16),
                            ),
                          if ((entry.triggerDescription ?? '').isNotEmpty)
                            Chip(
                              label:
                                  Text('Auslöser: ${entry.triggerDescription}'),
                              avatar: const Icon(
                                Icons.bolt_outlined,
                                size: 16,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                if ((entry.preTriggerPreoccupation ?? '').isNotEmpty ||
                    (entry.problemTiming ?? '').isNotEmpty) ...[
                  const SizedBox(height: AppConstants.spacingMedium),
                  _buildCard(
                    title: 'Vorlauf',
                    icon: Icons.timelapse_outlined,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if ((entry.preTriggerPreoccupation ?? '').isNotEmpty)
                          _buildLabeledValue(
                            'Schon vorher im Kopf',
                            entry.preTriggerPreoccupation!,
                          ),
                        if ((entry.problemTiming ?? '').isNotEmpty)
                          _buildLabeledValue(
                            'War das Thema schon vorher da?',
                            _getProblemTimingLabel(entry.problemTiming!),
                          ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: AppConstants.spacingMedium),
                _buildCard(
                  title: 'Körper & Gefühle',
                  icon: Icons.favorite_border,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _IntensityBar(
                              label: 'Vorbelastung',
                              value: entry.preTriggerLoad ?? 0,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _IntensityBar(
                              label: 'Im Moment',
                              value: entry.intensity,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _IntensityBar(
                              label: 'Anspannung',
                              value: entry.bodyTension,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildLabeledValue(
                        'Stärkstes Gefühl',
                        _getEmotionLabel(entry.primaryEmotion),
                      ),
                      if (additionalEmotions.isNotEmpty ||
                          (entry.secondaryEmotion ?? '').isNotEmpty)
                        _buildLabeledValue(
                          'Was noch mit dabei war',
                          [
                            ...additionalEmotions.map(_getEmotionLabel),
                            if ((entry.secondaryEmotion ?? '').isNotEmpty &&
                                !additionalEmotions
                                    .contains(entry.secondaryEmotion))
                              _getEmotionLabel(entry.secondaryEmotion!),
                          ].join(', '),
                        ),
                      if (bodyReactions.isNotEmpty) ...[
                        const Text(
                          'Körperreaktionen:',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 4),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: bodyReactions
                              .map((value) => Chip(label: Text(value)))
                              .toList(),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: AppConstants.spacingMedium),
                _buildCard(
                  title: 'Gedanken & Muster',
                  icon: Icons.psychology_outlined,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if ((entry.thoughtFocus ?? '').isNotEmpty)
                        _buildLabeledValue(
                          'Gedanklich vertieft in',
                          entry.thoughtFocus!,
                        ),
                      _buildLabeledValue(
                        'Erster automatischer Gedanke',
                        entry.automaticThought.isEmpty
                            ? 'Für diesen Eintrag nicht hinterlegt.'
                            : entry.automaticThought,
                      ),
                      if ((entry.factInterpretationResult ?? '').isNotEmpty)
                        _buildLabeledValue(
                          'Fakt oder Deutung',
                          _getFactInterpretationLabel(
                            entry.factInterpretationResult!,
                          ),
                        ),
                      if ((entry.systemReaction ?? '').isNotEmpty)
                        _buildLabeledValue(
                          'Erste Systemreaktion',
                          _getSystemReactionLabel(entry.systemReaction!),
                        ),
                      if ((entry.systemReaction ?? '').isEmpty &&
                          entry.firstImpulse.isNotEmpty)
                        _buildLabeledValue(
                          'Früher erfasster Erstimpuls',
                          _getLegacyImpulseLabel(entry.firstImpulse),
                        ),
                      if (thoughtPatterns.isNotEmpty)
                        _buildLabeledValue(
                          'Gedankenmuster',
                          thoughtPatterns.join(', '),
                        ),
                      if ((entry.fearOrPressurePoint ?? '').isNotEmpty)
                        _buildLabeledValue(
                          'Was am meisten Angst oder Druck gemacht hat',
                          entry.fearOrPressurePoint!,
                        ),
                      if ((entry.tippingPointAwareness ?? '').isNotEmpty)
                        _buildLabeledValue(
                          'Kipppunkt bemerkt',
                          _getTippingPointLabel(entry.tippingPointAwareness!),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: AppConstants.spacingMedium),
                _buildCard(
                  title: 'Verhalten',
                  icon: Icons.directions_run_outlined,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (actualBehaviorTags.isNotEmpty)
                        _buildLabeledValue(
                          'Ausgewähltes Verhalten',
                          actualBehaviorTags.join(', '),
                        ),
                      if ((entry.actualBehavior ?? '').isNotEmpty)
                        _buildLabeledValue(
                          'Notiz zum Verhalten',
                          entry.actualBehavior!,
                        ),
                    ],
                  ),
                ),
                if (touchedThemes.isNotEmpty ||
                    neededSupports.isNotEmpty ||
                    _legacyNeedSummary(entry).isNotEmpty ||
                    (entry.triggerAsLastDrop ?? '').isNotEmpty ||
                    (entry.backgroundTheme ?? '').isNotEmpty ||
                    (entry.preEscalationRelief ?? '').isNotEmpty ||
                    (entry.patternFamiliarity ?? '').isNotEmpty) ...[
                  const SizedBox(height: AppConstants.spacingMedium),
                  _buildCard(
                    title: 'Einordnung',
                    icon: Icons.explore_outlined,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (touchedThemes.isNotEmpty)
                          _buildLabeledValue(
                            'Getroffen wurde',
                            touchedThemes.join(', '),
                          ),
                        if (neededSupports.isNotEmpty)
                          _buildLabeledValue(
                            'Eigentlich gebraucht',
                            neededSupports.join(', '),
                          ),
                        if (touchedThemes.isEmpty &&
                            neededSupports.isEmpty &&
                            _legacyNeedSummary(entry).isNotEmpty)
                          _buildLabeledValue(
                            'Einordnung aus älterem Eintrag',
                            _legacyNeedSummary(entry),
                          ),
                        if ((entry.triggerAsLastDrop ?? '').isNotEmpty)
                          _buildLabeledValue(
                            'War es eher der letzte Tropfen?',
                            _getTriggerAsLastDropLabel(
                                entry.triggerAsLastDrop!),
                          ),
                        if ((entry.backgroundTheme ?? '').isNotEmpty)
                          _buildLabeledValue(
                            'Wahrscheinliches Hintergrundthema',
                            entry.backgroundTheme!,
                          ),
                        if ((entry.preEscalationRelief ?? '').isNotEmpty)
                          _buildLabeledValue(
                            'Was es vorher entschärft hätte',
                            entry.preEscalationRelief!,
                          ),
                        if ((entry.patternFamiliarity ?? '').isNotEmpty)
                          _buildLabeledValue(
                            'Bekanntes Muster',
                            _getPatternFamiliarityLabel(
                              entry.patternFamiliarity!,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
                if ((entry.realisticAlternative ?? '').isNotEmpty ||
                    (entry.nextStep ?? '').isNotEmpty) ...[
                  const SizedBox(height: AppConstants.spacingMedium),
                  _buildCard(
                    title: 'Nächster realistischer Schritt',
                    icon: Icons.alt_route_outlined,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if ((entry.realisticAlternative ?? '').isNotEmpty)
                          _buildLabeledValue(
                            'Realistischer anderer Schritt',
                            entry.realisticAlternative!,
                          ),
                        if ((entry.nextStep ?? '').isNotEmpty)
                          _buildLabeledValue(
                            (entry.realisticAlternative ?? '').isNotEmpty
                                ? 'Kleinster sinnvoller nächster Schritt'
                                : 'Notierter nächster Schritt',
                            entry.nextStep!,
                          ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: AppConstants.spacingMedium),
                _buildCard(
                  title: 'Auswertung',
                  icon: Icons.tips_and_updates_outlined,
                  child: contentAsync.when(
                    data: (content) {
                      final tipIds = _decodeStringList(entry.suggestedTipIds);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (evaluationStatusKeys.isNotEmpty) ...[
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: evaluationStatusKeys
                                  .map(
                                    (key) => Chip(
                                      label: Text(content.statusLabelFor(key)),
                                    ),
                                  )
                                  .toList(),
                            ),
                            const SizedBox(height: 12),
                          ],
                          if ((entry.evaluationHeadlineKey ?? '').isNotEmpty)
                            _buildLabeledValue(
                              'Was auffällt',
                              content.standOutFor(entry.evaluationHeadlineKey!),
                            ),
                          if ((entry.evaluationMeaningKey ?? '').isNotEmpty)
                            _buildLabeledValue(
                              'Was dahinter liegen könnte',
                              content.backgroundFor(
                                entry.evaluationMeaningKey!,
                              ),
                            ),
                          if ((entry.evaluationHelpfulNowKey ?? '').isNotEmpty)
                            _buildLabeledValue(
                              'Was jetzt hilfreicher ist als weitere Analyse',
                              content.helpfulNowFor(
                                entry.evaluationHelpfulNowKey!,
                              ),
                            ),
                          if ((entry.evaluationLearningPointKey ?? '')
                              .isNotEmpty)
                            _buildLabeledValue(
                              'Lernpunkt / frühester möglicher Abzweig',
                              content.learningPointFor(
                                entry.evaluationLearningPointKey!,
                              ),
                            ),
                          if (tipIds.isNotEmpty) ...[
                            const Text(
                              'Praktische Tipps:',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 4),
                            ...tipIds.map(
                              (tipId) => Padding(
                                padding: const EdgeInsets.only(bottom: 6),
                                child: Text('• ${content.tipFor(tipId)}'),
                              ),
                            ),
                          ],
                          if ((entry.selectedNextActionKey ?? '').isNotEmpty)
                            _buildLabeledValue(
                              'Gewählter nächster Schritt',
                              content.nextActionFor(
                                entry.selectedNextActionKey!,
                              ),
                            ),
                        ],
                      );
                    },
                    loading: () => const CircularProgressIndicator(),
                    error: (_, __) => const Text(
                      'Auswertung konnte nicht geladen werden.',
                    ),
                  ),
                ),
                if ((entry.aiEvaluationStatus ?? '').isNotEmpty ||
                    (entry.aiEvaluationText ?? '').isNotEmpty) ...[
                  const SizedBox(height: AppConstants.spacingMedium),
                  _buildCard(
                    title: 'Freie KI-Einordnung',
                    icon: Icons.auto_awesome_outlined,
                    child: _buildAiEvaluationSection(entry),
                  ),
                ],
                if (entry.interventionType != null) ...[
                  const SizedBox(height: AppConstants.spacingMedium),
                  _buildCard(
                    title: 'Intervention',
                    icon: Icons.self_improvement,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _getInterventionLabel(entry.interventionType!),
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        if (entry.interventionCompleted == true) ...[
                          const SizedBox(height: 4),
                          Text(
                            'Intervention abgeschlossen',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                        if (entry.postIntensity != null) ...[
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: _IntensityBar(
                                  label: 'Belastung (nachher)',
                                  value: entry.postIntensity!,
                                  showImprovement: true,
                                  improvement:
                                      entry.intensity - entry.postIntensity!,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _IntensityBar(
                                  label: 'Anspannung (nachher)',
                                  value: entry.postBodyTension!,
                                  showImprovement: true,
                                  improvement: entry.bodyTension -
                                      entry.postBodyTension!,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Fehler: $error')),
      ),
    );
  }

  Widget _buildAiEvaluationSection(SituationEntryData entry) {
    final status = AiEvaluationStatus.fromRaw(entry.aiEvaluationStatus);
    final content = AiEvaluationContent.tryParse(entry.aiEvaluationText);
    final isStalePending = status?.isPendingStale(
          requestedAt: entry.aiEvaluationRequestedAt,
        ) ??
        false;

    if (status == AiEvaluationStatus.pending && !isStalePending) {
      return const Text(
        'Die freie KI-Einordnung wurde angefragt und wird noch verarbeitet.',
      );
    }

    if (isStalePending) {
      return const Text(
        'Die freie KI-Einordnung wurde angefragt, aber nicht abgeschlossen. '
        'Du kannst den Eintrag erneut öffnen und die Anfrage neu starten.',
      );
    }

    if (status == AiEvaluationStatus.failed) {
      return const Text(
        'Die freie KI-Einordnung konnte für diesen Eintrag nicht gespeichert werden.',
      );
    }

    if (status == AiEvaluationStatus.success && content != null) {
      final metaParts = <String>[
        if ((entry.aiEvaluationProvider ?? '').isNotEmpty)
          'Provider: ${entry.aiEvaluationProvider}',
        if ((entry.aiEvaluationModel ?? '').isNotEmpty)
          'Modell: ${entry.aiEvaluationModel}',
        if (entry.aiEvaluationCompletedAt != null)
          _formatAiTimestamp(entry.aiEvaluationCompletedAt!),
      ];

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (metaParts.isNotEmpty) ...[
            Text(
              metaParts.join(' · '),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: AppConstants.spacingMedium),
          ],
          _buildLabeledValue('Was auffällt', content.wasAuffaellt),
          _buildLabeledValue('Einordnung', content.einordnung),
          _buildLabeledValue('Praktisch hilfreich', content.praktischHilfreich),
          if (content.hasVorsichtshinweis)
            _buildLabeledValue('Vorsichtshinweis', content.vorsichtshinweis!),
        ],
      );
    }

    return const Text(
      'Für diesen Eintrag liegt noch keine gespeicherte KI-Einordnung vor.',
    );
  }

  Widget _buildSectionHeader(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
        ),
      ],
    );
  }

  Widget _buildCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dt) {
    return '${dt.day}.${dt.month}.${dt.year} - ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  String _formatAiTimestamp(DateTime dt) {
    return 'Erstellt am ${dt.day.toString().padLeft(2, '0')}.${dt.month.toString().padLeft(2, '0')}.${dt.year} um ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  String _getContextLabel(String contextName) {
    return ContextType.fromRaw(contextName)?.label ?? contextName;
  }

  String _getContextEmoji(String contextName) {
    return ContextType.fromRaw(contextName)?.emoji ?? '❓';
  }

  String _getEmotionLabel(String emotionName) {
    final emotion = EmotionType.values
        .where((value) => value.name == emotionName)
        .firstOrNull;
    return emotion?.label ?? emotionName;
  }

  String _getProblemTimingLabel(String rawValue) {
    return ProblemTiming.fromRaw(rawValue)?.label ?? rawValue;
  }

  String _getFactInterpretationLabel(String rawValue) {
    final result = FactInterpretationResult.values
        .where((candidate) => candidate.name == rawValue)
        .firstOrNull;
    return result?.label ?? rawValue;
  }

  String _getSystemReactionLabel(String rawValue) {
    return SystemReactionType.fromRaw(rawValue)?.label ?? rawValue;
  }

  String _getLegacyImpulseLabel(String rawValue) {
    return ImpulseType.values
            .firstWhereOrNull((value) => value.name == rawValue)
            ?.label ??
        rawValue;
  }

  String _getTippingPointLabel(String rawValue) {
    return TippingPointAwareness.fromRaw(rawValue)?.label ?? rawValue;
  }

  String _getTriggerAsLastDropLabel(String rawValue) {
    return TriggerAsLastDrop.fromRaw(rawValue)?.label ?? rawValue;
  }

  String _getPatternFamiliarityLabel(String rawValue) {
    return PatternFamiliarity.fromRaw(rawValue)?.label ?? rawValue;
  }

  String _legacyNeedSummary(SituationEntryData entry) {
    if (_decodeStringList(entry.touchedThemes).isNotEmpty ||
        _decodeStringList(entry.neededSupports).isNotEmpty) {
      return '';
    }
    return (entry.needOrWoundedPoint ?? '').trim();
  }

  String _getInterventionLabel(String typeStr) {
    final labels = {
      'regulation': 'Regulation',
      'factCheck': 'Fakt vs. Deutung',
      'impulsePause': 'Impulspause',
      'ruminationStop': 'Grübelstopp',
      'communication': 'Kommunikationshilfe',
      'overwhelmStructure': 'Überforderungsstruktur',
      'selfValueCheck': 'Selbstabwertungscheck',
    };
    return labels[typeStr] ?? typeStr;
  }

  String _involvedLabel(SituationEntryData entry) {
    final rawValue = entry.involvedEntities ?? entry.involvedPerson ?? '';
    return rawValue.trim();
  }

  Widget _buildLabeledValue(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 4),
          Text(value),
        ],
      ),
    );
  }

  List<String> _decodeStringList(String? rawValue) {
    if (rawValue == null || rawValue.isEmpty) return const [];

    try {
      final decoded = jsonDecode(rawValue);
      if (decoded is List) {
        return decoded.whereType<String>().toList();
      }
    } catch (_) {
      return rawValue
          .split(',')
          .map((value) => value.trim())
          .where((value) => value.isNotEmpty)
          .toList();
    }

    return const [];
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Eintrag löschen?'),
        content: const Text(
          'Möchtest du diesen Eintrag wirklich löschen? Diese Aktion kann nicht rückgängig gemacht werden.',
        ),
        actions: [
          TextButton(
            onPressed: () => dialogContext.pop(),
            child: const Text('Abbrechen'),
          ),
          TextButton(
            onPressed: () async {
              dialogContext.pop();
              final db = ref.read(databaseProvider);
              await db.deleteSituationEntryById(widget.entryId);
              if (!mounted) return;

              context.pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Eintrag gelöscht')),
              );
            },
            child: const Text(
              'Löschen',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

class _IntensityBar extends StatelessWidget {
  const _IntensityBar({
    required this.label,
    required this.value,
    this.showImprovement = false,
    this.improvement,
  });

  final String label;
  final int value;
  final bool showImprovement;
  final int? improvement;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            if (showImprovement && improvement != null)
              Text(
                improvement! > 0 ? '-$improvement' : '+${-improvement!}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: improvement! > 0 ? AppColors.success : AppColors.error,
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        Stack(
          children: [
            Container(
              height: 8,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            FractionallySizedBox(
              widthFactor: value / 10,
              child: Container(
                height: 8,
                decoration: BoxDecoration(
                  color: _getColor(value),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          '$value/10',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
        ),
      ],
    );
  }

  Color _getColor(int value) {
    if (value <= 3) return AppColors.success;
    if (value <= 6) return AppColors.warning;
    return AppColors.error;
  }
}

@riverpod
Future<SituationEntryData?> entryById(Ref ref, int id) async {
  final db = ref.watch(databaseProvider);
  return db.getSituationEntryById(id);
}
