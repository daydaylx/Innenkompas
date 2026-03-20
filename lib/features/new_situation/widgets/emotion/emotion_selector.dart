import 'package:flutter/material.dart';

import '../../../../app/theme/colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/emotion_types.dart';

typedef _EmotionCluster = ({String label, List<EmotionType> emotions});

final List<_EmotionCluster> _emotionClusters = [
  (label: 'Wut & Gereiztheit', emotions: [EmotionType.anger, EmotionType.annoyance]),
  (
    label: 'Angst & Druck',
    emotions: [
      EmotionType.fear,
      EmotionType.overwhelm,
      EmotionType.powerlessness,
      EmotionType.helplessness,
    ]
  ),
  (
    label: 'Schmerz & Verlust',
    emotions: [
      EmotionType.hurt,
      EmotionType.sadness,
      EmotionType.disappointment,
      EmotionType.emptiness,
    ]
  ),
  (label: 'Ich & Selbstbild', emotions: [EmotionType.shame, EmotionType.guilt]),
];

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
        ..._buildClusteredChips(
          theme: theme,
          isChipVisible: (_) => true,
          isChipSelected: (e) => primaryEmotion == e,
          isChipDisabled: (_) => false,
          onChipTap: (emotion) {
            final isSelected = primaryEmotion == emotion;
            onPrimaryChanged(isSelected ? null : emotion);
          },
        ),
        const SizedBox(height: AppConstants.spacingLarge),
        Text(
          'Was war noch mit dabei? Optional, max. 2',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppConstants.spacingSmall),
        ..._buildClusteredChips(
          theme: theme,
          isChipVisible: (e) => e != primaryEmotion,
          isChipSelected: (e) => additionalEmotions.contains(e),
          isChipDisabled: (e) =>
              additionalEmotions.length >= 2 && !additionalEmotions.contains(e),
          onChipTap: (emotion) {
            final updated = List<EmotionType>.from(additionalEmotions);
            if (additionalEmotions.contains(emotion)) {
              updated.remove(emotion);
            } else {
              updated.add(emotion);
            }
            onAdditionalChanged(updated);
          },
        ),
      ],
    );
  }

  List<Widget> _buildClusteredChips({
    required ThemeData theme,
    required bool Function(EmotionType) isChipVisible,
    required bool Function(EmotionType) isChipSelected,
    required bool Function(EmotionType) isChipDisabled,
    required void Function(EmotionType) onChipTap,
  }) {
    final widgets = <Widget>[];
    var isFirst = true;

    for (final cluster in _emotionClusters) {
      final visible = cluster.emotions.where(isChipVisible).toList();
      if (visible.isEmpty) continue;

      if (!isFirst) {
        widgets.add(const SizedBox(height: AppConstants.spacingSmall));
      }
      isFirst = false;

      widgets.add(
        Text(
          cluster.label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: AppColors.textTertiary,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      );
      widgets.add(const SizedBox(height: 4));
      widgets.add(
        Wrap(
          spacing: AppConstants.spacingSmall,
          runSpacing: AppConstants.spacingSmall,
          children: visible.map((emotion) {
            final disabled = isChipDisabled(emotion);
            return _EmotionChip(
              emotion: emotion,
              isSelected: isChipSelected(emotion),
              isDisabled: disabled,
              onTap: disabled ? null : () => onChipTap(emotion),
            );
          }).toList(),
        ),
      );
    }

    return widgets;
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
