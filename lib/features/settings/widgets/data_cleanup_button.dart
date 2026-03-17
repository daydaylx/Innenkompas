import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/theme/colors.dart';
import '../../../application/providers/settings_provider.dart';
import 'package:go_router/go_router.dart';
import '../../../app/router.dart';
import 'app_list_tile.dart';

/// Data cleanup button for settings.
///
/// Features:
/// - Shows confirmation dialog
/// - Clears all data from database
/// - Redirects to onboarding after cleanup
class DataCleanupButton extends ConsumerWidget {
  const DataCleanupButton({super.key});

  Future<void> _showConfirmationDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alle Daten löschen?'),
        content: const Text(
          'Dies wird alle deine Einträge und Einstellungen dauerhaft löschen. '
          'Diese Aktion kann nicht rückgängig gemacht werden.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Abbrechen'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.error,
            ),
            child: const Text('Löschen'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      try {
        // Reset onboarding through settings provider
        await ref.read(settingsNotifierProvider.notifier).resetOnboarding();

        // Navigate to onboarding
        if (context.mounted) {
          context.go(AppRoutes.onboarding);
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Fehler beim Löschen der Daten.'),
              backgroundColor: AppColors.error,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppListTile(
      leading: const Icon(Icons.delete_outline, color: AppColors.error),
      title: 'Alle Daten löschen',
      subtitle: 'Alle Einträge und Einstellungen entfernen',
      onTap: () => _showConfirmationDialog(context, ref),
    );
  }
}
