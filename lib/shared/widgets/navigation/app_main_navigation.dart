import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../app/theme/colors.dart';
import '../../../core/constants/app_constants.dart';

/// Persistent main navigation for the app's primary areas.
class AppMainNavigationBar extends StatelessWidget {
  const AppMainNavigationBar({
    super.key,
    required this.currentRoute,
  });

  final String currentRoute;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppConstants.spacingMedium,
          0,
          AppConstants.spacingMedium,
          AppConstants.spacingMedium,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spacingSmall,
            vertical: AppConstants.spacingSmall,
          ),
          decoration: BoxDecoration(
            color: AppColors.backgroundElevated.withValues(alpha: 0.96),
            borderRadius: BorderRadius.circular(
              AppConstants.borderRadiusLarge,
            ),
            border: Border.all(color: AppColors.borderLight),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadowLight,
                blurRadius: 22,
                offset: Offset(0, 12),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: _NavItem(
                  label: 'Start',
                  icon: Icons.home_outlined,
                  activeIcon: Icons.home_rounded,
                  selected: currentRoute == AppRoutes.home,
                  onTap: () => context.go(AppRoutes.home),
                ),
              ),
              Expanded(
                child: _NavItem(
                  label: 'Verlauf',
                  icon: Icons.schedule_outlined,
                  activeIcon: Icons.schedule_rounded,
                  selected: currentRoute == AppRoutes.history,
                  onTap: () => context.go(AppRoutes.history),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.spacingSmall,
                ),
                child: FilledButton.icon(
                  onPressed: () => context.push(AppRoutes.newSituationEvent),
                  icon: const Icon(Icons.add_circle_outline),
                  label: const Text('Neu'),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(0, 52),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.spacingMedium,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppConstants.borderRadius,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: _NavItem(
                  label: 'Muster',
                  icon: Icons.insights_outlined,
                  activeIcon: Icons.insights_rounded,
                  selected: currentRoute == AppRoutes.patterns,
                  onTap: () => context.go(AppRoutes.patterns),
                ),
              ),
              Expanded(
                child: _NavItem(
                  label: 'Hilfe',
                  icon: Icons.sos_outlined,
                  activeIcon: Icons.sos_rounded,
                  selected: currentRoute == AppRoutes.crisis,
                  onTap: () => context.go(AppRoutes.crisis),
                ),
              ),
              Expanded(
                child: _NavItem(
                  label: 'Mehr',
                  icon: Icons.settings_outlined,
                  activeIcon: Icons.settings_rounded,
                  selected: currentRoute == AppRoutes.settings,
                  onTap: () => context.go(AppRoutes.settings),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final IconData activeIcon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primaryDark : AppColors.textTertiary;

    return InkWell(
      borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      onTap: selected ? null : onTap,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: AppConstants.spacingSmall),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(selected ? activeIcon : icon, color: color, size: 22),
            const SizedBox(height: 4),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: color,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
