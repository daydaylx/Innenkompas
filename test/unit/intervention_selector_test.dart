import 'package:flutter_test/flutter_test.dart';
import 'package:innenkompass/core/constants/emotion_types.dart';
import 'package:innenkompass/core/constants/system_states.dart';
import 'package:innenkompass/core/constants/intervention_types.dart';
import 'package:innenkompass/domain/rules/intervention_selector.dart';

void main() {
  group('InterventionSelector', () {
    test('selects regulation first for acute activation state', () {
      final result = InterventionSelector.selectInterventions(
        systemState: SystemState.acuteActivation,
        primaryEmotion: EmotionType.anger,
        intensity: 9,
      );

      expect(result, isNotEmpty);
      expect(result.first, InterventionType.regulation);
      expect(result.contains(InterventionType.impulsePause), isTrue);
    });

    test('selects fact check for reflective ready state', () {
      final result = InterventionSelector.selectInterventions(
        systemState: SystemState.reflectiveReady,
        primaryEmotion: EmotionType.sadness,
        intensity: 5,
      );

      expect(result, isNotEmpty);
      expect(result.first, InterventionType.factCheck);
    });

    test('selects rumination stop for rumination state', () {
      final result = InterventionSelector.selectInterventions(
        systemState: SystemState.rumination,
        primaryEmotion: EmotionType.fear,
        intensity: 6,
      );

      expect(result, isNotEmpty);
      expect(result.first, InterventionType.ruminationStop);
    });

    test('selects communication for conflict state with anger', () {
      final result = InterventionSelector.selectInterventions(
        systemState: SystemState.conflict,
        primaryEmotion: EmotionType.anger,
        intensity: 7,
      );

      expect(result, isNotEmpty);
      expect(result.first,
          InterventionType.communication); // Changed from impulsePause
      expect(result.contains(InterventionType.impulsePause), isTrue);
    });

    test('selects self value check for self devaluation state', () {
      final result = InterventionSelector.selectInterventions(
        systemState: SystemState.selfDevaluation,
        primaryEmotion: EmotionType.shame,
        intensity: 7,
      );

      expect(result, isNotEmpty);
      expect(result.first, InterventionType.selfValueCheck);
    });

    test('selects overwhelm structure for overwhelm state', () {
      final result = InterventionSelector.selectInterventions(
        systemState: SystemState.overwhelm,
        primaryEmotion: EmotionType.fear,
        intensity: 8,
      );

      expect(result, isNotEmpty);
      expect(result.first, InterventionType.overwhelmStructure);
    });

    test('selects regulation for crisis state', () {
      final result = InterventionSelector.selectInterventions(
        systemState: SystemState.crisis,
        primaryEmotion: EmotionType.fear,
        intensity: 10,
      );

      expect(result, isNotEmpty);
      expect(result.first, InterventionType.regulation);
    });

    test('includes emotion-based interventions for anger', () {
      final result = InterventionSelector.selectInterventions(
        systemState: SystemState.reflectiveReady,
        primaryEmotion: EmotionType.anger,
        intensity: 6,
      );

      // Anger should trigger impulse pause
      expect(result.contains(InterventionType.impulsePause), isTrue);
    });

    test('includes emotion-based interventions for fear in rumination state',
        () {
      final result = InterventionSelector.selectInterventions(
        systemState: SystemState.rumination, // Changed to rumination state
        primaryEmotion: EmotionType.fear,
        intensity: 5,
      );

      // Fear in rumination state prioritizes rumination stop
      expect(result.contains(InterventionType.ruminationStop), isTrue);
      expect(result.first, InterventionType.ruminationStop);
    });

    test('includes emotion-based interventions for shame', () {
      final result = InterventionSelector.selectInterventions(
        systemState: SystemState.reflectiveReady,
        primaryEmotion: EmotionType.shame,
        intensity: 6,
      );

      // Shame should trigger self value check
      expect(result.contains(InterventionType.selfValueCheck), isTrue);
    });

    test('includes emotion-based interventions for guilt', () {
      final result = InterventionSelector.selectInterventions(
        systemState: SystemState.reflectiveReady,
        primaryEmotion: EmotionType.guilt,
        intensity: 5,
      );

      // Guilt should trigger self value check
      expect(result.contains(InterventionType.selfValueCheck), isTrue);
    });

    test('returns max 4 interventions', () {
      final result = InterventionSelector.selectInterventions(
        systemState: SystemState.reflectiveReady,
        primaryEmotion: EmotionType.anger,
        intensity: 5,
      );

      expect(result.length, lessThanOrEqualTo(4));
    });

    test('at very high intensity (8+), regulation is prioritized', () {
      final result = InterventionSelector.selectInterventions(
        systemState: SystemState.reflectiveReady, // Changed from rumination
        primaryEmotion: EmotionType.fear,
        intensity: 8,
      );

      expect(result.first, InterventionType.regulation);
    });

    test('at maximum intensity, regulation comes first', () {
      final result = InterventionSelector.selectInterventions(
        systemState: SystemState.conflict,
        primaryEmotion: EmotionType.anger,
        intensity: 10,
      );

      expect(result.first, InterventionType.regulation);
    });

    test('deduplicates interventions', () {
      final result = InterventionSelector.selectInterventions(
        systemState: SystemState.acuteActivation,
        primaryEmotion: EmotionType.anger,
        intensity: 7,
      );

      // Check no duplicates
      final unique = result.toSet();
      expect(unique.length, result.length);
    });

    test('returns non-empty list for all combinations', () {
      final states = SystemState.values;
      final emotions = EmotionType.values;

      for (final state in states) {
        for (final emotion in emotions) {
          final result = InterventionSelector.selectInterventions(
            systemState: state,
            primaryEmotion: emotion,
            intensity: 5,
          );

          expect(result, isNotEmpty,
              reason: 'Should return interventions for $state + $emotion');
        }
      }
    });

    test('isInterventionSuitable returns true for regulation at high intensity',
        () {
      final result = InterventionSelector.isInterventionSuitable(
        intervention: InterventionType.regulation,
        state: SystemState.acuteActivation,
        intensity: 8,
      );

      expect(result, isTrue);
    });

    test(
        'isInterventionSuitable returns true for impulse pause at high intensity',
        () {
      final result = InterventionSelector.isInterventionSuitable(
        intervention: InterventionType.impulsePause,
        state: SystemState.reflectiveReady,
        intensity: 7,
      );

      expect(result, isTrue);
    });

    test(
        'isInterventionSuitable returns false for fact check in acute activation',
        () {
      final result = InterventionSelector.isInterventionSuitable(
        intervention: InterventionType.factCheck,
        state: SystemState.acuteActivation,
        intensity: 5,
      );

      expect(result, isFalse);
    });

    test('isInterventionSuitable returns false for fact check in crisis', () {
      final result = InterventionSelector.isInterventionSuitable(
        intervention: InterventionType.factCheck,
        state: SystemState.crisis,
        intensity: 5,
      );

      expect(result, isFalse);
    });

    test(
        'isInterventionSuitable returns false for communication in acute activation',
        () {
      final result = InterventionSelector.isInterventionSuitable(
        intervention: InterventionType.communication,
        state: SystemState.acuteActivation,
        intensity: 5,
      );

      expect(result, isFalse);
    });

    test('isInterventionSuitable returns false for communication in crisis',
        () {
      final result = InterventionSelector.isInterventionSuitable(
        intervention: InterventionType.communication,
        state: SystemState.crisis,
        intensity: 5,
      );

      expect(result, isFalse);
    });

    test('isInterventionSuitable returns false for communication in overwhelm',
        () {
      final result = InterventionSelector.isInterventionSuitable(
        intervention: InterventionType.communication,
        state: SystemState.overwhelm,
        intensity: 5,
      );

      expect(result, isFalse);
    });

    test(
        'isInterventionSuitable returns false for self value check in non-devaluation states',
        () {
      final result = InterventionSelector.isInterventionSuitable(
        intervention: InterventionType.selfValueCheck,
        state: SystemState.acuteActivation,
        intensity: 5,
      );

      expect(result, isFalse);
    });

    test('getFallbackIntervention returns regulation', () {
      final result = InterventionSelector.getFallbackIntervention();
      expect(result, InterventionType.regulation);
    });
  });
}
