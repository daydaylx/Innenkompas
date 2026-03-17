import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:innenkompass/application/providers/database_provider.dart';
import 'package:innenkompass/application/providers/intervention_providers.dart';
import 'package:innenkompass/application/providers/new_situation_providers.dart';
import 'package:innenkompass/core/constants/context_types.dart';
import 'package:innenkompass/core/constants/emotion_types.dart';
import 'package:innenkompass/core/constants/impulse_types.dart';
import 'package:innenkompass/core/constants/intervention_types.dart';
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
  });
}
