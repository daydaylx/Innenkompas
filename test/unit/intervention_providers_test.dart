import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:innenkompass/application/providers/database_provider.dart';
import 'package:innenkompass/application/providers/intervention_providers.dart';
import 'package:innenkompass/application/providers/new_situation_providers.dart';
import 'package:innenkompass/core/constants/context_types.dart';
import 'package:innenkompass/core/constants/emotion_types.dart';
import 'package:innenkompass/core/constants/fact_interpretation_results.dart';
import 'package:innenkompass/core/constants/impulse_types.dart';
import 'package:innenkompass/core/constants/intervention_types.dart';
import 'package:innenkompass/core/constants/system_states.dart';
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
          automaticThought: 'Ich muss sofort zurückschreiben.',
          firstImpulse: ImpulseType.counter,
          factInterpretation: FactInterpretationResult.mixed,
        ),
      );
      controller.updateReflectionData(
        const SituationReflectionData(
          needOrWoundedPoint: 'Ich brauche gerade Ruhe und Einordnung.',
          nextStep: 'Erst atmen, dann später antworten.',
        ),
      );

      final classification = container.read(classificationResultProvider);
      final interventions = container.read(recommendedInterventionsProvider);

      expect(classification, isNotNull);
      expect(interventions, isNotEmpty);
      expect(
        interventions.map((intervention) => intervention.type),
        classification!.recommendedInterventions,
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
          automaticThought: 'Es ist hoffnungslos und ich halte das nicht aus.',
          firstImpulse: ImpulseType.withdraw,
          factInterpretation: FactInterpretationResult.mostlyFacts,
        ),
      );
      controller.updateReflectionData(
        const SituationReflectionData(
          needOrWoundedPoint: 'Ich brauche sofort Sicherheit.',
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
      expect(interventions, isNotEmpty);
      expect(interventions.first.type, InterventionType.regulation);
    });
  });
}
