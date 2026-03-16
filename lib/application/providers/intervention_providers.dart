import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:innenkompass/core/constants/emotion_types.dart';
import 'package:innenkompass/core/constants/intervention_types.dart';
import 'package:innenkompass/core/constants/system_states.dart';
import 'package:innenkompass/data/db/app_database.dart';
import 'package:innenkompass/domain/models/intervention.dart';
import 'package:innenkompass/domain/models/intervention_library.dart';
import 'package:innenkompass/domain/models/intervention_step.dart';
import 'package:innenkompass/domain/models/pattern_summary.dart';
import 'package:innenkompass/domain/services/pattern_analyzer.dart';
import 'package:innenkompass/application/providers/database_provider.dart';

part 'intervention_providers.freezed.dart';
part 'intervention_providers.g.dart';

/// State für den Intervention-Flow
@riverpod
class InterventionFlowState extends _$InterventionFlowState {
  @override
  InterventionFlowData build() {
    return InterventionFlowData(
      currentStepIndex: 0,
      stepResponses: {},
      isCompleted: false,
      startedAt: null,
      completedAt: null,
      wasAborted: false,
    );
  }

  /// Startet eine neue Intervention
  void startIntervention(Intervention intervention) {
    state = InterventionFlowData(
      currentStepIndex: 0,
      stepResponses: {},
      isCompleted: false,
      startedAt: DateTime.now(),
      completedAt: null,
      wasAborted: false,
      intervention: intervention,
    );
  }

  /// Speichert die Antwort für den aktuellen Schritt
  void saveStepResponse(InterventionStepResponse response) {
    if (state.intervention == null) return;

    final newResponses = Map<String, InterventionStepResponse>.from(state.stepResponses);
    newResponses[response.stepId] = response;

    state = state.copyWith(
      stepResponses: newResponses,
    );
  }

  /// Geht zum nächsten Schritt
  void nextStep() {
    if (state.intervention == null) return;
    if (state.currentStepIndex < state.intervention!.steps.length - 1) {
      state = state.copyWith(
        currentStepIndex: state.currentStepIndex + 1,
      );
    }
  }

  /// Geht zum vorherigen Schritt
  void previousStep() {
    if (state.currentStepIndex > 0) {
      state = state.copyWith(
        currentStepIndex: state.currentStepIndex - 1,
      );
    }
  }

  /// Springt zu einem bestimmten Schritt
  void goToStep(int index) {
    if (state.intervention == null) return;
    if (index >= 0 && index < state.intervention!.steps.length) {
      state = state.copyWith(
        currentStepIndex: index,
      );
    }
  }

  /// Markiert die Intervention als abgeschlossen
  void completeIntervention() {
    state = state.copyWith(
      isCompleted: true,
      completedAt: DateTime.now(),
      currentStepIndex: (state.intervention?.steps.length ?? 1) - 1,
    );
  }

  /// Bricht die Intervention ab
  void abortIntervention() {
    state = state.copyWith(
      wasAborted: true,
      completedAt: DateTime.now(),
    );
  }

  /// Setzt den Flow zurück
  void reset() {
    state = InterventionFlowData(
      currentStepIndex: 0,
      stepResponses: {},
      isCompleted: false,
      startedAt: null,
      completedAt: null,
      wasAborted: false,
    );
  }
}

/// Datenklasse für den Intervention-Flow-State
@freezed
class InterventionFlowData with _$InterventionFlowData {
  const factory InterventionFlowData({
    /// Aktueller Schritt-Index
    required int currentStepIndex,

    /// Antworten aller Schritte (key: stepId)
    @Default({}) Map<String, InterventionStepResponse> stepResponses,

    /// Ist die Intervention abgeschlossen?
    required bool isCompleted,

    /// Startzeitpunkt
    DateTime? startedAt,

    /// Endzeitpunkt
    DateTime? completedAt,

    /// Wurde abgebrochen?
    required bool wasAborted,

    /// Die aktuelle Intervention
    Intervention? intervention,
  }) = _InterventionFlowData;

  factory InterventionFlowData.fromJson(Map<String, dynamic> json) =>
      _$InterventionFlowDataFromJson(json);

