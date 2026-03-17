import '../../core/constants/emotion_types.dart';
import '../../core/constants/impulse_types.dart';
import '../../core/constants/context_types.dart';

/// Domain model for event data captured in step 1 of the new situation flow.
class SituationEventData {
  const SituationEventData({
    required this.description,
    required this.context,
    required this.timestamp,
    this.involvedPerson,
  });

  /// Description of what happened (3-300 characters)
  final String description;

  /// Context in which the situation occurred
  final ContextType context;

  /// When the situation happened
  final DateTime timestamp;

  /// Optional person involved
  final String? involvedPerson;

  /// Create a copy with some fields replaced
  SituationEventData copyWith({
    String? description,
    ContextType? context,
    DateTime? timestamp,
    String? involvedPerson,
  }) {
    return SituationEventData(
      description: description ?? this.description,
      context: context ?? this.context,
      timestamp: timestamp ?? this.timestamp,
      involvedPerson: involvedPerson ?? this.involvedPerson,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SituationEventData &&
        other.description == description &&
        other.context == context &&
        other.timestamp == timestamp &&
        other.involvedPerson == involvedPerson;
  }

  @override
  int get hashCode {
    return description.hashCode ^
        context.hashCode ^
        timestamp.hashCode ^
        involvedPerson.hashCode;
  }
}

/// Domain model for emotion data captured in step 2 of the new situation flow.
class SituationEmotionData {
  const SituationEmotionData({
    required this.intensity,
    required this.bodyTension,
    required this.primaryEmotion,
    this.secondaryEmotion,
    this.bodySymptoms = const [],
  });

  /// Intensity rating (1-10)
  final int intensity;

  /// Body tension rating (1-10)
  final int bodyTension;

  /// Primary emotion
  final EmotionType primaryEmotion;

  /// Optional secondary emotion
  final EmotionType? secondaryEmotion;

  /// List of body symptoms experienced
  final List<String> bodySymptoms;

  /// Create a copy with some fields replaced
  SituationEmotionData copyWith({
    int? intensity,
    int? bodyTension,
    EmotionType? primaryEmotion,
    EmotionType? secondaryEmotion,
    List<String>? bodySymptoms,
  }) {
    return SituationEmotionData(
      intensity: intensity ?? this.intensity,
      bodyTension: bodyTension ?? this.bodyTension,
      primaryEmotion: primaryEmotion ?? this.primaryEmotion,
      secondaryEmotion: secondaryEmotion ?? this.secondaryEmotion,
      bodySymptoms: bodySymptoms ?? this.bodySymptoms,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SituationEmotionData &&
        other.intensity == intensity &&
        other.bodyTension == bodyTension &&
        other.primaryEmotion == primaryEmotion &&
        other.secondaryEmotion == secondaryEmotion &&
        _listEquals(other.bodySymptoms, bodySymptoms);
  }

  @override
  int get hashCode {
    return intensity.hashCode ^
        bodyTension.hashCode ^
        primaryEmotion.hashCode ^
        secondaryEmotion.hashCode ^
        bodySymptoms.hashCode;
  }

  bool _listEquals<T>(List<T> a, List<T> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}

/// Domain model for thought and impulse data captured in step 3 of the new situation flow.
class SituationThoughtImpulseData {
  const SituationThoughtImpulseData({
    required this.automaticThought,
    required this.firstImpulse,
    this.actualBehavior,
  });

  /// Automatic thought (max 200 characters)
  final String automaticThought;

  /// First impulse type
  final ImpulseType firstImpulse;

  /// Optional actual behavior (max 300 characters)
  final String? actualBehavior;

  /// Create a copy with some fields replaced
  SituationThoughtImpulseData copyWith({
    String? automaticThought,
    ImpulseType? firstImpulse,
    String? actualBehavior,
  }) {
    return SituationThoughtImpulseData(
      automaticThought: automaticThought ?? this.automaticThought,
      firstImpulse: firstImpulse ?? this.firstImpulse,
      actualBehavior: actualBehavior ?? this.actualBehavior,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SituationThoughtImpulseData &&
        other.automaticThought == automaticThought &&
        other.firstImpulse == firstImpulse &&
        other.actualBehavior == actualBehavior;
  }

  @override
  int get hashCode {
    return automaticThought.hashCode ^
        firstImpulse.hashCode ^
        actualBehavior.hashCode;
  }
}

/// Domain model for reflection data captured in step 4 of the new situation flow.
class SituationReflectionData {
  const SituationReflectionData({
    required this.needOrWoundedPoint,
    required this.nextStep,
  });

  /// What feels touched, vulnerable, or needed in this situation.
  final String needOrWoundedPoint;

  /// Concrete next step after the reflection.
  final String nextStep;

  SituationReflectionData copyWith({
    String? needOrWoundedPoint,
    String? nextStep,
  }) {
    return SituationReflectionData(
      needOrWoundedPoint: needOrWoundedPoint ?? this.needOrWoundedPoint,
      nextStep: nextStep ?? this.nextStep,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SituationReflectionData &&
        other.needOrWoundedPoint == needOrWoundedPoint &&
        other.nextStep == nextStep;
  }

  @override
  int get hashCode => needOrWoundedPoint.hashCode ^ nextStep.hashCode;
}

/// Validation result for form fields
class ValidationResult {
  const ValidationResult({
    this.isValid = true,
    this.errorMessages = const [],
  });

  final bool isValid;
  final List<String> errorMessages;

  /// Create a validation result with errors
  const ValidationResult.errors(List<String> messages)
      : isValid = false,
        errorMessages = messages;

  /// Create a valid result
  const ValidationResult.valid()
      : isValid = true,
        errorMessages = const [];

  /// Get the first error message
  String? get firstError =>
      errorMessages.isNotEmpty ? errorMessages.first : null;
}

/// Complete state for the new situation flow
class NewSituationFlowState {
  const NewSituationFlowState({
    this.eventData,
    this.emotionData,
    this.thoughtImpulseData,
    this.reflectionData,
    this.isSaving = false,
  });

  final SituationEventData? eventData;
  final SituationEmotionData? emotionData;
  final SituationThoughtImpulseData? thoughtImpulseData;
  final SituationReflectionData? reflectionData;
  final bool isSaving;

  /// Get current step (0-4)
  int get currentStep {
    if (reflectionData != null) return 4;
    if (thoughtImpulseData != null) return 3;
    if (emotionData != null) return 2;
    if (eventData != null) return 1;
    return 0;
  }

  /// Check if all data is complete
  bool get isComplete {
    return eventData != null &&
        emotionData != null &&
        thoughtImpulseData != null &&
        reflectionData != null;
  }

  /// Create a copy with some fields replaced
  NewSituationFlowState copyWith({
    SituationEventData? eventData,
    SituationEmotionData? emotionData,
    SituationThoughtImpulseData? thoughtImpulseData,
    SituationReflectionData? reflectionData,
    bool? isSaving,
  }) {
    return NewSituationFlowState(
      eventData: eventData ?? this.eventData,
      emotionData: emotionData ?? this.emotionData,
      thoughtImpulseData: thoughtImpulseData ?? this.thoughtImpulseData,
      reflectionData: reflectionData ?? this.reflectionData,
      isSaving: isSaving ?? this.isSaving,
    );
  }

  /// Reset to empty state
  NewSituationFlowState reset() {
    return const NewSituationFlowState();
  }
}
