import 'package:innenkompass/core/constants/context_types.dart';
import 'package:innenkompass/core/constants/emotion_types.dart';
import 'package:innenkompass/core/constants/fact_interpretation_results.dart';
import 'package:innenkompass/core/constants/system_reaction_types.dart';
import 'package:innenkompass/core/constants/system_states.dart';
import 'package:innenkompass/core/constants/tipping_point_awareness.dart';
import 'package:innenkompass/core/constants/trigger_as_last_drop.dart';
import 'package:innenkompass/domain/models/evaluation.dart';

class EvaluationEngine {
  EvaluationEngine._();

  static EvaluationResult evaluate({
    required SystemState systemState,
    required EmotionType primaryEmotion,
    required int preTriggerLoad,
    required int intensity,
    required int bodyTension,
    required SystemReactionType systemReaction,
    required ContextType context,
    required FactInterpretationResult factInterpretation,
    required List<String> thoughtPatterns,
    required List<String> actualBehaviorTags,
    required TippingPointAwareness tippingPointAwareness,
    required TriggerAsLastDrop triggerAsLastDrop,
    required List<String> touchedThemes,
  }) {
    final statusKeys = _statusKeysFor(
      systemState: systemState,
      preTriggerLoad: preTriggerLoad,
      intensity: intensity,
      bodyTension: bodyTension,
      systemReaction: systemReaction,
      actualBehaviorTags: actualBehaviorTags,
      triggerAsLastDrop: triggerAsLastDrop,
    );
    final nextActionOptions = _nextActionOptionsFor(
      statusKeys: statusKeys,
      systemState: systemState,
      factInterpretation: factInterpretation,
      context: context,
      systemReaction: systemReaction,
    );

    return EvaluationResult(
      systemState: systemState,
      whatStandsOutKey: _standOutKeyFor(
        statusKeys: statusKeys,
        preTriggerLoad: preTriggerLoad,
        thoughtPatterns: thoughtPatterns,
        triggerAsLastDrop: triggerAsLastDrop,
        systemReaction: systemReaction,
      ),
      whatMayBeBehindItKey: _backgroundKeyFor(
        systemState: systemState,
        preTriggerLoad: preTriggerLoad,
        factInterpretation: factInterpretation,
        triggerAsLastDrop: triggerAsLastDrop,
        touchedThemes: touchedThemes,
        context: context,
      ),
      helpfulNowKey: _helpfulNowKeyFor(
        statusKeys: statusKeys,
        factInterpretation: factInterpretation,
        systemReaction: systemReaction,
      ),
      learningPointKey: _learningPointKeyFor(
        preTriggerLoad: preTriggerLoad,
        bodyTension: bodyTension,
        factInterpretation: factInterpretation,
        tippingPointAwareness: tippingPointAwareness,
        thoughtPatterns: thoughtPatterns,
        statusKeys: statusKeys,
      ),
      statusKeys: statusKeys,
      suggestedTipIds: _tipIdsFor(
        systemState: systemState,
        primaryEmotion: primaryEmotion,
        factInterpretation: factInterpretation,
        systemReaction: systemReaction,
        thoughtPatterns: thoughtPatterns,
        intensity: intensity,
        bodyTension: bodyTension,
      ),
      suggestedNextActionKey: nextActionOptions.first,
      nextActionOptions: nextActionOptions,
    );
  }

  static List<String> _statusKeysFor({
    required SystemState systemState,
    required int preTriggerLoad,
    required int intensity,
    required int bodyTension,
    required SystemReactionType systemReaction,
    required List<String> actualBehaviorTags,
    required TriggerAsLastDrop triggerAsLastDrop,
  }) {
    final ordered = <String>{};

    if (systemState == SystemState.crisis) {
      ordered.add('safety_relevant_moment');
      ordered.add('stabilize_before_analysis');
      return ordered.toList(growable: false);
    }

    if (intensity >= 8 || bodyTension >= 8) {
      ordered.add('high_tension');
    }

    if ((intensity >= 8 && bodyTension >= 7) ||
        systemReaction == SystemReactionType.attack ||
        actualBehaviorTags.contains('geschrien') ||
        actualBehaviorTags.contains('Dinge geworfen')) {
      ordered.add('acute_escalation');
    }

    if (preTriggerLoad >= 7 || triggerAsLastDrop == TriggerAsLastDrop.yes) {
      ordered.add('strong_inner_pressure');
    }

    if (intensity >= 8 ||
        bodyTension >= 8 ||
        systemReaction == SystemReactionType.freeze) {
      ordered.add('reflection_limited');
      ordered.add('stabilize_before_analysis');
    }

    if (ordered.isEmpty) {
      ordered.add('high_tension');
    }

    return ordered.toList(growable: false);
  }

