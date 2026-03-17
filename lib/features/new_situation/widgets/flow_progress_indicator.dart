import 'package:flutter/material.dart';
import '../../../app/theme/colors.dart';
import '../../../core/constants/app_constants.dart';

/// Progress indicator for the new situation flow.
///
/// Shows the current step as dots with text.
class FlowProgressIndicator extends StatelessWidget {
  const FlowProgressIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingMedium),
      decoration: BoxDecoration(
        color: AppColors.glassOverlay,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        children: [
          Text(
            'Schritt $currentStep von $totalSteps',
            style: theme.textTheme.labelLarge?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppConstants.spacingSmall),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              totalSteps,
              (index) => _buildDot(index + 1, theme),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int step, ThemeData theme) {
    final isCompleted = step < currentStep;
    final isCurrent = step == currentStep;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isCurrent ? 36.0 : 12.0,
      height: 12.0,
      decoration: BoxDecoration(
        color: isCompleted || isCurrent
            ? AppColors.primary
            : AppColors.surfaceMuted,
        borderRadius: BorderRadius.circular(6),
        boxShadow: isCurrent
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.25),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ]
            : null,
      ),
    );
  }
}
