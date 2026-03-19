import 'package:innenkompass/core/constants/content_license_tags.dart';

/// Eigenentwickelte Selbsteinschätzungs-Kurzskala (SelbsteinschaetzungsSkala)
///
/// Erhebt 5 Bereiche der Belastung in der letzten Woche, je 0–4.
/// Summe 0–20, wiederholbar für Verlaufsbeobachtung.
///
/// WICHTIG: Dies ist eine vollständige Eigenentwicklung in eigenen Worten.
/// Kein Wortlaut aus ODSIS (Oxford University Press) oder UP/Hogrefe-Material.
///
/// Zweck: Pragmatisches Selbstbeobachtungs-Werkzeug für Verlaufsmonitoring.
/// Kein Diagnoseinstrument — kein Grenzwert-Cutoff im MVP.
class SelbsteinschaetzungsSkala {
  static const ContentLicenseTag licenseTag = ContentLicenseTag.publicDomain;
  static const String licenseNotes =
      'Vollständige Eigenentwicklung für privates Verlaufsmonitoring; kein ODSIS-Wortlaut.';

  /// Item 1: Häufigkeit
  /// Frage: „Wie oft haben Sie sich in der letzten Woche
  /// gedrückt, niedergeschlagen oder leer gefühlt?"
  /// 0 = Nie  |  1 = Selten  |  2 = Manchmal  |  3 = Oft  |  4 = Fast immer
  final int haeufigkeit;

  /// Item 2: Intensität
  /// Frage: „Wie stark war diese Belastung, wenn sie aufgetreten ist?"
  /// 0 = Gar nicht  |  1 = Leicht  |  2 = Mäßig  |  3 = Stark  |  4 = Extrem stark
  final int intensitaet;

  /// Item 3: Aktivitäten / Freude
  /// Frage: „Wie sehr hat die Belastung Ihr Interesse oder Ihre Freude
  /// an Dingen beeinträchtigt, die Ihnen normalerweise wichtig sind?"
  /// 0 = Keine Einschränkung  |  4 = Völlig eingeschränkt
  final int aktivitaeten;

  /// Item 4: Aufgaben / Funktionsfähigkeit
  /// Frage: „Wie sehr hat die Belastung Ihre Fähigkeit beeinträchtigt,
  /// alltägliche Aufgaben (Arbeit, Haushalt, Schule) zu erledigen?"
  /// 0 = Keine Einschränkung  |  4 = Völlig eingeschränkt
  final int aufgaben;

  /// Item 5: Soziales
  /// Frage: „Wie sehr hat die Belastung Ihre sozialen Kontakte
  /// und Beziehungen eingeschränkt?"
  /// 0 = Keine Einschränkung  |  4 = Völlig eingeschränkt
  final int soziales;

  /// Zeitpunkt der Erhebung
  final DateTime erhobenAm;

  const SelbsteinschaetzungsSkala({
    required this.haeufigkeit,
    required this.intensitaet,
    required this.aktivitaeten,
    required this.aufgaben,
    required this.soziales,
    required this.erhobenAm,
  })  : assert(haeufigkeit >= 0 && haeufigkeit <= 4),
        assert(intensitaet >= 0 && intensitaet <= 4),
        assert(aktivitaeten >= 0 && aktivitaeten <= 4),
        assert(aufgaben >= 0 && aufgaben <= 4),
        assert(soziales >= 0 && soziales <= 4);

  /// Gesamtpunktzahl (0–20)
  int get gesamt =>
      haeufigkeit + intensitaet + aktivitaeten + aufgaben + soziales;

  /// Verlaufskategorie (nur für interne Darstellung, kein Diagnose-Label)
  BelastungsBereich get bereich {
    if (gesamt <= 4) return BelastungsBereich.gering;
    if (gesamt <= 9) return BelastungsBereich.leicht;
    if (gesamt <= 14) return BelastungsBereich.maessig;
    return BelastungsBereich.erhoeht;
  }

  /// Δ-Wert im Vergleich zu einer früheren Messung (positiv = Verbesserung)
  int deltaZu(SelbsteinschaetzungsSkala frueher) => frueher.gesamt - gesamt;

  Map<String, dynamic> toJson() => {
        'haeufigkeit': haeufigkeit,
        'intensitaet': intensitaet,
        'aktivitaeten': aktivitaeten,
        'aufgaben': aufgaben,
        'soziales': soziales,
        'gesamt': gesamt,
        'erhobenAm': erhobenAm.toIso8601String(),
      };

