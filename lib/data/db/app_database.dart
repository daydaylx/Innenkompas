import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'tables/situation_entries.dart';
import 'tables/user_settings.dart';
import 'tables/crisis_plan.dart';

part 'app_database.g.dart';

/// Main database class for Innenkompass.
///
/// Uses Drift (SQLite) for local data persistence.
@DriftDatabase(tables: [SituationEntries, UserSettings, CrisisPlan])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  /// Migration strategy for database upgrades.
  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Handle database migrations here when schemaVersion increases
        // For now, we're at version 1, so no migrations needed yet
      },
      beforeOpen: (OpeningDetails details) async {
        // Enable foreign keys and other database pragmas
        await customStatement('PRAGMA foreign_keys = ON');
        await customStatement('PRAGMA journal_mode = WAL');
      },
    );
  }

  // ========== Situation Entries ==========

  /// Get all situation entries ordered by timestamp (newest first)
  Future<List<SituationEntryData>> getAllSituationEntries() {
    return (select(situationEntries)
          ..orderBy([(t) => OrderingTerm.desc(t.timestamp)])
          ..where((t) => t.isDraft.equals(false)))
        .get();
  }

  /// Get entries with pagination
  Future<List<SituationEntryData>> getSituationEntriesPaginated({
    int limit = 20,
    int offset = 0,
  }) {
    return (select(situationEntries)
          ..orderBy([(t) => OrderingTerm.desc(t.timestamp)])
          ..where((t) => t.isDraft.equals(false))
          ..limit(limit, offset: offset))
        .get();
  }

  /// Get a single entry by ID
  Future<SituationEntryData?> getSituationEntryById(int id) {
    return (select(situationEntries)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  /// Create a new entry
  Future<int> createSituationEntry(SituationEntriesCompanion entry) {
    return into(situationEntries).insert(entry);
  }

  /// Update an existing entry
  Future<bool> updateSituationEntry(SituationEntryData entry) {
    return update(situationEntries).replace(entry);
  }

  /// Delete an entry
  Future<int> deleteSituationEntry(SituationEntryData entry) {
    return delete(situationEntries).delete(entry);
  }

  /// Delete an entry by ID
  Future<int> deleteSituationEntryById(int id) {
    return (delete(situationEntries)..where((t) => t.id.equals(id))).go();
  }

  // ========== User Settings ==========

  /// Get the current settings (first row, since there should only be one)
  Future<UserSettingsData?> getUserSettings() {
    return (select(userSettings)..limit(1)).getSingleOrNull();
  }

  /// Create initial settings
  Future<int> createUserSettings(UserSettingsCompanion settings) {
    return into(userSettings).insert(settings);
  }

  /// Update settings
  Future<bool> updateUserSettings(UserSettingsData settings) {
    return update(userSettings).replace(settings);
  }

  /// Initialize default settings if none exist
  Future<UserSettingsData> getOrCreateUserSettings() async {
    final existing = await getUserSettings();
    if (existing != null) {
      return existing;
    }

    // Create default settings
    await createUserSettings(
      UserSettingsCompanion.insert(
        onboardingCompleted: const Value(false),
        isFirstLaunch: const Value(true),
        locale: const Value('de'),
        notificationsEnabled: const Value(false),
        discreteNotifications: const Value(true),
        appLockEnabled: const Value(false),
        themeMode: const Value('system'),
        analyticsEnabled: const Value(false),
      ),
    );

    return (await getUserSettings())!;
  }

  /// Set onboarding completed
  Future<void> setOnboardingCompleted(bool completed) {
    return (update(userSettings)..where((t) => t.id.equals(1)))
        .write(UserSettingsCompanion(onboardingCompleted: Value(completed)));
  }

  // ========== Crisis Plan ==========

  /// Get the crisis plan (first row, since there should only be one)
  Future<CrisisPlanData?> getCrisisPlan() {
    return (select(crisisPlan)..limit(1)).getSingleOrNull();
  }

  /// Create initial crisis plan
  Future<int> createCrisisPlan(CrisisPlanCompanion plan) {
    return into(crisisPlan).insert(plan);
  }

  /// Update crisis plan
  Future<bool> updateCrisisPlan(CrisisPlanData plan) {
    return update(crisisPlan).replace(plan);
  }

  /// Initialize empty crisis plan if none exists
  Future<CrisisPlanData> getOrCreateCrisisPlan() async {
    final existing = await getCrisisPlan();
    if (existing != null) {
      return existing;
    }

    // Create empty crisis plan
    await createCrisisPlan(CrisisPlanCompanion.insert());
    return (await getCrisisPlan())!;
  }

  // ========== Utility Methods ==========

  /// Clear all data from the database (useful for testing or data deletion)
  Future<void> clearAllData() async {
    // Delete all entries from all tables in reverse dependency order
    await delete(situationEntries).go();
    await delete(userSettings).go();
    await delete(crisisPlan).go();
  }

  /// Export all data as JSON (for backup)
  Future<Map<String, dynamic>> exportToJson() async {
    final entries = await getAllSituationEntries();
    final settings = await getUserSettings();
    final crisisPlan = await getCrisisPlan();

    return {
      'situationEntries': entries.map((e) => _entryToJson(e)).toList(),
      'userSettings': settings != null ? _settingsToJson(settings) : null,
      'crisisPlan': crisisPlan != null ? _crisisPlanToJson(crisisPlan) : null,
      'exportedAt': DateTime.now().toIso8601String(),
      'version': schemaVersion,
    };
  }

  Map<String, dynamic> _entryToJson(SituationEntryData e) => {
        'id': e.id,
        'situationDescription': e.situationDescription,
        'context': e.context,
        'timestamp': e.timestamp.toIso8601String(),
        'involvedPerson': e.involvedPerson,
        'intensity': e.intensity,
        'bodyTension': e.bodyTension,
        'primaryEmotion': e.primaryEmotion,
        'secondaryEmotion': e.secondaryEmotion,
        'bodySymptoms': e.bodySymptoms,
        'automaticThought': e.automaticThought,
        'firstImpulse': e.firstImpulse,
        'actualBehavior': e.actualBehavior,
        'systemState': e.systemState,
        'isCrisis': e.isCrisis,
        'interventionType': e.interventionType,
        'interventionId': e.interventionId,
        'interventionCompleted': e.interventionCompleted,
        'interventionDurationSec': e.interventionDurationSec,
        'postIntensity': e.postIntensity,
        'postBodyTension': e.postBodyTension,
        'postClarity': e.postClarity,
        'helpfulnessRating': e.helpfulnessRating,
        'postNote': e.postNote,
        'createdAt': e.createdAt.toIso8601String(),
        'updatedAt': e.updatedAt.toIso8601String(),
        'isDraft': e.isDraft,
      };

  Map<String, dynamic> _settingsToJson(UserSettingsData s) => {
        'id': s.id,
        'onboardingCompleted': s.onboardingCompleted,
        'isFirstLaunch': s.isFirstLaunch,
        'locale': s.locale,
        'notificationsEnabled': s.notificationsEnabled,
        'notificationTimes': s.notificationTimes,
        'discreteNotifications': s.discreteNotifications,
        'appLockEnabled': s.appLockEnabled,
        'appLockType': s.appLockType,
        'themeMode': s.themeMode,
        'emergencyContacts': s.emergencyContacts,
        'analyticsEnabled': s.analyticsEnabled,
        'lastBackupAt': s.lastBackupAt?.toIso8601String(),
        'lastDataCleanupAt': s.lastDataCleanupAt?.toIso8601String(),
        'createdAt': s.createdAt.toIso8601String(),
        'updatedAt': s.updatedAt.toIso8601String(),
      };

  Map<String, dynamic> _crisisPlanToJson(CrisisPlanData c) => {
        'id': c.id,
        'warningSigns': c.warningSigns,
        'copingStrategies': c.copingStrategies,
        'socialSupport': c.socialSupport,
        'safeEnvironment': c.safeEnvironment,
        'professionalResources': c.professionalResources,
        'emergencyContacts': c.emergencyContacts,
        'localResources': c.localResources,
        'personalMotivation': c.personalMotivation,
        'createdAt': c.createdAt.toIso8601String(),
        'updatedAt': c.updatedAt.toIso8601String(),
      };
}

/// Open a database connection.
///
/// This creates a SQLite database in the app's documents directory.
QueryExecutor _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'innenkompass.db'));
    return NativeDatabase.createInBackground(file);
  });
}
