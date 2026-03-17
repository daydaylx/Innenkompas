import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:innenkompass/app/theme/colors.dart';
import 'package:innenkompass/core/constants/app_constants.dart';
import 'package:innenkompass/domain/models/pattern_summary.dart';

/// Ruhiges Balken-Chart fuer Wochentagsmuster.
class WeekdayPatternChart extends StatelessWidget {
  const WeekdayPatternChart({
    super.key,
    required this.timePatterns,
  });

  final TimePatterns? timePatterns;

  @override
  Widget build(BuildContext context) {
    final hasData = timePatterns != null &&
        timePatterns!.weekdayDistribution.isNotEmpty &&
        timePatterns!.weekdayDistribution.any((count) => count > 0);

    if (!hasData) {
      return _buildEmptyState(context);
    }

    final theme = Theme.of(context);
    final weekdayLabels = ['So', 'Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa'];
    final maxCount = timePatterns!.weekdayDistribution.reduce(
      (a, b) => a > b ? a : b,
    );
    final mostStressfulIndex = timePatterns!.mostStressfulWeekday;
    final avgIntensity =
        timePatterns!.avgIntensityByWeekday[mostStressfulIndex];

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
            'Die Balken zeigen, an welchen Tagen Situationen haeufiger auftauchen.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: AppConstants.spacingLarge),
          SizedBox(
            height: 190,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: (maxCount * 1.2).toDouble(),
                minY: 0,
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      final count =
                          timePatterns!.weekdayDistribution[groupIndex];
                      final avg =
                          timePatterns!.avgIntensityByWeekday[groupIndex];

                      return BarTooltipItem(
                        '$count Eintrag${count == 1 ? '' : 'e'}\n',
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                        children: [
                          TextSpan(
                            text: 'Ø ${avg.toStringAsFixed(1)} Belastung',
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: AppColors.border.withValues(alpha: 0.6),
                      strokeWidth: 1,
                    );
                  },
                ),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index < 0 || index >= weekdayLabels.length) {
                          return const SizedBox.shrink();
                        }

                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            weekdayLabels[index],
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        if (value != value.roundToDouble()) {
                          return const SizedBox.shrink();
                        }

                        return Text(
                          value.toInt().toString(),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                barGroups: [
                  for (int i = 0;
                      i < timePatterns!.weekdayDistribution.length;
                      i++)
                    _buildGroup(
                      i,
                      timePatterns!.weekdayDistribution[i].toDouble(),
                      timePatterns!.avgIntensityByWeekday[i],
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppConstants.spacingLarge),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppConstants.spacingMedium),
            decoration: BoxDecoration(
              color: _barColor(avgIntensity).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  color: _barColor(avgIntensity),
                ),
                const SizedBox(width: AppConstants.spacingMedium),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Auffaelligster Tag',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _weekdayName(mostStressfulIndex),
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Ø ${avgIntensity.toStringAsFixed(1)}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: _barColor(avgIntensity),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData _buildGroup(int x, double count, double intensity) {
    final color = _barColor(intensity);

    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: count,
          width: 18,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              color.withValues(alpha: 0.72),
              color,
            ],
          ),
        ),
      ],
    );
  }

  Color _barColor(double intensity) {
    if (intensity <= 3) return AppColors.success;
    if (intensity <= 6) return AppColors.warning;
    return AppColors.error;
  }

  String _weekdayName(int index) {
    const labels = [
      'Sonntag',
      'Montag',
      'Dienstag',
      'Mittwoch',
      'Donnerstag',
      'Freitag',
      'Samstag',
    ];
    return labels[index];
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
        'Noch keine Wochentagsmuster verfuegbar.',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
      ),
    );
  }
}
