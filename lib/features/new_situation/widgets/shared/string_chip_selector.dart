import 'package:flutter/material.dart';

import '../../../../app/theme/colors.dart';
import '../../../../core/constants/app_constants.dart';

class StringChipSelector extends StatelessWidget {
  const StringChipSelector({
    super.key,
    required this.options,
    required this.selectedValues,
    required this.onChanged,
    this.maxSelected,
    this.errorText,
  });

  final List<String> options;
  final List<String> selectedValues;
  final ValueChanged<List<String>> onChanged;
  final int? maxSelected;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (errorText != null) ...[
          Text(
            errorText!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.error,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppConstants.spacingSmall),
        ],
        Wrap(
          spacing: AppConstants.spacingSmall,
          runSpacing: AppConstants.spacingSmall,
          children: options.map((option) {
            final isSelected = selectedValues.contains(option);
            final reachedMax = maxSelected != null &&
                selectedValues.length >= maxSelected! &&
                !isSelected;

            return FilterChip(
              label: Text(option),
              selected: isSelected,
              onSelected: reachedMax
                  ? null
                  : (selected) {
                      final updated = List<String>.from(selectedValues);
                      if (selected) {
                        updated.add(option);
                      } else {
                        updated.remove(option);
                      }
                      onChanged(updated);
                    },
            );
          }).toList(),
        ),
      ],
    );
  }
}
