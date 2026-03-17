import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:innenkompass/core/constants/emotion_types.dart';
import 'package:innenkompass/core/constants/system_states.dart';
import 'package:innenkompass/core/constants/intervention_types.dart';
import 'package:innenkompass/domain/models/intervention_step.dart';

part 'intervention.freezed.dart';
part 'intervention.g.dart';

/// Repräsentiert eine vollständige Intervention mit allen Schritten
@freezed
class Intervention with _$Intervention {
  const factory Intervention({
    /// Eindeutige ID der Intervention
    required String id,

    /// Typ der Intervention
    required InterventionType type,

    /// Titel der Intervention
    required String title,

    /// Zusammenfassung der Intervention
    required String summary,

    /// Detaillierte Beschreibung
    required String description,

    /// Liste aller Schritte
    required List<InterventionStep> steps,

    /// Geschätzte Dauer in Sekunden
    required int estimatedDurationSec,

    /// Für welche Systemzustände empfohlen
    required List<SystemState> recommendedForStates,

    /// Für welche Emotionen empfohlen
    required List<EmotionType> recommendedForEmotions,

    /// Mindest-Intensität für Empfehlung
    int? minIntensity,

    /// Maximal-Intensität für Empfehlung
    int? maxIntensity,

    /// Optional: Icon/Emoji für Darstellung
    String? icon,

    /// Optional: Kategorie für Gruppierung
    String? category,

    /// Optional: Schwierigkeitsgrad (1-5)
    int? difficultyLevel,
  }) = _Intervention;

  factory Intervention.fromJson(Map<String, dynamic> json) =>
      _$InterventionFromJson(json);
}

/// Ergebnis einer durchgeführten Intervention
@freezed
class InterventionResult with _$InterventionResult {
  const factory InterventionResult({
    /// ID der durchgeführten Intervention
    required String interventionId,

    /// Titel der Intervention
    required String title,

    /// Typ der Intervention
    required InterventionType type,

    /// Startzeitpunkt
    required DateTime startedAt,

    /// Endzeitpunkt
    required DateTime completedAt,

    /// Tatsächliche Dauer in Sekunden
    required int actualDurationSec,

    /// Antworten auf alle Schritte
    required List<InterventionStepResponse> stepResponses,

    /// Wurde die Intervention abgebrochen?
    required bool wasCompleted,

    /// Abbruch-Grund (falls abgebrochen)
    String? abortReason,

    /// Optional: Nutzer-Notiz nach Intervention
    String? userNote,
  }) = _InterventionResult;

  factory InterventionResult.fromJson(Map<String, dynamic> json) =>
      _$InterventionResultFromJson(json);
}

/// Effektivitäts-Metrik für eine Intervention
@freezed
class InterventionEffectiveness with _$InterventionEffectiveness {
  const factory InterventionEffectiveness({
    /// ID der Intervention
    required String interventionId,

    /// Titel der Intervention
    required String title,

    /// Typ der Intervention
    required InterventionType type,

    /// Anzahl der Durchführungen
    required int usageCount,

    /// Durchschnittliche Verbesserung der Belastung (vorher-nachher)
    required double avgImprovement,

    /// Durchschnittliche Verbesserung der Körperanspannung
    required double avgTensionImprovement,

    /// Durchschnittliche Klarheit nach Intervention
    required double avgClarityGain,

    /// Hilfreichkeits-Rating (1-10)
    required double avgHelpfulnessRating,

    /// Letzte Verwendung
    required DateTime lastUsedAt,
  }) = _InterventionEffectiveness;

  factory InterventionEffectiveness.fromJson(Map<String, dynamic> json) =>
      _$InterventionEffectivenessFromJson(json);
}
