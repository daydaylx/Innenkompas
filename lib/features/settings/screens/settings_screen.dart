import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../app/router.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../../shared/widgets/buttons/app_secondary_button.dart';
import '../../../shared/widgets/cards/app_card.dart';
import '../../../shared/widgets/navigation/app_main_navigation.dart';
import '../widgets/settings_widgets.dart';

/// Settings screen for Innenkompass.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return AppScaffold(
      title: 'Einstellungen',
      backgroundVariant: AppBackgroundVariant.calm,
      header: AppCard(
        variant: AppCardVariant.glass,
        margin: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ruhige Grundeinstellungen',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppConstants.spacingSmall),
            Text(
              'Passe Sprache, Sicherheit und Notfallkontakte an, ohne die App aus dem Fokus zu verlieren.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppMainNavigationBar(
        currentRoute: AppRoutes.settings,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Allgemein
            Padding(
              padding: const EdgeInsets.all(AppConstants.spacingMedium),
              child: Text(
                'Allgemein',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            const LanguageSelector(),
            const NotificationSettingsSection(),

            const SizedBox(height: AppConstants.spacingLarge),

            // Sicherheit
            Padding(
              padding: const EdgeInsets.all(AppConstants.spacingMedium),
              child: Text(
                'Sicherheit',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            const AppLockToggle(),

            const SizedBox(height: AppConstants.spacingLarge),

            // Krisenbereich
            Padding(
              padding: const EdgeInsets.all(AppConstants.spacingMedium),
              child: Text(
                'Krisenbereich',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            // Static crisis hotlines
            const EmergencyContactItem(
              label: 'Telefonseelsorge',
              phoneNumber: '0800 111 0 111',
            ),
            const EmergencyContactItem(
              label: 'Telefonseelsorge (alternativ)',
              phoneNumber: '0800 111 0 222',
            ),
            const EmergencyContactItem(
              label: 'Notruf',
              phoneNumber: '112',
            ),

            const SizedBox(height: AppConstants.spacingSmall),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacingMedium,
              ),
              child: AppCard(
                variant: AppCardVariant.soft,
                margin: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Persönliche Kontakte und Hilfen',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppConstants.spacingSmall),
                    Text(
                      'Deine persönlichen Kontakte, professionellen Anlaufstellen und lokalen Hilfen bearbeitest du gesammelt im Krisenplan.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppConstants.spacingMedium),
                    AppSecondaryButton(
                      onPressed: () => context.push(AppRoutes.crisisEdit),
                      icon: Icons.edit_note,
                      label: 'Krisenplan öffnen',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppConstants.spacingLarge),

            // Daten
            Padding(
              padding: const EdgeInsets.all(AppConstants.spacingMedium),
              child: Text(
                'Daten',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            const DataExportButton(),
            const DataCleanupButton(),

            const SizedBox(height: AppConstants.spacingXLarge),

            // App info
            const AppInfoSection(),

            const SizedBox(height: AppConstants.spacingXLarge),
          ],
        ),
      ),
    );
  }
}
