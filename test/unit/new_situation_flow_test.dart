import 'package:flutter_test/flutter_test.dart';
import 'package:innenkompass/core/constants/context_types.dart';
import 'package:innenkompass/core/constants/emotion_types.dart';
import 'package:innenkompass/core/constants/fact_interpretation_results.dart';
import 'package:innenkompass/core/constants/pattern_familiarity.dart';
import 'package:innenkompass/core/constants/problem_timing.dart';
import 'package:innenkompass/core/constants/system_reaction_types.dart';
import 'package:innenkompass/core/constants/tipping_point_awareness.dart';
import 'package:innenkompass/core/constants/trigger_as_last_drop.dart';
import 'package:innenkompass/core/validators/new_situation_validators.dart';
import 'package:innenkompass/domain/models/situation_draft.dart';

void main() {
  group('NewSituationFlowState', () {
    final eventData = SituationEventData(
      description: 'Ein schwieriges Gespräch im Büro.',
      preTriggerPreoccupation: 'Ich war schon angespannt wegen des Meetings.',
      problemTiming: ProblemTiming.partly,
      trigger: 'Ein abwertender Kommentar.',
      context: ContextType.work,
      timestamp: DateTime(2026, 3, 16, 9, 30),
    );
    const emotionData = SituationEmotionData(
      preTriggerLoad: 5,
      intensity: 7,
      bodyTension: 6,
      primaryEmotion: EmotionType.fear,
    );
    const thoughtData = SituationThoughtImpulseData(
      thoughtFocus: 'Ich war gedanklich noch bei dem vorigen Fehler.',
      automaticThought: 'Ich mache gleich alles falsch.',
      factInterpretation: FactInterpretationResult.mostlyInterpretation,
      systemReaction: SystemReactionType.withdrawal,
      actualBehaviorTags: ['zurückgezogen'],
      tippingPointAwareness: TippingPointAwareness.afterwards,
    );
    const reflectionData = SituationReflectionData(
      touchedThemes: ['Respekt'],
      neededSupports: ['Ruhe'],
      realisticAlternative:
          'Ich hätte kurz sagen können, dass ich später antworte.',
      triggerAsLastDrop: TriggerAsLastDrop.partly,
      backgroundTheme: 'Nicht ernst genommen werden.',
      nextStep: 'Ich sammle mich kurz und formuliere dann meine Rückfrage.',
      patternFamiliarity: PatternFamiliarity.sometimes,
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
        touchedThemes: ['Sicherheit'],
        neededSupports: ['Klarheit'],
        realisticAlternative: 'Ich hätte erst kurz stoppen können.',
        triggerAsLastDrop: TriggerAsLastDrop.partly,
        backgroundTheme: 'Ich hatte schon vorher Druck im Kopf.',
        nextStep: 'Ich atme durch und spreche das heute Abend ruhig an.',
      );

      final result =
          NewSituationValidators.validateReflectionData(reflectionData);

      expect(result.isValid, isTrue);
      expect(result.errorMessages, isEmpty);
    });

    test('rejects empty reflection data', () {
      const reflectionData = SituationReflectionData(
        touchedThemes: [],
        neededSupports: [],
        realisticAlternative: '',
        triggerAsLastDrop: TriggerAsLastDrop.unknown,
        backgroundTheme: '',
        nextStep: '',
      );

      final result =
          NewSituationValidators.validateReflectionData(reflectionData);

      expect(result.isValid, isFalse);
      expect(result.errorMessages.length, greaterThanOrEqualTo(4));
    });
  });
}
