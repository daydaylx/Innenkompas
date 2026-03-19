import 'package:flutter/material.dart';

import '../../../../app/theme/colors.dart';
import '../../../../core/constants/app_constants.dart';

class IntensitySlider extends StatelessWidget {
  const IntensitySlider({
    super.key,
    required this.preTriggerLoad,
    required this.intensity,
    required this.bodyTension,
    required this.onPreTriggerLoadChanged,
    required this.onIntensityChanged,
    required this.onBodyTensionChanged,
  });

  final int preTriggerLoad;
  final int intensity;
  final int bodyTension;
  final ValueChanged<int> onPreTriggerLoadChanged;
  final ValueChanged<int> onIntensityChanged;
  final ValueChanged<int> onBodyTensionChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _SegmentSection(
          label: 'Wie belastet warst du schon vor dem Auslöser?',
          helper: '0 heißt kaum belastet, 10 heißt schon vorher maximal voll.',
          value: preTriggerLoad,
          onChanged: onPreTriggerLoadChanged,
        ),
        const SizedBox(height: AppConstants.spacingLarge),
        _SegmentSection(
          label: 'Wie stark war die Belastung im Moment?',
          helper: 'Es reicht eine grobe Einschätzung.',
          value: intensity,
          onChanged: onIntensityChanged,
        ),
        const SizedBox(height: AppConstants.spacingLarge),
        _SegmentSection(
          label: 'Wie stark war die körperliche Anspannung?',
          helper: 'Auch hier reicht eine schnelle grobe Zahl.',
          value: bodyTension,
          onChanged: onBodyTensionChanged,
        ),
      ],
    );
  }
}

class _SegmentSection extends StatelessWidget {
  const _SegmentSection({
    required this.label,
    required this.helper,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final String helper;
  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tone = AppColors.intensityColor(value == 0 ? 1 : value);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: tone.withValues(alpha: 0.14),
                borderRadius:
                    BorderRadius.circular(AppConstants.borderRadiusPill),
              ),
              child: Text(
                '$value / 10',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: tone,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.spacingSmall),
        Text(
          helper,
          style: theme.textTheme.bodySmall?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppConstants.spacingMedium),
        Wrap(
          spacing: AppConstants.spacingSmall,
          runSpacing: AppConstants.spacingSmall,
          children: List.generate(AppConstants.maxIntensityRating + 1, (index) {
            final rating = index;
            final isSelected = value == rating;
            final color = AppColors.intensityColor(rating == 0 ? 1 : rating);

            return InkWell(
              onTap: () => onChanged(rating),
              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              child: AnimatedContainer(
                duration: const Duration(
                  milliseconds: AppConstants.animationDurationFast,
                ),
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isSelected
                      ? color.withValues(alpha: 0.18)
                      : AppColors.surfaceStrong.withValues(alpha: 0.88),
                  borderRadius:
                      BorderRadius.circular(AppConstants.borderRadius),
                  border: Border.all(
                    color: isSelected ? color : AppColors.borderLight,
                    width: isSelected ? 1.5 : 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    '$rating',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: isSelected ? color : AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: AppConstants.spacingSmall),
        Row(
          children: [
            Text(
              '0 kaum',
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
            const Spacer(),
            Text(
              '10 sehr stark',
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
