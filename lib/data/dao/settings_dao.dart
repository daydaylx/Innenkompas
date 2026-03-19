import 'dart:convert';
import 'package:drift/drift.dart';
import '../../data/db/app_database.dart';
import '../../domain/models/crisis_plan.dart';

/// DAO for user settings data access.
class SettingsDao {
  SettingsDao(this._db);

  final AppDatabase _db;

  Future<void> _updateCurrent(
    UserSettingsData Function(UserSettingsData current) buildUpdated,
  ) async {
    final current = await getOrCreate();
    final updated = buildUpdated(current).copyWith(updatedAt: DateTime.now());
    await _db.updateUserSettings(updated);
  }

  /// Get settings or create defaults.
  Future<UserSettingsData> getOrCreate() async {
    return _db.getOrCreateUserSettings();
  }

  /// Update notifications enabled flag.
  Future<void> updateNotificationsEnabled(bool enabled) async {
    await _updateCurrent(
      (current) => current.copyWith(notificationsEnabled: enabled),
    );
  }

  /// Update notification times (stored as JSON array of HH:mm strings).
  Future<void> updateNotificationTimes(List<String> times) async {
    final jsonStr = times.isEmpty ? null : jsonEncode(times);
    await _updateCurrent(
      (current) => current.copyWith(notificationTimes: Value(jsonStr)),
    );
  }

  /// Update discrete notifications flag.
  Future<void> updateDiscreteNotifications(bool enabled) async {
    await _updateCurrent(
      (current) => current.copyWith(discreteNotifications: enabled),
    );
  }

  /// Update app lock settings.
  Future<void> updateAppLock(bool enabled, String? type) async {
    await _updateCurrent(
      (current) => current.copyWith(
        appLockEnabled: enabled,
        appLockType: Value(type),
      ),
    );
  }

  /// Update emergency contacts (stored as JSON).
  Future<void> updateEmergencyContacts(List<EmergencyContact> contacts) async {
    final jsonStr =
        contacts.isEmpty ? null : EmergencyContact.listToJson(contacts);
    await _updateCurrent(
      (current) => current.copyWith(emergencyContacts: Value(jsonStr)),
    );
  }

  /// Update theme mode.
  Future<void> updateThemeMode(String mode) async {
    await _updateCurrent((current) => current.copyWith(themeMode: mode));
  }

  /// Update locale.
  Future<void> updateLocale(String locale) async {
    await _updateCurrent((current) => current.copyWith(locale: locale));
  }

  /// Clear all settings (reset to defaults).
  Future<void> clear() async {
    await _db.clearAllData();
  }
}
