import 'package:flutter/material.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';

enum AppCardVariant { focus, soft, glass, crisis }

/// Base card widget for Innenkompass.
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.variant = AppCardVariant.focus,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final AppCardVariant variant;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(
      variant == AppCardVariant.focus
          ? AppConstants.borderRadiusLarge
          : AppConstants.borderRadius,
    );

    final decoration = _CardDecoration.fromVariant(variant);

    final content = AnimatedContainer(
      duration:
          const Duration(milliseconds: AppConstants.animationDurationNormal),
      margin: margin ??
          const EdgeInsets.symmetric(
            vertical: AppConstants.spacingSmall,
          ),
      decoration: BoxDecoration(
        color: decoration.background,
        borderRadius: borderRadius,
        border: Border.all(color: decoration.border),
        boxShadow: decoration.shadows,
      ),
      child: Padding(
        padding: padding ??
            const EdgeInsets.all(
              AppConstants.spacingLarge,
            ),
        child: child,
      ),
    );

    if (onTap == null) {
      return content;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: content,
      ),
    );
  }
}

class AppListItemCard extends StatelessWidget {
  const AppListItemCard({
    super.key,
    required this.child,
    this.onTap,
    this.variant = AppCardVariant.soft,
  });

  final Widget child;
  final VoidCallback? onTap;
  final AppCardVariant variant;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      margin: const EdgeInsets.only(
        left: AppConstants.spacingMedium,
        right: AppConstants.spacingMedium,
        bottom: AppConstants.spacingSmall,
      ),
      onTap: onTap,
      variant: variant,
      child: child,
    );
  }
}

class _CardDecoration {
  const _CardDecoration({
    required this.background,
    required this.border,
    required this.shadows,
  });

  final Color background;
  final Color border;
  final List<BoxShadow> shadows;

  factory _CardDecoration.fromVariant(AppCardVariant variant) {
    switch (variant) {
      case AppCardVariant.focus:
        return _CardDecoration(
          background: AppColors.surfaceStrong,
          border: AppColors.borderLight,
          shadows: AppTheme.floatingShadow,
        );
      case AppCardVariant.soft:
        return _CardDecoration(
          background: AppColors.surface,
          border: AppColors.borderLight,
          shadows: AppTheme.softShadow,
        );
      case AppCardVariant.glass:
        return _CardDecoration(
          background: AppColors.glassOverlay,
          border: AppColors.border,
          shadows: AppTheme.softShadow,
        );
      case AppCardVariant.crisis:
        return _CardDecoration(
          background: AppColors.crisisSurface,
          border: AppColors.errorLight,
          shadows: AppTheme.softShadow,
        );
    }
  }
}
