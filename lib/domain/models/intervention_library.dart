import 'package:innenkompass/core/constants/content_license_tags.dart';
import 'package:innenkompass/core/constants/emotion_types.dart';
import 'package:innenkompass/core/constants/intervention_types.dart'
    show InterventionType;
import 'package:innenkompass/core/constants/system_states.dart';
import 'package:innenkompass/domain/models/intervention.dart';
import 'package:innenkompass/domain/models/intervention_step.dart';

/// Statische Bibliothek aller verfügbaren Interventionen
///
/// Enthält 7+ Interventionen gemäß MVP-Spezifikation:
/// 1. Regulation (4/6-Atmung, Erdung, Reorientierung, Impulspause)
/// 2. Fakt-vs-Deutung
/// 3. Impulspause
/// 4. Grübelunterbrechung
/// 5. Kommunikationshilfe
/// 6. Überforderungsstruktur
/// 7. Selbstabwertungscheck
class InterventionLibrary {
  static const ContentLicenseTag _defaultLicenseTag =
      ContentLicenseTag.originalInspiredNoCopy;
  static const String _commonLicenseNotes =
      'Eigene Formulierungen auf Basis etablierter Selbsthilfe- und Therapiekonzepte.';
  static const String _worksheetLicenseNotes =
      'Eigene Feldlogik und eigene Formulierungen; kein kopierter Wortlaut aus geschütztem Material.';

  // ============================================
  // REGULATION INTERVENTIONEN
  // ============================================

  /// 4-6-8 Atmung: Beruhigende Atemübung
  static const Intervention regulation4_6Breathing = Intervention(
    id: 'regulation_4_6_breathing',
    type: InterventionType.regulation,
    title: '4-6-8 Atmung',
    summary: 'Beruhigende Atemübung zur sofortigen Regulation',
    description:
        'Diese Atemübung aktiviert dein parasympathisches Nervensystem und hilft dir, dich schnell zu beruhigen.',
    steps: [
      InterventionStep(
        id: 'intro',
        type: InterventionStepType.text,
        title: 'Willkommen',
        body:
            'Diese Übung hilft dir, dein Nervensystem zu beruhigen. Du wirst 4 Sekunden einatmen, die Luft 6 Sekunden halten und 8 Sekunden ausatmen.',
        subtitle: 'Dauer: ca. 3-5 Minuten',
        helpText:
            'Finde eine bequeme Position. Du kannst sitzen oder stehen, wie es für dich passt.',
      ),
      InterventionStep(
        id: 'instruction',
        type: InterventionStepType.action,
        title: 'Vorbereitung',
        body:
            'Lege eine Hand auf deinen Bauch. Spüre wie sich dein Bauch beim Einatmen hebt und beim Ausatmen senkt.',
        helpText:
            'Atme durch die Nase ein und durch den Mund aus. Wenn du möchtest, kannst du auch durch die Nase ausatmen.',
      ),
      InterventionStep(
        id: 'breathing',
        type: InterventionStepType.breathing,
        title: '4-6-8 Atmung',
        body:
            'Folge der Animation und atme im Rhythmus: 4 Sekunden ein, 6 Sekunden halten, 8 Sekunden ausatmen.',
        durationSec: 180,
        metadata: {
          'inhale_duration': 4,
          'hold_duration': 6,
          'exhale_duration': 8,
          'cycles': 6,
        },
        helpText:
            'Wenn du schwindlig wirst, mache eine Pause und atme normal weiter.',
      ),
      InterventionStep(
        id: 'reflection',
        type: InterventionStepType.reflection,
        title: 'Wie fühlst du dich jetzt?',
        body:
            'Nimm dir einen Moment, um zu spüren, wie sich dein Körper jetzt anfühlt.',
        subtitle: 'Was hast du bemerkt?',
        helpText: 'Schreibe ein paar Worte darüber, was sich verändert hat.',
      ),
    ],
    estimatedDurationSec: 240,
    recommendedForStates: [
      SystemState.acuteActivation,
      SystemState.overwhelm,
      SystemState.conflict,
    ],
    recommendedForEmotions: [
      EmotionType.anger,
      EmotionType.fear,
      EmotionType.sadness,
      EmotionType.disgust,
    ],
    minIntensity: 5,
    icon: '🌬️',
    category: 'Regulation',
    difficultyLevel: 1,
    licenseTag: _defaultLicenseTag,
    licenseNotes: _commonLicenseNotes,
  );

