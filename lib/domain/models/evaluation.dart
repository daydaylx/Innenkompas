import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:innenkompass/core/constants/system_states.dart';

class EvaluationResult {
  const EvaluationResult({
    required this.systemState,
    required this.whatStandsOutKey,
    required this.whatMayBeBehindItKey,
    required this.helpfulNowKey,
    required this.learningPointKey,
    required this.statusKeys,
    required this.suggestedTipIds,
    required this.suggestedNextActionKey,
    required this.nextActionOptions,
  });

  final SystemState systemState;
  final String whatStandsOutKey;
  final String whatMayBeBehindItKey;
  final String helpfulNowKey;
  final String learningPointKey;
  final List<String> statusKeys;
  final List<String> suggestedTipIds;
  final String suggestedNextActionKey;
  final List<String> nextActionOptions;
}

class EvaluationContentBundle {
  const EvaluationContentBundle({
    required this.standOut,
    required this.background,
    required this.helpfulNow,
    required this.learningPoints,
    required this.statusLabels,
    required this.nextActions,
    required this.tips,
  });

  final Map<String, String> standOut;
  final Map<String, String> background;
  final Map<String, String> helpfulNow;
  final Map<String, String> learningPoints;
  final Map<String, String> statusLabels;
  final Map<String, String> nextActions;
  final Map<String, String> tips;

  String standOutFor(String key) => standOut[key] ?? key;
  String backgroundFor(String key) => background[key] ?? key;
  String helpfulNowFor(String key) => helpfulNow[key] ?? key;
  String learningPointFor(String key) => learningPoints[key] ?? key;
  String statusLabelFor(String key) => statusLabels[key] ?? key;
  String nextActionFor(String key) => nextActions[key] ?? key;
  String tipFor(String key) => tips[key] ?? key;

  static Future<EvaluationContentBundle> load() async {
    try {
      final copyRaw =
          await rootBundle.loadString('assets/content/evaluation_copy.de.json');
      final tipsRaw =
          await rootBundle.loadString('assets/content/tips.de.json');
      final copyJson = jsonDecode(copyRaw) as Map<String, dynamic>;
      final tipsJson = jsonDecode(tipsRaw) as Map<String, dynamic>;

      return EvaluationContentBundle(
        standOut: Map<String, String>.from(
          copyJson['standOut'] as Map<String, dynamic>,
        ),
        background: Map<String, String>.from(
          copyJson['background'] as Map<String, dynamic>,
        ),
        helpfulNow: Map<String, String>.from(
          copyJson['helpfulNow'] as Map<String, dynamic>,
        ),
        learningPoints: Map<String, String>.from(
          copyJson['learningPoints'] as Map<String, dynamic>,
        ),
        statusLabels: Map<String, String>.from(
          copyJson['statusLabels'] as Map<String, dynamic>,
        ),
        nextActions: Map<String, String>.from(
          copyJson['nextActions'] as Map<String, dynamic>,
        ),
        tips: Map<String, String>.from(
          tipsJson['tips'] as Map<String, dynamic>,
        ),
      );
    } catch (_) {
      return fallback;
    }
  }

