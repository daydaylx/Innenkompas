import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/theme/colors.dart';
import 'package:go_router/go_router.dart';
import '../../../app/router.dart';
import '../../../application/controllers/crisis_controller.dart';
import '../../../application/providers/bootstrap_provider.dart';
import '../../../application/providers/database_provider.dart';
import '../../../application/providers/intervention_providers.dart';
import '../../../application/providers/lock_provider.dart';
import '../../../application/providers/new_situation_providers.dart';
import '../../../application/providers/settings_provider.dart';
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
        await ref.read(databaseProvider).clearAllData();
        await ref.read(lockServiceProvider).clearLockData();

        ref.invalidate(newSituationFlowControllerProvider);
        ref.invalidate(interventionFlowStateProvider);
        ref.invalidate(postEvaluationStateProvider);
        ref.invalidate(crisisControllerProvider);
        ref.invalidate(settingsProvider);
        ref.invalidate(settingsNotifierProvider);
        ref.invalidate(lockStateProvider);
        ref.invalidate(appBootstrapProvider);

        if (context.mounted) {
          context.go(AppRoutes.root);
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
      subtitle: 'Alle Einträge, Einstellungen und Sperrdaten entfernen',
      onTap: () => _showConfirmationDialog(context, ref),
    );
  }
}
