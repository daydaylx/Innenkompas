import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:innenkompass/app/theme/colors.dart';
import 'package:innenkompass/core/constants/app_constants.dart';
import 'package:innenkompass/domain/models/pattern_summary.dart';

/// Ruhiges Linienchart fuer Belastungs- und Anspannungs-Trends.
class IntensityTrendChart extends StatefulWidget {
  const IntensityTrendChart({
    super.key,
    required this.intensityTrend,
    this.tensionTrend,
  });

  final List<TrendDataPoint> intensityTrend;
  final List<TrendDataPoint>? tensionTrend;

  @override
  State<IntensityTrendChart> createState() => _IntensityTrendChartState();
}

class _IntensityTrendChartState extends State<IntensityTrendChart> {
  bool showIntensity = true;
  bool showTension = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (widget.intensityTrend.isEmpty) {
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Belastung im Verlauf',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Die Kurve zeigt, ob die letzten Eintraege eher hoch, schwankend oder ruhiger verlaufen.',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppConstants.spacingMedium),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _LegendToggle(
                    color: AppColors.primary,
                    label: 'Belastung',
                    isActive: showIntensity,
                    onTap: () => setState(() => showIntensity = !showIntensity),
                  ),
                  if (widget.tensionTrend != null &&
                      widget.tensionTrend!.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    _LegendToggle(
                      color: AppColors.secondary,
                      label: 'Anspannung',
                      isActive: showTension,
                      onTap: () => setState(() => showTension = !showTension),
                    ),
                  ],
                ],
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingLarge),
          SizedBox(
            height: 220,
            child: LineChart(
              LineChartData(
                minY: 0,
                maxY: 10,
                minX: 0,
                maxX: (widget.intensityTrend.length - 1).toDouble(),
                backgroundColor: Colors.transparent,
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 2,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: AppColors.border.withValues(alpha: 0.6),
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: widget.intensityTrend.length <= 10,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index < 0 ||
                            index >= widget.intensityTrend.length) {
                          return const SizedBox.shrink();
                        }

                        final date = widget.intensityTrend[index].date;
                        return Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            '${date.day}.${date.month}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 26,
                      interval: 2,
                      getTitlesWidget: (value, meta) {
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
                borderData: FlBorderData(show: false),
                lineTouchData: LineTouchData(
                  enabled: true,
                  touchTooltipData: LineTouchTooltipData(
                    tooltipRoundedRadius: 16,
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((spot) {
                        final label =
                            spot.barIndex == 0 ? 'Belastung' : 'Anspannung';
                        return LineTooltipItem(
                          '$label\n${spot.y.toStringAsFixed(1)}',
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),
                lineBarsData: _buildLineBars(),
              ),
            ),
          ),
          const SizedBox(height: AppConstants.spacingMedium),
          Text(
            _buildInsightText(),
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  List<LineChartBarData> _buildLineBars() {
    final lines = <LineChartBarData>[];

    if (showIntensity) {
      lines.add(
        LineChartBarData(
          spots: _spotsFor(widget.intensityTrend),
          isCurved: true,
          color: AppColors.primary,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) {
              return FlDotCirclePainter(
                radius: 3.5,
                color: AppColors.primary,
                strokeWidth: 0,
              );
            },
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.primary.withValues(alpha: 0.16),
                AppColors.primary.withValues(alpha: 0.02),
              ],
            ),
          ),
        ),
      );
    }

    if (showTension &&
        widget.tensionTrend != null &&
        widget.tensionTrend!.isNotEmpty) {
      lines.add(
        LineChartBarData(
          spots: _spotsFor(widget.tensionTrend!),
          isCurved: true,
          color: AppColors.secondary,
          dashArray: const [8, 5],
          barWidth: 2.5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) {
              return FlDotCirclePainter(
                radius: 3,
                color: AppColors.secondary,
                strokeWidth: 0,
              );
            },
          ),
        ),
      );
    }

    return lines;
  }

  List<FlSpot> _spotsFor(List<TrendDataPoint> trend) {
    return [
      for (int i = 0; i < trend.length; i++)
        FlSpot(i.toDouble(), trend[i].value),
    ];
  }

  String _buildInsightText() {
    final latestIntensity = widget.intensityTrend.last.value;
    final firstIntensity = widget.intensityTrend.first.value;
    final delta = latestIntensity - firstIntensity;

    if (delta.abs() < 0.5) {
      return 'Die Belastung liegt zuletzt ungefaehr auf dem Niveau der ersten sichtbaren Eintraege.';
    }

    if (delta < 0) {
      return 'Die Belastung entwickelt sich zuletzt etwas ruhiger als zu Beginn des sichtbaren Verlaufs.';
    }

    return 'Die Belastung liegt zuletzt etwas hoeher als am Anfang des sichtbaren Verlaufs.';
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
        'Noch nicht genug Daten fuer einen Trend.',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
      ),
    );
  }
}

class _LegendToggle extends StatelessWidget {
  const _LegendToggle({
    required this.color,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final Color color;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive
              ? color.withValues(alpha: 0.14)
              : AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: isActive ? color.withValues(alpha: 0.4) : AppColors.border,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: isActive ? color : AppColors.textTertiary,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: isActive ? color : AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
