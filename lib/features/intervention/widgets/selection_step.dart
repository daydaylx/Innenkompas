import 'package:flutter/material.dart';
import 'package:innenkompass/core/constants/app_constants.dart';

/// Widget für Auswahl-Schritte mit Options-Buttons
class SelectionStep extends StatelessWidget {
  final List<String> options;
  final String? selectedOption;
  final ValueChanged<String> onOptionSelected;
  final bool allowMultiple;

  const SelectionStep({
    super.key,
    required this.options,
    required this.selectedOption,
    required this.onOptionSelected,
    this.allowMultiple = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: options.map((option) {
        final isSelected = selectedOption == option;

        return Padding(
          padding: const EdgeInsets.only(bottom: AppConstants.spacingSmall),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => onOptionSelected(option),
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
                      ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                      : Colors.transparent,
                ),
                child: Row(
                  children: [
                    // Radio-Button-Style Indicator
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
                          ? const Icon(
                              Icons.check,
                              size: 14,
                              color: Colors.white,
                            )
                          : null,
                    ),

                    const SizedBox(width: AppConstants.spacingMedium),

                    // Option-Text
                    Expanded(
                      child: Text(
                        option,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight:
                                  isSelected ? FontWeight.w600 : FontWeight.normal,
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
