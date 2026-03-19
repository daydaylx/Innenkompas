import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/router.dart';
import '../../../app/theme/colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../../shared/widgets/cards/app_card.dart';
import '../../../shared/widgets/navigation/app_main_navigation.dart';
import '../widgets/home_widgets.dart';

/// Main home screen for Innenkompass.
///
/// Features:
/// - Primary action button for new situation
/// - Quick action tiles (history, patterns)
/// - Prominent crisis button
/// - Last entry preview
/// - Settings in app bar
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return AppScaffold(
      title: 'Innenkompass',
      backgroundVariant: AppBackgroundVariant.calm,
      actions: [
        IconButton(
          icon: const Icon(Icons.settings_outlined),
          onPressed: () => context.push(AppRoutes.settings),
          tooltip: 'Einstellungen',
        ),
      ],
      bottomNavigationBar: const AppMainNavigationBar(
        currentRoute: AppRoutes.home,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppConstants.spacingMedium,
          AppConstants.spacingSmall,
          AppConstants.spacingMedium,
          AppConstants.spacingXLarge,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppCard(
              variant: AppCardVariant.glass,
              margin: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceStrong.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(
                        AppConstants.borderRadiusPill,
                      ),
                    ),
                    child: Text(
                      'Ruhiger Einstieg',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: AppColors.primaryDark,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingMedium),
                  Text(
                    'Hier kannst du kurz landen, sortieren und weiterdenken.',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingSmall),
                  Text(
                    'Starte mit einer Situation oder öffne deinen Verlauf und erkenne Zusammenhänge in ruhigen Schritten.',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppConstants.spacingLarge),
            PrimaryActionButton(
              label: 'Was ist passiert?',
              subtitle: 'Neue Situation erfassen',
              icon: Icons.add_circle_outline,
              onPressed: () => context.push(AppRoutes.newSituationEvent),
            ),
            const SizedBox(height: AppConstants.spacingMedium),
            _QuickCheckinButton(
              onTap: () => context.push(AppRoutes.quickCheckin),
            ),
            const SizedBox(height: AppConstants.spacingLarge),
            Row(
              children: [
                Expanded(
                  child: QuickActionTile(
                    label: 'Verlauf',
                    icon: Icons.calendar_today_outlined,
                    color: AppColors.primary,
                    onTap: () => context.push(AppRoutes.history),
                  ),
                ),
                const SizedBox(width: AppConstants.spacingMedium),
                Expanded(
                  child: QuickActionTile(
                    label: 'Muster',
                    icon: Icons.insights_outlined,
                    color: AppColors.secondary,
                    onTap: () => context.push(AppRoutes.patterns),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.spacingLarge),
            const LastEntryPreview(),
            const SizedBox(height: AppConstants.spacingLarge),
            HomeCrisisButton(
              onPressed: () => context.push(AppRoutes.crisis),
            ),
          ],
        ),
      ),
    );
  }
}

/// Kompakter Quick-Check-in-Button für den Home-Screen.
class _QuickCheckinButton extends StatelessWidget {
  const _QuickCheckinButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spacingLarge,
            vertical: AppConstants.spacingMedium,
          ),
          decoration: BoxDecoration(
            color: AppColors.secondary.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            border: Border.all(
              color: AppColors.secondary.withValues(alpha: 0.25),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.secondary.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.checklist_rounded,
                  size: 20,
                  color: AppColors.secondary,
                ),
              ),
              const SizedBox(width: AppConstants.spacingMedium),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kurz einchecken',
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '30 Sekunden · Emotion + Belastung',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: AppColors.textTertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
