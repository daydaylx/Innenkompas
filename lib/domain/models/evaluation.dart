import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:innenkompass/core/constants/system_states.dart';

/// Ergebnis der regelbasierten Sofort-Auswertung.
class EvaluationResult {
  const EvaluationResult({
    required this.systemState,
    required this.headlineKey,
    required this.meaningKey,
    required this.suggestedTipIds,
    required this.suggestedNextActionKey,
    required this.nextActionOptions,
  });

  final SystemState systemState;
  final String headlineKey;
  final String meaningKey;
  final List<String> suggestedTipIds;
  final String suggestedNextActionKey;
  final List<String> nextActionOptions;
}

/// Inhaltspaket für Auswertungscopy und Tipps aus lokalen Assets.
class EvaluationContentBundle {
  const EvaluationContentBundle({
    required this.headlines,
    required this.meanings,
    required this.nextActions,
    required this.tips,
  });

  final Map<String, String> headlines;
  final Map<String, String> meanings;
  final Map<String, String> nextActions;
  final Map<String, String> tips;

  String headlineFor(String key) => headlines[key] ?? key;
  String meaningFor(String key) => meanings[key] ?? key;
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
        headlines: Map<String, String>.from(
          copyJson['headlines'] as Map<String, dynamic>,
        ),
        meanings: Map<String, String>.from(
          copyJson['meanings'] as Map<String, dynamic>,
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
    headlines: {
      'acute_activation_high_tension':
          'Hohe Belastung und starker Handlungsdruck',
      'acute_activation_withdrawal':
          'Hohe Belastung mit starkem Rückzugsimpuls',
      'rumination_loop': 'Kreisende Gedanken ohne echte Klärung',
      'conflict_impulse': 'Konflikt mit schneller Reaktionsneigung',
      'self_devaluation_load': 'Belastung mit starker Selbstbewertung',
      'overwhelm_pressure': 'Viel Druck und zu viel gleichzeitig',
      'interpretation_uncertain_facts':
          'Starke Deutung bei noch unsicherer Faktenlage',
      'reflective_ready': 'Die Situation ist belastend, aber einordnbar',
      'crisis_support': 'Sehr hohe Belastung mit Bedarf nach sofortiger Stabilisierung',
    },
    meanings: {
      'acute_activation_alarm':
          'Dein Körper war vermutlich schneller als die sachliche Einordnung.',
      'rumination_clarifying':
          'Der Eintrag wirkt eher wie eine Denkschleife als wie eine Klärung.',
      'conflict_loaded':
          'Die Situation wirkt konfliktgeladen und impulsanfällig.',
      'self_devaluation_connected':
          'Die Belastung scheint stark mit Selbstbewertung verbunden.',
      'overwhelm_not_unsolvable':
          'Die Situation wirkt eher überfordernd als unlösbar.',
      'interpretation_not_certain':
          'Vieles daran klingt gerade eher nach Annahme als nach gesichertem Fakt.',
      'reflective_ready_accessible':
          'Du scheinst noch gut erreichbar für einen ruhigen nächsten Schritt zu sein.',
      'crisis_regulate_first':
          'Gerade zählt zuerst Stabilisierung und Unterstützung, nicht tiefe Analyse.',
    },
    nextActions: {
      'pause_now': 'Jetzt kurz Abstand schaffen.',
      'regulate_body_first': 'Erst den Körper beruhigen, dann weiterdenken.',
      'do_not_reply_now': 'Nicht im ersten Impuls antworten.',
      'address_later': 'Das Thema später ruhiger ansprechen.',
      'write_observation_first': 'Erst den sachlichen Kern notieren.',
      'check_facts_first': 'Fakten sammeln, bevor du weiter deutest.',
      'write_alternative_view': 'Eine alternative Erklärung aufschreiben.',
      'limit_thinking_loop': 'Die Denkschleife bewusst begrenzen.',
      'choose_one_step': 'Nur einen kleinen nächsten Schritt festlegen.',
      'reduce_stimuli': 'Reize reduzieren, bevor du planst.',
      'collect_counterevidence': 'Gegenbelege sammeln, bevor du dich bewertest.',
      'seek_support_now': 'Jetzt Unterstützung oder sichere Begleitung holen.',
    },
    tips: {
      'check_facts_not_assumptions':
          'Prüfe, ob du gerade Annahmen statt Fakten nutzt.',
      'write_alternative_explanation':
          'Formuliere eine alternative Erklärung.',
      'avoid_rechecking': 'Vermeide impulsives Nachkontrollieren.',
      'regulate_body_before_analysis':
          'Reguliere erst den Körper, bevor du weiter analysierst.',
      'do_not_react_first_impulse': 'Reagiere nicht im ersten Impuls.',
      'separate_criticism_from_value':
          'Trenne Kritik von persönlicher Abwertung.',
      'write_objective_observation':
          'Schreibe erst auf, was objektiv passiert ist.',
      'speak_later_in_observations':
          'Sprich später in Beobachtungen statt Vorwürfen.',
      'check_if_problem_solvable':
          'Prüfe, ob das Problem gerade lösbar ist.',
      'choose_next_step': 'Wenn ja: wähle einen nächsten Schritt.',
      'limit_loop': 'Wenn nein: begrenze die Denkschleife bewusst.',
      'repetition_not_clarity':
          'Wiederholung ist nicht automatisch Klärung.',
      'not_everything_at_once': 'Nicht alles gleichzeitig lösen.',
      'reduce_stimuli_then_plan': 'Erst Reize reduzieren, dann planen.',
      'more_analysis_not_solution':
          'Wenn alles zu viel ist, ist mehr Analyse oft nicht die Lösung.',
      'separate_error_from_selfworth': 'Trenne Fehler von Selbstwert.',
      'check_counterevidence': 'Prüfe Gegenbelege.',
      'write_more_realistic_alternative':
          'Formuliere eine realistischere Alternative.',
      'would_you_talk_same_way':
          'Würdest du mit einer anderen Person genauso sprechen?',
      'separate_observation_from_assumption':
          'Trenne Beobachtung und Unterstellung.',
      'move_conversation_if_needed':
          'Wenn nötig: Gespräch verschieben, statt eskalieren.',
      'get_support_now': 'Hole dir jetzt Unterstützung und bleibe nicht allein.',
    },
  );
}
