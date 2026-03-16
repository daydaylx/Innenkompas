import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme/app_theme.dart';
import 'theme/colors.dart';
import 'theme/typography.dart';

/// Main app widget for Innenkompass.
///
/// Sets up the ProviderScope, theme, and routing.
/// Note: Screen imports will be added when implementing individual features.
class InnenkompassApp extends ConsumerWidget {
  const InnenkompassApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // For now, showing a simple loading screen until the router is fully set up
    return MaterialApp(
      title: 'Innenkompass',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const _SplashScreen(),
    );
  }
}

/// Temporary splash screen until all features are implemented
class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.explore,
              size: 80,
              color: AppColors.primary,
            ),
            const SizedBox(height: 24),
            Text(
              'Innenkompass',
              style: AppTypography.displayMedium.copyWith(
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Lokal-first Selbstregulation',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 48),
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              'Phase 1: Fundament wird geladen...',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
