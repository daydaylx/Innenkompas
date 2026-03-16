import 'package:flutter/material.dart';
import 'package:innenkompass/core/constants/app_constants.dart';
import 'package:innenkompass/app/theme/colors.dart';
import 'package:innenkompass/shared/widgets/buttons/app_primary_button.dart';

/// Widget für Handlungs-Schritte mit Bestätigungs-Button
class ActionStep extends StatelessWidget {
  final bool isCompleted;
  final VoidCallback onComplete;
  final String? buttonText;
  final String? completedText;
  final String? instruction;

  const ActionStep({
    super.key,
    required this.isCompleted,
    required this.onComplete,
    this.buttonText,
    this.completedText,
    this.instruction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Instruktion (falls vorhanden)
        if (instruction != null) ...[
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingMedium),
            decoration: BoxDecoration(
              color: AppColors.warning.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.warning.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: AppColors.warning.withOpacity(0.8),
                ),
                const SizedBox(width: AppConstants.spacingSmall),
                Expanded(
                  child: Text(
                    instruction!,
                    style: TextStyle(
                      color: AppColors.warning.withOpacity(0.9),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppConstants.spacingLarge),
        ],

        // Bestätigungs-Button
        if (!isCompleted)
          AppPrimaryButton(
            onPressed: onComplete,
            text: buttonText ?? 'Ich habe es erledigt',
          )
        else
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingMedium),
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.success.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle,
                  color: AppColors.success,
                ),
                const SizedBox(width: AppConstants.spacingSmall),
                Text(
                  completedText ?? 'Erledigt!',
                  style: TextStyle(
                    color: AppColors.success,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