  static const EvaluationContentBundle fallback = EvaluationContentBundle(
    standOut: {
      'high_tension_body_fast': 'Dein System war stark unter Spannung.',
      'small_trigger_big_load':
          'Der Auslöser wirkt eher wie der letzte Tropfen als wie das ganze Thema.',
      'thought_spiral_active':
          'Neben dem Auslöser lief schon viel innere Vorbeschäftigung.',
      'automatic_reaction_fast':
          'Zwischen Auslöser und Reaktion war wenig innerer Puffer.',
      'conflict_pattern_visible':
          'Die Situation zeigt ein klares Konflikt- oder Schutzmuster.',
      'reflection_reachable':
          'Die Situation ist belastend, aber noch gut einordbar.',
      'safety_relevant_signal':
          'Die Belastung wirkt gerade sicherheitsrelevant.',
    },
    background: {
      'background_pressure_already_high':
          'Wahrscheinlich war die innere Belastung schon vorher erhöht.',
      'background_need_hit':
          'Es scheint weniger nur um den Anlass zu gehen, sondern um etwas, das in dir getroffen wurde.',
      'background_interpretation':
          'Ein Teil des Drucks kommt vermutlich aus Deutung, Befürchtung oder innerem Vorausdenken.',
      'background_control':
          'Kontrolle, Leistungsdruck oder Verantwortung könnten hier mit hineinspielen.',
      'background_conflict':
          'Respekt, Grenzen oder Gesehenwerden wirken hier als mögliches Hintergrundthema.',
      'background_unknown':
          'Das eigentliche Thema dahinter ist noch nicht ganz klar, aber es wirkt größer als der Auslöser allein.',
      'background_safety_first':
          'Im Moment ist nicht entscheidend, alles zu verstehen, sondern erst wieder etwas Stabilität zu bekommen.',
    },
    helpfulNow: {
      'helpful_stabilize_body':
          'Gerade ist Stabilisierung hilfreicher als weiteres Analysieren.',
      'helpful_reduce_input':
          'Weniger Reize und mehr Abstand wären jetzt wahrscheinlich hilfreicher als weitere Klärung.',
      'helpful_pause_before_contact':
          'Nicht sofort reagieren ist gerade hilfreicher als das Thema direkt weiterzutreiben.',
      'helpful_name_facts':
          'Zuerst den sachlichen Kern zu sortieren wäre gerade hilfreicher als weiterzudenken.',
      'helpful_choose_small_step':
          'Ein kleiner nächster Schritt ist jetzt hilfreicher als die ganze Situation auf einmal lösen zu wollen.',
      'helpful_seek_support':
          'Sich Unterstützung zu holen ist jetzt hilfreicher, als allein weiterzudrücken.',
    },
    learningPoints: {
      'learning_before_trigger':
          'Der früheste Abzweig lag wahrscheinlich schon vor dem Auslöser, bei der Vorbelastung.',
      'learning_notice_body_first':
          'Der früheste merkbare Punkt war wahrscheinlich im Körper und nicht erst im Verhalten.',
      'learning_name_automatic_thought':
          'Ein früher Abzweig könnte sein, den ersten Gedanken schneller als Deutung zu erkennen.',
      'learning_interrupt_pattern':
          'Wenn du das Muster früher bemerkst, reicht oft schon ein kleiner Bruch statt perfektes Verhalten.',
      'learning_build_pause':
          'Mehr Puffer zwischen Reiz und Reaktion wäre hier vermutlich der hilfreichste Lernpunkt.',
      'learning_stabilize_not_solve':
          'In sehr geladenen Momenten ist erst beruhigen oft der sinnvollere Abzweig als lösen.',
    },
    statusLabels: {
      'high_tension': 'Hohe Anspannung',
      'acute_escalation': 'Akute Eskalation',
      'safety_relevant_moment': 'Sicherheitsrelevanter Moment',
      'strong_inner_pressure': 'Starker innerer Druck',
      'reflection_limited': 'Reflexion gerade nur eingeschränkt sinnvoll',
      'stabilize_before_analysis': 'Erst Stabilisierung, dann Analyse',
    },
    nextActions: {
      'pause_now': 'Jetzt kurz stoppen und Abstand schaffen.',
      'regulate_body_first': 'Erst den Körper beruhigen, dann weiterdenken.',
      'do_not_reply_now': 'Gerade nicht im ersten Impuls reagieren.',
      'address_later': 'Das Thema später ruhiger ansprechen.',
      'write_observation_first': 'Erst notieren, was konkret passiert ist.',
      'check_facts_first': 'Fakten sortieren, bevor du weiter deutest.',
      'write_alternative_view': 'Eine realistischere Sicht dazuschreiben.',
      'limit_thinking_loop': 'Die Gedankenspirale bewusst begrenzen.',
      'choose_one_step': 'Nur den kleinsten nächsten Schritt festlegen.',
      'reduce_stimuli': 'Reize und Input erst einmal reduzieren.',
      'collect_counterevidence':
          'Gegenbelege sammeln, bevor du dich bewertest.',
      'seek_support_now':
          'Jetzt eine sichere Person oder Unterstützung einbeziehen.',
    },
    tips: {
      'check_facts_not_assumptions':
          'Prüfe, ob du gerade Annahmen statt Beobachtungen nutzt.',
      'write_alternative_explanation':
          'Schreibe eine zweite, weniger harte Erklärung daneben.',
      'avoid_rechecking':
          'Nicht immer wieder neu prüfen oder nachkontrollieren.',
      'regulate_body_before_analysis':
          'Beruhige erst den Körper, bevor du tiefer analysierst.',
      'do_not_react_first_impulse': 'Nicht auf den allerersten Impuls handeln.',
      'separate_criticism_from_value':
          'Trenne Kritik oder Fehler von deinem persönlichen Wert.',
      'write_objective_observation':
          'Halte erst den beobachtbaren Kern der Situation fest.',
      'speak_later_in_observations':
          'Wenn du später sprichst, bleib bei Beobachtung statt Vorwurf.',
      'check_if_problem_solvable':
          'Prüfe, ob heute überhaupt Klärung dran ist oder erst Entlastung.',
      'choose_next_step':
          'Lege nur den kleinsten sinnvollen nächsten Schritt fest.',
      'limit_loop': 'Setze der Denkschleife bewusst eine Grenze.',
      'repetition_not_clarity':
          'Mehr darüber nachdenken ist nicht automatisch mehr Klarheit.',
      'not_everything_at_once': 'Nicht alles gleichzeitig lösen wollen.',
      'reduce_stimuli_then_plan': 'Erst Reize runter, dann planen.',
      'more_analysis_not_solution':
          'Wenn alles zu viel ist, hilft oft weniger Analyse und mehr Regulation.',
      'separate_error_from_selfworth':
          'Ein Fehler sagt nicht alles über dich aus.',
      'check_counterevidence':
          'Suche aktiv nach Gegenbelegen zu deinem härtesten Gedanken.',
      'write_more_realistic_alternative':
          'Formuliere eine realistischere Alternative zum ersten Gedanken.',
      'would_you_talk_same_way':
          'Würdest du mit jemand anderem genauso hart sprechen?',
      'separate_observation_from_assumption':
          'Trenne, was passiert ist, von dem, was du hineinliest.',
      'move_conversation_if_needed':
          'Wenn nötig, verschiebe das Gespräch statt weiter hochzufahren.',
      'get_support_now':
          'Bleib damit gerade nicht allein und hole dir Unterstützung.',
    },
  );
}
