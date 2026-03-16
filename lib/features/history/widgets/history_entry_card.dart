import 'package:flutter/material.dart';
import 'package:innenkompass/core/constants/emotion_types.dart';
import 'package:innenkompass/core/constants/context_types.dart';
import 'package:innenkompass/data/db/app_database.dart';
import 'package:innenkompass/app/theme/colors.dart';

/// Card-Widget für einen Verlaufseintrag
class HistoryEntryCard extends StatelessWidget {
  final SituationEntryData entry;
  final VoidCallback onTap;
  final VoidCallback? onDelete;
  final bool swipeToDelete;

  const HistoryEntryCard({
    super.key,
    required this.entry,
    required this.onTap,
    this.onDelete,
    this.swipeToDelete = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Datum, Emotion, Kontext
              Row(
                children: [
                  // Emotion Emoji
                  Text(
                    _getEmotionEmoji(entry.primaryEmotion),
                    style: const TextStyle(fontSize: 28),
                  ),
                  const SizedBox(width: 12),

                  // Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _formatDate(entry.createdAt),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.grey[600],
                              ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _getEmotionLabel(entry.primaryEmotion),
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                  ),

                  // Kontext-Chip
                  Chip(
                    label: Text(
                      _getContextLabel(entry.context),
                      style: const TextStyle(fontSize: 12),
                    ),
                    avatar: Text(
                      _getContextEmoji(entry.context),
                      style: const TextStyle(fontSize: 12),
                    ),
                    visualDensity: VisualDensity.compact,
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Beschreibung (truncated)
              Text(
                entry.description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[700],
                    ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 12),

              // Footer: Intensität, Anspannung
              Row(
                children: [
                  _IntensityIndicator(
                    label: 'Belastung',
                    value: entry.intensity,
                  ),
                  const SizedBox(width: 16),
                  _IntensityIndicator(
                    label: 'Anspannung',
                    value: entry.bodyTension,
                  ),

                  const Spacer(),

                  // Intervention-Indicator
                  if (entry.interventionType != null)
                    Icon(
                      Icons.self_improvement,
                      size: 20,
                      color: AppColors.primary.withOpacity(0.6),
                    ),

                  // Krisen-Indicator
                  if (entry.isCrisis == true)
                    const Icon(
                      Icons.warning,
                      size: 20,
                      color: Colors.red,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime dt) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final entryDate = DateTime(dt.year, dt.month, dt.day);

    if (entryDate == today) {
      return 'Heute, ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    }

    final yesterday = today.subtract(const Duration(days: 1));
    if (entryDate == yesterday) {
      return 'Gestern, ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    }

    return '${dt.day}.${dt.month}.${dt.year}, ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
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
}

/// Intensitäts-Indikator
class _IntensityIndicator extends StatelessWidget {
  final String label;
  final int value;

  const _IntensityIndicator({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
        ),
        const SizedBox(width: 6),
        Container(
          width: 40,
          height: 6,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(3),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: value / 10,
            child: Container(
              decoration: BoxDecoration(
                color: _getColor(value),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          '$value',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: _getColor(value),
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
