import 'package:flutter/material.dart';
import '../../../../core/constants/context_types.dart';
import '../../../../app/theme/colors.dart';
import '../../../../core/constants/app_constants.dart';

/// Horizontal scrollable selector for context types.
class ContextSelector extends StatelessWidget {
  const ContextSelector({
    super.key,
    required this.selectedContext,
    required this.onContextSelected,
  });

  final ContextType? selectedContext;
  final ValueChanged<ContextType> onContextSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: ContextType.values.length,
        separatorBuilder: (context, index) =>
            const SizedBox(width: AppConstants.spacingSmall),
        itemBuilder: (context, index) {
          final contextType = ContextType.values[index];
          final isSelected = selectedContext == contextType;

          return _ContextChip(
            contextType: contextType,
            isSelected: isSelected,
            onTap: () => onContextSelected(contextType),
          );
        },
      ),
    );
  }
}

class _ContextChip extends StatelessWidget {
  const _ContextChip({
    required this.contextType,
    required this.isSelected,
    required this.onTap,
  });

  final ContextType contextType;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spacingMedium,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primarySoft
              : AppColors.surfaceStrong.withValues(alpha: 0.88),
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.borderLight,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              contextType.emoji,
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(width: AppConstants.spacingSmall),
            Text(
              contextType.label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isSelected
                        ? AppColors.primaryDark
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
