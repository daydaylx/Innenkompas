import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../../../core/constants/app_constants.dart';

/// Distinct crisis button with higher contrast and direct affordance.
class AppCrisisButton extends StatelessWidget {
  const AppCrisisButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isEnabled = true,
    this.isFullWidth = true,
    this.icon = Icons.phone_in_talk,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isEnabled;
  final bool isFullWidth;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final effectiveOnPressed = isEnabled ? onPressed : null;
    final theme = Theme.of(context);

    Widget child = SizedBox(
      height: AppConstants.buttonHeight,
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: Colors.white),
            const SizedBox(width: AppConstants.spacingSmall),
            Text(
              label,
              style: theme.textTheme.labelLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );

    if (isFullWidth) {
      child = SizedBox(width: double.infinity, child: child);
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: effectiveOnPressed == null
            ? AppColors.textDisabled
            : AppColors.crisis,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        boxShadow: effectiveOnPressed == null
            ? const []
            : [
                BoxShadow(
                  color: AppColors.crisis.withValues(alpha: 0.2),
                  blurRadius: 18,
                  offset: const Offset(0, 10),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: effectiveOnPressed,
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          child: child,
        ),
      ),
    );
  }
}
