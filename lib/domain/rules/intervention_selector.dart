import '../../core/constants/emotion_types.dart';
import '../../core/constants/system_states.dart';
import '../../core/constants/intervention_types.dart';

/// Intervention selector using rule-based logic.
///
/// This selector determines the most appropriate interventions
/// based on:
/// 1. System state (primary factor)
/// 2. Primary emotion (secondary factor)
/// 3. Intensity level (affects ordering and count)
///
/// Returns a prioritized list of intervention types (max 4 for MVP).
class InterventionSelector {
  InterventionSelector._();

  /// Select appropriate interventions based on classification inputs.
  ///
  /// Returns a prioritized list of [InterventionType] recommendations.
  /// The list is ordered from most to least important.
  /// Maximum 4 interventions are returned for the MVP.
  static List<InterventionType> selectInterventions({
    required SystemState systemState,
    required EmotionType primaryEmotion,
    required int intensity,
  }) {
    // Start with state-based recommendations
    final stateBased = _getStateBasedInterventions(systemState);

    if (systemState == SystemState.crisis) {
      return stateBased.take(4).toList(growable: false);
    }

    // Add emotion-based recommendations
    final emotionBased = _getEmotionBasedInterventions(primaryEmotion);

    // Adjust ordering based on intensity
    if (intensity >= 8) {
      // At very high intensity, regulation comes first
      return {
        if (!stateBased.contains(InterventionType.regulation))
          InterventionType.regulation,
        ...stateBased.take(3),
        ...emotionBased.take(1),
      }.take(4).toList();
    }

    // Combine and deduplicate while maintaining priority
    final combined = {
      ...stateBased,
      ...emotionBased,
    }.toList();

    // Reorder based on state priority
    final ordered = _reorderForState(combined, systemState);

    // Return max 4 interventions
    return ordered.take(4).toList();
  }

  /// Get state-based intervention recommendations.
  static List<InterventionType> _getStateBasedInterventions(
    SystemState state,
  ) {
    switch (state) {
      case SystemState.acuteActivation:
        return [
          InterventionType.regulation,
          InterventionType.impulsePause,
          InterventionType.factCheck,
        ];

      case SystemState.reflectiveReady:
        return [
          InterventionType.abc3,
          InterventionType.rsaAbcde,
          InterventionType.factCheck,
          InterventionType.communication,
          InterventionType.selfValueCheck,
        ];

      case SystemState.rumination:
        return [
          InterventionType.ruminationStop,
          InterventionType.abc3,
          InterventionType.factCheck,
          InterventionType.regulation,
        ];

      case SystemState.conflict:
        return [
          InterventionType.impulsePause,
          InterventionType.communication,
          InterventionType.factCheck,
        ];

      case SystemState.selfDevaluation:
        return [
          InterventionType.selfValueCheck,
          InterventionType.rsaAbcde,
          InterventionType.factCheck,
          InterventionType.regulation,
        ];

      case SystemState.overwhelm:
        return [
          InterventionType.overwhelmStructure,
          InterventionType.regulation,
          InterventionType.factCheck,
        ];

      case SystemState.crisis:
        // Crisis state - provide grounding and safety
        return [
          InterventionType.regulation,
          InterventionType.impulsePause,
        ];
    }
  }

  /// Get emotion-based intervention recommendations.
  static List<InterventionType> _getEmotionBasedInterventions(
    EmotionType emotion,
  ) {
    switch (emotion) {
      case EmotionType.anger:
        return [
          InterventionType.impulsePause,
          InterventionType.regulation,
          InterventionType.communication,
        ];

      case EmotionType.fear:
        return [
          InterventionType.regulation,
          InterventionType.ruminationStop,
          InterventionType.factCheck,
        ];

      case EmotionType.shame:
      case EmotionType.guilt:
        return [
          InterventionType.selfValueCheck,
          InterventionType.factCheck,
          InterventionType.regulation,
        ];

      case EmotionType.sadness:
        return [
          InterventionType.regulation,
          InterventionType.factCheck,
        ];

      case EmotionType.disgust:
        return [
          InterventionType.impulsePause,
          InterventionType.factCheck,
        ];

      case EmotionType.joy:
      case EmotionType.pride:
      case EmotionType.surprise:
      case EmotionType.loneliness:
        return [];
    }
  }

