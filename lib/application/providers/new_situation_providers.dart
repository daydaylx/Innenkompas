import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/impulse_types.dart';
import '../../core/constants/system_reaction_types.dart';
import '../../domain/services/evaluation_engine.dart';
import '../../core/validators/new_situation_validators.dart';
import '../../data/db/app_database.dart';
import '../../domain/models/situation_draft.dart';
import '../../domain/services/classification_service.dart';
import 'database_provider.dart';

/// StateNotifier for managing the new situation flow.
///
/// Handles:
/// - Draft data for each step
/// - Validation
/// - Saving to database
/// - Reset
class NewSituationFlowController extends StateNotifier<NewSituationFlowState> {
  NewSituationFlowController(this._db) : super(const NewSituationFlowState());

  final AppDatabase _db;
  int? _lastSavedEntryId;

  /// Get the ID of the last saved entry
  int? get lastSavedEntryId => _lastSavedEntryId;

  /// Update event data from step 1
  void updateEventData(SituationEventData data) {
    state = state.copyWith(eventData: data);
  }

  /// Update emotion data from step 2
  void updateEmotionData(SituationEmotionData data) {
    state = state.copyWith(emotionData: data);
  }

  /// Update thought and impulse data from step 3
  void updateThoughtImpulseData(SituationThoughtImpulseData data) {
    state = state.copyWith(thoughtImpulseData: data);
  }

  /// Update reflection data from step 4.
  void updateReflectionData(SituationReflectionData data) {
    state = state.copyWith(reflectionData: data);
  }

  /// Validate event data
  ValidationResult validateEvent() {
    if (state.eventData == null) {
      return const ValidationResult.errors(['Keine Ereignisdaten vorhanden.']);
    }
    return NewSituationValidators.validateEventData(state.eventData!);
  }

  /// Validate emotion data
  ValidationResult validateEmotion() {
    if (state.emotionData == null) {
      return const ValidationResult.errors(['Keine Emotionsdaten vorhanden.']);
    }
    return NewSituationValidators.validateEmotionData(state.emotionData!);
  }

  /// Validate thought and impulse data
  ValidationResult validateThoughtImpulse() {
    if (state.thoughtImpulseData == null) {
      return const ValidationResult.errors(
          ['Keine Gedanken/Impuls-Daten vorhanden.']);
    }
    return NewSituationValidators.validateThoughtImpulseData(
        state.thoughtImpulseData!);
  }

  /// Validate reflection data.
  ValidationResult validateReflection() {
    if (state.reflectionData == null) {
      return const ValidationResult.errors(
          ['Keine Reflexionsdaten vorhanden.']);
    }
    return NewSituationValidators.validateReflectionData(state.reflectionData!);
  }

