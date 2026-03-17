import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/theme/colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../application/providers/notification_provider.dart';
import 'app_list_tile.dart';

/// Notification settings section with time configuration.
class NotificationSettingsSection extends ConsumerWidget {
  const NotificationSettingsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final settings = ref.watch(notificationSettingsProvider);
    final notifier = ref.read(notificationSettingsProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Enable toggle
        AppListTile(
          leading: Icon(
            settings.enabled
                ? Icons.notifications_active_outlined
                : Icons.notifications_off_outlined,
          ),
          title: 'Benachrichtigungen',
          subtitle: settings.enabled ? 'Aktiviert' : 'Deaktiviert',
          trailing: Switch(
            value: settings.enabled,
            onChanged: (value) => notifier.toggleEnabled(value),
          ),
        ),

        if (settings.enabled) ...[
          // Notification times
          ...settings.times.asMap().entries.map((entry) {
            return AppListTile(
              leading: const Icon(Icons.schedule),
              title: 'Erinnerung ${entry.key + 1}',
              subtitle:
                  '${entry.value.hour.toString().padLeft(2, '0')}:${entry.value.minute.toString().padLeft(2, '0')}',
              onTap: () => _pickTime(context, notifier, settings, entry.key),
            );
          }),

          // Add time button
          if (settings.times.length < 3)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacingMedium,
              ),
              child: TextButton.icon(
                onPressed: () => _addTime(context, notifier, settings),
                icon: const Icon(Icons.add),
                label: const Text('Erinnerung hinzufügen'),
              ),
            ),

          // Discrete notifications toggle
          AppListTile(
            leading: const Icon(Icons.visibility_off_outlined),
            title: 'Diskrete Benachrichtigungen',
            subtitle: settings.discrete
                ? 'Keine sensiblen Inhalte'
                : 'Normale Benachrichtigungen',
            trailing: Switch(
              value: settings.discrete,
              onChanged: (value) => notifier.toggleDiscrete(value),
            ),
          ),

          // Preview
          if (settings.discrete)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacingMedium,
                vertical: AppConstants.spacingSmall,
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline,
                      size: 16, color: AppColors.textTertiary),
                  const SizedBox(width: AppConstants.spacingSmall),
                  Expanded(
                    child: Text(
                      'Vorschau: "Zeit für einen kurzen Rückblick."',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.textTertiary,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          const SizedBox(height: AppConstants.spacingSmall),
        ],
      ],
    );
  }

  Future<void> _pickTime(
    BuildContext context,
    NotificationSettingsNotifier notifier,
    NotificationSettings settings,
    int index,
  ) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: settings.times[index],
    );
    if (picked != null) {
      final newTimes = List<TimeOfDay>.from(settings.times);
      newTimes[index] = picked;
      await notifier.updateTimes(newTimes);
    }
  }

  Future<void> _addTime(
    BuildContext context,
    NotificationSettingsNotifier notifier,
    NotificationSettings settings,
  ) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 18, minute: 0),
    );
    if (picked != null) {
      final newTimes = [...settings.times, picked];
      await notifier.updateTimes(newTimes);
    }
  }
}
