import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/colors.dart';
import '../../../application/providers/bootstrap_provider.dart';
import '../../../application/providers/lock_provider.dart';
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
  @override
  Widget build(BuildContext context) {
    final bootstrapState = ref.watch(appBootstrapProvider);
    final lockState = ref.watch(lockStateProvider);

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
                  bootstrapState.hasError
                      ? 'Lokale Daten konnten nicht vorbereitet werden.'
                      : lockState.isLoading || bootstrapState.isLoading
                          ? 'Lokale Daten werden vorbereitet.'
                          : 'App-Start wird abgeschlossen.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                  textAlign: TextAlign.center,
                ),
                if (bootstrapState.hasError) ...[
                  const SizedBox(height: AppConstants.spacingSmall),
                  Text(
                    '${bootstrapState.error}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.error,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
                if (!bootstrapState.hasError) ...[
                  const SizedBox(height: AppConstants.spacingSmall),
                  Text(
                    lockState.isLoading
                        ? 'Sperrzustand wird geladen.'
                        : 'Lokale Daten werden vorbereitet.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textTertiary,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