  /// Erdungsübung: 5-4-3-2-1 Technik
  static const Intervention groundingExercise = Intervention(
    id: 'grounding_5_4_3_2_1',
    type: InterventionType.regulation,
    title: '5-4-3-2-1 Erdung',
    summary: 'Sinnesschärfung zur Reorientierung im Hier und Jetzt',
    description:
        'Diese Technik hilft dir, dich im Moment zu erden, wenn du dich überwältigt fühlst oder Gedanken kreisen.',
    steps: [
      InterventionStep(
        id: 'intro',
        type: InterventionStepType.text,
        title: 'Erdungsübung',
        body:
            'Diese Technik hilft dir, deinen Fokus von inneren Gedanken auf die äußere Welt zu verlagern.',
        subtitle: 'Dauer: ca. 5 Minuten',
        helpText:
            'Du kannst diese Übung überall durchführen - im Sitzen, Stehen oder Liegen.',
      ),
      InterventionStep(
        id: 'step_5',
        type: InterventionStepType.action,
        title: '5 Dinge die du sehen kannst',
        body: 'Schau dich um und nenne 5 Dinge, die du gerade sehen kannst.',
        subtitle: 'Nenne sie laut oder in Gedanken',
        helpText:
            'Sei genau - beschreibe Farbe, Form, Position. Zum Beispiel: Ich sehe einen blauen Stuhl, eine grüne Pflanze, ein weißes Papier...',
      ),
      InterventionStep(
        id: 'step_4',
        type: InterventionStepType.action,
        title: '4 Dinge die du berühren kannst',
        body:
            'Spüre 4 Dinge, die du berühren kannst. Nimm dir Zeit, wirklich zu fühlen.',
        subtitle: 'Spüre Textur, Temperatur',
        helpText:
            'Zum Beispiel: Die glatte Oberfläche des Tisches, die weiche Stoffbeschaffenheit deiner Kleidung, die warme Luft auf deiner Haut...',
      ),
      InterventionStep(
        id: 'step_3',
        type: InterventionStepType.action,
        title: '3 Dinge die du hören kannst',
        body: 'Höre genau hin. Nenne 3 Geräusche, die du gerade wahrnimmst.',
        subtitle: 'Nahe und ferne Geräusche',
        helpText:
            'Zum Beispiel: Das Summen des Kühlschranks, Vögel draußen, dein eigenes Atmen, Wind, Stimmen...',
      ),
      InterventionStep(
        id: 'step_2',
        type: InterventionStepType.action,
        title: '2 Dinge die du riechen kannst',
        body:
            'Was kannst du riechen? Wenn nichts offensichtlich ist, denke an deine Lieblingsdüfte.',
        subtitle: 'Oder: 2 Dinge die du schmecken kannst',
        helpText:
            'Wenn du gerade nichts riechen kannst, erinnere dich an zwei Gerüche, die dir gut gefallen.',
      ),
      InterventionStep(
        id: 'step_1',
        type: InterventionStepType.action,
        title: '1 Ding das du spürst',
        body:
            'Was spürst du gerade in deinem Körper? Wo hast du Spannung, wo Entspannung?',
        subtitle: 'Einziges positives Gefühl',
        helpText:
            'Zum Beispiel: Ich spüre Wärme in meinen Händen, mein Bauch hebt und senkt sich beim Atmen...',
      ),
      InterventionStep(
        id: 'reflection',
        type: InterventionStepType.reflection,
        title: 'Ankommen',
        body:
            'Nimm einen Moment, um zu spüren, wie sich deine Wahrnehmung jetzt verändert hat.',
        helpText: 'Bist du mehr im Hier und Jetzt angekommen?',
      ),
    ],
    estimatedDurationSec: 300,
    recommendedForStates: [
      SystemState.rumination,
      SystemState.overwhelm,
      SystemState.reflectiveReady,
    ],
    recommendedForEmotions: [
      EmotionType.fear,
      EmotionType.sadness,
      EmotionType.shame,
      EmotionType.guilt,
    ],
    minIntensity: 4,
    icon: '🧘',
    category: 'Regulation',
    difficultyLevel: 1,
    licenseTag: _defaultLicenseTag,
    licenseNotes: _commonLicenseNotes,
  );

  /// Impulspause: STOP-Technik
  static const Intervention impulsePause = Intervention(
    id: 'impulse_pause_stop',
    type: InterventionType.impulsePause,
    title: 'STOP - Impulspause',
    summary: 'Unterbreche impulsive Handlungen',
    description:
        'Die STOP-Technik hilft dir, zwischen Reiz und Reaktion eine bewusste Pause einzufügen.',
    steps: [
      InterventionStep(
        id: 'intro',
        type: InterventionStepType.text,
        title: 'STOP Methode',
        body:
            'Wenn du spürst, dass du impulsiv handeln willst, gib dir selbst den Befehl: STOPP!',
        subtitle: 'Dauer: ca. 2-3 Minuten',
        helpText:
            'Diese kurze Pause kann verhindern, dass du etwas tust, die du später bereust.',
      ),
      InterventionStep(
        id: 'step_s',
        type: InterventionStepType.action,
        title: 'S - Stoppen',
        body:
            'Halte sofort an. Was auch immer du gerade tun wolltest - unterbrich es.',
        subtitle: 'Machen Sie körperlich still',
        helpText:
            'Steh still, setz dich, oder leg die Hände in den Schoß. Unterbrich jede Bewegung.',
      ),
      InterventionStep(
        id: 'step_t',
        type: InterventionStepType.action,
        title: 'T - Tief atmen',
        body: 'Nimm 3 tiefe Atemzüge. Atme langsam ein und langsam aus.',
        subtitle: '4 Sekunden ein, 6 Sekunden aus',
        helpText:
            'Spüre wie die Luft in deine Lungen strömt und wieder entweicht.',
      ),
      InterventionStep(
        id: 'step_o',
        type: InterventionStepType.reflection,
        title: 'O - Observieren',
        body:
            'Beobachte was in dir vorgeht. Welche Emotionen spürst du? Welche Gedanken?',
        subtitle: 'Benenne es ohne Bewertung',
        helpText:
            'Zum Beispiel: Ich spüre Wut in meiner Brust. Ich habe den Gedanken, dass ich ungerecht behandelt wurde.',
      ),
      InterventionStep(
        id: 'step_p',
        type: InterventionStepType.reflection,
        title: 'P - Proaktiv entscheiden',
        body:
            'Welche Handlungsmöglichkeiten hast du? Was entspricht deinen Werten?',
        subtitle: 'Wähle bewusst',
        helpText:
            'Zum Beispiel: Ich könnte mich wegstürzen, eine Pause machen, oder ruhig antworten.',
      ),
      InterventionStep(
        id: 'decision',
        type: InterventionStepType.selection,
        title: 'Entscheidung',
        body: 'Was möchtest du jetzt tun?',
        options: [
          'Ich nehme mir eine Pause',
          'Ich handle anders als geplant',
          'Ich suche Unterstützung',
          'Ich brauche noch Zeit',
        ],
      ),
    ],
    estimatedDurationSec: 120,
    recommendedForStates: [
      SystemState.acuteActivation,
      SystemState.conflict,
    ],
    recommendedForEmotions: [
      EmotionType.anger,
      EmotionType.disgust,
      EmotionType.fear,
    ],
    minIntensity: 6,
    icon: '🛑',
    category: 'Impulskontrolle',
    difficultyLevel: 2,
    licenseTag: _defaultLicenseTag,
    licenseNotes: _commonLicenseNotes,
  );

  // ============================================
  // KOGNITIVE INTERVENTIONEN
  // ============================================

