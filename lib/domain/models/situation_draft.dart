import '../../core/constants/context_types.dart';
import '../../core/constants/emotion_types.dart';
import '../../core/constants/fact_interpretation_results.dart';
import '../../core/constants/pattern_familiarity.dart';
import '../../core/constants/problem_timing.dart';
import '../../core/constants/system_reaction_types.dart';
import '../../core/constants/tipping_point_awareness.dart';
import '../../core/constants/trigger_as_last_drop.dart';

class SituationEventContextData {
  const SituationEventContextData({
    required this.description,
    required this.context,
    required this.timestamp,
    this.involvedEntities,
  });

  final String description;
  final ContextType context;
  final DateTime timestamp;
  final String? involvedEntities;

  SituationEventContextData copyWith({
    String? description,
    ContextType? context,
    DateTime? timestamp,
    String? involvedEntities,
  }) {
    return SituationEventContextData(
      description: description ?? this.description,
      context: context ?? this.context,
      timestamp: timestamp ?? this.timestamp,
      involvedEntities: involvedEntities ?? this.involvedEntities,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SituationEventContextData &&
        other.description == description &&
        other.context == context &&
        other.timestamp == timestamp &&
        other.involvedEntities == involvedEntities;
  }

  @override
  int get hashCode =>
      description.hashCode ^
      context.hashCode ^
      timestamp.hashCode ^
      involvedEntities.hashCode;
}

class SituationEventData {
  const SituationEventData({
    required this.description,
    required this.preTriggerPreoccupation,
    this.problemTiming,
    required this.trigger,
    required this.preTriggerLoad,
    required this.context,
    required this.timestamp,
    this.involvedEntities,
  });

  final String description;
  final String preTriggerPreoccupation;
  final ProblemTiming? problemTiming;
  final String trigger;
  final int preTriggerLoad;
  final ContextType context;
  final DateTime timestamp;
  final String? involvedEntities;

  SituationEventData copyWith({
    String? description,
    String? preTriggerPreoccupation,
    ProblemTiming? problemTiming,
    String? trigger,
    int? preTriggerLoad,
    ContextType? context,
    DateTime? timestamp,
    String? involvedEntities,
  }) {
    return SituationEventData(
      description: description ?? this.description,
      preTriggerPreoccupation:
          preTriggerPreoccupation ?? this.preTriggerPreoccupation,
      problemTiming: problemTiming ?? this.problemTiming,
      trigger: trigger ?? this.trigger,
      preTriggerLoad: preTriggerLoad ?? this.preTriggerLoad,
      context: context ?? this.context,
      timestamp: timestamp ?? this.timestamp,
      involvedEntities: involvedEntities ?? this.involvedEntities,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SituationEventData &&
        other.description == description &&
        other.preTriggerPreoccupation == preTriggerPreoccupation &&
        other.problemTiming == problemTiming &&
        other.trigger == trigger &&
        other.preTriggerLoad == preTriggerLoad &&
        other.context == context &&
        other.timestamp == timestamp &&
        other.involvedEntities == involvedEntities;
  }

  @override
  int get hashCode =>
      description.hashCode ^
      preTriggerPreoccupation.hashCode ^
      (problemTiming?.hashCode ?? 0) ^
      trigger.hashCode ^
      preTriggerLoad.hashCode ^
      context.hashCode ^
      timestamp.hashCode ^
      involvedEntities.hashCode;
}

class SituationEmotionData {
  const SituationEmotionData({
    required this.intensity,
    required this.bodyTension,
    required this.primaryEmotion,
    this.additionalEmotions = const [],
    this.initialBodyReactions = const [],
  });

  final int intensity;
  final int bodyTension;
  final EmotionType primaryEmotion;
  final List<EmotionType> additionalEmotions;
  final List<String> initialBodyReactions;

