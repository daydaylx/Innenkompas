import 'package:flutter_test/flutter_test.dart';
import 'package:innenkompass/core/constants/context_types.dart';
import 'package:innenkompass/core/constants/emotion_types.dart';
import 'package:innenkompass/core/constants/fact_interpretation_results.dart';
import 'package:innenkompass/core/constants/impulse_types.dart';
import 'package:innenkompass/core/constants/system_states.dart';
import 'package:innenkompass/domain/services/evaluation_engine.dart';

void main() {
  group('EvaluationEngine', () {
    test('returns interpretation-focused output for uncertain facts', () {
      final result = EvaluationEngine.evaluate(
        systemState: SystemState.interpretation,
        primaryEmotion: EmotionType.fear,
        intensity: 6,
        bodyTension: 5,
        firstImpulse: ImpulseType.control,
        context: ContextType.work,
        factInterpretation: FactInterpretationResult.mostlyInterpretation,
      );

      expect(result.headlineKey, 'interpretation_uncertain_facts');
      expect(result.meaningKey, 'interpretation_not_certain');
      expect(result.suggestedTipIds, contains('check_facts_not_assumptions'));
      expect(result.suggestedNextActionKey, 'check_facts_first');
      expect(result.nextActionOptions, contains('write_alternative_view'));
    });

    test('prioritizes regulation-first advice for acute activation', () {
      final result = EvaluationEngine.evaluate(
        systemState: SystemState.acuteActivation,
        primaryEmotion: EmotionType.anger,
        intensity: 9,
        bodyTension: 8,
        firstImpulse: ImpulseType.counter,
        context: ContextType.partnership,
        factInterpretation: FactInterpretationResult.mixed,
      );

      expect(result.headlineKey, 'acute_activation_high_tension');
      expect(result.suggestedNextActionKey, 'regulate_body_first');
      expect(result.suggestedTipIds.first, 'regulate_body_before_analysis');
      expect(result.suggestedTipIds, contains('do_not_react_first_impulse'));
    });
  });
}
