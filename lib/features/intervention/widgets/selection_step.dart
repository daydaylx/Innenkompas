import 'package:flutter/material.dart';
import 'package:innenkompass/core/constants/app_constants.dart';

/// Widget für Auswahl-Schritte mit Options-Buttons
/// Unterstützt Single-Select (Radio-Style) und Multi-Select (Checkbox-Style)
class SelectionStep extends StatelessWidget {
  final List<String> options;

  // Single-select
  final String? selectedOption;
  final ValueChanged<String>? onOptionSelected;

  // Multi-select
  final List<String>? selectedOptions;
  final ValueChanged<List<String>>? onOptionsChanged;

  final bool allowMultiple;

  const SelectionStep({
    super.key,
    required this.options,
    this.selectedOption,
    this.onOptionSelected,
    this.selectedOptions,
    this.onOptionsChanged,
    this.allowMultiple = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: options.map((option) {
        final bool isSelected = allowMultiple
            ? (selectedOptions?.contains(option) ?? false)
            : selectedOption == option;

        return Padding(
          padding: const EdgeInsets.only(bottom: AppConstants.spacingSmall),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                if (allowMultiple && onOptionsChanged != null) {
                  final current = List<String>.from(selectedOptions ?? []);
                  if (current.contains(option)) {
                    current.remove(option);
                  } else {
                    current.add(option);
                  }
                  onOptionsChanged!(current);
                } else if (onOptionSelected != null) {
                  onOptionSelected!(option);
                }
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(AppConstants.spacingMedium),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey[300]!,
                    width: isSelected ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  color: isSelected
                      ? Theme.of(context)
                          .colorScheme
                          .primary
                          .withValues(alpha: 0.1)
                      : Colors.transparent,
                ),
                child: Row(
                  children: [
                    // Checkbox- oder Radio-Indicator je nach Modus
                    if (allowMultiple)
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey[400]!,
                            width: 2,
                          ),
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : Colors.transparent,
                        ),
                        child: isSelected
                            ? const Icon(Icons.check,
                                size: 14, color: Colors.white)
                            : null,
                      )
                    else
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey[400]!,
                            width: 2,
                          ),
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : Colors.transparent,
                        ),
                        child: isSelected
                            ? const Icon(Icons.check,
                                size: 14, color: Colors.white)
                            : null,
                      ),

                    const SizedBox(width: AppConstants.spacingMedium),

                    // Option-Text
                    Expanded(
                      child: Text(
                        option,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                              color: isSelected
                                  ? Theme.of(context).colorScheme.primary
                                  : null,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
