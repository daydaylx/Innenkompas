import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../data/db/app_database.dart';
import '../../domain/services/notification_service.dart';
import 'settings_provider.dart';

/// Provider for FlutterLocalNotificationsPlugin instance.
final localNotificationsPluginProvider =
    Provider<FlutterLocalNotificationsPlugin>((ref) {
  return FlutterLocalNotificationsPlugin();
});

/// Provider for the notification service.
final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService(ref.watch(localNotificationsPluginProvider));
});

/// Settings for notifications.
class NotificationSettings {
  const NotificationSettings({
    this.enabled = false,
    this.discrete = true,
    this.times = const [],
  });

  final bool enabled;
  final bool discrete;
  final List<TimeOfDay> times;

  factory NotificationSettings.fromUserSettings(UserSettingsData? settings) {
    final times =
        NotificationSchedule.fromJsonString(settings?.notificationTimes)
            .map((schedule) => schedule.time)
            .toList(growable: false);

    return NotificationSettings(
      enabled: settings?.notificationsEnabled ?? false,
      discrete: settings?.discreteNotifications ?? true,
      times: times,
    );
  }
}

final notificationSettingsProvider = Provider<NotificationSettings>((ref) {
  final settings = ref.watch(settingsNotifierProvider);
  return NotificationSettings.fromUserSettings(settings);
});

final notificationSettingsControllerProvider =
    Provider<NotificationSettingsController>((ref) {
  return NotificationSettingsController(ref);
});

class NotificationSettingsController {
  NotificationSettingsController(this._ref);

  final Ref _ref;

  NotificationService get _service => _ref.read(notificationServiceProvider);

  Future<bool> toggleEnabled(bool enabled) async {
    if (enabled) {
      final granted = await _service.requestPermissions();
      if (!granted) {
        return false;
      }
    }

    await _ref
        .read(settingsNotifierProvider.notifier)
        .updateNotificationSettings(notificationsEnabled: enabled);
    await _syncFromCurrentSettings();
    return true;
  }

  Future<void> updateTimes(List<TimeOfDay> times) async {
    final normalizedTimes = _normalizeTimes(times);
    await _ref
        .read(settingsNotifierProvider.notifier)
        .updateNotificationSettings(
          notificationTimes: normalizedTimes.isEmpty
              ? null
              : NotificationSchedule.toJsonString(
                  _schedulesFromTimes(normalizedTimes),
                ),
          clearNotificationTimes: normalizedTimes.isEmpty,
        );
    await _syncFromCurrentSettings();
  }

  Future<void> toggleDiscrete(bool discrete) async {
    await _ref
        .read(settingsNotifierProvider.notifier)
        .updateNotificationSettings(discreteNotifications: discrete);
    await _syncFromCurrentSettings();
  }

  Future<void> _syncFromCurrentSettings() async {
    final settings = _ref.read(settingsNotifierProvider);
    if (settings == null) {
      return;
    }

    await syncNotificationSchedules(
      service: _service,
      settings: settings,
    );
  }

  List<NotificationSchedule> _schedulesFromTimes(List<TimeOfDay> times) {
    return times
        .asMap()
        .entries
        .map(
          (entry) => NotificationSchedule(
            id: entry.key,
            time: entry.value,
          ),
        )
        .toList(growable: false);
  }

  List<TimeOfDay> _normalizeTimes(List<TimeOfDay> times) {
    final uniqueTimes = <String, TimeOfDay>{};
    for (final time in times) {
      final key =
          '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
      uniqueTimes[key] = time;
    }

    final normalized = uniqueTimes.values.toList()
      ..sort((a, b) {
        final left = (a.hour * 60) + a.minute;
        final right = (b.hour * 60) + b.minute;
        return left.compareTo(right);
      });

    return normalized.take(3).toList(growable: false);
  }
}

Future<void> syncNotificationSchedules({
  required NotificationService service,
  required UserSettingsData settings,
}) async {
  if (!settings.notificationsEnabled) {
    await service.cancelAll();
    return;
  }

  final schedules =
      NotificationSchedule.fromJsonString(settings.notificationTimes);
  if (schedules.isEmpty) {
    await service.cancelAll();
    return;
  }

  await service.scheduleMultiple(
    schedules,
    discrete: settings.discreteNotifications,
  );
}
