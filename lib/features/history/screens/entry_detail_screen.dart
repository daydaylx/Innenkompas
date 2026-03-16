import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:innenkompass/app/router.dart';
import 'package:innenkompass/core/constants/app_constants.dart';
import 'package:innenkompass/core/constants/emotion_types.dart';
import 'package:innenkompass/core/constants/context_types.dart';
import 'package:innenkompass/core/constants/system_states.dart';
import 'package:innenkompass/data/db/app_database.dart';
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
  ConsumerState<EntryDetailScreen> createState() =>
      _EntryDetailScreenState();
}

class _EntryDetailScreenState extends ConsumerState<EntryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final entryAsync = ref.watch(entryByIdProvider(widget.entryId));

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
                  _formatDateTime(entry.createdAt),
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
                        entry.description,
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
                          children: entry.bodySymptoms!
                              .map((s) => Chip(label: Text(s)))
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

                if (entry.systemState != null) ...[
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
                                _getSystemStateLabel(entry.systemState!),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              backgroundColor:
                                  _getSystemStateColor(entry.systemState!)
                                      .withOpacity(0.2),
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
                                backgroundColor: Colors.red.withOpacity(0.1),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
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
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        if (entry.interventionCompletedAt != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            'Abgeschlossen: ${_formatDateTime(entry.interventionCompletedAt!)}',
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
                                  improvement: entry.intensity - entry.postIntensity!,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _IntensityBar(
                                  label: 'Anspannung (nachher)',
                                  value: entry.postBodyTension!,
                                  showImprovement: true,
                                  improvement:
                                      entry.bodyTension - entry.postBodyTension!,
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

  String _getContextLabel(ContextType context) {
    final labels = {
      ContextType.work: 'Arbeit',
      ContextType.family: 'Familie',
      ContextType.partnership: 'Partnerschaft',
      ContextType.friends: 'Freunde',
      ContextType.finances: 'Finanzen',
      ContextType.health: 'Gesundheit',
      ContextType.leisure: 'Freizeit',
      ContextType.other: 'Sonstiges',
      ContextType.unknown: 'Unbekannt',
    };
    return labels[context] ?? context.name;
  }

  String _getContextEmoji(ContextType context) {
    final emojis = {
      ContextType.work: '💼',
      ContextType.family: '👨‍👩‍👧‍👦',
      ContextType.partnership: '❤️',
      ContextType.friends: '👥',
      ContextType.finances: '💰',
      ContextType.health: '🏥',
      ContextType.leisure: '🎮',
      ContextType.other: '📌',
      ContextType.unknown: '❓',
    };
    return emojis[context] ?? '❓';
  }

  String _getEmotionLabel(EmotionType emotion) {
    final labels = {
      EmotionType.anger: 'Wut',
      EmotionType.fear: 'Angst',
      EmotionType.sadness: 'Trauer',
      EmotionType.shame: 'Scham',
      EmotionType.disgust: 'Ekel',
      EmotionType.joy: 'Freude',
      EmotionType.surprise: 'Überraschung',
      EmotionType.guilt: 'Schuld',
      EmotionType.pride: 'Stolz',
      EmotionType.loneliness: 'Einsamkeit',
    };
    return labels[emotion] ?? emotion.name;
  }

  String _getEmotionEmoji(EmotionType emotion) {
    final emojis = {
      EmotionType.anger: '😠',
      EmotionType.fear: '😨',
      EmotionType.sadness: '😢',
      EmotionType.shame: '😳',
      EmotionType.disgust: '🤢',
      EmotionType.joy: '😊',
      EmotionType.surprise: '😲',
      EmotionType.guilt: '😔',
      EmotionType.pride: '😌',
      EmotionType.loneliness: '😞',
    };
    return emojis[emotion] ?? '😐';
  }

  String _getImpulseLabel(ImpulseType impulse) {
    final labels = {
      ImpulseType.counter: 'Kontern',
      ImpulseType.flee: 'Flüchten',
      ImpulseType.freeze: 'Erstarrung',
      ImpulseType.ruminate: 'Grübeln',
      ImpulseType.control: 'Kontrolle wollen',
      ImpulseType.perfectionism: 'Perfektionismus',
      ImpulseType.comply: 'Anpassen',
      ImpulseType.withdraw: 'Zurückziehen',
      ImpulseType.searchProximity: 'Nähe suchen',
      ImpulseType.selfHarm: 'Selbstverletzung',
      ImpulseType.immediateAction: 'Sofort handeln',
      ImpulseType.suppress: 'Unterdrücken',
    };
    return labels[impulse] ?? impulse.name;
  }

  String _getSystemStateLabel(String stateStr) {
    try {
      final state = SystemState.fromString(stateStr);
      final labels = {
        SystemState.acuteActivation: 'Akute Aktivierung',
        SystemState.reflectiveReady: 'Reflexionsbereit',
        SystemState.rumination: 'Grübelmodus',
        SystemState.conflict: 'Konflikt',
        SystemState.selfDevaluation: 'Selbstabwertung',
        SystemState.overwhelm: 'Überforderung',
        SystemState.crisis: 'Krise',
      };
      return labels[state] ?? state.name;
    } catch (_) {
      return stateStr;
    }
  }

  Color _getSystemStateColor(String stateStr) {
    try {
      final state = SystemState.fromString(stateStr);
      final colors = {
        SystemState.acuteActivation: AppColors.error,
        SystemState.reflectiveReady: AppColors.success,
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

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eintrag löschen?'),
        content: const Text(
          'Möchtest du diesen Eintrag wirklich löschen? Diese Aktion kann nicht rückgängig gemacht werden.',
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Abbrechen'),
          ),
          TextButton(
            onPressed: () async {
              context.pop();
              final db = ref.read(databaseProvider);
              await db.deleteSituationEntry(widget.entryId);
              if (mounted) {
                context.pop(); // Zurück zur Liste
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Eintrag gelöscht')),
                );
              }
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
Future<SituationEntryData?> entryById(EntryByIdRef ref, int id) async {
  final db = ref.watch(databaseProvider);
  return db.getSituationEntryById(id);
}
