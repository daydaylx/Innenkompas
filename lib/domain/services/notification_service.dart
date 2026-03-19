import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/services.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

/// Service for managing local notifications.
///
/// Provides discrete, privacy-respecting reminders for self-reflection.
class NotificationService {
  NotificationService(this._plugin);

  final FlutterLocalNotificationsPlugin _plugin;
  bool _isInitialized = false;

  static const String _channelId = 'innenkompass_reminders';
  static const String _channelName = 'Erinnerungen';
  static const String _channelDescription =
      'Diskrete Erinnerungen für Selbstreflexion';

  /// Initialize the notification service.
  Future<void> initialize() async {
    if (_isInitialized) {
      return;
    }

    try {
      tz_data.initializeTimeZones();

      const androidSettings =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      const iosSettings = DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      );
      const settings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      );

      await _plugin.initialize(settings);
      _isInitialized = true;
    } on PlatformException {
      // Unsupported platforms keep notifications disabled gracefully.
    } on MissingPluginException {
      // Tests may not wire native notification plugins.
    }
  }

  /// Request notification permissions from the user.
  Future<bool> requestPermissions() async {
    await initialize();

    try {
      final androidPlugin = _plugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

      if (androidPlugin != null) {
        final granted = await androidPlugin.requestNotificationsPermission();
        return granted ?? false;
      }

      final iosPlugin = _plugin.resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>();

      if (iosPlugin != null) {
        final granted = await iosPlugin.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
        return granted ?? false;
      }
    } on PlatformException {
      return false;
    } on MissingPluginException {
      return false;
    }

    return false;
  }

  /// Schedule a daily notification at the given time.
  Future<void> scheduleDaily({
    required int id,
    required TimeOfDay time,
    required String title,
    required String body,
  }) async {
    await initialize();

    final androidDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDescription,
      importance: Importance.low,
      priority: Priority.low,
      styleInformation: const DefaultStyleInformation(true, true),
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: false,
      presentSound: false,
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    try {
      await _plugin.zonedSchedule(
        id,
        title,
        body,
        _nextInstanceOfTime(time),
        details,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    } on PlatformException {
      // Ignore scheduling failures on unsupported platforms.
    } on MissingPluginException {
      // Ignore scheduling failures in tests.
    }
  }

  /// Schedule multiple notifications at the given times.
  Future<void> scheduleMultiple(
    List<NotificationSchedule> schedules, {
    required bool discrete,
  }) async {
    await cancelAll();

    for (final schedule in schedules) {
      final message = _getMessage(schedule.id, discrete: discrete);
      await scheduleDaily(
        id: schedule.id,
        time: schedule.time,
        title: message.title,
        body: message.body,
      );
    }
  }

  /// Cancel all scheduled notifications.
  Future<void> cancelAll() async {
    await initialize();
    try {
      await _plugin.cancelAll();
    } on PlatformException {
      // Ignore cancellation failures on unsupported platforms.
    } on MissingPluginException {
      // Ignore cancellation failures in tests.
    }
  }

  /// Cancel a specific notification.
  Future<void> cancel(int id) async {
    await initialize();
    try {
      await _plugin.cancel(id);
    } on PlatformException {
      // Ignore cancellation failures on unsupported platforms.
    } on MissingPluginException {
      // Ignore cancellation failures in tests.
    }
  }

  /// Check if notifications are enabled on the system level.
  Future<bool> areNotificationsEnabled() async {
    await initialize();

    try {
      final androidPlugin = _plugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

      if (androidPlugin != null) {
        final enabled = await androidPlugin.areNotificationsEnabled();
        return enabled ?? false;
      }
    } on PlatformException {
      return false;
    } on MissingPluginException {
      return false;
    }

    return true;
  }

  /// Get a preview message for the active notification mode.
  String getPreviewMessage({required bool discrete}) {
    return discrete
        ? _discreteMessages.first.body
        : _standardMessages.first.body;
  }

  /// Get a notification message by ID and mode.
  _NotificationMessage _getMessage(int id, {required bool discrete}) {
    final messages = discrete ? _discreteMessages : _standardMessages;
    final index = id % messages.length;
    return messages[index];
  }

  /// Calculate the next instance of a given time.
  tz.TZDateTime _nextInstanceOfTime(TimeOfDay time) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    return scheduled;
  }

  /// Get all available discrete notification messages for preview.
  List<String> getNotificationMessages({required bool discrete}) {
    final messages = discrete ? _discreteMessages : _standardMessages;
    return messages.map((m) => m.body).toList();
  }

  /// Discrete notification messages (privacy-safe).
  static const List<_NotificationMessage> _discreteMessages = [
    _NotificationMessage(
      title: 'Innenkompass',
      body: 'Zeit für einen kurzen Rückblick.',
    ),
    _NotificationMessage(
      title: 'Innenkompass',
      body: 'Wie fühlst du dich gerade?',
    ),
    _NotificationMessage(
      title: 'Innenkompass',
      body: 'Kurzer Check-In mit dir selbst.',
    ),
    _NotificationMessage(
      title: 'Innenkompass',
      body: 'Ein Moment der Achtsamkeit.',
    ),
    _NotificationMessage(
      title: 'Innenkompass',
      body: 'Dein Innenkompass erinnert dich.',
    ),
  ];

  static const List<_NotificationMessage> _standardMessages = [
    _NotificationMessage(
      title: 'Innenkompass',
      body: 'Zeit für einen kurzen Check-in mit deinen Gedanken und Gefühlen.',
    ),
    _NotificationMessage(
      title: 'Innenkompass',
      body: 'Nimm dir einen Moment und halte fest, was heute in dir los ist.',
    ),
    _NotificationMessage(
      title: 'Innenkompass',
      body:
          'Wie geht es dir gerade wirklich? Eine kurze Reflexion kann helfen.',
    ),
    _NotificationMessage(
      title: 'Innenkompass',
      body:
          'Wenn gerade viel los ist, kann ein kurzer Eintrag wieder Ordnung schaffen.',
    ),
    _NotificationMessage(
      title: 'Innenkompass',
      body:
          'Vielleicht ist jetzt ein guter Zeitpunkt für einen bewussten Rückblick.',
    ),
  ];
}

/// Schedule data for a notification.
class NotificationSchedule {
  const NotificationSchedule({
    required this.id,
    required this.time,
    this.type = 'reminder',
  });

  final int id;
  final TimeOfDay time;
  final String type;

  /// Parse notification times from JSON string stored in DB.
  static List<NotificationSchedule> fromJsonString(String? jsonString) {
    if (jsonString == null || jsonString.isEmpty) return [];
    try {
      final list = jsonDecode(jsonString) as List;
      return list.asMap().entries.map((entry) {
        final timeStr = entry.value as String;
        final parts = timeStr.split(':');
        return NotificationSchedule(
          id: entry.key,
          time: TimeOfDay(
            hour: int.parse(parts[0]),
            minute: int.parse(parts[1]),
          ),
        );
      }).toList();
    } catch (_) {
      return [];
    }
  }

  /// Convert schedules to JSON string for DB storage.
  static String toJsonString(List<NotificationSchedule> schedules) {
    final list = schedules
        .map((s) =>
            '${s.time.hour.toString().padLeft(2, '0')}:${s.time.minute.toString().padLeft(2, '0')}')
        .toList();
    return jsonEncode(list);
  }
}

/// Internal notification message class.
class _NotificationMessage {
  const _NotificationMessage({
    required this.title,
    required this.body,
  });

  final String title;
  final String body;
}
