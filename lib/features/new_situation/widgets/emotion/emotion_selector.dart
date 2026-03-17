import 'package:flutter/material.dart';
import '../../../../core/constants/emotion_types.dart';
import '../../../../app/theme/colors.dart';
import '../../../../core/constants/app_constants.dart';

/// Emotion selector with primary (required) and secondary (optional) selection.
class EmotionSelector extends StatelessWidget {
  const EmotionSelector({
    super.key,
    required this.primaryEmotion,
    required this.secondaryEmotion,
    required this.onPrimaryChanged,
    required this.onSecondaryChanged,
  });

  final EmotionType? primaryEmotion;
  final EmotionType? secondaryEmotion;
  final ValueChanged<EmotionType?> onPrimaryChanged;
  final ValueChanged<EmotionType?> onSecondaryChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Primary emotion (required)
        Text(
          'Was hast du am stärksten gespürt?',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: AppConstants.spacingSmall),
        Wrap(
          spacing: AppConstants.spacingSmall,
          runSpacing: AppConstants.spacingSmall,
          children: EmotionType.values.map((emotion) {
            final isSelected = primaryEmotion == emotion;
            return _EmotionChip(
              emotion: emotion,
              isSelected: isSelected,
              isPrimary: true,
              onTap: () => onPrimaryChanged(isSelected ? null : emotion),
            );
          }).toList(),
        ),
        const SizedBox(height: AppConstants.spacingLarge),

        // Secondary emotion (optional)
        Text(
          'Was hast du sonst noch gespürt? (Optional)',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppConstants.spacingSmall),
        Wrap(
          spacing: AppConstants.spacingSmall,
          runSpacing: AppConstants.spacingSmall,
          children: EmotionType.values.map((emotion) {
            // Don't show primary emotion as an option for secondary
            if (emotion == primaryEmotion) {
              return const SizedBox.shrink();
            }
            final isSelected = secondaryEmotion == emotion;
            return _EmotionChip(
              emotion: emotion,
              isSelected: isSelected,
              isPrimary: false,
              onTap: () => onSecondaryChanged(isSelected ? null : emotion),
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
    required this.isPrimary,
    required this.onTap,
  });

  final EmotionType emotion;
  final bool isSelected;
  final bool isPrimary;
  final VoidCallback onTap;

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
              : AppColors.surfaceStrong.withValues(alpha: 0.88),
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          border: Border.all(
            color: isSelected ? emotionColor : AppColors.borderLight,
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
                color: isSelected ? emotionColor : AppColors.textPrimary,
                fontWeight:
                    isPrimary && isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