  /// Fakt-vs-Deutung Analyse
  static const Intervention factCheck = Intervention(
    id: 'fact_check_basic',
    type: InterventionType.factCheck,
    title: 'Fakt vs. Deutung',
    summary: 'Unterscheide objektive Fakten von Interpretationen',
    description:
        'Hilft dir, automatische Gedanken zu hinterfragen und realistischere Perspektiven zu entwickeln.',
    steps: [
      InterventionStep(
        id: 'intro',
        type: InterventionStepType.text,
        title: 'Fakt vs. Deutung',
        body:
            'Oft vermischen wir objektive Fakten mit unseren Interpretationen. Diese Übung hilft dir, beides zu trennen.',
        subtitle: 'Dauer: ca. 5-7 Minuten',
        helpText:
            'Fakten sind objektiv überprüfbar. Deutungen sind subjektive Interpretationen.',
      ),
      InterventionStep(
        id: 'situation',
        type: InterventionStepType.reflection,
        title: 'Was ist passiert?',
        body:
            'Beschreibe die Situation kurz und objektiv, als würdest du eine Kameraaufnahme beschreiben.',
        helpText:
            'Vermeide Bewertungen. Statt "Er war aggressiv" schreibe "Er hat laut gesprochen und die Hand auf den Tisch geschlagen."',
      ),
      InterventionStep(
        id: 'thought',
        type: InterventionStepType.reflection,
        title: 'Was hast du gedacht?',
        body: 'Welcher automatische Gedanke ist dir gekommen?',
        helpText:
            'Zum Beispiel: Er mag mich nicht mehr. Ich bin wertlos. Niemand respektiert mich.',
      ),
      InterventionStep(
        id: 'fact_check',
        type: InterventionStepType.factCheck,
        title: 'Fakten-Check',
        body:
            'Untersuche deinen Gedanken: Welche Teile sind objektive Fakten, welche sind Interpretationen?',
        metadata: {
          'fact_fields': ['Was ist objektiv überprüfbar?'],
          'interpretation_fields': [
            'Was ist deine Interpretation?',
            'Was könnte auch anders interpretiert werden?'
          ],
        },
        helpText:
            'Fakten: "Er hat nicht geantwortet." Deutung: "Er ignoriert mich."',
      ),
      InterventionStep(
        id: 'alternatives',
        type: InterventionStepType.reflection,
        title: 'Alternativen',
        body: 'Welche anderen Erklärungen sind möglich?',
        subtitle: 'Mindestens 2 alternative Perspektiven',
        helpText:
            'Zum Beispiel: Er hat vielleicht mein Handy nicht gehört. Er war beschäftigt. Er musste dringend weg.',
      ),
      InterventionStep(
        id: 'balance',
        type: InterventionStepType.reflection,
        title: 'Ausgewogene Sicht',
        body: 'Wie könntest du die Situation jetzt realistischer sehen?',
        helpText:
            'Formuliere einen Gedanken, der die Fakten berücksichtigt und nicht so verletzend ist.',
      ),
    ],
    estimatedDurationSec: 360,
    recommendedForStates: [
      SystemState.rumination,
      SystemState.selfDevaluation,
      SystemState.interpretation,
      SystemState.reflectiveReady,
    ],
    recommendedForEmotions: [
      EmotionType.shame,
      EmotionType.guilt,
      EmotionType.sadness,
      EmotionType.fear,
    ],
    minIntensity: 3,
    icon: '⚖️',
    category: 'Kognitiv',
    difficultyLevel: 3,
    licenseTag: _defaultLicenseTag,
    licenseNotes: _commonLicenseNotes,
  );

  /// Grübelstopp
  static const Intervention ruminationStop = Intervention(
    id: 'rumination_stop',
    type: InterventionType.ruminationStop,
    title: 'Grübelstopp',
    summary: 'Unterbriche endlose Gedankenschleifen',
    description:
        'Wenn Gedanken kreisen und dich nicht loslassen, hilft diese Technik, die Schleife zu durchbrechen.',
    steps: [
      InterventionStep(
        id: 'intro',
        type: InterventionStepType.text,
        title: 'Grübelstopp',
        body:
            'Grübeln sind Gedanken, die immer wiederkehren, ohne zu einer Lösung zu führen. Diese Übung hilft, sie zu unterbrechen.',
        subtitle: 'Dauer: ca. 3-5 Minuten',
        helpText: 'Grübeln kostet Energie und verschlimmert oft die Stimmung.',
      ),
      InterventionStep(
        id: 'detect',
        type: InterventionStepType.action,
        title: 'Erkennen',
        body:
            'Bist du gerade am Grübeln? Hier sind Anzeichen: Die gleichen Gedanken kreisen seit mindestens 10 Minuten, du fühlst dich erschöpft, du kommst nicht auf einen grünen Zweig.',
        subtitle: 'Wenn ja, dann mach weiter',
      ),
      InterventionStep(
        id: 'stop_command',
        type: InterventionStepType.action,
        title: 'Stopp-Befehl',
        body:
            'Sage dir laut oder in Gedanken: STOPP! Du kannst auch eine Geste machen, zum Beispiel in die Hände klatschen.',
        helpText:
            'Dieser physische oder mentale "Knall" unterbricht die Gedankenschleife.',
      ),
      InterventionStep(
        id: 'shift_focus',
        type: InterventionStepType.action,
        title: 'Fokus verlagern',
        body:
            'Verlagere deine Aufmerksamkeit sofort auf etwas anderes in deiner Umgebung.',
        subtitle: '5-4-3-2-1 Technik',
        helpText:
            'Benenne 5 Dinge die du siehst, 4 die du berühren kannst, 3 die du hörst, 2 die du riechst, 1 das du schmeckst.',
      ),
      InterventionStep(
        id: 'activity',
        type: InterventionStepType.selection,
        title: 'Aktivität wählen',
        body: 'Wähle eine Tätigkeit, die deine Aufmerksamkeit erfordert:',
        options: [
          'Spazieren gehen',
          'Musik hören',
          'Ein kurzes Video ansehen',
          'Etwas aufräumen',
          'Kreatives Tun',
          'Sport/Bewegung',
        ],
        helpText:
            'Wichtig: Die Tätigkeit sollte deine Aufmerksamkeit erfordern, nicht passiv sein.',
      ),
      InterventionStep(
        id: 'plan',
        type: InterventionStepType.reflection,
        title: 'Feste Denkzeit',
        body:
            'Wenn das Thema wichtig ist, plane eine feste Zeit zum Nachdenken ein (z.B. 15 Minuten heute Abend).',
        helpText:
            'Wenn das Gedanken wiederkehrt, erinnere dich: Ich darüber später nachdenken - jetzt nicht.',
      ),
    ],
    estimatedDurationSec: 180,
    recommendedForStates: [
      SystemState.rumination,
      SystemState.reflectiveReady,
    ],
    recommendedForEmotions: [
      EmotionType.fear,
      EmotionType.sadness,
      EmotionType.shame,
      EmotionType.guilt,
    ],
    minIntensity: 4,
    icon: '🛑',
    category: 'Grübelmanagement',
    difficultyLevel: 2,
    licenseTag: _defaultLicenseTag,
    licenseNotes: _commonLicenseNotes,
  );

