import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../domain/services/notification_service.dart';

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

  NotificationSettings copyWith({
    bool? enabled,
    bool? discrete,
    List<TimeOfDay>? times,
  }) {
    return NotificationSettings(
      enabled: enabled ?? this.enabled,
      discrete: discrete ?? this.discrete,
      times: times ?? this.times,
    );
  }
}

/// Notifier for notification settings state.
class NotificationSettingsNotifier extends StateNotifier<NotificationSettings> {
  NotificationSettingsNotifier(this._service)
      : super(const NotificationSettings()) {
    _loadSettings();
  }

  final NotificationService _service;

  Future<void> _loadSettings() async {
    // Settings are loaded from DB through settingsNotifierProvider
  }

  /// Toggle notifications on/off.
  Future<void> toggleEnabled(bool enabled) async {
    if (enabled) {
      final granted = await _service.requestPermissions();
      if (!granted) return;
    } else {
      await _service.cancelAll();
    }
    state = state.copyWith(enabled: enabled);
  }

  /// Update notification times.
  Future<void> updateTimes(List<TimeOfDay> times) async {
    state = state.copyWith(times: times);
    if (state.enabled) {
      await scheduleReminders();
    }
  }

  /// Toggle discrete mode.
  Future<void> toggleDiscrete(bool discrete) async {
    state = state.copyWith(discrete: discrete);
  }

  /// Schedule reminders based on current settings.
  Future<void> scheduleReminders() async {
    if (!state.enabled || state.times.isEmpty) {
      await _service.cancelAll();
      return;
    }

    final schedules = state.times.asMap().entries.map((entry) {
      return NotificationSchedule(
        id: entry.key,
        time: entry.value,
      );
    }).toList();

    await _service.scheduleMultiple(schedules);
  }
}

/// Provider for notification settings state.
final notificationSettingsProvider =
    StateNotifierProvider<NotificationSettingsNotifier, NotificationSettings>(
        (ref) {
  return NotificationSettingsNotifier(ref.watch(notificationServiceProvider));
});
