import 'package:drift/drift.dart';

/// User settings table.
///
/// Stores app-wide user preferences and settings.
@DataClassName('UserSettingsData')
class UserSettings extends Table {
  // Primary key - only one row expected
  IntColumn get id => integer().autoIncrement()();

  // Onboarding and first launch
  BoolColumn get onboardingCompleted =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get isFirstLaunch => boolean().withDefault(const Constant(true))();

  // Language and locale
  TextColumn get locale =>
      text().withDefault(const Constant('de'))(); // Default: German

  // Notifications
  BoolColumn get notificationsEnabled =>
      boolean().withDefault(const Constant(false))();
  TextColumn get notificationTimes =>
      text().nullable()(); // JSON array of notification times
  BoolColumn get discreteNotifications =>
      boolean().withDefault(const Constant(true))();

  // App lock
  BoolColumn get appLockEnabled =>
      boolean().withDefault(const Constant(false))();
  TextColumn get appLockType => text().nullable()(); // 'biometric', 'pin', etc.

  // Theme
  TextColumn get themeMode => text()
      .withDefault(const Constant('system'))(); // 'light', 'dark', 'system'

  // Emergency contacts (JSON array)
  TextColumn get emergencyContacts => text().nullable()();

  // Privacy and data
  BoolColumn get analyticsEnabled =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastBackupAt => dateTime().nullable()();
  DateTimeColumn get lastDataCleanupAt => dateTime().nullable()();

  // Timestamps
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