  factory SelbsteinschaetzungsSkala.fromJson(Map<String, dynamic> json) =>
      SelbsteinschaetzungsSkala(
        haeufigkeit: json['haeufigkeit'] as int,
        intensitaet: json['intensitaet'] as int,
        aktivitaeten: json['aktivitaeten'] as int,
        aufgaben: json['aufgaben'] as int,
        soziales: json['soziales'] as int,
        erhobenAm: DateTime.parse(json['erhobenAm'] as String),
      );

  @override
  String toString() =>
      'SelbsteinschaetzungsSkala(gesamt: $gesamt, bereich: ${bereich.label})';
}

/// Verlaufskategorien ohne Diagnose-Implikation
enum BelastungsBereich {
  /// Gesamt 0–4
  gering('Gering belastet'),

  /// Gesamt 5–9
  leicht('Leicht belastet'),

  /// Gesamt 10–14
  maessig('Mäßig belastet'),

  /// Gesamt 15–20
  erhoeht('Erhöht belastet');

  final String label;
  const BelastungsBereich(this.label);

  /// Hinweistext für UI — keine Diagnose-Aussage
  String get hinweis {
    switch (this) {
      case BelastungsBereich.gering:
        return 'Deine Einschätzung zeigt aktuell eine geringe Belastung.';
      case BelastungsBereich.leicht:
        return 'Deine Einschätzung zeigt eine leichte Belastung. Selbstfürsorge kann helfen.';
      case BelastungsBereich.maessig:
        return 'Deine Einschätzung zeigt eine mäßige Belastung. Unterstützung suchen kann sinnvoll sein.';
      case BelastungsBereich.erhoeht:
        return 'Deine Einschätzung zeigt eine erhöhte Belastung. Bitte sprich mit einer Fachkraft.';
    }
  }
}

/// Statische Itemdefinitionen für die UI-Darstellung
class BelastungsskalaDef {
  static const List<SkalaDef> items = [
    SkalaDef(
      feldKey: 'haeufigkeit',
      frage:
          'Wie oft haben Sie sich in der letzten Woche gedrückt, niedergeschlagen oder leer gefühlt?',
      ankerlabels: {
        0: 'Nie',
        1: 'Selten',
        2: 'Manchmal',
        3: 'Oft',
        4: 'Fast immer',
      },
    ),
    SkalaDef(
      feldKey: 'intensitaet',
      frage: 'Wie stark war diese Belastung, wenn sie aufgetreten ist?',
      ankerlabels: {
        0: 'Gar nicht',
        1: 'Leicht',
        2: 'Mäßig',
        3: 'Stark',
        4: 'Extrem stark',
      },
    ),
    SkalaDef(
      feldKey: 'aktivitaeten',
      frage:
          'Wie sehr hat die Belastung Ihr Interesse oder Ihre Freude an Dingen beeinträchtigt, die Ihnen normalerweise wichtig sind?',
      ankerlabels: {
        0: 'Keine Einschränkung',
        1: 'Leichte Einschränkung',
        2: 'Mäßige Einschränkung',
        3: 'Starke Einschränkung',
        4: 'Völlig eingeschränkt',
      },
    ),
    SkalaDef(
      feldKey: 'aufgaben',
      frage:
          'Wie sehr hat die Belastung Ihre Fähigkeit beeinträchtigt, alltägliche Aufgaben (Arbeit, Haushalt, Schule) zu erledigen?',
      ankerlabels: {
        0: 'Keine Einschränkung',
        1: 'Leichte Einschränkung',
        2: 'Mäßige Einschränkung',
        3: 'Starke Einschränkung',
        4: 'Völlig eingeschränkt',
      },
    ),
    SkalaDef(
      feldKey: 'soziales',
      frage:
          'Wie sehr hat die Belastung Ihre sozialen Kontakte und Beziehungen eingeschränkt?',
      ankerlabels: {
        0: 'Keine Einschränkung',
        1: 'Leichte Einschränkung',
        2: 'Mäßige Einschränkung',
        3: 'Starke Einschränkung',
        4: 'Völlig eingeschränkt',
      },
    ),
  ];
}

/// Definition eines einzelnen Skalaitems für die UI
class SkalaDef {
  final String feldKey;
  final String frage;
  final Map<int, String> ankerlabels;

  const SkalaDef({
    required this.feldKey,
    required this.frage,
    required this.ankerlabels,
  });
}
