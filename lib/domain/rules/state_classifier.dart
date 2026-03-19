import '../../core/constants/emotion_types.dart';
import '../../core/constants/impulse_types.dart';
import '../../core/constants/context_types.dart';
import '../../core/constants/fact_interpretation_results.dart';
import '../../core/constants/system_states.dart';

/// State classifier for determining the user's current mental/emotional state.
///
/// This classifier uses a deterministic rule-based approach to categorize
/// a situation into one of 8 possible system states based on the captured data.
///
/// Classification priority (highest to lowest):
/// 1. Acute Activation - High intensity + high tension + action impulse
/// 2. Self-Devaluation - Shame/guilt emotions with significant intensity
/// 3. Overwhelm - Overwhelming contexts with high intensity
/// 4. Conflict - Conflict contexts + conflict emotions + conflict impulses
/// 5. Rumination - Rumination impulses + negative emotions
/// 6. Interpretation - Unsichere Faktenlage mit starker Deutung
/// 7. Default: Reflective Ready
class StateClassifier {
  StateClassifier._();

  /// Classify the current state based on all available inputs.
  ///
  /// Returns a [SystemState] that best matches the pattern of inputs.
  /// The classification is deterministic - same inputs always produce the same output.
  static SystemState classify({
    required int intensity,
    required int bodyTension,
    required EmotionType primaryEmotion,
    EmotionType? secondaryEmotion,
    required ImpulseType firstImpulse,
    required ContextType context,
    FactInterpretationResult factInterpretation =
        FactInterpretationResult.mixed,
  }) {
    // Priority 1: Check for acute activation first
    // High intensity (8+) AND high body tension (7+) AND action-oriented impulse
    if (intensity >= 8 && bodyTension >= 7) {
      if (_isActionImpulse(firstImpulse)) {
        return SystemState.acuteActivation;
      }
    }

    // Priority 2: Check for self-devaluation
    // Primary or secondary emotion is shame/guilt with moderate+ intensity (6+)
    if (_isSelfDevaluatingEmotion(primaryEmotion, secondaryEmotion)) {
      if (intensity >= 6) {
        return SystemState.selfDevaluation;
      }
    }

    // Priority 3: Check for overwhelm
    // Overwhelming context with high intensity (7+)
    if (_isOverwhelmingContext(context) && intensity >= 7) {
      return SystemState.overwhelm;
    }

    // Priority 4: Check for conflict
    // Conflict context + conflict emotion + conflict impulse
    if (_isConflictContext(context)) {
      if (_isConflictEmotion(primaryEmotion) &&
          _isConflictImpulse(firstImpulse)) {
        return SystemState.conflict;
      }
    }

    // Priority 5: Check for rumination
    // Rumination-related impulse + rumination-prone emotions
    if (_isRuminationImpulse(firstImpulse)) {
      if (_isRuminationEmotion(primaryEmotion, secondaryEmotion)) {
        return SystemState.rumination;
      }
    }

    // Priority 6: Interpretation mode with weak factual certainty
    if (factInterpretation == FactInterpretationResult.mostlyInterpretation) {
      return SystemState.interpretation;
    }

    // Default: Reflective Ready
    // This is the baseline state - moderate distress, still accessible for reflection
    return SystemState.reflectiveReady;
  }

  /// Check if the impulse is action-oriented (counter, flee, immediate action).
  static bool _isActionImpulse(ImpulseType impulse) {
    return impulse == ImpulseType.counter ||
        impulse == ImpulseType.flee ||
        impulse == ImpulseType.immediateAction;
  }

  /// Check if either emotion is shame or guilt (self-devaluating).
  static bool _isSelfDevaluatingEmotion(
    EmotionType primary,
    EmotionType? secondary,
  ) {
    return primary == EmotionType.shame ||
        primary == EmotionType.guilt ||
        secondary == EmotionType.shame ||
        secondary == EmotionType.guilt;
  }

  /// Check if the context is typically overwhelming.
  static bool _isOverwhelmingContext(ContextType context) {
    return context == ContextType.work ||
        context == ContextType.finances ||
        context == ContextType.family ||
        context == ContextType.health;
  }

  /// Check if the context typically involves conflicts.
  static bool _isConflictContext(ContextType context) {
    return context == ContextType.partnership ||
        context == ContextType.family ||
        context == ContextType.work ||
        context == ContextType.friends;
  }

  /// Check if the emotion is typically involved in conflicts.
  static bool _isConflictEmotion(EmotionType emotion) {
    return emotion == EmotionType.anger || emotion == EmotionType.disgust;
  }

  /// Check if the impulse is typically involved in conflicts.
  static bool _isConflictImpulse(ImpulseType impulse) {
    return impulse == ImpulseType.counter ||
        impulse == ImpulseType.comply ||
        impulse == ImpulseType.withdraw;
  }

  /// Check if the impulse is rumination-related.
  static bool _isRuminationImpulse(ImpulseType impulse) {
    return impulse == ImpulseType.ruminate ||
        impulse == ImpulseType.control ||
        impulse == ImpulseType.perfectionism;
  }

  /// Check if either emotion is prone to rumination.
  static bool _isRuminationEmotion(
    EmotionType primary,
    EmotionType? secondary,
  ) {
    return primary == EmotionType.fear ||
        primary == EmotionType.sadness ||
        primary == EmotionType.shame ||
        primary == EmotionType.guilt ||
        secondary == EmotionType.fear ||
        secondary == EmotionType.sadness ||
        secondary == EmotionType.shame ||
        secondary == EmotionType.guilt;
  }
}

/// Result of state classification.
class ClassificationResult {
  const ClassificationResult({
    required this.systemState,
    required this.classificationConfidence,
    this.matchingCriteria = const [],
  });

  /// The determined system state.
  final SystemState systemState;

  /// Confidence level (0.0 to 1.0) based on how many criteria matched.
  /// In this deterministic rule-based system, this is either 0.0 or 1.0.
  final double classificationConfidence;

  /// List of criteria that matched for this classification.
  final List<String> matchingCriteria;

  @override
  String toString() {
    return 'ClassificationResult(state: $systemState, confidence: $classificationConfidence)';
  }
}
