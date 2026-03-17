import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:innenkompass/app/theme/colors.dart';
import 'package:innenkompass/core/constants/app_constants.dart';
import 'package:innenkompass/core/constants/emotion_types.dart';

/// Ruhiges Donut-Chart fuer Emotions-Verteilungen.
class EmotionDistributionChart extends StatefulWidget {
  const EmotionDistributionChart({
    super.key,
    required this.emotionFrequency,
    required this.totalEntries,
  });

  final Map<EmotionType, int> emotionFrequency;
  final int totalEntries;

  @override
  State<EmotionDistributionChart> createState() =>
      _EmotionDistributionChartState();
}

class _EmotionDistributionChartState extends State<EmotionDistributionChart> {
  int? touchedIndex;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sortedEmotions = widget.emotionFrequency.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    if (sortedEmotions.isEmpty) {
      return _buildEmptyState(context);
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.spacingLarge),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ein Kreisbild fuer die Gesamtverteilung. Beruehren zeigt den Anteil der jeweiligen Emotion.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: AppConstants.spacingLarge),
          SizedBox(
            height: 220,
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (event, response) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          response == null ||
                          response.touchedSection == null) {
                        touchedIndex = null;
                        return;
                      }

                      touchedIndex =
                          response.touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
                borderData: FlBorderData(show: false),
                centerSpaceRadius: 56,
                sectionsSpace: 3,
                sections: _buildSections(sortedEmotions),
              ),
            ),
          ),
          const SizedBox(height: AppConstants.spacingLarge),
          Wrap(
            spacing: AppConstants.spacingSmall,
            runSpacing: AppConstants.spacingSmall,
            children: _buildLegend(theme, sortedEmotions),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _buildSections(
    List<MapEntry<EmotionType, int>> sortedEmotions,
  ) {
    return [
      for (int i = 0; i < sortedEmotions.length; i++)
        _buildSection(sortedEmotions[i], i == touchedIndex),
    ];
  }

  PieChartSectionData _buildSection(
    MapEntry<EmotionType, int> entry,
    bool isTouched,
  ) {
    final percentage = widget.totalEntries == 0
        ? 0
        : (entry.value / widget.totalEntries * 100);
    final color = _getEmotionColor(entry.key);

    return PieChartSectionData(
      value: entry.value.toDouble(),
      color: color,
      radius: isTouched ? 64 : 56,
      title: isTouched ? '${percentage.toStringAsFixed(0)} %' : '',
      titleStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontSize: 14,
      ),
      badgeWidget: isTouched
          ? _Badge(
              emoji: entry.key.emoji,
              size: 38,
            )
          : null,
      badgePositionPercentageOffset: .98,
    );
  }

  List<Widget> _buildLegend(
    ThemeData theme,
    List<MapEntry<EmotionType, int>> sortedEmotions,
  ) {
    return sortedEmotions.take(6).map((entry) {
      final color = _getEmotionColor(entry.key);
      final percentage = widget.totalEntries == 0
          ? 0
          : (entry.value / widget.totalEntries * 100).round();

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${entry.key.emoji} ${entry.key.label}  $percentage %',
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }).toList();
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

class _Badge extends StatelessWidget {
  const _Badge({
    required this.emoji,
    required this.size,
  });

  final String emoji;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.border, width: 1.5),
      ),
      alignment: Alignment.center,
      child: Text(
        emoji,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
