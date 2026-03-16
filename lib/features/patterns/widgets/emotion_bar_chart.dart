import 'package:flutter/material.dart';
import 'package:innenkompass/core/constants/emotion_types.dart';
import 'package:innenkompass/app/theme/colors.dart';

/// Balkendiagramm für Emotions-Häufigkeiten
class EmotionBarChart extends StatelessWidget {
  final Map<EmotionType, int> emotionFrequency;
  final int totalEntries;

  const EmotionBarChart({
    super.key,
    required this.emotionFrequency,
    required this.totalEntries,
  });

  @override
  Widget build(BuildContext context) {
    final sortedEmotions = emotionFrequency.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    if (sortedEmotions.isEmpty) {
      return const Center(
        child: Text('Keine Daten verfügbar'),
      );
    }

    final maxCount = sortedEmotions.first.value;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top 3 Emotionen als Highlight
            ...sortedEmotions.take(3).map((entry) {
              final percentage = (entry.value / totalEntries * 100);
              final barWidth = entry.value / maxCount;

              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header: Emoji, Label, Percentage
                    Row(
                      children: [
                        Text(
                          _getEmotionEmoji(entry.key),
                          style: const TextStyle(fontSize: 24),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _getEmotionLabel(entry.key),
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                        Text(
                          '${percentage.toInt()}%',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: _getEmotionColor(entry.key),
                              ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Bar
                    Stack(
                      children: [
                        Container(
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: barWidth,
                          child: Container(
                            height: 12,
                            decoration: BoxDecoration(
                              color: _getEmotionColor(entry.key),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    // Count
                    Text(
                      '${entry.value}x',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                  ],
                ),
              );
            }).toList(),

            // Divider
            if (sortedEmotions.length > 3)
              Divider(color: Colors.grey[200]),

            // Weitere Emotionen (kompakt)
            if (sortedEmotions.length > 3)
              ...sortedEmotions.skip(3).map((entry) {
                final percentage = (entry.value / totalEntries * 100);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Text(
                        _getEmotionEmoji(entry.key),
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _getEmotionLabel(entry.key),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      Text(
                        '${percentage.toInt()}%',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                );
              }).toList(),
          ],
        ),
      ),
    );
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

  Color _getEmotionColor(EmotionType emotion) {
    final colors = {
      EmotionType.anger: AppColors.error,
      EmotionType.fear: Colors.orange,
      EmotionType.sadness: Colors.blue,
      EmotionType.shame: Colors.purple,
      EmotionType.disgust: Colors.green[700]!,
      EmotionType.joy: AppColors.success,
      EmotionType.surprise: Colors.cyan,
      EmotionType.guilt: Colors.brown,
      EmotionType.pride: AppColors.success,
      EmotionType.loneliness: Colors.grey,
    };
    return colors[emotion] ?? Colors.grey;
  }
}
