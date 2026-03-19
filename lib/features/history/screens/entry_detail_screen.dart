import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:innenkompass/application/providers/evaluation_providers.dart';
import 'package:innenkompass/core/constants/app_constants.dart';
import 'package:innenkompass/core/constants/emotion_types.dart';
import 'package:innenkompass/core/constants/fact_interpretation_results.dart';
import 'package:innenkompass/core/constants/context_types.dart';
import 'package:innenkompass/core/constants/impulse_types.dart';
import 'package:innenkompass/core/constants/system_states.dart';
import 'package:innenkompass/data/db/app_database.dart';
import 'package:innenkompass/domain/models/ai_evaluation.dart';
import 'package:innenkompass/application/providers/database_provider.dart';
import 'package:innenkompass/shared/widgets/app_scaffold.dart';
import 'package:innenkompass/app/theme/colors.dart';

part 'entry_detail_screen.g.dart';

/// Screen für die Detailansicht eines Situationseintrags
class EntryDetailScreen extends ConsumerStatefulWidget {
  final int entryId;

  const EntryDetailScreen({
    super.key,
    required this.entryId,
  });

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
          onPressed: () => _showDeleteDialog(),
          tooltip: 'Löschen',
        ),
      ],
      body: entryAsync.when(
        data: (entry) {
          if (entry == null) {
            return const Center(
              child: Text('Eintrag nicht gefunden'),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.spacingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Datum und Zeit
                _buildSectionHeader(
                  Icons.calendar_today,
                  _formatDateTime(entry.timestamp),
                ),

                const SizedBox(height: AppConstants.spacingMedium),

                // Situation
                _buildCard(
                  title: 'Situation',
                  icon: Icons.description,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.situationDescription,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: AppConstants.spacingSmall),
                      Row(
                        children: [
                          Chip(
                            label: Text(_getContextLabel(entry.context)),
                            avatar: Text(_getContextEmoji(entry.context)),
                          ),
                          const SizedBox(width: 8),
                          if (entry.involvedPerson != null &&
                              entry.involvedPerson!.isNotEmpty)
                            Chip(
                              label: Text(entry.involvedPerson!),
                              avatar: const Icon(Icons.person, size: 16),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppConstants.spacingMedium),

                // Emotionen
                _buildCard(
                  title: 'Emotionen',
                  icon: Icons.sentiment_satisfied_alt,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            _getEmotionEmoji(entry.primaryEmotion),
                            style: const TextStyle(fontSize: 32),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _getEmotionLabel(entry.primaryEmotion),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                if (entry.secondaryEmotion != null) ...[
                                  Text(
                                    '+ ${_getEmotionLabel(entry.secondaryEmotion!)}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: Colors.grey[600],
                                        ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _IntensityBar(
                              label: 'Belastung',
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
                      if (entry.bodySymptoms != null &&
                          entry.bodySymptoms!.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _decodeBodySymptoms(entry.bodySymptoms)
                              .where((s) => s.trim().isNotEmpty)
                              .map((s) => Chip(label: Text(s.trim())))
                              .toList(),
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(height: AppConstants.spacingMedium),

                // Gedanke & Impuls
                _buildCard(
                  title: 'Gedanken & Impulse',
                  icon: Icons.psychology,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Automatischer Gedanke:',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        entry.automaticThought,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Erster Impuls:',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _getImpulseLabel(entry.firstImpulse),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      if ((entry.factInterpretationResult ?? '')
                          .isNotEmpty) ...[
                        const SizedBox(height: 12),
                        const Text(
                          'Fakt oder Deutung:',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _getFactInterpretationLabel(
                            entry.factInterpretationResult!,
                          ),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                      if (entry.actualBehavior != null &&
                          entry.actualBehavior!.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        const Text(
                          'Tatsächliches Verhalten:',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          entry.actualBehavior!,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ],
                  ),
                ),

                if ((entry.needOrWoundedPoint ?? '').isNotEmpty ||
                    (entry.nextStep ?? '').isNotEmpty) ...[
                  const SizedBox(height: AppConstants.spacingMedium),
                  _buildCard(
                    title: 'Einordnung',
                    icon: Icons.explore_outlined,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if ((entry.needOrWoundedPoint ?? '').isNotEmpty) ...[
                          const Text(
                            'Bedürfnis oder verletzter Punkt:',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            entry.needOrWoundedPoint!,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                        if ((entry.needOrWoundedPoint ?? '').isNotEmpty &&
                            (entry.nextStep ?? '').isNotEmpty)
                          const SizedBox(height: 12),
                        if ((entry.nextStep ?? '').isNotEmpty) ...[
                          const Text(
                            'Nächster Schritt:',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            entry.nextStep!,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: AppConstants.spacingMedium),

                // Klassifikation
                _buildCard(
                  title: 'Klassifikation',
                  icon: Icons.analytics,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Chip(
                            label: Text(
                              _getSystemStateLabel(entry.systemState),
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            backgroundColor:
                                _getSystemStateColor(entry.systemState)
                                    .withValues(alpha: 0.2),
                          ),
                          if (entry.isCrisis == true) ...[
                            const SizedBox(width: 8),
                            Chip(
                              label: const Text('Krise'),
                              avatar: const Icon(
                                Icons.warning,
                                size: 16,
                                color: Colors.red,
                              ),
                              backgroundColor:
                                  Colors.red.withValues(alpha: 0.1),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),

                if ((entry.evaluationHeadlineKey ?? '').isNotEmpty ||
                    (entry.evaluationMeaningKey ?? '').isNotEmpty ||
                    (entry.suggestedTipIds ?? '').isNotEmpty) ...[
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
                            if ((entry.evaluationHeadlineKey ?? '').isNotEmpty)
                              _buildLabeledValue(
                                'Was auffällt',
                                content.headlineFor(
                                  entry.evaluationHeadlineKey!,
                                ),
                              ),
                            if ((entry.evaluationMeaningKey ?? '').isNotEmpty)
                              _buildLabeledValue(
                                'Was das bedeuten könnte',
                                content.meaningFor(
                                  entry.evaluationMeaningKey!,
                                ),
                              ),
                            if ((entry.suggestedNextActionKey ?? '').isNotEmpty)
                              _buildLabeledValue(
                                'Was jetzt hilfreich sein kann',
                                content.nextActionFor(
                                  entry.suggestedNextActionKey!,
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
                ],

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

                  // Intervention
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
                          if (entry.postClarity != null) ...[
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                const Icon(
                                  Icons.lightbulb,
                                  size: 20,
                                  color: AppColors.warning,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Klarheit: ${entry.postClarity}/10',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ],
                          if (entry.helpfulnessRating != null) ...[
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(
                                  Icons.thumb_up,
                                  size: 20,
                                  color: AppColors.success,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Hilfreichkeit: ${entry.helpfulnessRating}/10',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ],
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
        error: (error, stack) => Center(
          child: Text('Fehler: $error'),
        ),
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
          _buildLabeledValue(
            'Praktisch hilfreich',
            content.praktischHilfreich,
          ),
          if (content.hasVorsichtshinweis)
            _buildLabeledValue(
              'Vorsichtshinweis',
              content.vorsichtshinweis!,
            ),
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
    final ctx =
        ContextType.values.where((e) => e.name == contextName).firstOrNull;
    return ctx?.label ?? contextName;
  }

  String _getContextEmoji(String contextName) {
    final ctx =
        ContextType.values.where((e) => e.name == contextName).firstOrNull;
    return ctx?.emoji ?? '❓';
  }

  String _getEmotionLabel(String emotionName) {
    final emotion =
        EmotionType.values.where((e) => e.name == emotionName).firstOrNull;
    return emotion?.label ?? emotionName;
  }

  String _getEmotionEmoji(String emotionName) {
    final emotion =
        EmotionType.values.where((e) => e.name == emotionName).firstOrNull;
    return emotion?.emoji ?? '😐';
  }

  String _getImpulseLabel(String impulseName) {
    final impulse =
        ImpulseType.values.where((e) => e.name == impulseName).firstOrNull;
    return impulse?.label ?? impulseName;
  }

  String _getSystemStateLabel(String stateStr) {
    try {
      final state =
          SystemState.values.where((e) => e.name == stateStr).firstOrNull;
      final labels = {
        SystemState.acuteActivation: 'Akute Aktivierung',
        SystemState.reflectiveReady: 'Reflexionsbereit',
        SystemState.interpretation: 'Interpretationsmodus',
        SystemState.rumination: 'Grübelmodus',
        SystemState.conflict: 'Konflikt',
        SystemState.selfDevaluation: 'Selbstabwertung',
        SystemState.overwhelm: 'Überforderung',
        SystemState.crisis: 'Krise',
      };
      if (state == null) return stateStr;
      return labels[state] ?? state.name;
    } catch (_) {
      return stateStr;
    }
  }

  Color _getSystemStateColor(String stateStr) {
    try {
      final state =
          SystemState.values.where((e) => e.name == stateStr).firstOrNull;
      final colors = {
        SystemState.acuteActivation: AppColors.error,
        SystemState.reflectiveReady: AppColors.success,
        SystemState.interpretation: AppColors.warning,
        SystemState.rumination: AppColors.warning,
        SystemState.conflict: AppColors.error,
        SystemState.selfDevaluation: Colors.purple,
        SystemState.overwhelm: Colors.orange,
        SystemState.crisis: Colors.red,
      };
      return colors[state] ?? Colors.grey;
    } catch (_) {
      return Colors.grey;
    }
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

  String _getFactInterpretationLabel(String rawValue) {
    final result = FactInterpretationResult.values
        .where((candidate) => candidate.name == rawValue)
        .firstOrNull;
    return result?.label ?? rawValue;
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

  List<String> _decodeBodySymptoms(String? rawValue) {
    if (rawValue == null || rawValue.isEmpty) return const [];

    try {
      final decoded = jsonDecode(rawValue);
      if (decoded is List) {
        return decoded.whereType<String>().toList();
      }
    } catch (_) {
      // Fall back to legacy comma-separated representation.
    }

    return rawValue.split(',');
  }

  List<String> _decodeStringList(String? rawValue) {
    if (rawValue == null || rawValue.isEmpty) return const [];

    try {
      final decoded = jsonDecode(rawValue);
      if (decoded is List) {
        return decoded.whereType<String>().toList();
      }
    } catch (_) {
      return const [];
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

              context.pop(); // Zurück zur Liste
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

/// Widget für Intensitätsanzeige
class _IntensityBar extends StatelessWidget {
  final String label;
  final int value;
  final bool showImprovement;
  final int? improvement;

  const _IntensityBar({
    required this.label,
    required this.value,
    this.showImprovement = false,
    this.improvement,
  });

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
            if (showImprovement && improvement != null) ...[
              Text(
                improvement! > 0 ? '-$improvement' : '+${-improvement!}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: improvement! > 0 ? AppColors.success : AppColors.error,
                ),
              ),
            ],
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