  /// Berechnet die tatsächliche Dauer in Sekunden
  int? get actualDurationSec {
    if (startedAt == null || completedAt == null) return null;
    return completedAt!.difference(startedAt!).inSeconds;
  }

  /// Gibt den aktuellen Schritt zurück
  InterventionStep? get currentStep {
    if (intervention == null) return null;
    if (currentStepIndex < 0 || currentStepIndex >= intervention!.steps.length) {
      return null;
    }
    return intervention!.steps[currentStepIndex];
  }

  /// Gibt alle Antworten als Liste zurück
  List<InterventionStepResponse> get responsesList => stepResponses.values.toList();

  /// Prüft, ob alle Pflicht-Schritte beantwortet wurden
  bool get allRequiredStepsAnswered {
    if (intervention == null) return false;

    for (final step in intervention!.steps) {
      // Prüfen, ob dieser Schritt eine Antwort hat
      if (!stepResponses.containsKey(step.id)) {
        return false;
      }
    }

    return true;
  }
}

/// Provider für Interventionen basierend auf Klassifikation
@riverpod
List<Intervention> recommendedInterventions(RecommendedInterventionsRef ref) {
  // Dieser Provider wird von außen mit Parametern aufgerufen
  throw UnimplementedError('Use getRecommendedInterventions instead');
}

/// Factory-Methode um empfohlene Interventionen zu erhalten
List<Intervention> getRecommendedInterventions({
  required SystemState systemState,
  required EmotionType primaryEmotion,
  required int intensity,
  List<InterventionType>? preferredTypes,
}) {
  return InterventionLibrary.getRecommended(
    systemState: systemState,
    emotion: primaryEmotion,
    intensity: intensity,
    preferredTypes: preferredTypes,
  );
}

/// State für die Nachbewertung
@riverpod
class PostEvaluationState extends _$PostEvaluationState {
  @override
  PostEvaluationData build() {
    return const PostEvaluationData(
      postIntensity: null,
      postBodyTension: null,
      postClarity: null,
      helpfulnessRating: null,
      userNote: null,
    );
  }

  /// Aktualisiert die Belastung nach der Intervention
  void updatePostIntensity(int value) {
    state = state.copyWith(postIntensity: value);
  }

  /// Aktualisiert die Körperanspannung nach der Intervention
  void updatePostBodyTension(int value) {
    state = state.copyWith(postBodyTension: value);
  }

  /// Aktualisiert die Klarheit nach der Intervention
  void updatePostClarity(int value) {
    state = state.copyWith(postClarity: value);
  }

  /// Aktualisiert das Hilfreichkeits-Rating
  void updateHelpfulnessRating(int value) {
    state = state.copyWith(helpfulnessRating: value);
  }

  /// Aktualisiert die Nutzer-Notiz
  void updateUserNote(String? value) {
    state = state.copyWith(userNote: value);
  }

  /// Prüft, ob die Nachbewertung vollständig ist
  bool get isComplete {
    return state.postIntensity != null &&
        state.postBodyTension != null &&
        state.postClarity != null &&
        state.helpfulnessRating != null;
  }

  /// Setzt den State zurück
  void reset() {
    state = const PostEvaluationData(
      postIntensity: null,
      postBodyTension: null,
      postClarity: null,
      helpfulnessRating: null,
      userNote: null,
    );
  }
}

/// Datenklasse für die Nachbewertung
@freezed
class PostEvaluationData with _$PostEvaluationData {
  const factory PostEvaluationData({
    /// Belastung nach der Intervention (1-10)
    int? postIntensity,

    /// Körperanspannung nach der Intervention (1-10)
    int? postBodyTension,

    /// Klarheit nach der Intervention (1-10)
    int? postClarity,

    /// Hilfreichkeits-Rating (1-10)
    int? helpfulnessRating,

    /// Optionale Nutzer-Notiz
    String? userNote,
  }) = _PostEvaluationData;

  factory PostEvaluationData.fromJson(Map<String, dynamic> json) =>
      _$PostEvaluationDataFromJson(json);

