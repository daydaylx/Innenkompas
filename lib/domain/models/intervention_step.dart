import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:innenkompass/core/constants/intervention_types.dart';

part 'intervention_step.freezed.dart';
part 'intervention_step.g.dart';

/// Typen von Interventionsschritten
enum InterventionStepType {
  /// Informative Textanzeige
  text,

  /// Atemübung mit Animation
  breathing,

  /// Timer mit Countdown
  timer,

  /// Reflexionsfrage mit Textfeld
  reflection,

  /// Auswahl aus Optionen
  selection,

  /// Handlungsaufforderung
  action,

  /// Fakt/Deutung Analyse
  factCheck,

  /// Bewertung 1-10
  rating;

  static InterventionStepType fromString(String value) {
    return InterventionStepType.values.firstWhere(
      (type) => type.name == value,
      orElse: () => InterventionStepType.text,
    );
  }

  String toDisplayString() {
    switch (this) {
      case InterventionStepType.text:
        return 'Information';
      case InterventionStepType.breathing:
        return 'Atemübung';
      case InterventionStepType.timer:
        return 'Timer';
      case InterventionStepType.reflection:
        return 'Reflexion';
      case InterventionStepType.selection:
        return 'Auswahl';
      case InterventionStepType.action:
        return 'Handlung';
      case InterventionStepType.factCheck:
        return 'Fakt/Deutung';
      case InterventionStepType.rating:
        return 'Bewertung';
    }
  }
}

/// Repräsentiert einen einzelnen Schritt innerhalb einer Intervention
@freezed
class InterventionStep with _$InterventionStep {
  const factory InterventionStep({
    /// Eindeutige ID des Schritts
    required String id,

    /// Typ des Schritts
    required InterventionStepType type,

    /// Titel des Schritts
    required String title,

    /// Hauptinhalt/Anweisung
    required String body,

    /// Optionale Dauer in Sekunden (für Timer/Breathing)
    int? durationSec,

    /// Optionale Auswahlmöglichkeiten (für selection/reflection)
    List<String>? options,

    /// Optionale Metadaten für spezifische Step-Typen
    Map<String, dynamic>? metadata,

    /// Optional: Untertitel für zusätzliche Informationen
    String? subtitle,

    /// Optional: Hilfetext
    String? helpText,
  }) = _InterventionStep;

  factory InterventionStep.fromJson(Map<String, dynamic> json) =>
      _$InterventionStepFromJson(json);
}

/// Antwort eines Nutzers auf einen Interventionsschritt
@freezed
class InterventionStepResponse with _$InterventionStepResponse {
  const factory InterventionStepResponse({
    /// ID des Schritts
    required String stepId,

    /// Typ des Schritts
    required InterventionStepType type,

    /// Text-Antwort (für reflection)
    String? textResponse,

    /// Auswahl-Antwort (für selection)
    String? selectionResponse,

    /// Bewertungs-Antwort (für rating)
    int? ratingResponse,

    /// Bool-Antwort (für action/confirmation)
    bool? boolResponse,

    /// Optional: Dauer die der Nutzer gebraucht hat
    int? actualDurationSec,

    /// Zeitstempel der Antwort
    required DateTime answeredAt,
  }) = _InterventionStepResponse;

  factory InterventionStepResponse.fromJson(Map<String, dynamic> json) =>
      _$InterventionStepResponseFromJson(json);
}
