import 'package:flutter/material.dart';
import 'package:innenkompass/core/constants/emotion_types.dart';
import 'package:innenkompass/core/constants/context_types.dart';
import 'package:innenkompass/data/db/app_database.dart';
import 'package:innenkompass/app/theme/colors.dart';
import 'package:innenkompass/core/constants/app_constants.dart';
import 'package:innenkompass/shared/widgets/cards/app_card.dart';

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
    return AppListItemCard(
      variant: AppCardVariant.soft,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius:
                      BorderRadius.circular(AppConstants.borderRadius),
                ),
                child: Center(
                  child: Text(
                    _getEmotionEmoji(entry.primaryEmotion),
                    style: const TextStyle(fontSize: 28),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _formatDate(entry.timestamp),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textTertiary,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _getEmotionLabel(entry.primaryEmotion),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primarySoft,
                  borderRadius:
                      BorderRadius.circular(AppConstants.borderRadiusPill),
                ),
                child: Text(
                  '${_getContextEmoji(entry.context)} ${_getContextLabel(entry.context)}',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.primaryDark,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Beschreibung (truncated)
          Text(
            entry.situationDescription,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          if ((entry.nextStep ?? '').isNotEmpty) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: AppColors.glassOverlay,
                borderRadius:
                    BorderRadius.circular(AppConstants.borderRadiusPill),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.arrow_forward_rounded,
                    size: 16,
                    color: AppColors.primaryDark,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      entry.nextStep!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.primaryDark,
                            fontWeight: FontWeight.w600,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],

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
                  color: AppColors.accent,
                ),

              if (entry.isCrisis == true)
                const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Icon(
                    Icons.warning,
                    size: 20,
                    color: AppColors.crisis,
                  ),
                ),
            ],
          ),
        ],
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
                color: AppColors.textTertiary,
              ),
        ),
        const SizedBox(width: 6),
        Container(
          width: 40,
          height: 6,
          decoration: BoxDecoration(
            color: AppColors.borderLight,
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
