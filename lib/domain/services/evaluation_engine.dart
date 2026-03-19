import 'package:innenkompass/core/constants/context_types.dart';
import 'package:innenkompass/core/constants/emotion_types.dart';
import 'package:innenkompass/core/constants/fact_interpretation_results.dart';
import 'package:innenkompass/core/constants/impulse_types.dart';
import 'package:innenkompass/core/constants/system_states.dart';
import 'package:innenkompass/domain/models/evaluation.dart';

/// Regelbasierte Auswertung für Sofort-Feedback und praktische Tipps.
class EvaluationEngine {
  EvaluationEngine._();

  static EvaluationResult evaluate({
    required SystemState systemState,
    required EmotionType primaryEmotion,
    required int intensity,
    required int bodyTension,
    required ImpulseType firstImpulse,
    required ContextType context,
    required FactInterpretationResult factInterpretation,
  }) {
    final headlineKey = _headlineKeyFor(
      systemState: systemState,
      intensity: intensity,
      bodyTension: bodyTension,
      firstImpulse: firstImpulse,
      factInterpretation: factInterpretation,
    );
    final meaningKey = _meaningKeyFor(
      systemState: systemState,
      factInterpretation: factInterpretation,
    );
    final nextActionOptions = _nextActionOptionsFor(
      systemState: systemState,
      factInterpretation: factInterpretation,
      context: context,
    );
    final suggestedNextActionKey = nextActionOptions.first;

    final suggestedTipIds = _tipIdsFor(
      systemState: systemState,
      primaryEmotion: primaryEmotion,
      firstImpulse: firstImpulse,
      factInterpretation: factInterpretation,
      intensity: intensity,
      bodyTension: bodyTension,
    );

    return EvaluationResult(
      systemState: systemState,
      headlineKey: headlineKey,
      meaningKey: meaningKey,
      suggestedTipIds: suggestedTipIds,
      suggestedNextActionKey: suggestedNextActionKey,
      nextActionOptions: nextActionOptions,
    );
  }

  static String _headlineKeyFor({
    required SystemState systemState,
    required int intensity,
    required int bodyTension,
    required ImpulseType firstImpulse,
    required FactInterpretationResult factInterpretation,
  }) {
    switch (systemState) {
      case SystemState.acuteActivation:
        if (firstImpulse == ImpulseType.withdraw ||
            firstImpulse == ImpulseType.flee) {
          return 'acute_activation_withdrawal';
        }
        return 'acute_activation_high_tension';
      case SystemState.rumination:
        return 'rumination_loop';
      case SystemState.conflict:
        return 'conflict_impulse';
      case SystemState.selfDevaluation:
        return 'self_devaluation_load';
      case SystemState.overwhelm:
        return 'overwhelm_pressure';
      case SystemState.interpretation:
        return 'interpretation_uncertain_facts';
      case SystemState.crisis:
        return 'crisis_support';
      case SystemState.reflectiveReady:
        if (factInterpretation == FactInterpretationResult.mostlyInterpretation &&
            intensity >= 5 &&
            bodyTension >= 5) {
          return 'interpretation_uncertain_facts';
        }
        return 'reflective_ready';
    }
  }

  static String _meaningKeyFor({
    required SystemState systemState,
    required FactInterpretationResult factInterpretation,
  }) {
    switch (systemState) {
      case SystemState.acuteActivation:
        return 'acute_activation_alarm';
      case SystemState.rumination:
        return 'rumination_clarifying';
      case SystemState.conflict:
        return 'conflict_loaded';
      case SystemState.selfDevaluation:
        return 'self_devaluation_connected';
      case SystemState.overwhelm:
        return 'overwhelm_not_unsolvable';
      case SystemState.interpretation:
        return 'interpretation_not_certain';
      case SystemState.crisis:
        return 'crisis_regulate_first';
      case SystemState.reflectiveReady:
        if (factInterpretation == FactInterpretationResult.mostlyInterpretation) {
          return 'interpretation_not_certain';
        }
        return 'reflective_ready_accessible';
    }
  }

