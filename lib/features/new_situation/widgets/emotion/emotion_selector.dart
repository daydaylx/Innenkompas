import 'package:flutter/material.dart';

import '../../../../app/theme/colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/emotion_types.dart';

class EmotionSelector extends StatelessWidget {
  const EmotionSelector({
    super.key,
    required this.primaryEmotion,
    required this.additionalEmotions,
    required this.onPrimaryChanged,
    required this.onAdditionalChanged,
  });

  final EmotionType? primaryEmotion;
  final List<EmotionType> additionalEmotions;
  final ValueChanged<EmotionType?> onPrimaryChanged;
  final ValueChanged<List<EmotionType>> onAdditionalChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Was war das stärkste Gefühl?',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppConstants.spacingSmall),
        Wrap(
          spacing: AppConstants.spacingSmall,
          runSpacing: AppConstants.spacingSmall,
          children: EmotionType.flowOptions.map((emotion) {
            final isSelected = primaryEmotion == emotion;
            return _EmotionChip(
              emotion: emotion,
              isSelected: isSelected,
              onTap: () => onPrimaryChanged(isSelected ? null : emotion),
            );
          }).toList(),
        ),
        const SizedBox(height: AppConstants.spacingLarge),
        Text(
          'Was war noch mit dabei? Optional, max. 2',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppConstants.spacingSmall),
        Wrap(
          spacing: AppConstants.spacingSmall,
          runSpacing: AppConstants.spacingSmall,
          children: EmotionType.flowOptions.where((emotion) {
            return emotion != primaryEmotion;
          }).map((emotion) {
            final isSelected = additionalEmotions.contains(emotion);
            final disableNewSelection =
                additionalEmotions.length >= 2 && !isSelected;

            return _EmotionChip(
              emotion: emotion,
              isSelected: isSelected,
              isDisabled: disableNewSelection,
              onTap: disableNewSelection
                  ? null
                  : () {
                      final updated =
                          List<EmotionType>.from(additionalEmotions);
                      if (isSelected) {
                        updated.remove(emotion);
                      } else {
                        updated.add(emotion);
                      }
                      onAdditionalChanged(updated);
                    },
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _EmotionChip extends StatelessWidget {
  const _EmotionChip({
    required this.emotion,
    required this.isSelected,
    required this.onTap,
    this.isDisabled = false,
  });

  final EmotionType emotion;
  final bool isSelected;
  final bool isDisabled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final emotionColor = Color(emotion.colorCode);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spacingMedium,
          vertical: AppConstants.spacingSmall,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? emotionColor.withValues(alpha: 0.16)
              : isDisabled
                  ? AppColors.surfaceVariant
                  : AppColors.surfaceStrong.withValues(alpha: 0.88),
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          border: Border.all(
            color: isSelected
                ? emotionColor
                : isDisabled
                    ? AppColors.border
                    : AppColors.borderLight,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              emotion.emoji,
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(width: AppConstants.spacingSmall),
            Text(
              emotion.label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isSelected
                    ? emotionColor
                    : isDisabled
                        ? AppColors.textTertiary
                        : AppColors.textPrimary,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
