/// Context types for situations in Innenkompass.
///
/// These define the life areas or contexts in which situations occur.
enum ContextType {
  /// Arbeit - Job, Karriere, Aufgaben, Kollegen
  work('Arbeit', '💼'),

  /// Familie - Eltern, Geschwister, Verwandte
  family('Familie', '👨‍👩‍👧‍👦'),

  /// Partnerschaft - Partner/in, Beziehung, Ehe
  partnership('Partnerschaft', '❤️'),

  /// Freunde - Freundschaften, soziale Kontakte
  friends('Freunde', '👥'),

  /// Alltag - Termine, Wege, kleine Reibungen im Tagesablauf
  everyday('Alltag', '🕰️'),

  /// Organisation/Haushalt - To-dos, Papierkram, Ordnung, Finanzen
  organizationHousehold('Organisation/Haushalt', '🧺'),

  /// Gesundheit - Körperliche Gesundheit, Krankheit, Wohlbefinden
  health('Gesundheit', '🏥'),

  /// Selbstbild/Leistung - Leistung, Selbstwert, Bewertung
  selfWorthPerformance('Selbstbild/Leistung', '🪞'),

  /// Legacy: Finanzen - Geld, Schulden, Einkommen, Ausgaben
  /// Finanzen - Geld, Schulden, Einkommen, Ausgaben
  finances('Finanzen', '💰'),

  /// Legacy: Freizeit - Hobbys, Sport, Entspannung
  /// Freizeit - Hobbys, Sport, Entspannung
  leisure('Freizeit', '🎨'),

  /// Legacy: Alleinsein - Zeit mit sich selbst, Einsamkeit
  /// Alleinsein - Zeit mit sich selbst, Einsamkeit
  solitude('Alleinsein', '🧘'),

  /// Sonstiges - Andere Kontexte
  other('Sonstiges', '📌');

  final String label;
  final String emoji;

  const ContextType(this.label, this.emoji);

  /// Get display label with emoji
  String get displayLabel => '$emoji $label';

  /// Get a description for the context
  String get description {
    switch (this) {
      case ContextType.work:
        return 'Job, Karriere, Aufgaben oder Kollegen';
      case ContextType.family:
        return 'Eltern, Geschwister oder Verwandte';
      case ContextType.partnership:
        return 'Partner/in, Beziehung oder Ehe';
      case ContextType.friends:
        return 'Freundschaften oder soziale Kontakte';
      case ContextType.everyday:
        return 'Tagesablauf, Wege, Termine oder kleine Reibungen';
      case ContextType.organizationHousehold:
        return 'Organisation, Haushalt, To-dos oder Papierkram';
      case ContextType.health:
        return 'Körperliche Gesundheit oder Wohlbefinden';
      case ContextType.selfWorthPerformance:
        return 'Leistung, Bewertung oder Selbstwert';
      case ContextType.finances:
        return 'Geldangelegenheiten, Schulden oder Einkommen';
      case ContextType.leisure:
        return 'Hobbys, Sport oder Entspannung';
      case ContextType.solitude:
        return 'Zeit mit sich selbst';
      case ContextType.other:
        return 'Andere Lebensbereiche';
    }
  }

  /// Get all context types as a list
  static List<ContextType> get all => ContextType.values;

  /// Kontextoptionen, die im neuen 4-Schritte-Flow aktiv angeboten werden.
  static List<ContextType> get flowOptions => [
        work,
        partnership,
        family,
        friends,
        everyday,
        organizationHousehold,
        health,
        selfWorthPerformance,
        other,
      ];

  /// Get most common contexts (for quick selection)
  static List<ContextType> get common => [
        work,
        family,
        partnership,
        friends,
        health,
      ];

  static ContextType? fromRaw(String? rawValue) {
    if (rawValue == null || rawValue.trim().isEmpty) return null;
    final normalized = rawValue.trim();

    for (final value in ContextType.values) {
      if (value.name == normalized || value.label == normalized) {
        return value;
      }
    }

    switch (normalized) {
      case 'Alltag':
        return ContextType.everyday;
      case 'Organisation/Haushalt':
        return ContextType.organizationHousehold;
      case 'Selbstbild/Leistung':
        return ContextType.selfWorthPerformance;
      default:
        return null;
    }
  }
}