  static List<String> _nextActionOptionsFor({
    required SystemState systemState,
    required FactInterpretationResult factInterpretation,
    required ContextType context,
  }) {
    switch (systemState) {
      case SystemState.acuteActivation:
        return const [
          'regulate_body_first',
          'pause_now',
          'do_not_reply_now',
        ];
      case SystemState.rumination:
        return const [
          'limit_thinking_loop',
          'write_alternative_view',
          'choose_one_step',
        ];
      case SystemState.conflict:
        return const [
          'do_not_reply_now',
          'write_observation_first',
          'address_later',
        ];
      case SystemState.selfDevaluation:
        return const [
          'collect_counterevidence',
          'write_alternative_view',
          'pause_now',
        ];
      case SystemState.overwhelm:
        return const [
          'choose_one_step',
          'reduce_stimuli',
          'pause_now',
        ];
      case SystemState.interpretation:
        return const [
          'check_facts_first',
          'write_alternative_view',
          'pause_now',
        ];
      case SystemState.crisis:
        return const [
          'seek_support_now',
          'regulate_body_first',
          'pause_now',
        ];
      case SystemState.reflectiveReady:
        if (factInterpretation == FactInterpretationResult.mostlyInterpretation) {
          return const [
            'check_facts_first',
            'write_alternative_view',
            'choose_one_step',
          ];
        }
        if (context == ContextType.work || context == ContextType.family) {
          return const [
            'write_observation_first',
            'address_later',
            'choose_one_step',
          ];
        }
        return const [
          'choose_one_step',
          'pause_now',
          'address_later',
        ];
    }
  }

  static List<String> _tipIdsFor({
    required SystemState systemState,
    required EmotionType primaryEmotion,
    required ImpulseType firstImpulse,
    required FactInterpretationResult factInterpretation,
    required int intensity,
    required int bodyTension,
  }) {
    final ordered = <String>{};

    void addAll(Iterable<String> ids) => ordered.addAll(ids);

    addAll(_stateTips[systemState] ?? const []);
    addAll(_emotionTips[primaryEmotion] ?? const []);
    addAll(_impulseTips[firstImpulse] ?? const []);

    if (factInterpretation == FactInterpretationResult.mostlyInterpretation) {
      addAll(const [
        'check_facts_not_assumptions',
        'write_alternative_explanation',
      ]);
    } else if (factInterpretation == FactInterpretationResult.mixed) {
      addAll(const ['check_facts_not_assumptions']);
    }

    if (intensity >= 8 || bodyTension >= 8) {
      addAll(const ['regulate_body_before_analysis', 'do_not_react_first_impulse']);
    }

    return ordered.take(4).toList(growable: false);
  }

  static const Map<SystemState, List<String>> _stateTips = {
    SystemState.acuteActivation: [
      'regulate_body_before_analysis',
      'do_not_react_first_impulse',
      'choose_next_step',
    ],
    SystemState.rumination: [
      'check_if_problem_solvable',
      'choose_next_step',
      'limit_loop',
      'repetition_not_clarity',
    ],
    SystemState.conflict: [
      'do_not_react_first_impulse',
      'separate_observation_from_assumption',
      'write_objective_observation',
      'move_conversation_if_needed',
    ],
    SystemState.selfDevaluation: [
      'separate_error_from_selfworth',
      'check_counterevidence',
      'write_more_realistic_alternative',
      'would_you_talk_same_way',
    ],
    SystemState.overwhelm: [
      'not_everything_at_once',
      'choose_next_step',
      'reduce_stimuli_then_plan',
      'more_analysis_not_solution',
    ],
    SystemState.interpretation: [
      'check_facts_not_assumptions',
      'write_alternative_explanation',
      'write_objective_observation',
    ],
    SystemState.reflectiveReady: [
      'choose_next_step',
      'write_objective_observation',
    ],
    SystemState.crisis: [
      'get_support_now',
      'regulate_body_before_analysis',
      'do_not_react_first_impulse',
    ],
  };

  static const Map<EmotionType, List<String>> _emotionTips = {
    EmotionType.fear: [
      'check_facts_not_assumptions',
      'write_alternative_explanation',
      'avoid_rechecking',
    ],
    EmotionType.anger: [
      'do_not_react_first_impulse',
      'separate_criticism_from_value',
      'speak_later_in_observations',
    ],
    EmotionType.shame: [
      'separate_error_from_selfworth',
      'check_counterevidence',
    ],
    EmotionType.guilt: [
      'separate_error_from_selfworth',
      'write_more_realistic_alternative',
    ],
    EmotionType.sadness: [
      'choose_next_step',
      'regulate_body_before_analysis',
    ],
    EmotionType.disgust: [
      'write_objective_observation',
      'do_not_react_first_impulse',
    ],
  };

  static const Map<ImpulseType, List<String>> _impulseTips = {
    ImpulseType.ruminate: [
      'limit_loop',
      'repetition_not_clarity',
    ],
    ImpulseType.control: [
      'check_facts_not_assumptions',
      'choose_next_step',
    ],
    ImpulseType.withdraw: [
      'regulate_body_before_analysis',
      'choose_next_step',
    ],
    ImpulseType.counter: [
      'do_not_react_first_impulse',
      'write_objective_observation',
    ],
    ImpulseType.immediateAction: [
      'do_not_react_first_impulse',
      'regulate_body_before_analysis',
    ],
    ImpulseType.selfCriticism: [
      'separate_error_from_selfworth',
      'would_you_talk_same_way',
    ],
  };
}
