import 'package:flutter_test/flutter_test.dart';
import 'package:innenkompass/core/constants/emotion_types.dart';
import 'package:innenkompass/core/constants/fact_interpretation_results.dart';
import 'package:innenkompass/core/constants/impulse_types.dart';
import 'package:innenkompass/core/constants/context_types.dart';
import 'package:innenkompass/core/constants/system_states.dart';
import 'package:innenkompass/domain/rules/state_classifier.dart';

void main() {
  group('StateClassifier', () {
    test(
        'classifies acute activation with high intensity, tension, and action impulse',
        () {
      final result = StateClassifier.classify(
        intensity: 9,
        bodyTension: 8,
        primaryEmotion: EmotionType.anger,
        secondaryEmotion: null,
        firstImpulse: ImpulseType.counter,
        context: ContextType.partnership,
      );

      expect(result, SystemState.acuteActivation);
    });

    test('classifies acute activation with flee impulse', () {
      final result = StateClassifier.classify(
        intensity: 8,
        bodyTension: 7,
        primaryEmotion: EmotionType.fear,
        secondaryEmotion: null,
        firstImpulse: ImpulseType.flee,
        context: ContextType.work,
      );

      expect(result, SystemState.acuteActivation);
    });

    test('classifies acute activation with immediate action impulse', () {
      final result = StateClassifier.classify(
        intensity: 10,
        bodyTension: 9,
        primaryEmotion: EmotionType.disgust,
        secondaryEmotion: null,
        firstImpulse: ImpulseType.immediateAction,
        context: ContextType.friends,
      );

      expect(result, SystemState.acuteActivation);
    });

    test(
        'does NOT classify acute activation with high values but non-action impulse',
        () {
      final result = StateClassifier.classify(
        intensity: 9,
        bodyTension: 8,
        primaryEmotion: EmotionType.sadness,
        secondaryEmotion: null,
        firstImpulse: ImpulseType.ruminate,
        context: ContextType.solitude,
      );

      expect(result, isNot(SystemState.acuteActivation));
    });

    test('classifies self-devaluation with shame emotion and high intensity',
        () {
      final result = StateClassifier.classify(
        intensity: 7,
        bodyTension: 6,
        primaryEmotion: EmotionType.shame,
        secondaryEmotion: null,
        firstImpulse: ImpulseType.withdraw,
        context: ContextType.friends,
      );

      expect(result, SystemState.selfDevaluation);
    });

    test('classifies self-devaluation with guilt emotion', () {
      final result = StateClassifier.classify(
        intensity: 8,
        bodyTension: 5,
        primaryEmotion: EmotionType.guilt,
        secondaryEmotion: null,
        firstImpulse: ImpulseType.selfCriticism,
        context: ContextType.family,
      );

      expect(result, SystemState.selfDevaluation);
    });

    test('classifies self-devaluation with secondary shame emotion', () {
      final result = StateClassifier.classify(
        intensity: 6,
        bodyTension: 6,
        primaryEmotion: EmotionType.fear,
        secondaryEmotion: EmotionType.shame,
        firstImpulse: ImpulseType.ruminate,
        context: ContextType.work,
      );

      expect(result, SystemState.selfDevaluation);
    });

    test('classifies overwhelm with work context and high intensity', () {
      final result = StateClassifier.classify(
        intensity: 8,
        bodyTension: 7,
        primaryEmotion: EmotionType.fear,
        secondaryEmotion: null,
        firstImpulse: ImpulseType.control,
        context: ContextType.work,
      );

      expect(result, SystemState.overwhelm);
    });

    test('classifies overwhelm with finances context', () {
      final result = StateClassifier.classify(
        intensity: 7,
        bodyTension: 6,
        primaryEmotion: EmotionType.sadness,
        secondaryEmotion: null,
        firstImpulse: ImpulseType.ruminate,
        context: ContextType.finances,
      );

      expect(result, SystemState.overwhelm);
    });

    test('classifies overwhelm with family context', () {
      final result = StateClassifier.classify(
        intensity: 9,
        bodyTension: 8,
        primaryEmotion: EmotionType.fear,
        secondaryEmotion: null,
        firstImpulse: ImpulseType.freeze,
        context: ContextType.family,
      );

      expect(result, SystemState.overwhelm);
    });

    test('classifies conflict with partnership context and anger emotion', () {
      final result = StateClassifier.classify(
        intensity: 6,
        bodyTension: 5,
        primaryEmotion: EmotionType.anger,
        secondaryEmotion: null,
        firstImpulse: ImpulseType.counter,
        context: ContextType.partnership,
      );

      expect(result, SystemState.conflict);
    });

    test('classifies conflict with disgust emotion and withdraw impulse', () {
      final result = StateClassifier.classify(
        intensity: 5,
        bodyTension: 4,
        primaryEmotion: EmotionType.disgust,
        secondaryEmotion: null,
        firstImpulse: ImpulseType.withdraw,
        context: ContextType.partnership,
      );

      expect(result, SystemState.conflict);
    });

    test('classifies overwhelm with work context takes priority over conflict',
        () {
      final result = StateClassifier.classify(
        intensity: 7,
        bodyTension: 5,
        primaryEmotion: EmotionType.anger,
        secondaryEmotion: null,
        firstImpulse: ImpulseType.comply,
        context: ContextType.work,
      );

      // Work context at intensity 7+ is overwhelm, not conflict (priority order)
      expect(result, SystemState.overwhelm);
    });

    test('does NOT classify conflict without conflict emotion', () {
      final result = StateClassifier.classify(
        intensity: 5,
        bodyTension: 4,
        primaryEmotion: EmotionType.sadness,
        secondaryEmotion: null,
        firstImpulse: ImpulseType.withdraw,
        context: ContextType.partnership,
      );

      expect(result, isNot(SystemState.conflict));
    });

    test('classifies rumination with ruminate impulse and fear emotion', () {
      final result = StateClassifier.classify(
        intensity: 5,
        bodyTension: 4,
        primaryEmotion: EmotionType.fear,
        secondaryEmotion: null,
        firstImpulse: ImpulseType.ruminate,
        context: ContextType.solitude,
      );

      expect(result, SystemState.rumination);
    });

    test('classifies rumination with control impulse and sadness emotion', () {
      final result = StateClassifier.classify(
        intensity: 6,
        bodyTension: 5,
        primaryEmotion: EmotionType.sadness,
        secondaryEmotion: null,
        firstImpulse: ImpulseType.control,
        context: ContextType.leisure,
      );

      expect(result, SystemState.rumination);
    });

    test('classifies rumination with perfectionism impulse', () {
      final result = StateClassifier.classify(
        intensity: 7,
        bodyTension: 6,
        primaryEmotion: EmotionType.fear,
        secondaryEmotion: null,
        firstImpulse: ImpulseType.perfectionism,
        context: ContextType.friends, // Friends is not an overwhelming context
      );

      expect(result, SystemState.rumination);
    });

    test('classifies reflective ready as default state', () {
      final result = StateClassifier.classify(
        intensity: 4,
        bodyTension: 3,
        primaryEmotion: EmotionType.joy,
        secondaryEmotion: null,
        firstImpulse: ImpulseType.seekHelp,
        context: ContextType.leisure,
      );

      expect(result, SystemState.reflectiveReady);
    });

    test(
        'classifies interpretation when facts are uncertain and no higher rule matches',
        () {
      final result = StateClassifier.classify(
        intensity: 5,
        bodyTension: 5,
        primaryEmotion: EmotionType.fear,
        secondaryEmotion: null,
        firstImpulse: ImpulseType.distraction,
        context: ContextType.other,
        factInterpretation: FactInterpretationResult.mostlyInterpretation,
      );

      expect(result, SystemState.interpretation);
    });

    test(
        'classifies reflective ready with moderate intensity and no matching patterns',
        () {
      final result = StateClassifier.classify(
        intensity: 5,
        bodyTension: 4,
        primaryEmotion: EmotionType.surprise,
        secondaryEmotion: null,
        firstImpulse: ImpulseType.distraction,
        context: ContextType.leisure,
      );

      expect(result, SystemState.reflectiveReady);
    });

    test('prioritizes acute activation over other states', () {
      // High intensity + body tension + action impulse should override
      // other matching patterns (e.g., rumination with fear)
      final result = StateClassifier.classify(
        intensity: 9,
        bodyTension: 8,
        primaryEmotion: EmotionType.fear,
        secondaryEmotion: null,
        firstImpulse: ImpulseType.immediateAction,
        context: ContextType.work,
      );

      expect(result, SystemState.acuteActivation);
    });

    test('prioritizes self-devaluation over rumination', () {
      // Shame with high intensity should take priority over rumination
      final result = StateClassifier.classify(
        intensity: 8,
        bodyTension: 5,
        primaryEmotion: EmotionType.shame,
        secondaryEmotion: null,
        firstImpulse: ImpulseType.ruminate,
        context: ContextType.friends,
      );

      expect(result, SystemState.selfDevaluation);
    });

    test('is deterministic - same inputs produce same output', () {
      final inputs = {
        'intensity': 6,
        'bodyTension': 5,
        'primaryEmotion': EmotionType.anger,
        'secondaryEmotion': null,
        'firstImpulse': ImpulseType.counter,
        'context': ContextType.partnership,
      };

      final result1 = StateClassifier.classify(
        intensity: inputs['intensity'] as int,
        bodyTension: inputs['bodyTension'] as int,
        primaryEmotion: inputs['primaryEmotion'] as EmotionType,
        secondaryEmotion: inputs['secondaryEmotion'] as EmotionType?,
        firstImpulse: inputs['firstImpulse'] as ImpulseType,
        context: inputs['context'] as ContextType,
      );

      final result2 = StateClassifier.classify(
        intensity: inputs['intensity'] as int,
        bodyTension: inputs['bodyTension'] as int,
        primaryEmotion: inputs['primaryEmotion'] as EmotionType,
        secondaryEmotion: inputs['secondaryEmotion'] as EmotionType?,
        firstImpulse: inputs['firstImpulse'] as ImpulseType,
        context: inputs['context'] as ContextType,
      );

      expect(result1, result2);
    });
  });
}
