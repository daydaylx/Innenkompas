import 'package:flutter_test/flutter_test.dart';
import 'package:innenkompass/core/constants/context_types.dart';
import 'package:innenkompass/core/constants/emotion_types.dart';
import 'package:innenkompass/core/constants/fact_interpretation_results.dart';
import 'package:innenkompass/core/constants/system_reaction_types.dart';
import 'package:innenkompass/core/constants/system_states.dart';
import 'package:innenkompass/core/constants/tipping_point_awareness.dart';
import 'package:innenkompass/core/constants/trigger_as_last_drop.dart';
import 'package:innenkompass/domain/services/evaluation_engine.dart';

void main() {
  group('EvaluationEngine', () {
    test('returns interpretation-focused output for uncertain facts', () {
      final result = EvaluationEngine.evaluate(
        systemState: SystemState.interpretation,
        primaryEmotion: EmotionType.fear,
        preTriggerLoad: 7,
        intensity: 6,
        bodyTension: 5,
        systemReaction: SystemReactionType.control,
        context: ContextType.work,
        factInterpretation: FactInterpretationResult.mostlyInterpretation,
        thoughtPatterns: const ['Grübeln'],
        actualBehaviorTags: const ['zurückgezogen'],
        tippingPointAwareness: TippingPointAwareness.afterwards,
        triggerAsLastDrop: TriggerAsLastDrop.yes,
        touchedThemes: const ['Kontrolle'],
      );

      expect(result.whatStandsOutKey, 'small_trigger_big_load');
      expect(result.whatMayBeBehindItKey, 'background_pressure_already_high');
      expect(result.suggestedTipIds, contains('check_facts_not_assumptions'));
      expect(result.suggestedNextActionKey, 'check_facts_first');
      expect(result.nextActionOptions, contains('write_alternative_view'));
    });

    test('prioritizes regulation-first advice for acute activation', () {
      final result = EvaluationEngine.evaluate(
        systemState: SystemState.acuteActivation,
        primaryEmotion: EmotionType.anger,
        preTriggerLoad: 5,
        intensity: 9,
        bodyTension: 8,
        systemReaction: SystemReactionType.attack,
        context: ContextType.partnership,
        factInterpretation: FactInterpretationResult.mixed,
        thoughtPatterns: const ['Vorwürfe an andere'],
        actualBehaviorTags: const ['geschrien'],
        tippingPointAwareness: TippingPointAwareness.late,
        triggerAsLastDrop: TriggerAsLastDrop.partly,
        touchedThemes: const ['Respekt'],
      );

      expect(result.whatStandsOutKey, 'automatic_reaction_fast');
      expect(result.suggestedNextActionKey, 'regulate_body_first');
      expect(result.suggestedTipIds.first, 'regulate_body_before_analysis');
      expect(result.suggestedTipIds, contains('do_not_react_first_impulse'));
    });
  });
}
