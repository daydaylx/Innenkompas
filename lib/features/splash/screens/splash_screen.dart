import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../app/theme/colors.dart';
import '../../../application/providers/database_provider.dart';
import '../../../application/providers/lock_provider.dart';
import '../../../application/providers/settings_provider.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../../shared/widgets/cards/app_card.dart';

/// App entry splash screen with quiet startup state.
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool _didNavigate = false;

  @override
  Widget build(BuildContext context) {
    final setupState = ref.watch(databaseSetupProvider);
    final settings = ref.watch(settingsNotifierProvider);
    final lockState = ref.watch(lockStateProvider);

    final canRoute = setupState.hasValue && settings != null && !_didNavigate;
    if (canRoute) {
      final target = lockState.isLocked
          ? AppRoutes.lock
          : settings.onboardingCompleted
              ? AppRoutes.home
              : AppRoutes.onboarding;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted || _didNavigate) return;
        _didNavigate = true;
        context.go(target);
      });
    }

    return AppScaffold(
      title: AppConstants.appName,
      backgroundVariant: AppBackgroundVariant.calm,
      showAppBar: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.spacingLarge),
          child: AppCard(
            variant: AppCardVariant.glass,
            margin: EdgeInsets.zero,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 84,
                  height: 84,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.surfaceStrong.withValues(alpha: 0.82),
                    border: Border.all(color: AppColors.borderLight),
                  ),
                  child: const Icon(
                    Icons.explore_outlined,
                    size: 40,
                    color: AppColors.primaryDark,
                  ),
                ),
                const SizedBox(height: AppConstants.spacingLarge),
                Text(
                  AppConstants.appName,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: AppConstants.spacingSmall),
                Text(
                  'Kurz landen, sortieren und weiterdenken.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppConstants.spacingLarge),
                const CircularProgressIndicator(),
                const SizedBox(height: AppConstants.spacingMedium),
                Text(
                  setupState.hasError
                      ? 'Lokale Daten konnten nicht vorbereitet werden.'
                      : 'Lokale Daten werden vorbereitet.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