  // ============================================
  // KOMMUNIKATION
  // ============================================

  /// Kommunikationshilfe
  static const Intervention communicationHelp = Intervention(
    id: 'communication_help',
    type: InterventionType.communication,
    title: 'Ich-Botschaften formulieren',
    summary: 'Konstruktiv kommunizieren in Konfliktsituationen',
    description:
        'Lerne, deine Bedürfnisse und Gefühle klar und nicht vorwurfsvoll auszudrücken.',
    steps: [
      InterventionStep(
        id: 'intro',
        type: InterventionStepType.text,
        title: 'Ich-Botschaften',
        body:
            'Ich-Botschaften helfen, Konflikte konstruktiv zu lösen, ohne den anderen anzugreifen.',
        subtitle: 'Dauer: ca. 5 Minuten',
        helpText:
            'Du-Botschaften (z.B. "Du hörst mir nie zu") erzeugen Verteidigung. Ich-Botschaften laden zum Verständnis ein.',
      ),
      InterventionStep(
        id: 'structure',
        type: InterventionStepType.text,
        title: 'Die 4-Schritte-Formel',
        body: '''1. Beschreibe die Situation objektiv
2. Benenne dein Gefühl
3. Erkläre die Auswirkung auf dich
4. Mache einen konkreten Vorschlag''',
        subtitle: 'N = Nachricht, die ankommt',
      ),
      InterventionStep(
        id: 'situation',
        type: InterventionStepType.reflection,
        title: 'Schritt 1: Situation',
        body: 'Was ist objektiv passiert? Beschreibe ohne Bewertung.',
        helpText: 'Statt "Du hast geschrien" → "Du hast laut gesprochen"',
      ),
      InterventionStep(
        id: 'feeling',
        type: InterventionStepType.reflection,
        title: 'Schritt 2: Gefühl',
        body: 'Was hast du gefühlt?',
        helpText:
            'Ich fühle mich... verletzt/ängstlich/überfordert/unsicher...',
      ),
      InterventionStep(
        id: 'impact',
        type: InterventionStepType.reflection,
        title: 'Schritt 3: Auswirkung',
        body: 'Was bewirkt das bei mir?',
        helpText:
            'Wenn du das tust, fühle ich mich... Ich denke dann, dass... Ich kann dann nicht mehr...',
      ),
      InterventionStep(
        id: 'wish',
        type: InterventionStepType.reflection,
        title: 'Schritt 4: Wunsch',
        body: 'Was würdest du dir wünschen?',
        helpText:
            'Ich würde mir wünschen, dass... Es wäre mir hilfreich, wenn...',
      ),
      InterventionStep(
        id: 'assemble',
        type: InterventionStepType.reflection,
        title: 'Zusammensetzen',
        body: 'Setze deine Ich-Botschaft zusammen:',
        helpText:
            'Wenn [Situation], fühle ich mich [Gefühl], weil [Auswirkung]. Ich würde mir wünschen, dass [Wunsch].',
      ),
      InterventionStep(
        id: 'timing',
        type: InterventionStepType.selection,
        title: 'Der richtige Zeitpunkt',
        body: 'Wann möchtest du das Gespräch führen?',
        options: [
          'Jetzt sofort',
          'In einer Stunde',
          'Heute Abend',
          'Morgen',
          'Brauche noch Zeit zum Vorbereiten',
        ],
      ),
    ],
    estimatedDurationSec: 300,
    recommendedForStates: [
      SystemState.conflict,
      SystemState.interpretation,
      SystemState.reflectiveReady,
    ],
    recommendedForEmotions: [
      EmotionType.anger,
      EmotionType.disgust,
      EmotionType.sadness,
      EmotionType.fear,
    ],
    minIntensity: 4,
    icon: '💬',
    category: 'Kommunikation',
    difficultyLevel: 3,
    licenseTag: _defaultLicenseTag,
    licenseNotes: _commonLicenseNotes,
  );

  // ============================================
  // ÜBERFORDERUNG
  // ============================================

  /// Überforderungsstruktur
  static const Intervention overwhelmStructure = Intervention(
    id: 'overwhelm_structure',
    type: InterventionType.overwhelmStructure,
    title: 'Prioritäten setzen',
    summary: 'Strukturieren wenn alles zu viel wird',
    description:
        'Wenn dich alles überwältigt, hilft diese Methode, Klarheit zu schaffen und kleine Schritte zu planen.',
    steps: [
      InterventionStep(
        id: 'intro',
        type: InterventionStepType.text,
        title: 'Überforderung strukturieren',
        body:
            'Wenn alles zu viel wird, hilft es, die Last in kleine, handhabbare Teile zu zerlegen.',
        subtitle: 'Dauer: ca. 5-10 Minuten',
        helpText:
            'Überforderung entsteht, wenn wir versuchen, alles auf einmal zu sehen und zu lösen.',
      ),
      InterventionStep(
        id: 'brain_dump',
        type: InterventionStepType.reflection,
        title: 'Alles aufschreiben',
        body:
            'Schreibe alles auf, was in deinem Kopf ist - Aufgaben, Sorgen, Ideen, Verpflichtungen.',
        helpText:
            'Nicht bewerten, nicht sortieren. Einfach alles raus aus dem Kopf.',
      ),
      InterventionStep(
        id: 'categorize',
        type: InterventionStepType.action,
        title: 'Kategorisieren',
        body:
            'Sortiere deine Liste in 3 Kategorien:\n\n1. MACH ICH JETZT (wichtig und dringend)\n2. PLANE ICH EIN (wichtig aber nicht dringend)\n3. LASS ICH LOS (nicht wichtig oder nicht beeinflussbar)',
        subtitle: 'Sei streng mit Kategorie 3',
        helpText: 'Wenn du dich unsicher bist, kommt es meist in Kategorie 2.',
      ),
      InterventionStep(
        id: 'select_one',
        type: InterventionStepType.action,
        title: 'Eines auswählen',
        body: 'Wähle EINE Sache aus der "MACH ICH JETZT"-Liste aus. Nur eine.',
        helpText:
            'Die Erleichterung beginnt mit der Entscheidung, was du NICHT jetzt tun musst.',
      ),
      InterventionStep(
        id: 'break_down',
        type: InterventionStepType.reflection,
        title: 'In Schritte zerlegen',
        body: 'Zerlege diese eine Aufgabe in die kleinstmöglichen Schritte.',
        helpText: 'Statt "Küche aufräumen" → "Spüler ausräumen" (5 Minuten).',
      ),
      InterventionStep(
        id: 'first_step',
        type: InterventionStepType.action,
        title: 'Erster Schritt',
        body: 'Was ist der allerkleinste Schritt, den du jetzt tun kannst?',
        helpText: 'Dieser Schritt sollte weniger als 2 Minuten dauern.',
      ),
      InterventionStep(
        id: 'timer',
        type: InterventionStepType.timer,
        title: '5 Minuten Fokus',
        body:
            'Setze einen Timer für 5 Minuten und arbeite nur an dieser einen Aufgabe.',
        durationSec: 300,
        helpText:
            'Wenn der Timer klingelt, darfst du aufhören oder 5 Minuten weitermachen.',
      ),
    ],
    estimatedDurationSec: 420,
    recommendedForStates: [
      SystemState.overwhelm,
      SystemState.reflectiveReady,
    ],
    recommendedForEmotions: [
      EmotionType.fear,
      EmotionType.sadness,
      EmotionType.shame,
    ],
    minIntensity: 5,
    icon: '📋',
    category: 'Selbstorganisation',
    difficultyLevel: 2,
    licenseTag: _defaultLicenseTag,
    licenseNotes: _commonLicenseNotes,
  );

