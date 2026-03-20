import 'package:flutter_test/flutter_test.dart';
import 'package:innenkompass/core/constants/context_types.dart';
import 'package:innenkompass/core/constants/emotion_types.dart';
import 'package:innenkompass/core/constants/impulse_types.dart';
import 'package:innenkompass/core/constants/system_states.dart';
import 'package:innenkompass/domain/services/classification_service.dart';
import 'package:innenkompass/domain/services/intervention_resolver.dart';

void main() {
  group('InterventionResolver', () {
    test('classification exposes a concrete intervention id', () {
      final result = ClassificationService.classify(
        intensity: 10,
        bodyTension: 10,
        primaryEmotion: EmotionType.fear,
        firstImpulse: ImpulseType.freeze,
        context: ContextType.other,
        automaticThought: 'Ich halte das gerade nicht aus.',
      );

      expect(result.primaryInterventionId, 'acute_regulation');
      expect(result.recommendedInterventionIds, contains('acute_regulation'));
    });

    test('stored direct id wins over a contradictory type', () {
      final result = InterventionResolver.resolveForStoredEntry(
        storedInterventionId: 'grounding_5_4_3_2_1',
        storedInterventionTypeRaw: 'factCheck',
        systemStateRaw: SystemState.interpretation.name,
        primaryEmotionRaw: EmotionType.fear.name,
        intensity: 6,
      );

      expect(result, isNotNull);
      expect(result!.interventionId, 'grounding_5_4_3_2_1');
      expect(result.interventionType.name, 'regulation');
      expect(result.source, InterventionResolutionSource.directId);
    });

    test('legacy type fallback resolves deterministically to abc3', () {
      final result = InterventionResolver.resolveForStoredEntry(
        storedInterventionId: null,
        storedInterventionTypeRaw: 'abc3',
        systemStateRaw: SystemState.reflectiveReady.name,
        primaryEmotionRaw: EmotionType.fear.name,
        intensity: 5,
      );

      expect(result, isNotNull);
      expect(result!.interventionId, 'abc3_protocol');
      expect(result.source, InterventionResolutionSource.legacyFallback);
    });

    test('label helper covers concrete ids and newer intervention types', () {
      expect(
        InterventionResolver.labelForStoredReference(
          interventionId: 'rsa_abcde_v1',
          interventionTypeRaw: 'factCheck',
        ),
        'Rationale Selbstanalyse (RSA)',
      );
      expect(
        InterventionResolver.labelForStoredReference(
          interventionId: null,
          interventionTypeRaw: 'abc3',
        ),
        'ABC-3 Protokoll',
      );
    });
  });
}
