import 'package:innenkompass/core/constants/actual_behavior_types.dart';
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
    required List<String> neededSupports,
    String? needOrWoundedPoint,
    String? backgroundTheme,
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
      preTriggerLoad: preTriggerLoad,
      triggerAsLastDrop: triggerAsLastDrop,
      neededSupports: neededSupports,
      tippingPointAwareness: tippingPointAwareness,
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
        neededSupports: neededSupports,
        needOrWoundedPoint: needOrWoundedPoint,
        backgroundTheme: backgroundTheme,
        context: context,
      ),
      helpfulNowKey: _helpfulNowKeyFor(
        statusKeys: statusKeys,
        preTriggerLoad: preTriggerLoad,
        triggerAsLastDrop: triggerAsLastDrop,
        neededSupports: neededSupports,
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
        preTriggerLoad: preTriggerLoad,
        triggerAsLastDrop: triggerAsLastDrop,
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
    final normalizedBehaviorTags =
        ActualBehaviorTypes.normalizeAll(actualBehaviorTags).toSet();

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
        normalizedBehaviorTags.contains('scream') ||
        normalizedBehaviorTags.contains('throw_objects') ||
        normalizedBehaviorTags.contains('raise_voice') ||
        normalizedBehaviorTags.contains('freeze_block')) {
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
    required List<String> neededSupports,
    required String? needOrWoundedPoint,
    required String? backgroundTheme,
    required ContextType context,
  }) {
    if (systemState == SystemState.crisis) {
      return 'background_safety_first';
    }
    final normalizedSupportSet =
        neededSupports.map((value) => value.trim()).toSet();
    final normalizedNeedOrWoundedPoint = needOrWoundedPoint?.trim();
    final normalizedBackgroundTheme = backgroundTheme?.trim();

    if (normalizedSupportSet.any(
      (value) => {
        'Ruhe',
        'Abstand',
        'Pause',
        'Schlaf oder körperliche Entlastung',
      }.contains(value),
    )) {
      return 'background_need_rest';
    }
    if (normalizedSupportSet.any(
      (value) => {
        'Zuspruch',
        'Ernst genommen werden',
        'Verständnis',
      }.contains(value),
    )) {
      return 'background_need_validation';
    }
    if (normalizedSupportSet.any(
      (value) => {
        'Klarheit',
        'Struktur',
        'Entscheidungshilfe',
      }.contains(value),
    )) {
      return 'background_need_clarity';
    }
    if (normalizedSupportSet.contains('Hilfe')) {
      return 'background_need_support';
    }
    if (normalizedSupportSet.contains('Grenzen')) {
      return 'background_need_boundaries';
    }
    if ((normalizedNeedOrWoundedPoint != null &&
            normalizedNeedOrWoundedPoint.isNotEmpty) ||
        (normalizedBackgroundTheme != null &&
            normalizedBackgroundTheme.isNotEmpty)) {
      return 'background_need_hit';
    }
    if (factInterpretation == FactInterpretationResult.mostlyInterpretation) {
      return 'background_interpretation';
    }
    if (preTriggerLoad >= 7) {
      return 'background_pressure_already_high';
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
    required int preTriggerLoad,
    required TriggerAsLastDrop triggerAsLastDrop,
    required List<String> neededSupports,
    required FactInterpretationResult factInterpretation,
    required SystemReactionType systemReaction,
  }) {
    if (statusKeys.contains('stabilize_before_analysis')) {
      return 'helpful_stabilize_body';
    }
    if (preTriggerLoad >= 8 &&
        (triggerAsLastDrop == TriggerAsLastDrop.yes ||
            triggerAsLastDrop == TriggerAsLastDrop.partly)) {
      return 'helpful_reduce_load_before_trigger';
    }
    if (neededSupports.any(
      (value) =>
          value == 'Hilfe' || value == 'Zuspruch' || value == 'Verständnis',
    )) {
      return 'helpful_seek_support';
    }
    if (systemReaction == SystemReactionType.attack ||
        systemReaction == SystemReactionType.flight) {
      return 'helpful_pause_before_contact';
    }
    if (factInterpretation == FactInterpretationResult.mostlyInterpretation) {
      return 'helpful_name_facts';
    }
    if (statusKeys.contains('strong_inner_pressure') ||
        neededSupports.any(
          (value) => value == 'Ruhe' || value == 'Abstand' || value == 'Pause',
        )) {
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
    if (tippingPointAwareness == TippingPointAwareness.late) {
      return 'learning_pause_inside_moment';
    }
    if (tippingPointAwareness == TippingPointAwareness.early) {
      return 'learning_decide_earlier';
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
    required int preTriggerLoad,
    required TriggerAsLastDrop triggerAsLastDrop,
    required List<String> neededSupports,
    required TippingPointAwareness tippingPointAwareness,
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

    if (preTriggerLoad >= 8 &&
        (triggerAsLastDrop == TriggerAsLastDrop.yes ||
            triggerAsLastDrop == TriggerAsLastDrop.partly)) {
      return [
        'check_load_before_contact',
        'reduce_stimuli',
        if (neededSupports.any(
          (value) =>
              value == 'Hilfe' || value == 'Zuspruch' || value == 'Verständnis',
        ))
          'seek_support_now'
        else
          'choose_one_step',
      ];
    }

    if (statusKeys.contains('stabilize_before_analysis')) {
      return const [
        'regulate_body_first',
        'reduce_stimuli',
        'pause_now',
      ];
    }

    if (tippingPointAwareness == TippingPointAwareness.early) {
      return const [
        'honor_early_signal',
        'address_later',
        'choose_one_step',
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
    required int preTriggerLoad,
    required TriggerAsLastDrop triggerAsLastDrop,
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

    if (preTriggerLoad >= 7 ||
        triggerAsLastDrop == TriggerAsLastDrop.yes ||
        triggerAsLastDrop == TriggerAsLastDrop.partly) {
      addAll(const [
        'notice_load_before_trigger',
        'protect_small_buffer',
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
