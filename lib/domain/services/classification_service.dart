import '../../core/constants/emotion_types.dart';
import '../../core/constants/fact_interpretation_results.dart';
import '../../core/constants/impulse_types.dart';
import '../../core/constants/context_types.dart';
import '../../core/constants/system_states.dart';
import '../../core/constants/intervention_types.dart';
import '../rules/state_classifier.dart';
import '../rules/crisis_detector.dart';
import '../rules/intervention_selector.dart';
import 'intervention_resolver.dart';

/// Classification service that combines all classification components.
///
/// This service provides a single entry point for:
/// 1. State classification (StateClassifier)
/// 2. Crisis detection (CrisisDetector)
/// 3. Intervention selection (InterventionSelector)
///
/// It orchestrates the three components and returns a unified result.
class ClassificationService {
  ClassificationService._();

  /// Perform complete classification for a situation entry.
  ///
  /// This is the main entry point for classification. It runs all three
  /// classification steps and returns a unified result.
  ///
  /// Parameters:
  /// - [intensity]: Emotional intensity rating (1-10)
  /// - [bodyTension]: Body tension rating (1-10)
  /// - [primaryEmotion]: The primary emotion experienced
  /// - [secondaryEmotion]: Optional secondary emotion
  /// - [firstImpulse]: The first/strongest impulse
  /// - [context]: The context in which the situation occurred
  /// - [automaticThought]: The automatic thought that arose
  /// - [factInterpretation]: Einschätzung, wie stark der Gedanke auf Fakten basiert
  ///
  /// Returns a [CompleteClassificationResult] containing all classification data.
  static CompleteClassificationResult classify({
    required int intensity,
    required int bodyTension,
    required EmotionType primaryEmotion,
    EmotionType? secondaryEmotion,
    required ImpulseType firstImpulse,
    required ContextType context,
    required String automaticThought,
    FactInterpretationResult factInterpretation =
        FactInterpretationResult.mixed,
  }) {
    // Step 1: Classify system state
    final systemState = StateClassifier.classify(
      intensity: intensity,
      bodyTension: bodyTension,
      primaryEmotion: primaryEmotion,
      secondaryEmotion: secondaryEmotion,
      firstImpulse: firstImpulse,
      context: context,
      factInterpretation: factInterpretation,
    );

    // Step 2: Detect crisis indicators
    final crisisResult = CrisisDetector.detect(
      intensity: intensity,
      bodyTension: bodyTension,
      primaryEmotion: primaryEmotion,
      automaticThought: automaticThought,
      context: context,
    );

    final effectiveSystemState =
        crisisResult.isCrisis ? SystemState.crisis : systemState;

    // Step 3: Select interventions
    final interventions = InterventionSelector.selectInterventions(
      systemState: effectiveSystemState,
      primaryEmotion: primaryEmotion,
      intensity: intensity,
    );
    final concreteRecommendations = InterventionResolver.resolveRecommendations(
      systemState: effectiveSystemState,
      primaryEmotion: primaryEmotion,
      intensity: intensity,
    );

    return CompleteClassificationResult(
      systemState: effectiveSystemState,
      isCrisis: crisisResult.isCrisis,
      crisisIndicators: crisisResult.indicators,
      crisisSeverity: crisisResult.severity,
      recommendedInterventions: interventions,
      recommendedInterventionIds: concreteRecommendations
          .map((recommendation) => recommendation.interventionId)
          .toList(growable: false),
      primaryIntervention:
          interventions.isNotEmpty ? interventions.first : null,
      primaryInterventionId: concreteRecommendations.isNotEmpty
          ? concreteRecommendations.first.interventionId
          : null,
    );
  }

  /// Quick classification for emergency scenarios.
  ///
  /// This is a simplified version that focuses on crisis detection
  /// and basic state classification. Used in time-sensitive scenarios.
  static QuickClassificationResult quickClassify({
    required int intensity,
    required int bodyTension,
    required String automaticThought,
  }) {
    final isEmergency = CrisisDetector.isEmergencyCrisis(
      intensity: intensity,
      bodyTension: bodyTension,
      automaticThought: automaticThought,
    );

    // For emergency, we default to crisis state
    final systemState =
        isEmergency ? SystemState.crisis : SystemState.reflectiveReady;

    return QuickClassificationResult(
      systemState: systemState,
      isEmergencyCrisis: isEmergency,
      requiresImmediateIntervention: isEmergency,
    );
  }

