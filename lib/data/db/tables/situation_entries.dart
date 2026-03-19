import 'package:drift/drift.dart';

/// Situation entries table.
///
/// This is the main table for storing all situation entries in the app.
@DataClassName('SituationEntryData')
class SituationEntries extends Table {
  // Primary key
  IntColumn get id => integer().autoIncrement()();

  // Core fields (Phase 1)
  TextColumn get situationDescription => text()();
  TextColumn get context => text()();
  DateTimeColumn get timestamp => dateTime()();
  TextColumn get involvedPerson =>
      text().nullable()(); // Optional person involved

  // Emotion fields (Phase 1)
  IntColumn get intensity => integer()(); // 1-10
  IntColumn get bodyTension => integer()(); // 1-10
  TextColumn get primaryEmotion => text()();
  TextColumn get secondaryEmotion =>
      text().nullable()(); // Optional second emotion
  TextColumn get bodySymptoms => text().nullable()(); // JSON array of symptoms

  // Thought and impulse fields (Phase 1)
  TextColumn get automaticThought => text()();
  TextColumn get firstImpulse => text()();
  TextColumn get factInterpretationResult => text().nullable()();
  TextColumn get actualBehavior =>
      text().nullable()(); // Optional actual behavior
  TextColumn get needOrWoundedPoint => text().nullable()();
  TextColumn get nextStep => text().nullable()();

  // Classification fields (Phase 4)
  TextColumn get systemState => text()();
  BoolColumn get isCrisis => boolean().withDefault(const Constant(false))();
  TextColumn get evaluationHeadlineKey => text().nullable()();
  TextColumn get evaluationMeaningKey => text().nullable()();
  TextColumn get suggestedTipIds => text().nullable()(); // JSON array
  TextColumn get suggestedNextActionKey => text().nullable()();
  TextColumn get selectedNextActionKey => text().nullable()();
  TextColumn get aiEvaluationStatus => text().nullable()();
  TextColumn get aiEvaluationProvider => text().nullable()();
  TextColumn get aiEvaluationModel => text().nullable()();
  DateTimeColumn get aiEvaluationRequestedAt => dateTime().nullable()();
  DateTimeColumn get aiEvaluationCompletedAt => dateTime().nullable()();
  BoolColumn get aiEvaluationConsentGiven =>
      boolean().withDefault(const Constant(false))();
  TextColumn get aiEvaluationText => text().nullable()();
  IntColumn get aiEvaluationSchemaVersion => integer().nullable()();

  // Intervention fields (Phase 5)
  TextColumn get interventionType =>
      text().nullable()(); // Type of intervention shown
  TextColumn get interventionId =>
      text().nullable()(); // ID of specific intervention
  BoolColumn get interventionCompleted =>
      boolean().withDefault(const Constant(false))();
  IntColumn get interventionDurationSec =>
      integer().nullable()(); // Actual duration in seconds

  // Post-evaluation fields (Phase 5)
  IntColumn get postIntensity =>
      integer().nullable()(); // Intensity after intervention
  IntColumn get postBodyTension =>
      integer().nullable()(); // Body tension after intervention
  IntColumn get postClarity =>
      integer().nullable()(); // Clarity after intervention
  IntColumn get helpfulnessRating =>
      integer().nullable()(); // 1-10 helpfulness rating
  TextColumn get postNote => text().nullable()(); // Optional note after

  // Metadata
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isDraft =>
      boolean().withDefault(const Constant(false))(); // For incomplete entries

  // Note: Indexes can be added later if needed for performance
  // For MVP, we'll rely on standard querying without custom indexes
}
