import 'package:flutter/material.dart';
import 'package:innenkompass/app/theme/colors.dart';
import 'package:innenkompass/core/constants/app_constants.dart';
import 'package:innenkompass/core/constants/emotion_types.dart';

/// Ruhiges Balken-Chart fuer Emotions-Haeufigkeiten.
class EmotionBarChart extends StatelessWidget {
  const EmotionBarChart({
    super.key,
    required this.emotionFrequency,
    required this.totalEntries,
  });

  final Map<EmotionType, int> emotionFrequency;
  final int totalEntries;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sortedEmotions = emotionFrequency.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    if (sortedEmotions.isEmpty) {
      return _buildEmptyState(context);
    }

    final maxCount = sortedEmotions.first.value;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.spacingLarge),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.border.withValues(alpha: 0.7),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Die drei haeufigsten Gefuehle stehen im Vordergrund, alles Weitere bleibt dezent im Hintergrund.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: AppConstants.spacingLarge),
          ...sortedEmotions.take(3).map((entry) {
            final percentage =
                totalEntries == 0 ? 0 : (entry.value / totalEntries * 100);
            final barWidth = maxCount == 0 ? 0.0 : entry.value / maxCount;
            final color = _getEmotionColor(entry.key);

            return Padding(
              padding: const EdgeInsets.only(bottom: AppConstants.spacingLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        _getEmotionEmoji(entry.key),
                        style: const TextStyle(fontSize: 24),
                      ),
                      const SizedBox(width: AppConstants.spacingSmall),
                      Expanded(
                        child: Text(
                          _getEmotionLabel(entry.key),
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        '${percentage.toStringAsFixed(0)} %',
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: color,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppConstants.spacingSmall),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: Stack(
                      children: [
                        Container(
                          height: 12,
                          color: AppColors.surfaceVariant,
                        ),
                        FractionallySizedBox(
                          widthFactor: barWidth,
                          child: Container(
                            height: 12,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  color.withValues(alpha: 0.65),
                                  color,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${entry.value} Eintraege',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            );
          }),
          if (sortedEmotions.length > 3) ...[
            const Divider(height: 1),
            const SizedBox(height: AppConstants.spacingMedium),
            Wrap(
              spacing: AppConstants.spacingSmall,
              runSpacing: AppConstants.spacingSmall,
              children: sortedEmotions.skip(3).map((entry) {
                final percentage = totalEntries == 0
                    ? 0
                    : (entry.value / totalEntries * 100).round();
                final color = _getEmotionColor(entry.key);

                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    '${_getEmotionEmoji(entry.key)} ${_getEmotionLabel(entry.key)}  $percentage %',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.spacingLarge),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.7)),
      ),
      child: Text(
        'Keine Daten verfuegbar.',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
      ),
    );
  }

  String _getEmotionLabel(EmotionType emotion) {
    return emotion.label;
  }

  String _getEmotionEmoji(EmotionType emotion) {
    return emotion.emoji;
  }

  Color _getEmotionColor(EmotionType emotion) {
    switch (emotion) {
      case EmotionType.anger:
        return AppColors.error;
      case EmotionType.fear:
        return AppColors.warning;
      case EmotionType.sadness:
        return AppColors.secondary;
      case EmotionType.shame:
        return AppColors.secondaryDark;
      case EmotionType.disgust:
        return AppColors.primaryDark;
      case EmotionType.joy:
        return AppColors.success;
      case EmotionType.surprise:
        return AppColors.primaryLight;
      case EmotionType.guilt:
        return AppColors.errorLight;
      case EmotionType.pride:
        return AppColors.primary;
      case EmotionType.loneliness:
        return AppColors.textTertiary;
    }
  }
}
