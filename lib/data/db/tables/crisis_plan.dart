import 'package:drift/drift.dart';

/// Crisis plan table.
///
/// Stores the user's personalized crisis plan and emergency resources.
@DataClassName('CrisisPlanData')
class CrisisPlan extends Table {
  // Primary key - only one row expected
  IntColumn get id => integer().autoIncrement()();

  // Early warning signs (JSON array of strings)
  TextColumn get warningSigns => text().nullable()();

  // Coping strategies that work (JSON array)
  TextColumn get copingStrategies => text().nullable()();

  // Social connections and support (JSON array)
  TextColumn get socialSupport => text().nullable()();

  // Making the environment safe (text)
  TextColumn get safeEnvironment => text().nullable()();

  // Professional resources (JSON array)
  TextColumn get professionalResources => text().nullable()();

  // Emergency contacts (JSON array)
  TextColumn get emergencyContacts => text().nullable()();

  // Local crisis resources (JSON array)
  TextColumn get localResources => text().nullable()();

  // Personal motivation/reasons for staying (text)
  TextColumn get personalMotivation => text().nullable()();

  // Timestamps
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
}
