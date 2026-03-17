import 'package:flutter/material.dart';
import '../../../app/theme/colors.dart';
import '../../../core/constants/app_constants.dart';

/// Info card for displaying informational messages.
///
/// Features:
/// - Type-based styling (info, warning, error, success)
/// - Icon based on type
/// - Optional title
enum AppInfoCardType { info, warning, error, success }

class AppInfoCard extends StatelessWidget {
  const AppInfoCard({
    super.key,
    required this.type,
    required this.message,
    this.title,
    this.onAction,
    this.actionLabel,
  });

  final AppInfoCardType type;
  final String message;
  final String? title;
  final VoidCallback? onAction;
  final String? actionLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = _getColors();

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppConstants.spacingMedium,
        vertical: AppConstants.spacingSmall,
      ),
      padding: const EdgeInsets.all(AppConstants.spacingMedium),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(color: colors.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colors.iconBackground,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  colors.icon,
                  size: 20,
                  color: colors.iconColor,
                ),
              ),
              const SizedBox(width: AppConstants.spacingMedium),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (title != null) ...[
                      Text(
                        title!,
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: colors.text,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: AppConstants.spacingSmall),
                    ],
                    Text(
                      message,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colors.text,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (onAction != null && actionLabel != null) ...[
            const SizedBox(height: AppConstants.spacingMedium),
            TextButton(
              onPressed: onAction,
              child: Text(actionLabel!),
            ),
          ],
        ],
      ),
    );
  }

  _InfoCardColors _getColors() {
    switch (type) {
      case AppInfoCardType.info:
        return _InfoCardColors(
          background: AppColors.primary.withValues(alpha: 0.1),
          border: AppColors.primary.withValues(alpha: 0.3),
          icon: Icons.info_outline,
          iconColor: AppColors.primary,
          iconBackground: AppColors.primary.withValues(alpha: 0.2),
          text: AppColors.textPrimary,
        );
      case AppInfoCardType.warning:
        return _InfoCardColors(
          background: AppColors.warning.withValues(alpha: 0.1),
          border: AppColors.warning.withValues(alpha: 0.3),
          icon: Icons.warning_amber_rounded,
          iconColor: AppColors.warning,
          iconBackground: AppColors.warning.withValues(alpha: 0.2),
          text: AppColors.textPrimary,
        );
      case AppInfoCardType.error:
        return _InfoCardColors(
          background: AppColors.error.withValues(alpha: 0.1),
          border: AppColors.error.withValues(alpha: 0.3),
          icon: Icons.error_outline,
          iconColor: AppColors.error,
          iconBackground: AppColors.error.withValues(alpha: 0.2),
          text: AppColors.textPrimary,
        );
      case AppInfoCardType.success:
        return _InfoCardColors(
          background: AppColors.success.withValues(alpha: 0.1),
          border: AppColors.success.withValues(alpha: 0.3),
          icon: Icons.check_circle_outline,
          iconColor: AppColors.success,
          iconBackground: AppColors.success.withValues(alpha: 0.2),
          text: AppColors.textPrimary,
        );
    }
  }
}

class _InfoCardColors {
  final Color background;
  final Color border;
  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final Color text;

  _InfoCardColors({
    required this.background,
    required this.border,
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.text,
  });
}

/// Crisis info card specifically for emergency contacts and hotlines.
class AppCrisisInfoCard extends StatelessWidget {
  const AppCrisisInfoCard({
    super.key,
    this.title = 'Krisenhilfe',
    required this.hotlines,
    this.message,
  });

  final String title;
  final List<String> hotlines;
  final String? message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.all(AppConstants.spacingMedium),
      padding: const EdgeInsets.all(AppConstants.spacingMedium),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border:
            Border.all(color: AppColors.error.withValues(alpha: 0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.phone_in_talk,
                  size: 20,
                  color: AppColors.error,
                ),
              ),
              const SizedBox(width: AppConstants.spacingMedium),
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: AppColors.error,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          if (message != null) ...[
            const SizedBox(height: AppConstants.spacingSmall),
            Text(
              message!,
              style: theme.textTheme.bodyMedium,
            ),
          ],
          if (hotlines.isNotEmpty) ...[
            const SizedBox(height: AppConstants.spacingMedium),
            ...hotlines.map((hotline) => Padding(
                  padding:
                      const EdgeInsets.only(bottom: AppConstants.spacingSmall),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.phone,
                        size: 16,
                        color: AppColors.error,
                      ),
                      const SizedBox(width: AppConstants.spacingSmall),
                      Text(
                        hotline,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.error,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ],
      ),
    );
  }
}