  /// Classify state only (without crisis detection or intervention selection).
  ///
  /// This is useful when you only need the system state without the full
  /// classification pipeline.
  static SystemState classifyStateOnly({
    required int intensity,
    required int bodyTension,
    required EmotionType primaryEmotion,
    EmotionType? secondaryEmotion,
    required ImpulseType firstImpulse,
    required ContextType context,
    FactInterpretationResult factInterpretation =
        FactInterpretationResult.mixed,
  }) {
    return StateClassifier.classify(
      intensity: intensity,
      bodyTension: bodyTension,
      primaryEmotion: primaryEmotion,
      secondaryEmotion: secondaryEmotion,
      firstImpulse: firstImpulse,
      context: context,
      factInterpretation: factInterpretation,
    );
  }

  /// Detect crisis only (without state classification).
  ///
  /// This is useful when you want to check for crisis indicators
  /// without running the full classification.
  static CrisisDetectionResult detectCrisisOnly({
    required int intensity,
    required int bodyTension,
    required EmotionType primaryEmotion,
    required String automaticThought,
    required ContextType context,
  }) {
    return CrisisDetector.detect(
      intensity: intensity,
      bodyTension: bodyTension,
      primaryEmotion: primaryEmotion,
      automaticThought: automaticThought,
      context: context,
    );
  }

  /// Get intervention recommendations only.
  ///
  /// This is useful when you already have the state and just need
  /// intervention recommendations.
  static List<InterventionType> getInterventionsOnly({
    required SystemState systemState,
    required EmotionType primaryEmotion,
    required int intensity,
  }) {
    return InterventionSelector.selectInterventions(
      systemState: systemState,
      primaryEmotion: primaryEmotion,
      intensity: intensity,
    );
  }
}

/// Complete classification result containing all classification data.
class CompleteClassificationResult {
  const CompleteClassificationResult({
    required this.systemState,
    required this.isCrisis,
    required this.crisisIndicators,
    required this.crisisSeverity,
    required this.recommendedInterventions,
    required this.recommendedInterventionIds,
    required this.primaryIntervention,
    required this.primaryInterventionId,
  });

  /// The determined system state.
  final SystemState systemState;

  /// Whether a crisis was detected.
  final bool isCrisis;

  /// List of crisis indicators found.
  final List<String> crisisIndicators;

  /// Severity level of the crisis (if any).
  final CrisisSeverity crisisSeverity;

  /// Ordered list of recommended interventions.
  final List<InterventionType> recommendedInterventions;

  /// Ordered list of concrete intervention IDs.
  final List<String> recommendedInterventionIds;

  /// The primary intervention to use first.
  final InterventionType? primaryIntervention;

  /// The concrete intervention ID to use first.
  final String? primaryInterventionId;

  /// Check if this result requires immediate crisis support.
  bool get requiresImmediateCrisisSupport {
    return isCrisis && crisisSeverity == CrisisSeverity.high;
  }

  /// Check if this result requires some crisis support.
  bool get requiresCrisisSupport {
    return isCrisis;
  }

  /// Get a summary description of the classification.
  String get summary {
    final buffer = StringBuffer();
    buffer.write('Zustand: ${systemState.displayLabel}');
    if (isCrisis) {
      buffer.write(' | Krise erkannt (${crisisSeverity.displayLabel})');
    }
    if (recommendedInterventions.isNotEmpty) {
      buffer.write(
          ' | Empfehlung: ${recommendedInterventions.first.displayLabel}');
    }
    return buffer.toString();
  }

  @override
  String toString() {
    return 'CompleteClassificationResult(state: $systemState, isCrisis: $isCrisis, interventions: $recommendedInterventions)';
  }
}

/// Quick classification result for emergency scenarios.
class QuickClassificationResult {
  const QuickClassificationResult({
    required this.systemState,
    required this.isEmergencyCrisis,
    required this.requiresImmediateIntervention,
  });

  /// The determined system state.
  final SystemState systemState;

  /// Whether this is an emergency crisis situation.
  final bool isEmergencyCrisis;

  /// Whether immediate intervention is required.
  final bool requiresImmediateIntervention;

  @override
  String toString() {
    return 'QuickClassificationResult(state: $systemState, isEmergency: $isEmergencyCrisis)';
  }
}