  /// Reorder interventions based on system state priority.
  static List<InterventionType> _reorderForState(
    List<InterventionType> interventions,
    SystemState state,
  ) {
    // Priority order based on state
    final priorityMap = <InterventionType, int>{
      // Acute activation - regulation first
      InterventionType.regulation: state == SystemState.acuteActivation ? 1 : 5,
      InterventionType.impulsePause:
          state == SystemState.acuteActivation ? 2 : 4,

      // Rumination - rumination stop first
      InterventionType.ruminationStop: state == SystemState.rumination ? 1 : 5,

      // Conflict - impulse pause first
      InterventionType.communication: state == SystemState.conflict ? 2 : 4,

      // Self-devaluation - self value check first
      InterventionType.selfValueCheck:
          state == SystemState.selfDevaluation ? 1 : 5,

      // Overwhelm - structure first
      InterventionType.overwhelmStructure:
          state == SystemState.overwhelm ? 1 : 5,

      // Fact check is generally good for reflective states
      InterventionType.factCheck: state == SystemState.reflectiveReady ? 1 : 3,

      // Worksheet templates for reflective states
      InterventionType.abc3: state == SystemState.reflectiveReady ? 2 : 6,
      InterventionType.rsaAbcde: state == SystemState.selfDevaluation ? 2 : 7,
    };

    // Sort by priority (lower number = higher priority)
    final sorted = interventions.toList()
      ..sort((a, b) {
        final priorityA = priorityMap[a] ?? 10;
        final priorityB = priorityMap[b] ?? 10;
        return priorityA.compareTo(priorityB);
      });

    return sorted;
  }

  /// Get a fallback intervention when classification fails.
  static InterventionType getFallbackIntervention() {
    return InterventionType.regulation;
  }

  /// Check if an intervention type is suitable for the given state.
  static bool isInterventionSuitable({
    required InterventionType intervention,
    required SystemState state,
    required int intensity,
  }) {
    // Regulation is suitable for all high-intensity states
    if (intensity >= 7) {
      return intervention == InterventionType.regulation ||
          intervention == InterventionType.impulsePause;
    }

    // Fact check is not suitable for acute states
    if (state == SystemState.acuteActivation || state == SystemState.crisis) {
      return intervention != InterventionType.factCheck &&
          intervention != InterventionType.communication &&
          intervention != InterventionType.selfValueCheck;
    }

    // Communication requires some readiness
    if (intervention == InterventionType.communication) {
      return state != SystemState.acuteActivation &&
          state != SystemState.crisis &&
          state != SystemState.overwhelm;
    }

    // Self value check is specific to devaluation states
    if (intervention == InterventionType.selfValueCheck) {
      return state == SystemState.selfDevaluation ||
          state == SystemState.reflectiveReady;
    }

    return true;
  }
}

/// Result of intervention selection.
class InterventionSelectionResult {
  const InterventionSelectionResult({
    required this.recommendedInterventions,
    required this.primaryIntervention,
    this.alternativeInterventions = const [],
  });

  /// Ordered list of recommended interventions.
  final List<InterventionType> recommendedInterventions;

  /// The primary intervention to use first.
  final InterventionType primaryIntervention;

  /// Alternative interventions if the primary doesn't fit.
  final List<InterventionType> alternativeInterventions;

  /// Get the estimated total duration for all recommended interventions.
  int get estimatedTotalDuration {
    return recommendedInterventions
        .map((i) => i.typicalDuration)
        .fold(0, (sum, duration) => sum + duration);
  }

  @override
  String toString() {
    return 'InterventionSelectionResult(primary: $primaryIntervention, all: $recommendedInterventions)';
  }
}