  // ============================================
  // SELBSTWERT
  // ============================================

  /// Selbstabwertungscheck
  static const Intervention selfValueCheck = Intervention(
    id: 'self_value_check',
    type: InterventionType.selfValueCheck,
    title: 'Selbstmitgefühl üben',
    summary: 'Gentler mit dir selbst sein',
    description:
        'Wenn du dich selbst kritisiert oder abwertest, hilft diese Übung, Selbstmitgefühl zu entwickeln.',
    steps: [
      InterventionStep(
        id: 'intro',
        type: InterventionStepType.text,
        title: 'Selbstmitgefühl',
        body:
            'Selbstkritik ist oft unsere Automatik-Reaktion. Aber sie verletzt uns und hilft nicht wirklich.',
        subtitle: 'Dauer: ca. 5-7 Minuten',
        helpText:
            'Selbstmitgefühl ist nicht Selbstsucht - es ist die Grundlage für Resilienz.',
      ),
      InterventionStep(
        id: 'notice',
        type: InterventionStepType.action,
        title: 'Bemerken',
        body: 'Wann kritisiert du dich gerade? Welche Worte benutzt du?',
        helpText: 'Hör auf deinen inneren Kritiker. Was sagt er?',
      ),
      InterventionStep(
        id: 'friend_perspective',
        type: InterventionStepType.reflection,
        title: 'Freunde-Perspektive',
        body:
            'Stell dir vor, dein bester Freund wäre in dieser Situation. Was würdest du ihm sagen?',
        helpText:
            'Würdest du ihm die gleichen kritischen Worte sagen, die du dir selbst sagst?',
      ),
      InterventionStep(
        id: 'common_humanity',
        type: InterventionStepType.action,
        title: 'Gemeinsame Menschlichkeit',
        body:
            'Realisiere: Viele andere Menschen fühlen sich genauso in solchen Momenten. Du bist nicht allein.',
        helpText:
            'Fehler, Schwierigkeiten und Schmerz sind Teil des menschlichen Lebens - nicht nur deines.',
      ),
      InterventionStep(
        id: 'kind_words',
        type: InterventionStepType.reflection,
        title: 'Freundliche Worte',
        body: 'Formuliere 3 freundliche Sätze, die du dir selbst sagen kannst:',
        subtitle: 'Als wärst du dein eigener bester Freund',
        helpText:
            'Zum Beispiel: "Es ist okay, so zu fühlen." "Du tuest dein Bestes." "Dies ist ein schwieriger Moment, und er wird vergehen."',
      ),
      InterventionStep(
        id: 'hand_on_heart',
        type: InterventionStepType.action,
        title: 'Geste der Freundlichkeit',
        body: 'Lege eine Hand auf dein Herz. Spüre die Wärme.',
        durationSec: 30,
        helpText:
            'Während du dies tust, wiederhole die freundlichen Sätze für dich selbst.',
      ),
      InterventionStep(
        id: 'commitment',
        type: InterventionStepType.reflection,
        title: 'Vergiss nicht',
        body:
            'In schwierigen Momenten kannst du zu dieser Übung zurückkehren. Du verdienst denselben Freundlichkeit, die du anderen schenkst.',
        helpText:
            'Wie könntest du diese freundliche Haltung in deinem Alltag verankern?',
      ),
    ],
    estimatedDurationSec: 360,
    recommendedForStates: [
      SystemState.selfDevaluation,
      SystemState.rumination,
      SystemState.reflectiveReady,
    ],
    recommendedForEmotions: [
      EmotionType.shame,
      EmotionType.guilt,
      EmotionType.sadness,
    ],
    minIntensity: 3,
    icon: '💙',
    category: 'Selbstwert',
    difficultyLevel: 3,
    licenseTag: _defaultLicenseTag,
    licenseNotes: _commonLicenseNotes,
  );

  // ============================================
  // ARBEITSBLATT-TEMPLATES (konzeptv2neu.md)
  // ============================================