  static String _standOutKeyFor({
    required List<String> statusKeys,
    required int preTriggerLoad,
    required List<String> thoughtPatterns,
    required TriggerAsLastDrop triggerAsLastDrop,
    required SystemReactionType systemReaction,
  }) {
    if (statusKeys.contains('safety_relevant_moment')) {
      return 'safety_relevant_signal';
    }
    if (triggerAsLastDrop == TriggerAsLastDrop.yes || preTriggerLoad >= 7) {
      return 'small_trigger_big_load';
    }
    if (_containsThoughtLoop(thoughtPatterns)) {
      return 'thought_spiral_active';
    }
    if (systemReaction == SystemReactionType.attack ||
        systemReaction == SystemReactionType.flight ||
        systemReaction == SystemReactionType.freeze) {
      return 'automatic_reaction_fast';
    }
    if (statusKeys.contains('acute_escalation')) {
      return 'conflict_pattern_visible';
    }
    if (statusKeys.contains('high_tension')) {
      return 'high_tension_body_fast';
    }
    return 'reflection_reachable';
  }

  static String _backgroundKeyFor({
    required SystemState systemState,
    required int preTriggerLoad,
    required FactInterpretationResult factInterpretation,
    required TriggerAsLastDrop triggerAsLastDrop,
    required List<String> touchedThemes,
    required ContextType context,
  }) {
    if (systemState == SystemState.crisis) {
      return 'background_safety_first';
    }
    if (preTriggerLoad >= 7) {
      return 'background_pressure_already_high';
    }
    if (factInterpretation == FactInterpretationResult.mostlyInterpretation) {
      return 'background_interpretation';
    }
    if (triggerAsLastDrop != TriggerAsLastDrop.no) {
      return 'background_need_hit';
    }
    if (touchedThemes.contains('Kontrolle') ||
        touchedThemes.contains('Kompetenz') ||
        context == ContextType.selfWorthPerformance ||
        context == ContextType.work) {
      return 'background_control';
    }
    if (touchedThemes.contains('Respekt') ||
        touchedThemes.contains('Grenzen') ||
        touchedThemes.contains('Anerkennung')) {
      return 'background_conflict';
    }
    return 'background_unknown';
  }

  static String _helpfulNowKeyFor({
    required List<String> statusKeys,
    required FactInterpretationResult factInterpretation,
    required SystemReactionType systemReaction,
  }) {
    if (statusKeys.contains('stabilize_before_analysis')) {
      return 'helpful_stabilize_body';
    }
    if (systemReaction == SystemReactionType.attack ||
        systemReaction == SystemReactionType.flight) {
      return 'helpful_pause_before_contact';
    }
    if (factInterpretation == FactInterpretationResult.mostlyInterpretation) {
      return 'helpful_name_facts';
    }
    if (statusKeys.contains('strong_inner_pressure')) {
      return 'helpful_reduce_input';
    }
    return 'helpful_choose_small_step';
  }

  static String _learningPointKeyFor({
    required int preTriggerLoad,
    required int bodyTension,
    required FactInterpretationResult factInterpretation,
    required TippingPointAwareness tippingPointAwareness,
    required List<String> thoughtPatterns,
    required List<String> statusKeys,
  }) {
    if (statusKeys.contains('stabilize_before_analysis')) {
      return 'learning_stabilize_not_solve';
    }
    if (preTriggerLoad >= 7) {
      return 'learning_before_trigger';
    }
    if (tippingPointAwareness == TippingPointAwareness.afterwards ||
        tippingPointAwareness == TippingPointAwareness.none) {
      return 'learning_notice_body_first';
    }
    if (factInterpretation == FactInterpretationResult.mostlyInterpretation) {
      return 'learning_name_automatic_thought';
    }
    if (_containsThoughtLoop(thoughtPatterns)) {
      return 'learning_interrupt_pattern';
    }
    return 'learning_build_pause';
  }