  /// Berechnet die Verbesserung der Belastung
  int? calculateImprovement(int preIntensity) {
    if (postIntensity == null) return null;
    return preIntensity - postIntensity!;
  }

  /// Berechnet die Verbesserung der Körperanspannung
  int? calculateTensionImprovement(int preTension) {
    if (postBodyTension == null) return null;
    return preTension - postBodyTension!;
  }
}

/// Provider für Pattern-Analyse
@riverpod
Future<PatternSummary> patternSummary(PatternSummaryRef ref) async {
  final db = ref.watch(databaseProvider);
  final entries = await db.getAllSituationEntries();
  return PatternAnalyzer.analyzePatterns(entries);
}

/// Provider für gefilterte Einträge
@riverpod
Future<List<SituationEntryData>> filteredHistoryEntries(
  FilteredHistoryEntriesRef ref,
  HistoryFilter filter,
) async {
  final db = ref.watch(databaseProvider);
  final allEntries = await db.getAllSituationEntries();
  final filtered = PatternAnalyzer.filterEntries(allEntries, filter);
  // Sortiere: Neueste zuerst
  filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt));
  return filtered;
}

/// Provider für Emotions-Statistiken
@riverpod
Future<Map<EmotionType, Map<String, dynamic>>> emotionStatistics(
  EmotionStatisticsRef ref,
) async {
  final db = ref.watch(databaseProvider);
  final entries = await db.getAllSituationEntries();

  final stats = <EmotionType, Map<String, dynamic>>{};
  for (final emotion in EmotionType.values) {
    stats[emotion] = PatternAnalyzer.getEmotionStats(entries, emotion);
  }

  return stats;
}

/// Provider für Trend-Daten der letzten 7 Tage
@riverpod
Future<TrendData> last7DaysTrend(Last7DaysTrendRef ref) async {
  final db = ref.watch(databaseProvider);
  final allEntries = await db.getAllSituationEntries();

  final now = DateTime.now();
  final sevenDaysAgo = now.subtract(const Duration(days: 7));

  final recentEntries = allEntries
      .where((e) => e.createdAt.isAfter(sevenDaysAgo))
      .toList();

  if (recentEntries.isEmpty) {
    return const TrendData(
      avgIntensity: 0,
      avgTension: 0,
      entryCount: 0,
      mostCommonEmotion: null,
    );
  }

  final avgIntensity = recentEntries
          .map((e) => e.intensity)
          .reduce((a, b) => a + b) /
      recentEntries.length;

  final avgTension = recentEntries
          .map((e) => e.bodyTension)
          .reduce((a, b) => a + b) /
      recentEntries.length;

  final mostCommonEmotion = PatternAnalyzer.getEmotionStats(
    recentEntries,
    recentEntries
            .map((e) => e.primaryEmotion)
            .reduce((a, b) => recentEntries
                    .where((e) => e.primaryEmotion == a)
                    .length >=
                recentEntries.where((e) => e.primaryEmotion == b).length
            ? a
            : b),
  )['mostCommonEmotion'] as EmotionType?;

  return TrendData(
    avgIntensity: avgIntensity,
    avgTension: avgTension,
    entryCount: recentEntries.length,
    mostCommonEmotion: mostCommonEmotion,
  );
}

/// Trend-Daten
@freezed
class TrendData with _$TrendData {
  const factory TrendData({
    required double avgIntensity,
    required double avgTension,
    required int entryCount,
    required EmotionType? mostCommonEmotion,
  }) = _TrendData;

  factory TrendData.fromJson(Map<String, dynamic> json) =>
      _$TrendDataFromJson(json);
}

/// Provider für gespeicherte Interventionsergebnisse
@riverpod
Future<List<InterventionEffectiveness>> interventionEffectiveness(
  InterventionEffectivenessRef ref,
) async {
  final db = ref.watch(databaseProvider);
  final entries = await db.getAllSituationEntries();

  final summary = await PatternAnalyzer.analyzePatterns(entries);
  return summary.mostEffectiveInterventions;
}

/// Helper-Provider für die Datenbank
@riverpod
AppDatabase database(DatabaseRef ref) {
  throw UnimplementedError('Use AppDatabase.instance from database_provider');
}
