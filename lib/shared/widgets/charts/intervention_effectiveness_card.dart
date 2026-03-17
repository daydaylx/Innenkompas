import 'package:flutter/material.dart';
import 'package:innenkompass/app/theme/colors.dart';
import 'package:innenkompass/core/constants/app_constants.dart';
import 'package:innenkompass/domain/models/intervention.dart';

/// Ruhige Liste hilfreicher Interventionen.
class InterventionEffectivenessCard extends StatelessWidget {
  const InterventionEffectivenessCard({
    super.key,
    required this.interventions,
    this.title = 'Hilfreichste Interventionen',
    this.maxItems = 5,
  });

  final List<InterventionEffectiveness> interventions;
  final String title;
  final int maxItems;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (interventions.isEmpty) {
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
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Die Liste zeigt, welche Schritte zuletzt am ehesten Erleichterung gebracht haben.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: AppConstants.spacingLarge),
          ...interventions.take(maxItems).map(_buildItem),
        ],
      ),
    );
  }

  Widget _buildItem(InterventionEffectiveness effectiveness) {
    return Builder(
      builder: (context) {
        final theme = Theme.of(context);
        final improvement = effectiveness.avgImprovement;
        final highlightColor = improvement > 0
            ? AppColors.success
            : improvement < 0
                ? AppColors.error
                : AppColors.secondary;

        return Container(
          margin: const EdgeInsets.only(bottom: AppConstants.spacingMedium),
          padding: const EdgeInsets.all(AppConstants.spacingMedium),
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant.withValues(alpha: 0.65),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: highlightColor.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      _iconFor(improvement),
                      color: highlightColor,
                    ),
                  ),
                  const SizedBox(width: AppConstants.spacingMedium),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          effectiveness.title,
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${effectiveness.usageCount}x verwendet',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        improvement > 0
                            ? '+${improvement.toStringAsFixed(1)}'
                            : improvement.toStringAsFixed(1),
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: highlightColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Entlastung',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.spacingMedium),
              Row(
                children: [
                  Icon(
                    Icons.star_rounded,
                    size: 16,
                    color: AppColors.warning,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    effectiveness.avgHelpfulnessRating.toStringAsFixed(1),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: AppConstants.spacingMedium),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: LinearProgressIndicator(
                        minHeight: 6,
                        value: (improvement.abs() / 10).clamp(0.0, 1.0),
                        backgroundColor: AppColors.surface,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(highlightColor),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  IconData _iconFor(double improvement) {
    if (improvement >= 3) return Icons.emoji_events_outlined;
    if (improvement >= 1.5) return Icons.favorite_border_rounded;
    if (improvement >= 0) return Icons.check_circle_outline_rounded;
    return Icons.refresh_rounded;
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
        'Noch keine Interventionen durchgefuehrt.',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
      ),
    );
  }
}