  /// Save the complete entry to database
  ///
  /// Returns the ID of the created entry, or null if saving failed.
  /// Uses ClassificationService to determine system state, crisis status,
  /// and recommended interventions.
  Future<int?> saveEntry() async {
    if (!state.isComplete) {
      return null;
    }

    try {
      state = state.copyWith(isSaving: true);

      final eventData = state.eventData!;
      final emotionData = state.emotionData!;
      final thoughtData = state.thoughtImpulseData!;
      final reflectionData = state.reflectionData!;
      final legacyImpulse = _mapSystemReactionToLegacyImpulse(
        thoughtData.systemReaction,
      );
      final secondaryEmotion = emotionData.additionalEmotions.isNotEmpty
          ? emotionData.additionalEmotions.first
          : null;
      final actualBehaviorSummary = _mergeBehaviorSummary(
          thoughtData.actualBehaviorTags, thoughtData.actualBehaviorNote);
      final needSummary = _buildLegacyNeedSummary(
        reflectionData.touchedThemes,
        reflectionData.neededSupports,
      );

      // Perform classification using ClassificationService
      final classification = ClassificationService.classify(
        intensity: emotionData.intensity,
        bodyTension: emotionData.bodyTension,
        primaryEmotion: emotionData.primaryEmotion,
        secondaryEmotion: secondaryEmotion,
        firstImpulse: legacyImpulse,
        context: eventData.context,
        automaticThought: thoughtData.automaticThought,
        factInterpretation: thoughtData.factInterpretation,
      );
      final evaluation = EvaluationEngine.evaluate(
        systemState: classification.systemState,
        primaryEmotion: emotionData.primaryEmotion,
        preTriggerLoad: emotionData.preTriggerLoad,
        intensity: emotionData.intensity,
        bodyTension: emotionData.bodyTension,
        systemReaction: thoughtData.systemReaction,
        context: eventData.context,
        factInterpretation: thoughtData.factInterpretation,
        thoughtPatterns: thoughtData.thoughtPatterns,
        actualBehaviorTags: thoughtData.actualBehaviorTags,
        tippingPointAwareness: thoughtData.tippingPointAwareness,
        triggerAsLastDrop: reflectionData.triggerAsLastDrop,
        touchedThemes: reflectionData.touchedThemes,
      );

      final systemState = classification.systemState.name;
      final isCrisis = classification.isCrisis;
      final interventionType = classification.primaryIntervention?.name;

      // Create the entry with classification results
      final id = await _db.createSituationEntry(
        SituationEntriesCompanion.insert(
          situationDescription: eventData.description,
          context: eventData.context.name,
          timestamp: eventData.timestamp,
          involvedPerson: eventData.involvedEntities != null
              ? Value(eventData.involvedEntities)
              : const Value.absent(),
          involvedEntities: eventData.involvedEntities != null
              ? Value(eventData.involvedEntities)
              : const Value.absent(),
          preTriggerPreoccupation: Value(eventData.preTriggerPreoccupation),
          problemTiming: Value(eventData.problemTiming.name),
          triggerDescription: Value(eventData.trigger),
          preTriggerLoad: Value(emotionData.preTriggerLoad),
          intensity: emotionData.intensity,
          bodyTension: emotionData.bodyTension,
          primaryEmotion: emotionData.primaryEmotion.name,
          secondaryEmotion: secondaryEmotion != null
              ? Value(secondaryEmotion.name)
              : const Value.absent(),
          bodySymptoms: emotionData.initialBodyReactions.isNotEmpty
              ? Value(_encodeList(emotionData.initialBodyReactions))
              : const Value.absent(),
          initialBodyReactions: emotionData.initialBodyReactions.isNotEmpty
              ? Value(_encodeList(emotionData.initialBodyReactions))
              : const Value.absent(),
          additionalEmotions: emotionData.additionalEmotions.isNotEmpty
              ? Value(_encodeList(
                  emotionData.additionalEmotions
                      .map((emotion) => emotion.name)
                      .toList(),
                ))
              : const Value.absent(),
          thoughtFocus: Value(thoughtData.thoughtFocus),
          automaticThought: thoughtData.automaticThought,
          firstImpulse: legacyImpulse.name,
          factInterpretationResult: Value(thoughtData.factInterpretation.name),
          systemReaction: Value(thoughtData.systemReaction.name),
          thoughtPatterns: thoughtData.thoughtPatterns.isNotEmpty
              ? Value(_encodeList(thoughtData.thoughtPatterns))
              : const Value.absent(),
          actualBehaviorTags: thoughtData.actualBehaviorTags.isNotEmpty
              ? Value(_encodeList(thoughtData.actualBehaviorTags))
              : const Value.absent(),
          actualBehavior: actualBehaviorSummary != null
              ? Value(actualBehaviorSummary)
              : const Value.absent(),
          tippingPointAwareness: Value(thoughtData.tippingPointAwareness.name),
          fearOrPressurePoint: thoughtData.fearOrPressurePoint != null
              ? Value(thoughtData.fearOrPressurePoint)
              : const Value.absent(),
          needOrWoundedPoint: Value(needSummary),
          touchedThemes: Value(_encodeList(reflectionData.touchedThemes)),
          neededSupports: Value(_encodeList(reflectionData.neededSupports)),
          realisticAlternative: Value(reflectionData.realisticAlternative),
          triggerAsLastDrop: Value(reflectionData.triggerAsLastDrop.name),
          backgroundTheme: Value(reflectionData.backgroundTheme),
          preEscalationRelief: reflectionData.preEscalationRelief != null
              ? Value(reflectionData.preEscalationRelief)
              : const Value.absent(),
          patternFamiliarity: reflectionData.patternFamiliarity != null
              ? Value(reflectionData.patternFamiliarity!.name)
              : const Value.absent(),
          nextStep: Value(reflectionData.nextStep),
          systemState: systemState,
          isCrisis: Value(isCrisis),
          evaluationHeadlineKey: Value(evaluation.whatStandsOutKey),
          evaluationMeaningKey: Value(evaluation.whatMayBeBehindItKey),
          evaluationHelpfulNowKey: Value(evaluation.helpfulNowKey),
          evaluationLearningPointKey: Value(evaluation.learningPointKey),
          evaluationStatusKeys: Value(_encodeList(evaluation.statusKeys)),
          suggestedTipIds: Value(jsonEncode(evaluation.suggestedTipIds)),
          suggestedNextActionKey: Value(evaluation.suggestedNextActionKey),
          // selectedNextActionKey bleibt absent – Nutzer wählt auf dem Evaluation-Screen
          interventionType: interventionType != null
              ? Value(interventionType)
              : const Value.absent(),
          isDraft: const Value(false),
        ),
      );

      // Store the last saved entry ID
      _lastSavedEntryId = id;

      return id;
    } catch (e) {
      // Log error but don't crash
      // In production, use proper logging
      return null;
    } finally {
      state = state.copyWith(isSaving: false);
    }
  }

  /// Reset the flow to initial state
  void reset() {
    state = state.reset();
  }

  String _encodeList(List<String> values) {
    return jsonEncode(values);
  }