  SituationEmotionData copyWith({
    int? intensity,
    int? bodyTension,
    EmotionType? primaryEmotion,
    List<EmotionType>? additionalEmotions,
    List<String>? initialBodyReactions,
  }) {
    return SituationEmotionData(
      intensity: intensity ?? this.intensity,
      bodyTension: bodyTension ?? this.bodyTension,
      primaryEmotion: primaryEmotion ?? this.primaryEmotion,
      additionalEmotions: additionalEmotions ?? this.additionalEmotions,
      initialBodyReactions: initialBodyReactions ?? this.initialBodyReactions,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SituationEmotionData &&
        other.intensity == intensity &&
        other.bodyTension == bodyTension &&
        other.primaryEmotion == primaryEmotion &&
        _listEquals(other.additionalEmotions, additionalEmotions) &&
        _listEquals(other.initialBodyReactions, initialBodyReactions);
  }

  @override
  int get hashCode =>
      intensity.hashCode ^
      bodyTension.hashCode ^
      primaryEmotion.hashCode ^
      additionalEmotions.hashCode ^
      initialBodyReactions.hashCode;
}

class SituationThoughtImpulseData {
  const SituationThoughtImpulseData({
    required this.thoughtFocus,
    required this.automaticThought,
    required this.factInterpretation,
    required this.systemReaction,
    required this.tippingPointAwareness,
    this.thoughtPatterns = const [],
    this.actualBehaviorTags = const [],
    this.actualBehaviorNote,
    this.fearOrPressurePoint,
  });

  final String thoughtFocus;
  final String automaticThought;
  final FactInterpretationResult factInterpretation;
  final SystemReactionType systemReaction;
  final List<String> thoughtPatterns;
  final List<String> actualBehaviorTags;
  final String? actualBehaviorNote;
  final TippingPointAwareness tippingPointAwareness;
  final String? fearOrPressurePoint;

  SituationThoughtImpulseData copyWith({
    String? thoughtFocus,
    String? automaticThought,
    FactInterpretationResult? factInterpretation,
    SystemReactionType? systemReaction,
    List<String>? thoughtPatterns,
    List<String>? actualBehaviorTags,
    String? actualBehaviorNote,
    TippingPointAwareness? tippingPointAwareness,
    String? fearOrPressurePoint,
  }) {
    return SituationThoughtImpulseData(
      thoughtFocus: thoughtFocus ?? this.thoughtFocus,
      automaticThought: automaticThought ?? this.automaticThought,
      factInterpretation: factInterpretation ?? this.factInterpretation,
      systemReaction: systemReaction ?? this.systemReaction,
      thoughtPatterns: thoughtPatterns ?? this.thoughtPatterns,
      actualBehaviorTags: actualBehaviorTags ?? this.actualBehaviorTags,
      actualBehaviorNote: actualBehaviorNote ?? this.actualBehaviorNote,
      tippingPointAwareness:
          tippingPointAwareness ?? this.tippingPointAwareness,
      fearOrPressurePoint: fearOrPressurePoint ?? this.fearOrPressurePoint,
    );
  }

  bool get hasActualBehavior =>
      actualBehaviorTags.isNotEmpty ||
      (actualBehaviorNote != null && actualBehaviorNote!.trim().isNotEmpty);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SituationThoughtImpulseData &&
        other.thoughtFocus == thoughtFocus &&
        other.automaticThought == automaticThought &&
        other.factInterpretation == factInterpretation &&
        other.systemReaction == systemReaction &&
        _listEquals(other.thoughtPatterns, thoughtPatterns) &&
        _listEquals(other.actualBehaviorTags, actualBehaviorTags) &&
        other.actualBehaviorNote == actualBehaviorNote &&
        other.tippingPointAwareness == tippingPointAwareness &&
        other.fearOrPressurePoint == fearOrPressurePoint;
  }

  @override
  int get hashCode =>
      thoughtFocus.hashCode ^
      automaticThought.hashCode ^
      factInterpretation.hashCode ^
      systemReaction.hashCode ^
      thoughtPatterns.hashCode ^
      actualBehaviorTags.hashCode ^
      actualBehaviorNote.hashCode ^
      tippingPointAwareness.hashCode ^
      fearOrPressurePoint.hashCode;
}

class SituationReflectionData {
  const SituationReflectionData({
    required this.touchedThemes,
    required this.neededSupports,
    required this.triggerAsLastDrop,
    this.realisticAlternative,
    this.backgroundTheme,
    this.nextStep,
    this.preEscalationRelief,
    this.patternFamiliarity,
  });

  final List<String> touchedThemes;
  final List<String> neededSupports;
  final TriggerAsLastDrop triggerAsLastDrop;
  final String? realisticAlternative;
  final String? backgroundTheme;
  final String? nextStep;
  final String? preEscalationRelief;
  final PatternFamiliarity? patternFamiliarity;

