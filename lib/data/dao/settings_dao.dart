import 'dart:convert';
import 'package:drift/drift.dart';
import '../../data/db/app_database.dart';
import '../../domain/models/crisis_plan.dart';

/// DAO for user settings data access.
class SettingsDao {
  SettingsDao(this._db);

  final AppDatabase _db;

  /// Get settings or create defaults.
  Future<UserSettingsData> getOrCreate() async {
    return _db.getOrCreateUserSettings();
  }

  /// Update notifications enabled flag.
  Future<void> updateNotificationsEnabled(bool enabled) async {
    await (_db.update(_db.userSettings)..where((t) => t.id.equals(1)))
        .write(UserSettingsCompanion(
      notificationsEnabled: Value(enabled),
    ));
  }

  /// Update notification times (stored as JSON array of HH:mm strings).
  Future<void> updateNotificationTimes(List<String> times) async {
    final jsonStr = times.isEmpty ? null : jsonEncode(times);
    await (_db.update(_db.userSettings)..where((t) => t.id.equals(1)))
        .write(UserSettingsCompanion(
      notificationTimes: Value(jsonStr),
    ));
  }

  /// Update discrete notifications flag.
  Future<void> updateDiscreteNotifications(bool enabled) async {
    await (_db.update(_db.userSettings)..where((t) => t.id.equals(1)))
        .write(UserSettingsCompanion(
      discreteNotifications: Value(enabled),
    ));
  }

  /// Update app lock settings.
  Future<void> updateAppLock(bool enabled, String? type) async {
    await (_db.update(_db.userSettings)..where((t) => t.id.equals(1)))
        .write(UserSettingsCompanion(
      appLockEnabled: Value(enabled),
      appLockType: Value(type),
    ));
  }

  /// Update emergency contacts (stored as JSON).
  Future<void> updateEmergencyContacts(List<EmergencyContact> contacts) async {
    final jsonStr =
        contacts.isEmpty ? null : EmergencyContact.listToJson(contacts);
    await (_db.update(_db.userSettings)..where((t) => t.id.equals(1)))
        .write(UserSettingsCompanion(
      emergencyContacts: Value(jsonStr),
    ));
  }

  /// Update theme mode.
  Future<void> updateThemeMode(String mode) async {
    await (_db.update(_db.userSettings)..where((t) => t.id.equals(1)))
        .write(UserSettingsCompanion(
      themeMode: Value(mode),
    ));
  }

  /// Update locale.
  Future<void> updateLocale(String locale) async {
    await (_db.update(_db.userSettings)..where((t) => t.id.equals(1)))
        .write(UserSettingsCompanion(
      locale: Value(locale),
    ));
  }

  /// Clear all settings (reset to defaults).
  Future<void> clear() async {
    await _db.clearAllData();
  }
}