  /// ABC-3 Kurzprotokoll
  ///
  /// Feldlogik: Auslöser (A) → Bewertungen/Gedanken (B) → Konsequenzen (C)
  /// Konsequenzen differenziert in Gefühl, Körper, Verhalten.
  /// Eigene Formulierungen — kein kopierter Wortlaut aus IBT/Kohlhammer.
  static const Intervention abc3Protocol = Intervention(
    id: 'abc3_protocol',
    type: InterventionType.abc3,
    title: 'ABC-3 Kurzprotokoll',
    summary: 'Situation – Gedanken – Konsequenzen strukturiert erfassen',
    description:
        'Das ABC-Modell hilft dir, eine belastende Situation in drei Ebenen aufzugliedern: den Auslöser (A), deine Bewertungen und Gedanken dazu (B) und die Konsequenzen (C) in Gefühl, Körper und Verhalten.',
    steps: [
      InterventionStep(
        id: 'abc3_intro',
        type: InterventionStepType.text,
        title: 'ABC-Modell',
        body:
            'Belastende Situationen enthalten drei Ebenen: den Auslöser (A), deine Gedanken dazu (B) und deine Reaktionen in Gefühl, Körper und Verhalten (C).',
        subtitle: 'Dauer: ca. 5–10 Minuten',
        helpText:
            'Nicht die Situation (A) verursacht deine Reaktion (C) – sondern deine Bewertung (B) vermittelt. Das zu erkennen gibt dir Handlungsspielraum.',
      ),
      InterventionStep(
        id: 'abc3_a_situation',
        type: InterventionStepType.reflection,
        title: 'A – Was ist passiert?',
        body:
            'Beschreibe die Situation kurz und so objektiv wie möglich. Was ist konkret passiert?',
        subtitle: 'Wie eine Kameraaufnahme — ohne Bewertung',
        helpText:
            'Statt „Er war gemein" lieber: „Er hat laut gesprochen und die Tür zugeworfen."',
        metadata: {
          'field_key': 'a.description',
          'max_length': 500,
          'required': true,
        },
      ),
      InterventionStep(
        id: 'abc3_b_beliefs',
        type: InterventionStepType.reflection,
        title: 'B – Welche Gedanken sind aufgetaucht?',
        body:
            'Notiere die Gedanken, die dir in der Situation durch den Kopf gegangen sind.',
        subtitle: 'Mindestens ein Gedanke',
        helpText:
            'Zum Beispiel: „Ich schaffe das nicht." – „Das ist typisch." – „Niemand respektiert mich."',
        metadata: {
          'field_key': 'b.thoughts',
          'min_items': 1,
          'max_items': 10,
          'item_max_length': 200,
          'required': true,
        },
      ),
      InterventionStep(
        id: 'abc3_c1_emotions',
        type: InterventionStepType.selection,
        title: 'C1 – Welche Gefühle hattest du?',
        body: 'Welche Emotion(en) hast du in dieser Situation erlebt?',
        subtitle: 'consequence.emotions[]',
        options: [
          'Angst',
          'Ärger',
          'Traurigkeit',
          'Scham',
          'Schuld',
          'Ekel',
          'Freude',
          'Überraschung',
          'Neutral',
        ],
        helpText: 'Du kannst mehrere Gefühle wählen.',
        metadata: {
          'field_key': 'c.emotions',
          'multi_select': true,
          'with_intensity': true,
          'intensity_range': '0-10',
        },
      ),
      InterventionStep(
        id: 'abc3_c2_body',
        type: InterventionStepType.selection,
        title: 'C2 – Was hast du körperlich gespürt?',
        body: 'Welche Körpersignale hast du in dieser Situation bemerkt?',
        subtitle: 'consequence.body_signals[]',
        options: [
          'Herzrasen',
          'Muskelverspannung',
          'Schwitzen',
          'Druck in der Brust',
          'Enge im Hals',
          'Schwindel',
          'Magengrummeln',
          'Zittern',
          'Erschöpfung',
          'Taubheitsgefühl',
        ],
        helpText:
            'Körpersignale zeigen, wie dein Nervensystem auf die Situation reagiert hat.',
        metadata: {
          'field_key': 'c.body_signals',
          'multi_select': true,
          'with_freetext': true,
        },
      ),
      InterventionStep(
        id: 'abc3_c3_behavior',
        type: InterventionStepType.selection,
        title: 'C3 – Wie hast du reagiert?',
        body: 'Was hast du in der Situation getan oder nicht getan?',
        subtitle: 'consequence.behavior',
        options: [
          'Direkt reagiert',
          'Zurückgezogen',
          'Gegrübelt',
          'Vermieden',
          'Abgelenkt',
          'Gespräch gesucht',
          'Aufgeschrieben',
          'Nichts getan',
        ],
        helpText:
            'Das tatsächliche Verhalten — nicht was du hättest tun sollen.',
        metadata: {
          'field_key': 'c.behavior',
          'with_note': true,
          'note_max_length': 300,
        },
      ),
      InterventionStep(
        id: 'abc3_post_rating',
        type: InterventionStepType.rating,
        title: 'Wie geht es dir jetzt?',
        body:
            'Nachdem du die Situation beschrieben hast: Wie hoch ist deine Belastung jetzt noch?',
        subtitle: 'Belastung 0–10',
        helpText:
            'Manchmal hilft das Aufschreiben bereits, die Belastung etwas zu verringern.',
        metadata: {
          'field_key': 'post.intensity',
          'min': 0,
          'max': 10,
          'also_rate_clarity': true,
        },
      ),
    ],
    estimatedDurationSec: 480,
    recommendedForStates: [
      SystemState.reflectiveReady,
      SystemState.rumination,
      SystemState.interpretation,
      SystemState.conflict,
      SystemState.selfDevaluation,
    ],
    recommendedForEmotions: [
      EmotionType.anger,
      EmotionType.fear,
      EmotionType.sadness,
      EmotionType.shame,
      EmotionType.guilt,
    ],
    minIntensity: 3,
    icon: '📝',
    category: 'Arbeitsblätter',
    difficultyLevel: 2,
    licenseTag: _defaultLicenseTag,
    licenseNotes: _worksheetLicenseNotes,
  );