  SituationReflectionData copyWith({
    List<String>? touchedThemes,
    List<String>? neededSupports,
    TriggerAsLastDrop? triggerAsLastDrop,
    String? realisticAlternative,
    String? backgroundTheme,
    String? nextStep,
    String? preEscalationRelief,
    PatternFamiliarity? patternFamiliarity,
  }) {
    return SituationReflectionData(
      touchedThemes: touchedThemes ?? this.touchedThemes,
      neededSupports: neededSupports ?? this.neededSupports,
      triggerAsLastDrop: triggerAsLastDrop ?? this.triggerAsLastDrop,
      realisticAlternative: realisticAlternative ?? this.realisticAlternative,
      backgroundTheme: backgroundTheme ?? this.backgroundTheme,
      nextStep: nextStep ?? this.nextStep,
      preEscalationRelief: preEscalationRelief ?? this.preEscalationRelief,
      patternFamiliarity: patternFamiliarity ?? this.patternFamiliarity,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SituationReflectionData &&
        _listEquals(other.touchedThemes, touchedThemes) &&
        _listEquals(other.neededSupports, neededSupports) &&
        other.triggerAsLastDrop == triggerAsLastDrop &&
        other.realisticAlternative == realisticAlternative &&
        other.backgroundTheme == backgroundTheme &&
        other.nextStep == nextStep &&
        other.preEscalationRelief == preEscalationRelief &&
        other.patternFamiliarity == patternFamiliarity;
  }

  @override
  int get hashCode =>
      touchedThemes.hashCode ^
      neededSupports.hashCode ^
      triggerAsLastDrop.hashCode ^
      (realisticAlternative?.hashCode ?? 0) ^
      (backgroundTheme?.hashCode ?? 0) ^
      (nextStep?.hashCode ?? 0) ^
      preEscalationRelief.hashCode ^
      patternFamiliarity.hashCode;
}

class ValidationResult {
  const ValidationResult({
    this.isValid = true,
    this.errorMessages = const [],
  });

  final bool isValid;
  final List<String> errorMessages;

  const ValidationResult.errors(List<String> messages)
      : isValid = false,
        errorMessages = messages;

  const ValidationResult.valid()
      : isValid = true,
        errorMessages = const [];

  String? get firstError =>
      errorMessages.isNotEmpty ? errorMessages.first : null;
}

enum NewSituationCapturePath {
  full,
  reduced,
}

class NewSituationFlowState {
  const NewSituationFlowState({
    this.eventContextData,
    this.eventData,
    this.emotionData,
    this.thoughtImpulseData,
    this.reflectionData,
    this.capturePath = NewSituationCapturePath.full,
    this.isSaving = false,
  });

  final SituationEventContextData? eventContextData;
  final SituationEventData? eventData;
  final SituationEmotionData? emotionData;
  final SituationThoughtImpulseData? thoughtImpulseData;
  final SituationReflectionData? reflectionData;
  final NewSituationCapturePath capturePath;
  final bool isSaving;

  int get currentStep {
    if (reflectionData != null) return 5;
    if (thoughtImpulseData != null) return 4;
    if (emotionData != null) return 3;
    if (eventData != null) return 2;
    if (eventContextData != null) return 1;
    return 0;
  }

  bool get requiresReflection => capturePath == NewSituationCapturePath.full;

  bool get isComplete =>
      eventData != null &&
      emotionData != null &&
      thoughtImpulseData != null &&
      (!requiresReflection || reflectionData != null);

  NewSituationFlowState copyWith({
    SituationEventContextData? eventContextData,
    SituationEventData? eventData,
    SituationEmotionData? emotionData,
    SituationThoughtImpulseData? thoughtImpulseData,
    SituationReflectionData? reflectionData,
    NewSituationCapturePath? capturePath,
    bool? isSaving,
  }) {
    return NewSituationFlowState(
      eventContextData: eventContextData ?? this.eventContextData,
      eventData: eventData ?? this.eventData,
      emotionData: emotionData ?? this.emotionData,
      thoughtImpulseData: thoughtImpulseData ?? this.thoughtImpulseData,
      reflectionData: reflectionData ?? this.reflectionData,
      capturePath: capturePath ?? this.capturePath,
      isSaving: isSaving ?? this.isSaving,
    );
  }

  NewSituationFlowState reset() => const NewSituationFlowState();
}

bool _listEquals<T>(List<T> a, List<T> b) {
  if (a.length != b.length) return false;
  for (int index = 0; index < a.length; index++) {
    if (a[index] != b[index]) {
      return false;
    }
  }
  return true;
}
