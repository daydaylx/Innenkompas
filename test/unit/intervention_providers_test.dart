import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:innenkompass/application/providers/database_provider.dart';
import 'package:innenkompass/application/providers/intervention_providers.dart';
import 'package:innenkompass/application/providers/new_situation_providers.dart';
import 'package:innenkompass/core/constants/context_types.dart';
import 'package:innenkompass/core/constants/emotion_types.dart';
import 'package:innenkompass/core/constants/fact_interpretation_results.dart';
import 'package:innenkompass/core/constants/intervention_types.dart';
import 'package:innenkompass/core/constants/problem_timing.dart';
import 'package:innenkompass/core/constants/system_reaction_types.dart';
import 'package:innenkompass/core/constants/system_states.dart';
import 'package:innenkompass/core/constants/tipping_point_awareness.dart';
import 'package:innenkompass/core/constants/trigger_as_last_drop.dart';
import 'package:innenkompass/data/db/app_database.dart';
import 'package:innenkompass/domain/models/intervention_library.dart';
import 'package:innenkompass/domain/models/situation_draft.dart';

void main() {
  group('recommendedInterventionsProvider', () {
    test('maps classification recommendations to interventions in order', () {
      final database = AppDatabase.forTesting(NativeDatabase.memory());
      addTearDown(database.close);

      final container = ProviderContainer(
        overrides: [
          databaseProvider.overrideWithValue(database),
        ],
      );
      addTearDown(container.dispose);

      final controller =
          container.read(newSituationFlowControllerProvider.notifier);
      controller.updateEventData(
        SituationEventData(
          description: 'Nach einem harten Feedback im Teammeeting.',
          preTriggerPreoccupation: 'Ich war schon angespannt und müde.',
          problemTiming: ProblemTiming.partly,
          trigger: 'Ein Satz vor allen anderen.',
          preTriggerLoad: 6,
          context: ContextType.work,
          timestamp: DateTime(2026, 3, 17, 9, 30),
        ),
      );
      controller.updateEmotionData(
        const SituationEmotionData(
          intensity: 8,
          bodyTension: 7,
          primaryEmotion: EmotionType.anger,
        ),
      );
      controller.updateThoughtImpulseData(
        const SituationThoughtImpulseData(
          thoughtFocus: 'Ich war noch bei meiner Unsicherheit.',
          automaticThought: 'Ich muss sofort zurückschreiben.',
          factInterpretation: FactInterpretationResult.mixed,
          systemReaction: SystemReactionType.attack,
          actualBehaviorTags: ['diskutiert'],
          tippingPointAwareness: TippingPointAwareness.late,
        ),
      );
      controller.updateReflectionData(
        const SituationReflectionData(
          touchedThemes: ['Respekt'],
          neededSupports: ['Ruhe'],
          realisticAlternative: 'Ich hätte kurz stoppen können.',
          triggerAsLastDrop: TriggerAsLastDrop.partly,
          backgroundTheme: 'Nicht ernst genommen werden.',
          nextStep: 'Erst atmen, dann später antworten.',
        ),
      );

      final classification = container.read(classificationResultProvider);
      final interventions = container.read(recommendedInterventionsProvider);

      expect(classification, isNotNull);
      expect(interventions, isNotEmpty);
      expect(
        interventions.map((intervention) => intervention.id),
        classification!.recommendedInterventionIds,
      );
      expect(
        interventions.map((intervention) => intervention.type),
        classification.recommendedInterventions,
      );
    });

    test('falls back to active intervention when no classification exists', () {
      final database = AppDatabase.forTesting(NativeDatabase.memory());
      addTearDown(database.close);

      final container = ProviderContainer(
        overrides: [
          databaseProvider.overrideWithValue(database),
        ],
      );
      addTearDown(container.dispose);

      final intervention =
          InterventionLibrary.getByType(InterventionType.regulation).first;

      container
          .read(interventionFlowStateProvider.notifier)
          .startIntervention(intervention);

      final interventions = container.read(recommendedInterventionsProvider);

      expect(interventions.map((item) => item.id), [intervention.id]);
    });

    test('escalates detected crises to crisis-safe interventions', () {
      final database = AppDatabase.forTesting(NativeDatabase.memory());
      addTearDown(database.close);

      final container = ProviderContainer(
        overrides: [
          databaseProvider.overrideWithValue(database),
        ],
      );
      addTearDown(container.dispose);

      final controller =
          container.read(newSituationFlowControllerProvider.notifier);
      controller.updateEventData(
        SituationEventData(
          description: 'Ich sitze allein nach einem heftigen Streit.',
          preTriggerPreoccupation: 'Ich war schon völlig überladen.',
          problemTiming: ProblemTiming.alreadyThere,
          trigger: 'Noch ein harter Satz.',
          preTriggerLoad: 8,
          context: ContextType.family,
          timestamp: DateTime(2026, 3, 17, 23, 15),
        ),
      );
      controller.updateEmotionData(
        const SituationEmotionData(
          intensity: 9,
          bodyTension: 9,
          primaryEmotion: EmotionType.fear,
        ),
      );
      controller.updateThoughtImpulseData(
        const SituationThoughtImpulseData(
          thoughtFocus: 'Ich war schon im Kopf völlig fest.',
          automaticThought: 'Es ist hoffnungslos und ich halte das nicht aus.',
          factInterpretation: FactInterpretationResult.mostlyFacts,
          systemReaction: SystemReactionType.withdrawal,
          actualBehaviorTags: ['zurückgezogen'],
          tippingPointAwareness: TippingPointAwareness.none,
        ),
      );
      controller.updateReflectionData(
        const SituationReflectionData(
          touchedThemes: ['Sicherheit'],
          neededSupports: ['Hilfe'],
          realisticAlternative:
              'Ich hätte sofort eine sichere Person anrufen können.',
          triggerAsLastDrop: TriggerAsLastDrop.yes,
          backgroundTheme: 'Ich war schon lange über meiner Grenze.',
          nextStep: 'Ich hole mir Hilfe und gehe nicht allein damit weiter.',
        ),
      );

      final classification = container.read(classificationResultProvider);
      final interventions = container.read(recommendedInterventionsProvider);

      expect(classification, isNotNull);
      expect(classification!.isCrisis, isTrue);
      expect(classification.systemState, SystemState.crisis);
      expect(classification.recommendedInterventions.first,
          InterventionType.regulation);
      expect(
        classification.recommendedInterventions,
        isNot(contains(InterventionType.factCheck)),
      );
      expect(classification.primaryInterventionId, 'acute_regulation');
      expect(interventions, isNotEmpty);
      expect(interventions.first.id, 'acute_regulation');
      expect(interventions.first.type, InterventionType.regulation);
    });
  });
}