  /// RSA / ABCDE — Rationale Selbstanalyse
  ///
  /// Erweitert das ABC-3-Protokoll um Disputation (D) und rationale Alternative (E).
  /// Eigene Formulierungen nach dem REBT-Konzept von Albert Ellis (Allgemeingut).
  /// Kein kopierter Wortlaut aus IBT/Kohlhammer-Arbeitsblättern.
  static const Intervention rsaAbcde = Intervention(
    id: 'rsa_abcde_v1',
    type: InterventionType.rsaAbcde,
    title: 'Rationale Selbstanalyse (RSA)',
    summary: 'Gedanken prüfen und eine rationale Alternative entwickeln',
    description:
        'Das ABCDE-Modell erweitert das ABC-Protokoll um eine Prüfung deiner Gedanken (D: Wahr? Hilfreich?) und die Entwicklung einer rationalen Alternative und Wunschreaktion (E).',
    steps: [
      InterventionStep(
        id: 'rsa_intro',
        type: InterventionStepType.text,
        title: 'Rationale Selbstanalyse',
        body:
            'Wir prüfen jetzt einen deiner Gedanken genauer: Stimmt er wirklich? Ist er hilfreich? Und: Was wäre eine realistischere Alternative?',
        subtitle: 'Dauer: ca. 10–15 Minuten',
        helpText:
            'Dieser Prozess funktioniert am besten mit etwas Abstand – wenn du nicht mehr akut im Ausnahmezustand bist.',
      ),
      InterventionStep(
        id: 'rsa_b_select',
        type: InterventionStepType.reflection,
        title: 'Welchen Gedanken möchtest du prüfen?',
        body: 'Schreibe den Gedanken auf, den du genauer untersuchen möchtest.',
        subtitle: 'rsa.b.selected_thought',
        helpText:
            'Wähle den Gedanken, der am belastendsten war oder am häufigsten wiederkehrt.',
        metadata: {
          'field_key': 'b.selected_thought',
          'max_length': 200,
          'required': true,
        },
      ),
      InterventionStep(
        id: 'rsa_d1_truth',
        type: InterventionStepType.factCheck,
        title: 'D1 – Entspricht dieser Gedanke überprüfbaren Fakten?',
        body:
            'Prüfe den Gedanken auf seinen Wahrheitsgehalt: Welche Belege gibt es dafür – und welche dagegen?',
        subtitle: 'rsa.d.truth_check',
        helpText:
            'Ein Gedanke muss nicht wahr sein, weil er sich wahr anfühlt. Fakten sind objektiv überprüfbar.',
        metadata: {
          'field_key': 'd.truth_check',
          'answer_options': [
            'Ja, vollständig',
            'Teilweise',
            'Nein, eher nicht'
          ],
          'with_note': true,
          'note_label': 'Begründung / Belege',
          'note_max_length': 300,
          'required': true,
        },
      ),
      InterventionStep(
        id: 'rsa_d2_helpful',
        type: InterventionStepType.factCheck,
        title: 'D2 – Ist dieser Gedanke hilfreich für dich?',
        body:
            'Hilft dir dieser Gedanke, die Situation zu bewältigen und deinen Zielen näher zu kommen?',
        subtitle: 'rsa.d.usefulness_check',
        helpText:
            'Selbst ein „wahrer" Gedanke kann unproduktiv sein. Frage: Was bringt mir dieser Gedanke?',
        metadata: {
          'field_key': 'd.helpful_check',
          'answer_options': ['Ja', 'Nein', 'Unklar'],
          'with_note': true,
          'note_label': 'Warum hilfreich oder nicht hilfreich?',
          'note_max_length': 300,
          'required': true,
        },
      ),
      InterventionStep(
        id: 'rsa_d3_perspective',
        type: InterventionStepType.reflection,
        title: 'Perspektivwechsel',
        body:
            'Was würde eine dir nahestehende, weise Person über diese Situation sagen? Wie würde sie deinen Gedanken einordnen?',
        subtitle: 'rsa.d.perspective',
        helpText:
            'Stell dir vor, wie du einer guten Freundin in genau dieser Situation raten würdest.',
        metadata: {
          'field_key': 'd.perspective',
          'max_length': 300,
          'required': false,
        },
      ),
      InterventionStep(
        id: 'rsa_e_rational',
        type: InterventionStepType.reflection,
        title: 'E – Rationale Alternative',
        body:
            'Formuliere einen realistischeren, ausgewogeneren Gedanken, der die Fakten berücksichtigt.',
        subtitle: 'rsa.e.rational_alternative',
        helpText:
            'Nicht „alles ist toll" — sondern: Was ist eine nüchterne, hilfreiche Perspektive auf die Situation?',
        metadata: {
          'field_key': 'e.rational_alternative',
          'max_length': 300,
          'required': true,
        },
      ),
      InterventionStep(
        id: 'rsa_e_desired',
        type: InterventionStepType.selection,
        title: 'E – Wunschzustand',
        body: 'Wie möchtest du dich nach dieser Reflexion idealerweise fühlen?',
        subtitle: 'rsa.e.desired_emotion',
        options: [
          'Ruhiger',
          'Traurig aber stabil',
          'Ärgerlich aber kontrolliert',
          'Neutral',
          'Etwas leichter',
          'Entschlossen',
        ],
        helpText:
            'Das ist kein Versprechen — sondern eine Richtung, in die du dich entwickeln möchtest.',
        metadata: {
          'field_key': 'e.desired_emotion',
          'with_behavior_note': true,
          'behavior_label': 'Was möchtest du als nächstes konkret tun?',
          'behavior_max_length': 200,
        },
      ),
      InterventionStep(
        id: 'rsa_rerating',
        type: InterventionStepType.rating,
        title: 'Re-Rating',
        body: 'Wie stark belastet dich der ursprüngliche Gedanke jetzt noch?',
        subtitle: 'Intensität vorher / nachher vergleichen',
        helpText:
            'Selbst eine kleine Veränderung zeigt, dass die Reflexion gewirkt hat.',
        metadata: {
          'field_key': 'rerating.intensity',
          'min': 0,
          'max': 10,
          'compare_with': 'c.emotion.intensity',
        },
      ),
    ],
    estimatedDurationSec: 720,
    recommendedForStates: [
      SystemState.reflectiveReady,
      SystemState.rumination,
      SystemState.interpretation,
      SystemState.selfDevaluation,
      SystemState.conflict,
    ],
    recommendedForEmotions: [
      EmotionType.fear,
      EmotionType.shame,
      EmotionType.guilt,
      EmotionType.sadness,
      EmotionType.anger,
    ],
    minIntensity: 3,
    maxIntensity: 7,
    icon: '🔬',
    category: 'Arbeitsblätter',
    difficultyLevel: 4,
    licenseTag: _defaultLicenseTag,
    licenseNotes: _worksheetLicenseNotes,
  );

  // ============================================
  // KRISENUNTERSTÜTZUNG
  // ============================================

