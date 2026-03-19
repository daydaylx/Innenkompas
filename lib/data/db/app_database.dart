import 'dart:convert';
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../../core/constants/app_constants.dart';
import '../../domain/models/ai_evaluation.dart';
import '../../domain/models/ai_reflection.dart';
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
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => AppConstants.databaseVersion;

  /// Migration strategy for database upgrades.
  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          await m.addColumn(
            situationEntries,
            situationEntries.needOrWoundedPoint,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.nextStep,
          );
        }
        if (from < 3) {
          await m.addColumn(
            situationEntries,
            situationEntries.factInterpretationResult,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.evaluationHeadlineKey,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.evaluationMeaningKey,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.suggestedTipIds,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.suggestedNextActionKey,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.selectedNextActionKey,
          );
        }
        if (from < 4) {
          await m.addColumn(
            situationEntries,
            situationEntries.aiEvaluationStatus,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.aiEvaluationProvider,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.aiEvaluationModel,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.aiEvaluationRequestedAt,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.aiEvaluationCompletedAt,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.aiEvaluationConsentGiven,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.aiEvaluationText,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.aiEvaluationSchemaVersion,
          );
        }
        if (from < 5) {
          await m.addColumn(
            situationEntries,
            situationEntries.involvedEntities,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.preTriggerPreoccupation,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.problemTiming,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.triggerDescription,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.preTriggerLoad,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.initialBodyReactions,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.additionalEmotions,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.thoughtFocus,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.systemReaction,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.thoughtPatterns,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.actualBehaviorTags,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.tippingPointAwareness,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.fearOrPressurePoint,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.touchedThemes,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.neededSupports,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.realisticAlternative,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.triggerAsLastDrop,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.backgroundTheme,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.preEscalationRelief,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.patternFamiliarity,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.evaluationHelpfulNowKey,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.evaluationLearningPointKey,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.evaluationStatusKeys,
          );
        }
        if (from < 6) {
          await m.addColumn(
            situationEntries,
            situationEntries.aiReflectionMode,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.aiReflectionStatus,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.aiReflectionSummary,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.aiReflectionLikelyCore,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.aiReflectionEarlyTurningPoint,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.aiReflectionAlternative,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.aiReflectionNextStep,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.aiReflectionMantra,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.aiReflectionDeferredUntil,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.aiReflectionCompletedAt,
          );
        }
        if (from < 7) {
          await m.addColumn(
            situationEntries,
            situationEntries.aiReflectionPhase,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.aiReflectionSessionId,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.aiReflectionInputHash,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.aiReflectionStartedAt,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.aiReflectionProvider,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.aiReflectionModel,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.aiReflectionSchemaVersion,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.aiReflectionStartObservation,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.aiReflectionStartQuestion,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.aiReflectionStartHelperStarters,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.aiReflectionLastErrorCode,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.aiReflectionLastErrorMessage,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.aiReflectionDeferredAt,
          );
          await m.addColumn(
            situationEntries,
            situationEntries.aiReflectionResumeSuggestedAt,
          );
        }
      },
      beforeOpen: (OpeningDetails details) async {
        // Enable foreign keys and other database pragmas
        await customStatement('PRAGMA foreign_keys = ON');
        await customStatement('PRAGMA journal_mode = WAL');
      },
    );
  }

  // ========== Situation Entries ==========

  /// Update post-evaluation data for an entry
  Future<void> updatePostEvaluation({
    required int entryId,
    required int postIntensity,
    required int postBodyTension,
    required int postClarity,
    required int helpfulnessRating,
    String? userNote,
    required DateTime completedAt,
    required int actualDuration,
  }) async {
    await (update(situationEntries)..where((e) => e.id.equals(entryId))).write(
      SituationEntriesCompanion(
        postIntensity: Value(postIntensity),
        postBodyTension: Value(postBodyTension),
        postClarity: Value(postClarity),
        helpfulnessRating: Value(helpfulnessRating),
        postNote: Value(userNote),
        interventionCompleted: const Value(true),
        interventionDurationSec: Value(actualDuration),
      ),
    );
  }

  /// Speichert die vom Nutzer gewählte Soforthilfe/Nächster-Schritt-Auswahl.
  Future<void> updateSelectedNextAction({
    required int entryId,
    required String selectedNextActionKey,
  }) async {
    await (update(situationEntries)..where((e) => e.id.equals(entryId))).write(
      SituationEntriesCompanion(
        selectedNextActionKey: Value(selectedNextActionKey),
      ),
    );
  }

  /// Marks a saved entry as opted-in and currently waiting for AI output.
  Future<void> markAiEvaluationPending({
    required int entryId,
    required bool consentGiven,
    required DateTime requestedAt,
  }) async {
    await (update(situationEntries)..where((e) => e.id.equals(entryId))).write(
      SituationEntriesCompanion(
        aiEvaluationStatus: Value(AiEvaluationStatus.pending.name),
        aiEvaluationConsentGiven: Value(consentGiven),
        aiEvaluationRequestedAt: Value(requestedAt),
        aiEvaluationCompletedAt: const Value(null),
        aiEvaluationText: const Value(null),
        aiEvaluationSchemaVersion: const Value(null),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Persists a successful AI evaluation response.
  Future<void> saveAiEvaluationSuccess({
    required int entryId,
    required String provider,
    required String model,
    required int schemaVersion,
    required AiEvaluationContent content,
    required DateTime completedAt,
  }) async {
    await (update(situationEntries)..where((e) => e.id.equals(entryId))).write(
      SituationEntriesCompanion(
        aiEvaluationStatus: Value(AiEvaluationStatus.success.name),
        aiEvaluationProvider: Value(provider),
        aiEvaluationModel: Value(model),
        aiEvaluationCompletedAt: Value(completedAt),
        aiEvaluationConsentGiven: const Value(true),
        aiEvaluationText: Value(content.toJsonString()),
        aiEvaluationSchemaVersion: Value(schemaVersion),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Persists a failed AI evaluation attempt without removing user consent.
  Future<void> markAiEvaluationFailed({
    required int entryId,
    required DateTime completedAt,
  }) async {
    await (update(situationEntries)..where((e) => e.id.equals(entryId))).write(
      SituationEntriesCompanion(
        aiEvaluationStatus: Value(AiEvaluationStatus.failed.name),
        aiEvaluationCompletedAt: Value(completedAt),
        aiEvaluationConsentGiven: const Value(true),
        aiEvaluationText: const Value(null),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> markAiReflectionInProgress({
    required int entryId,
    required AiReflectionMode mode,
    required String sessionId,
    required String inputHash,
    required DateTime startedAt,
  }) async {
    await (update(situationEntries)..where((e) => e.id.equals(entryId))).write(
      SituationEntriesCompanion(
        aiReflectionMode: Value(mode.name),
        aiReflectionStatus: Value(AiReflectionStatus.inProgress.rawValue),
        aiReflectionPhase: Value(AiReflectionPhase.startPending.rawValue),
        aiReflectionSessionId: Value(sessionId),
        aiReflectionInputHash: Value(inputHash),
        aiReflectionStartedAt: Value(startedAt),
        aiReflectionProvider: const Value(null),
        aiReflectionModel: const Value(null),
        aiReflectionSchemaVersion: const Value(null),
        aiReflectionStartObservation: const Value(null),
        aiReflectionStartQuestion: const Value(null),
        aiReflectionStartHelperStarters: const Value(null),
        aiReflectionSummary: const Value(null),
        aiReflectionLikelyCore: const Value(null),
        aiReflectionEarlyTurningPoint: const Value(null),
        aiReflectionAlternative: const Value(null),
        aiReflectionNextStep: const Value(null),
        aiReflectionMantra: const Value(null),
        aiReflectionCompletedAt: const Value(null),
        aiReflectionLastErrorCode: const Value(null),
        aiReflectionLastErrorMessage: const Value(null),
        aiReflectionDeferredAt: const Value(null),
        aiReflectionResumeSuggestedAt: const Value(null),
        aiReflectionDeferredUntil: const Value(null),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<bool> saveAiReflectionStartContent({
    required int entryId,
    required String sessionId,
    required String inputHash,
    required AiReflectionMode mode,
    required AiReflectionStartContent content,
    required String provider,
    required String model,
    required int schemaVersion,
    required DateTime startedAt,
  }) async {
    final rows = await (update(situationEntries)
          ..where((e) =>
              e.id.equals(entryId) &
              e.aiReflectionSessionId.equals(sessionId) &
              e.aiReflectionInputHash.equals(inputHash)))
        .write(
      SituationEntriesCompanion(
        aiReflectionMode: Value(mode.name),
        aiReflectionStatus: Value(AiReflectionStatus.inProgress.rawValue),
        aiReflectionPhase: Value(AiReflectionPhase.readyForReply.rawValue),
        aiReflectionStartedAt: Value(startedAt),
        aiReflectionProvider: Value(provider),
        aiReflectionModel: Value(model),
        aiReflectionSchemaVersion: Value(schemaVersion),
        aiReflectionStartObservation: Value(content.observation),
        aiReflectionStartQuestion: Value(content.question),
        aiReflectionStartHelperStarters:
            Value(jsonEncode(content.helperStarters)),
        aiReflectionLastErrorCode: const Value(null),
        aiReflectionLastErrorMessage: const Value(null),
        updatedAt: Value(DateTime.now()),
      ),
    );

    return rows > 0;
  }

  Future<bool> markAiReflectionCompletePending({
    required int entryId,
    required String sessionId,
    required String inputHash,
  }) async {
    final rows = await (update(situationEntries)
          ..where((e) =>
              e.id.equals(entryId) &
              e.aiReflectionSessionId.equals(sessionId) &
              e.aiReflectionInputHash.equals(inputHash)))
        .write(
      SituationEntriesCompanion(
        aiReflectionStatus: Value(AiReflectionStatus.inProgress.rawValue),
        aiReflectionPhase: Value(AiReflectionPhase.completePending.rawValue),
        aiReflectionLastErrorCode: const Value(null),
        aiReflectionLastErrorMessage: const Value(null),
        updatedAt: Value(DateTime.now()),
      ),
    );

    return rows > 0;
  }

  Future<void> markAiReflectionDeferred({
    required int entryId,
    required AiReflectionMode? mode,
    required DateTime deferredAt,
    DateTime? resumeSuggestedAt,
  }) async {
    final current = await getSituationEntryById(entryId);
    final phase = current?.aiReflectionStartObservation != null
        ? AiReflectionPhase.readyForReply.rawValue
        : null;
    await (update(situationEntries)..where((e) => e.id.equals(entryId))).write(
      SituationEntriesCompanion(
        aiReflectionMode: mode == null ? const Value(null) : Value(mode.name),
        aiReflectionStatus: Value(AiReflectionStatus.deferred.rawValue),
        aiReflectionPhase: Value(phase),
        aiReflectionDeferredAt: Value(deferredAt),
        aiReflectionResumeSuggestedAt: Value(resumeSuggestedAt),
        aiReflectionDeferredUntil: Value(resumeSuggestedAt ?? deferredAt),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<bool> markAiReflectionFailed({
    required int entryId,
    required String sessionId,
    required String inputHash,
    required AiReflectionPhase phase,
    required AiReflectionErrorCode errorCode,
    required String message,
    required bool keepInProgress,
  }) async {
    final rows = await (update(situationEntries)
          ..where((e) =>
              e.id.equals(entryId) &
              e.aiReflectionSessionId.equals(sessionId) &
              e.aiReflectionInputHash.equals(inputHash)))
        .write(
      SituationEntriesCompanion(
        aiReflectionStatus: keepInProgress
            ? Value(AiReflectionStatus.inProgress.rawValue)
            : const Value(null),
        aiReflectionPhase: Value(phase.rawValue),
        aiReflectionLastErrorCode: Value(errorCode.name),
        aiReflectionLastErrorMessage: Value(message),
        updatedAt: Value(DateTime.now()),
      ),
    );

    return rows > 0;
  }

  Future<void> clearAiReflectionInProgress({
    required int entryId,
  }) async {
    final current = await getSituationEntryById(entryId);
    if (current == null ||
        AiReflectionStatus.fromRaw(current.aiReflectionStatus) !=
            AiReflectionStatus.inProgress) {
      return;
    }

    await (update(situationEntries)..where((e) => e.id.equals(entryId))).write(
      SituationEntriesCompanion(
        aiReflectionMode: const Value(null),
        aiReflectionStatus: const Value(null),
        aiReflectionPhase: const Value(null),
        aiReflectionSessionId: const Value(null),
        aiReflectionInputHash: const Value(null),
        aiReflectionStartedAt: const Value(null),
        aiReflectionProvider: const Value(null),
        aiReflectionModel: const Value(null),
        aiReflectionSchemaVersion: const Value(null),
        aiReflectionDeferredUntil: const Value(null),
        aiReflectionDeferredAt: const Value(null),
        aiReflectionResumeSuggestedAt: const Value(null),
        aiReflectionStartObservation: const Value(null),
        aiReflectionStartQuestion: const Value(null),
        aiReflectionStartHelperStarters: const Value(null),
        aiReflectionLastErrorCode: const Value(null),
        aiReflectionLastErrorMessage: const Value(null),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<bool> saveAiReflectionCompleted({
    required int entryId,
    required AiReflectionMode mode,
    required String sessionId,
    required String inputHash,
    required String provider,
    required String model,
    required int schemaVersion,
    required AiReflectionResult result,
    required DateTime completedAt,
  }) async {
    final rows = await (update(situationEntries)
          ..where((e) =>
              e.id.equals(entryId) &
              e.aiReflectionSessionId.equals(sessionId) &
              e.aiReflectionInputHash.equals(inputHash)))
        .write(
      SituationEntriesCompanion(
        aiReflectionMode: Value(mode.name),
        aiReflectionStatus: Value(AiReflectionStatus.completed.rawValue),
        aiReflectionPhase: Value(AiReflectionPhase.completed.rawValue),
        aiReflectionProvider: Value(provider),
        aiReflectionModel: Value(model),
        aiReflectionSchemaVersion: Value(schemaVersion),
        aiReflectionSummary: Value(result.summary),
        aiReflectionLikelyCore: Value(result.likelyCore),
        aiReflectionEarlyTurningPoint: Value(result.earlyTurningPoint),
        aiReflectionAlternative: Value(result.alternative),
        aiReflectionNextStep: Value(result.nextStep),
        aiReflectionMantra:
            result.hasMantra ? Value(result.mantra) : const Value(null),
        aiReflectionLastErrorCode: const Value(null),
        aiReflectionLastErrorMessage: const Value(null),
        aiReflectionDeferredAt: const Value(null),
        aiReflectionResumeSuggestedAt: const Value(null),
        aiReflectionCompletedAt: Value(completedAt),
        aiReflectionDeferredUntil: const Value(null),
        updatedAt: Value(DateTime.now()),
      ),
    );

    return rows > 0;
  }

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
  Future<void> setOnboardingCompleted(bool completed) async {
    final settings = await getOrCreateUserSettings();
    await updateUserSettings(
      settings.copyWith(
        onboardingCompleted: completed,
        isFirstLaunch: !completed,
        updatedAt: DateTime.now(),
      ),
    );
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
        'involvedEntities': e.involvedEntities,
        'preTriggerPreoccupation': e.preTriggerPreoccupation,
        'problemTiming': e.problemTiming,
        'triggerDescription': e.triggerDescription,
        'preTriggerLoad': e.preTriggerLoad,
        'intensity': e.intensity,
        'bodyTension': e.bodyTension,
        'primaryEmotion': e.primaryEmotion,
        'secondaryEmotion': e.secondaryEmotion,
        'bodySymptoms': e.bodySymptoms,
        'initialBodyReactions': e.initialBodyReactions,
        'additionalEmotions': e.additionalEmotions,
        'thoughtFocus': e.thoughtFocus,
        'automaticThought': e.automaticThought,
        'firstImpulse': e.firstImpulse,
        'factInterpretationResult': e.factInterpretationResult,
        'systemReaction': e.systemReaction,
        'thoughtPatterns': e.thoughtPatterns,
        'actualBehaviorTags': e.actualBehaviorTags,
        'actualBehavior': e.actualBehavior,
        'tippingPointAwareness': e.tippingPointAwareness,
        'fearOrPressurePoint': e.fearOrPressurePoint,
        'needOrWoundedPoint': e.needOrWoundedPoint,
        'touchedThemes': e.touchedThemes,
        'neededSupports': e.neededSupports,
        'realisticAlternative': e.realisticAlternative,
        'triggerAsLastDrop': e.triggerAsLastDrop,
        'backgroundTheme': e.backgroundTheme,
        'preEscalationRelief': e.preEscalationRelief,
        'patternFamiliarity': e.patternFamiliarity,
        'nextStep': e.nextStep,
        'systemState': e.systemState,
        'isCrisis': e.isCrisis,
        'evaluationHeadlineKey': e.evaluationHeadlineKey,
        'evaluationMeaningKey': e.evaluationMeaningKey,
        'evaluationHelpfulNowKey': e.evaluationHelpfulNowKey,
        'evaluationLearningPointKey': e.evaluationLearningPointKey,
        'evaluationStatusKeys': e.evaluationStatusKeys,
        'suggestedTipIds': e.suggestedTipIds,
        'suggestedNextActionKey': e.suggestedNextActionKey,
        'selectedNextActionKey': e.selectedNextActionKey,
        'aiEvaluationStatus': e.aiEvaluationStatus,
        'aiEvaluationProvider': e.aiEvaluationProvider,
        'aiEvaluationModel': e.aiEvaluationModel,
        'aiEvaluationRequestedAt': e.aiEvaluationRequestedAt?.toIso8601String(),
        'aiEvaluationCompletedAt': e.aiEvaluationCompletedAt?.toIso8601String(),
        'aiEvaluationConsentGiven': e.aiEvaluationConsentGiven,
        'aiEvaluationText': e.aiEvaluationText,
        'aiEvaluationSchemaVersion': e.aiEvaluationSchemaVersion,
        'aiReflectionMode': e.aiReflectionMode,
        'aiReflectionStatus': e.aiReflectionStatus,
        'aiReflectionSummary': e.aiReflectionSummary,
        'aiReflectionLikelyCore': e.aiReflectionLikelyCore,
        'aiReflectionEarlyTurningPoint': e.aiReflectionEarlyTurningPoint,
        'aiReflectionAlternative': e.aiReflectionAlternative,
        'aiReflectionNextStep': e.aiReflectionNextStep,
        'aiReflectionMantra': e.aiReflectionMantra,
        'aiReflectionDeferredUntil':
            e.aiReflectionDeferredUntil?.toIso8601String(),
        'aiReflectionCompletedAt': e.aiReflectionCompletedAt?.toIso8601String(),
        'aiReflectionPhase': e.aiReflectionPhase,
        'aiReflectionSessionId': e.aiReflectionSessionId,
        'aiReflectionInputHash': e.aiReflectionInputHash,
        'aiReflectionStartedAt': e.aiReflectionStartedAt?.toIso8601String(),
        'aiReflectionProvider': e.aiReflectionProvider,
        'aiReflectionModel': e.aiReflectionModel,
        'aiReflectionSchemaVersion': e.aiReflectionSchemaVersion,
        'aiReflectionStartObservation': e.aiReflectionStartObservation,
        'aiReflectionStartQuestion': e.aiReflectionStartQuestion,
        'aiReflectionStartHelperStarters': e.aiReflectionStartHelperStarters,
        'aiReflectionLastErrorCode': e.aiReflectionLastErrorCode,
        'aiReflectionLastErrorMessage': e.aiReflectionLastErrorMessage,
        'aiReflectionDeferredAt': e.aiReflectionDeferredAt?.toIso8601String(),
        'aiReflectionResumeSuggestedAt':
            e.aiReflectionResumeSuggestedAt?.toIso8601String(),
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
