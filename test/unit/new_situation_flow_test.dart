import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:innenkompass/core/constants/context_types.dart';
import 'package:innenkompass/core/constants/emotion_types.dart';
import 'package:innenkompass/core/constants/fact_interpretation_results.dart';
import 'package:innenkompass/core/constants/pattern_familiarity.dart';
import 'package:innenkompass/core/constants/problem_timing.dart';
import 'package:innenkompass/core/constants/system_reaction_types.dart';
import 'package:innenkompass/core/constants/tipping_point_awareness.dart';
import 'package:innenkompass/core/constants/trigger_as_last_drop.dart';
import 'package:innenkompass/core/validators/new_situation_validators.dart';
import 'package:innenkompass/data/db/app_database.dart';
import 'package:innenkompass/application/providers/new_situation_providers.dart';
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
        triggerAsLastDrop: TriggerAsLastDrop.unknown,
      );

      final result =
          NewSituationValidators.validateReflectionData(reflectionData);

      expect(result.isValid, isFalse);
      expect(result.errorMessages.length, greaterThanOrEqualTo(2));
    });
  });

  group('NewSituationFlowController.saveEntry', () {
    test('persists a concrete intervention id for new entries', () async {
      final database = AppDatabase.forTesting(NativeDatabase.memory());
      addTearDown(database.close);

      final controller = NewSituationFlowController(database);

      controller.updateEventData(
        SituationEventData(
          description: 'Ich bekam unerwartet kritisches Feedback.',
          preTriggerPreoccupation: 'Ich war vorher schon angespannt.',
          problemTiming: ProblemTiming.partly,
          trigger: 'Ein scharfer Kommentar im Meeting.',
          context: ContextType.work,
          timestamp: DateTime(2026, 3, 20, 11, 0),
        ),
      );
      controller.updateEmotionData(
        const SituationEmotionData(
          preTriggerLoad: 4,
          intensity: 5,
          bodyTension: 5,
          primaryEmotion: EmotionType.fear,
        ),
      );
      controller.updateThoughtImpulseData(
        const SituationThoughtImpulseData(
          thoughtFocus: 'Ich denke noch an den Kommentar.',
          automaticThought: 'Ich werde jetzt sicher falsch eingeschätzt.',
          factInterpretation: FactInterpretationResult.mostlyInterpretation,
          systemReaction: SystemReactionType.withdrawal,
          actualBehaviorTags: ['zurückgezogen'],
          tippingPointAwareness: TippingPointAwareness.afterwards,
        ),
      );
      controller.updateReflectionData(
        const SituationReflectionData(
          touchedThemes: ['Respekt'],
          neededSupports: ['Klarheit'],
          realisticAlternative:
              'Ich kann erst die Fakten sortieren und später antworten.',
          triggerAsLastDrop: TriggerAsLastDrop.partly,
          backgroundTheme: 'Ich habe Angst, falsch bewertet zu werden.',
          nextStep: 'Ich notiere erst, was wirklich gesagt wurde.',
        ),
      );

      final entryId = await controller.saveEntry();
      final entry = await database.getSituationEntryById(entryId!);

      expect(entry, isNotNull);
      expect(entry!.interventionType, 'factCheck');
      expect(entry.interventionId, 'fact_check_basic');
    });
  });
}
