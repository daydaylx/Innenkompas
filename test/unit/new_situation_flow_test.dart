import 'package:flutter_test/flutter_test.dart';
import 'package:innenkompass/core/constants/context_types.dart';
import 'package:innenkompass/core/constants/emotion_types.dart';
import 'package:innenkompass/core/constants/fact_interpretation_results.dart';
import 'package:innenkompass/core/constants/impulse_types.dart';
import 'package:innenkompass/core/validators/new_situation_validators.dart';
import 'package:innenkompass/domain/models/situation_draft.dart';

void main() {
  group('NewSituationFlowState', () {
    final eventData = SituationEventData(
      description: 'Ein schwieriges Gespräch im Büro.',
      context: ContextType.work,
      timestamp: DateTime(2026, 3, 16, 9, 30),
    );
    const emotionData = SituationEmotionData(
      intensity: 7,
      bodyTension: 6,
      primaryEmotion: EmotionType.fear,
    );
    const thoughtData = SituationThoughtImpulseData(
      automaticThought: 'Ich mache gleich alles falsch.',
      firstImpulse: ImpulseType.withdraw,
      factInterpretation: FactInterpretationResult.mostlyInterpretation,
    );
    const reflectionData = SituationReflectionData(
      needOrWoundedPoint: 'Ich wollte ernst genommen werden.',
      nextStep: 'Ich sammle mich kurz und formuliere dann meine Rückfrage.',
    );

    test('is not complete before reflection data exists', () {
      final state = NewSituationFlowState(
        eventData: eventData,
        emotionData: emotionData,
        thoughtImpulseData: thoughtData,
      );

      expect(state.currentStep, 3);
      expect(state.isComplete, isFalse);
    });

    test('becomes complete after reflection data is added', () {
      final state = NewSituationFlowState(
        eventData: eventData,
        emotionData: emotionData,
        thoughtImpulseData: thoughtData,
        reflectionData: reflectionData,
      );

      expect(state.currentStep, 4);
      expect(state.isComplete, isTrue);
    });
  });

  group('NewSituationValidators', () {
    test('accepts valid reflection data', () {
      const reflectionData = SituationReflectionData(
        needOrWoundedPoint: 'Ich brauche Klarheit und Sicherheit.',
        nextStep: 'Ich atme durch und spreche das heute Abend ruhig an.',
      );

      final result =
          NewSituationValidators.validateReflectionData(reflectionData);

      expect(result.isValid, isTrue);
      expect(result.errorMessages, isEmpty);
    });

    test('rejects empty reflection data', () {
      const reflectionData = SituationReflectionData(
        needOrWoundedPoint: '',
        nextStep: '',
      );

      final result =
          NewSituationValidators.validateReflectionData(reflectionData);

      expect(result.isValid, isFalse);
      expect(result.errorMessages.length, 2);
    });
  });
}
