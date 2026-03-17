import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../app/theme/colors.dart';

/// Multi-select chip list for body symptoms.
class BodySymptomsSelector extends StatelessWidget {
  const BodySymptomsSelector({
    super.key,
    required this.selectedSymptoms,
    required this.onSymptomsChanged,
  });

  final List<String> selectedSymptoms;
  final ValueChanged<List<String>> onSymptomsChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppConstants.spacingSmall,
      runSpacing: AppConstants.spacingSmall,
      children: AppConstants.commonBodySymptoms.map((symptom) {
        final isSelected = selectedSymptoms.contains(symptom);
        return _SymptomChip(
          symptom: symptom,
          isSelected: isSelected,
          onTap: () {
            final updated = List<String>.from(selectedSymptoms);
            if (isSelected) {
              updated.remove(symptom);
            } else {
              updated.add(symptom);
            }
            onSymptomsChanged(updated);
          },
        );
      }).toList(),
    );
  }
}

class _SymptomChip extends StatelessWidget {
  const _SymptomChip({
    required this.symptom,
    required this.isSelected,
    required this.onTap,
  });

  final String symptom;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spacingSmall,
          vertical: AppConstants.spacingSmall,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.secondarySoft
              : AppColors.surfaceStrong.withValues(alpha: 0.88),
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          border: Border.all(
            color: isSelected ? AppColors.secondary : AppColors.borderLight,
          ),
        ),
        child: Text(
          symptom,
          style: theme.textTheme.bodySmall?.copyWith(
            color:
                isSelected ? AppColors.secondaryDark : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
