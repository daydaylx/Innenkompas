import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';
import '../../../application/providers/settings_provider.dart';
import 'app_list_tile.dart';

/// Notification toggle widget for settings.
///
/// Features:
/// - Toggle notifications on/off
/// - Persists to user_settings.notificationsEnabled
class NotificationToggle extends ConsumerWidget {
  const NotificationToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsNotifierProvider);
    final isEnabled = settings?.notificationsEnabled ??
        AppConstants.defaultNotificationsEnabled;

    return AppListTile(
      leading: const Icon(Icons.notifications_outlined),
      title: 'Benachrichtigungen',
      subtitle: isEnabled ? 'Aktiviert' : 'Deaktiviert',
      trailing: Switch(
        value: isEnabled,
        onChanged: (value) async {
          await ref
              .read(settingsNotifierProvider.notifier)
              .toggleNotifications(value);
        },
      ),
    );
  }
}
