import 'package:flutter/material.dart';
import '../../../../core/constants/impulse_types.dart';
import '../../../../app/theme/colors.dart';
import '../../../../core/constants/app_constants.dart';

/// Selector for impulse type.
class ImpulseSelector extends StatelessWidget {
  const ImpulseSelector({
    super.key,
    required this.selectedImpulse,
    required this.onImpulseSelected,
    this.errorText,
  });

  final ImpulseType? selectedImpulse;
  final ValueChanged<ImpulseType> onImpulseSelected;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (errorText != null) ...[
          Text(
            errorText!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.error,
            ),
          ),
          const SizedBox(height: AppConstants.spacingSmall),
        ],
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: AppConstants.spacingSmall,
          crossAxisSpacing: AppConstants.spacingSmall,
          childAspectRatio: 2.5,
          children: ImpulseType.values.map((impulse) {
            final isSelected = selectedImpulse == impulse;
            return _ImpulseTile(
              impulse: impulse,
              isSelected: isSelected,
              onTap: () => onImpulseSelected(impulse),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _ImpulseTile extends StatelessWidget {
  const _ImpulseTile({
    required this.impulse,
    required this.isSelected,
    required this.onTap,
  });

  final ImpulseType impulse;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppConstants.spacingSmall),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primarySoft
              : AppColors.surfaceStrong.withValues(alpha: 0.88),
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.borderLight,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              impulse.emoji,
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 2),
            Text(
              impulse.label,
              style: theme.textTheme.bodySmall?.copyWith(
                color:
                    isSelected ? AppColors.primaryDark : AppColors.textPrimary,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