  static List<String> _nextActionOptionsFor({
    required List<String> statusKeys,
    required SystemState systemState,
    required FactInterpretationResult factInterpretation,
    required ContextType context,
    required SystemReactionType systemReaction,
  }) {
    if (statusKeys.contains('safety_relevant_moment')) {
      return const [
        'seek_support_now',
        'regulate_body_first',
        'pause_now',
      ];
    }

    if (statusKeys.contains('stabilize_before_analysis')) {
      return const [
        'regulate_body_first',
        'reduce_stimuli',
        'pause_now',
      ];
    }

    if (systemReaction == SystemReactionType.attack ||
        systemReaction == SystemReactionType.flight) {
      return const [
        'do_not_reply_now',
        'pause_now',
        'address_later',
      ];
    }

    if (factInterpretation == FactInterpretationResult.mostlyInterpretation) {
      return const [
        'check_facts_first',
        'write_alternative_view',
        'write_observation_first',
      ];
    }

    if (systemState == SystemState.overwhelm) {
      return const [
        'choose_one_step',
        'reduce_stimuli',
        'pause_now',
      ];
    }

    if (context == ContextType.work || context == ContextType.partnership) {
      return const [
        'write_observation_first',
        'address_later',
        'choose_one_step',
      ];
    }

    return const [
      'choose_one_step',
      'pause_now',
      'write_observation_first',
    ];
  }

  static List<String> _tipIdsFor({
    required SystemState systemState,
    required EmotionType primaryEmotion,
    required FactInterpretationResult factInterpretation,
    required SystemReactionType systemReaction,
    required List<String> thoughtPatterns,
    required int intensity,
    required int bodyTension,
  }) {
    final ordered = <String>{};

    void addAll(Iterable<String> ids) => ordered.addAll(ids);

    if (systemState == SystemState.crisis) {
      addAll(const [
        'get_support_now',
        'regulate_body_before_analysis',
      ]);
      return ordered.toList(growable: false);
    }

    if (intensity >= 8 || bodyTension >= 8) {
      addAll(const [
        'regulate_body_before_analysis',
        'do_not_react_first_impulse',
      ]);
    }

    if (factInterpretation == FactInterpretationResult.mostlyInterpretation) {
      addAll(const [
        'check_facts_not_assumptions',
        'write_alternative_explanation',
      ]);
    }

    if (_containsThoughtLoop(thoughtPatterns)) {
      addAll(const [
        'limit_loop',
        'repetition_not_clarity',
      ]);
    }

    if (systemReaction == SystemReactionType.attack) {
      addAll(const [
        'do_not_react_first_impulse',
        'speak_later_in_observations',
      ]);
    }

    if (systemReaction == SystemReactionType.control) {
      addAll(const [
        'check_if_problem_solvable',
        'choose_next_step',
      ]);
    }

    switch (primaryEmotion) {
      case EmotionType.anger:
      case EmotionType.annoyance:
        addAll(const [
          'separate_observation_from_assumption',
          'move_conversation_if_needed',
        ]);
      case EmotionType.shame:
      case EmotionType.guilt:
        addAll(const [
          'separate_error_from_selfworth',
          'would_you_talk_same_way',
        ]);
      case EmotionType.fear:
      case EmotionType.powerlessness:
      case EmotionType.helplessness:
        addAll(const [
          'check_facts_not_assumptions',
          'regulate_body_before_analysis',
        ]);
      case EmotionType.overwhelm:
      case EmotionType.emptiness:
        addAll(const [
          'not_everything_at_once',
          'reduce_stimuli_then_plan',
        ]);
      default:
        addAll(const ['choose_next_step']);
    }

    return ordered.take(4).toList(growable: false);
  }

  static bool _containsThoughtLoop(List<String> thoughtPatterns) {
    return thoughtPatterns.contains('Grübeln') ||
        thoughtPatterns.contains('Katastrophisieren') ||
        thoughtPatterns.contains('Gedankenspirale');
  }
}