  ImpulseType _mapSystemReactionToLegacyImpulse(SystemReactionType reaction) {
    switch (reaction) {
      case SystemReactionType.attack:
        return ImpulseType.counter;
      case SystemReactionType.withdrawal:
        return ImpulseType.withdraw;
      case SystemReactionType.flight:
        return ImpulseType.flee;
      case SystemReactionType.freeze:
        return ImpulseType.freeze;
      case SystemReactionType.appease:
        return ImpulseType.comply;
      case SystemReactionType.control:
        return ImpulseType.control;
      case SystemReactionType.unknown:
        return ImpulseType.unknown;
    }
  }

  String? _mergeBehaviorSummary(List<String> tags, String? note) {
    final trimmedNote = note?.trim();
    final hasNote = trimmedNote != null && trimmedNote.isNotEmpty;
    if (tags.isEmpty && !hasNote) {
      return null;
    }

    final buffer = StringBuffer();
    if (tags.isNotEmpty) {
      buffer.write(tags.join(', '));
    }
    if (hasNote) {
      if (buffer.isNotEmpty) {
        buffer.write(' | ');
      }
      buffer.write(trimmedNote);
    }
    return buffer.toString();
  }

  String _buildLegacyNeedSummary(
      List<String> touchedThemes, List<String> needs) {
    final touched = touchedThemes.join(', ');
    final needed = needs.join(', ');
    if (touched.isEmpty && needed.isEmpty) {
      return '';
    }
    if (touched.isNotEmpty && needed.isNotEmpty) {
      return 'Getroffen: $touched. Gebraucht: $needed.';
    }
    if (touched.isNotEmpty) {
      return 'Getroffen: $touched.';
    }
    return 'Gebraucht: $needed.';
  }
}

/// Provider for the new situation flow controller.
///
/// This depends on the database provider and creates a new controller
/// instance when the database is ready.
final newSituationFlowControllerProvider =
    StateNotifierProvider<NewSituationFlowController, NewSituationFlowState>(
        (ref) {
  final db = ref.watch(databaseProvider);
  return NewSituationFlowController(db);
});

/// Provider for the event data from the flow.
final eventDataProvider = Provider<SituationEventData?>((ref) {
  return ref.watch(newSituationFlowControllerProvider).eventData;
});

/// Provider for the emotion data from the flow.
final emotionDataProvider = Provider<SituationEmotionData?>((ref) {
  return ref.watch(newSituationFlowControllerProvider).emotionData;
});

/// Provider for the thought and impulse data from the flow.
final thoughtImpulseDataProvider =
    Provider<SituationThoughtImpulseData?>((ref) {
  return ref.watch(newSituationFlowControllerProvider).thoughtImpulseData;
});

/// Provider for the reflection data from the flow.
final reflectionDataProvider = Provider<SituationReflectionData?>((ref) {
  return ref.watch(newSituationFlowControllerProvider).reflectionData;
});

/// Provider for the current step number (0-4).
final currentStepProvider = Provider<int>((ref) {
  return ref.watch(newSituationFlowControllerProvider).currentStep;
});

/// Provider for checking if the flow is complete.
final isFlowCompleteProvider = Provider<bool>((ref) {
  return ref.watch(newSituationFlowControllerProvider).isComplete;
});

/// Provider for checking if the flow is currently saving.
final isFlowSavingProvider = Provider<bool>((ref) {
  return ref.watch(newSituationFlowControllerProvider).isSaving;
});

/// Provider for getting the classification result for the current flow.
///
/// This computes the classification on-demand based on the current flow data.
/// Returns null if the flow is not complete.
final classificationResultProvider =
    Provider<CompleteClassificationResult?>((ref) {
  final state = ref.watch(newSituationFlowControllerProvider);

  if (!state.isComplete) {
    return null;
  }

  final eventData = state.eventData!;
  final emotionData = state.emotionData!;
  final thoughtData = state.thoughtImpulseData!;

  return ClassificationService.classify(
    intensity: emotionData.intensity,
    bodyTension: emotionData.bodyTension,
    primaryEmotion: emotionData.primaryEmotion,
    secondaryEmotion: emotionData.additionalEmotions.isNotEmpty
        ? emotionData.additionalEmotions.first
        : null,
    firstImpulse: _mapReactionToImpulse(thoughtData.systemReaction),
    context: eventData.context,
    automaticThought: thoughtData.automaticThought,
    factInterpretation: thoughtData.factInterpretation,
  );
});

/// Provider for checking if the current flow indicates a crisis.
///
/// Returns null if the flow is not complete.
final isCrisisProvider = Provider<bool?>((ref) {
  final classification = ref.watch(classificationResultProvider);
  return classification?.isCrisis;
});

ImpulseType _mapReactionToImpulse(SystemReactionType reaction) {
  switch (reaction) {
    case SystemReactionType.attack:
      return ImpulseType.counter;
    case SystemReactionType.withdrawal:
      return ImpulseType.withdraw;
    case SystemReactionType.flight:
      return ImpulseType.flee;
    case SystemReactionType.freeze:
      return ImpulseType.freeze;
    case SystemReactionType.appease:
      return ImpulseType.comply;
    case SystemReactionType.control:
      return ImpulseType.control;
    case SystemReactionType.unknown:
      return ImpulseType.unknown;
  }
}