  /// Akut-Intervention bei extremer Belastung
  static const Intervention acuteRegulation = Intervention(
    id: 'acute_regulation',
    type: InterventionType.regulation,
    title: 'Sofort-Hilfe bei extremer Belastung',
    summary: 'Erste Hilfe für akute Überflutung',
    description:
        'Wenn du dich komplett überflutet fühlst, ist diese schnelle Regulation der erste Schritt.',
    steps: [
      InterventionStep(
        id: 'intro',
        type: InterventionStepType.text,
        title: 'Sofort-Hilfe',
        body:
            'Es ist okay, nicht okay zu sein. Diese Übung hilft dir, dich im Moment zu stabilisieren.',
        subtitle: 'Dauer: ca. 2-3 Minuten',
        helpText: 'Du bist in Sicherheit. Atmen. Du schaffst das.',
      ),
      InterventionStep(
        id: 'ground',
        type: InterventionStepType.action,
        title: 'Bodenkontakt',
        body:
            'Spüre deine Füße auf dem Boden. Wenn du sitzt, spüre deinen Körper auf dem Stuhl.',
        helpText: 'Drücke deine Füße aktiv in den Boden. Spüre die Stabilität.',
      ),
      InterventionStep(
        id: 'breathe',
        type: InterventionStepType.breathing,
        title: 'Sofort-Atmung',
        body:
            'Atme tief in den Bauch. Wenn du einatmest, zähle 4. Wenn du ausatmest, zähle 6.',
        durationSec: 120,
        metadata: {
          'inhale_duration': 4,
          'hold_duration': 0,
          'exhale_duration': 6,
          'cycles': 10,
        },
        helpText:
            'Jeder Ausatem ist ein bisschen mehr Ankommen bei dir selbst.',
      ),
      InterventionStep(
        id: 'safety',
        type: InterventionStepType.action,
        title: 'Sicherheit bestätigen',
        body:
            'Sage dir selbst: Ich bin in Sicherheit. Im Moment passiert mir nichts.',
        helpText: 'Wiederhole dies mehrmals für dich selbst.',
      ),
      InterventionStep(
        id: 'next_step',
        type: InterventionStepType.selection,
        title: 'Nächster Schritt',
        body: 'Was brauchst du jetzt?',
        options: [
          'Noch mehr Zeit zum Atmen',
          'Jemanden anrufen',
          'Ein kaltes Getränk',
          'Frische Luft',
          'In Sicherheit bringen (Notruf)',
        ],
        helpText:
            'Wenn du dich nicht sicher fühlst oder jemanden verletzen könnten, wähle "In Sicherheit bringen".',
      ),
    ],
    estimatedDurationSec: 120,
    recommendedForStates: [
      SystemState.acuteActivation,
      SystemState.crisis,
      SystemState.overwhelm,
    ],
    recommendedForEmotions: [
      EmotionType.anger,
      EmotionType.fear,
      EmotionType.disgust,
      EmotionType.shame,
    ],
    minIntensity: 8,
    icon: '🆘',
    category: 'Krisenintervention',
    difficultyLevel: 1,
    licenseTag: _defaultLicenseTag,
    licenseNotes: _commonLicenseNotes,
  );

  // ============================================
  // LIBRARY ACCESS
  // ============================================

  /// Alle verfügbaren Interventionen
  static const List<Intervention> allInterventions = [
    // Regulation
    regulation4_6Breathing,
    groundingExercise,
    impulsePause,

    // Cognitive
    factCheck,
    ruminationStop,

    // Communication
    communicationHelp,

    // Overwhelm
    overwhelmStructure,

    // Self-value
    selfValueCheck,

    // Arbeitsblatt-Templates (konzeptv2neu.md)
    abc3Protocol,
    rsaAbcde,

    // Crisis
    acuteRegulation,
  ];

  /// Intervention anhand der ID finden
  static Intervention? getById(String id) {
    try {
      return allInterventions.firstWhere((i) => i.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Alle Interventionen eines Typs
  static List<Intervention> getByType(InterventionType type) {
    return allInterventions.where((i) => i.type == type).toList();
  }

  /// Interventionen für einen bestimmten Systemzustand
  static List<Intervention> getBySystemState(SystemState state) {
    return allInterventions
        .where((i) => i.recommendedForStates.contains(state))
        .toList();
  }

  /// Interventionen für eine bestimmte Emotion
  static List<Intervention> getByEmotion(EmotionType emotion) {
    return allInterventions
        .where((i) => i.recommendedForEmotions.contains(emotion))
        .toList();
  }

  /// Interventionen basierend auf Intensität filtern
  static List<Intervention> getByIntensity(int intensity) {
    return allInterventions.where((i) {
      if (i.minIntensity != null && intensity < i.minIntensity!) {
        return false;
      }
      if (i.maxIntensity != null && intensity > i.maxIntensity!) {
        return false;
      }
      return true;
    }).toList();
  }

  /// Empfohlene Interventionen basierend auf Kontext
  static List<Intervention> getRecommended({
    required SystemState systemState,
    required EmotionType emotion,
    required int intensity,
    List<InterventionType>? preferredTypes,
  }) {
    var interventions = getBySystemState(systemState);

    // Nach Emotion filtern
    final emotionMatch = interventions
        .where((i) => i.recommendedForEmotions.contains(emotion))
        .toList();

    // Wenn Emotion-Matches existieren, diese bevorzugen
    if (emotionMatch.isNotEmpty) {
      interventions = emotionMatch;
    }

    // Nach Intensität filtern
    interventions = getByIntensity(intensity)
        .where((i) => interventions.contains(i))
        .toList();

    // Nach bevorzugten Typen sortieren (falls angegeben)
    if (preferredTypes != null && preferredTypes.isNotEmpty) {
      final preferred =
          interventions.where((i) => preferredTypes.contains(i.type)).toList();
      final others =
          interventions.where((i) => !preferredTypes.contains(i.type)).toList();
      interventions = [...preferred, ...others];
    }

    // Maximal 4 Interventionen zurückgeben
    return interventions.take(4).toList();
  }

  /// Alle Kategorien
  static List<String> get categories =>
      allInterventions.map((i) => i.category ?? 'Sonstige').toSet().toList()
        ..sort();

  /// Interventionen nach Kategorie
  static Map<String, List<Intervention>> getByCategory() {
    final Map<String, List<Intervention>> categorized = {};
    for (final intervention in allInterventions) {
      final category = intervention.category ?? 'Sonstige';
      categorized[category] = [...categorized[category] ?? [], intervention];
    }
    return categorized;
  }
}
