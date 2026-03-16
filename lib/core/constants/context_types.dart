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

  /// Gesundheit - Körperliche Gesundheit, Krankheit, Wohlbefinden
  health('Gesundheit', '🏥'),

  /// Finanzen - Geld, Schulden, Einkommen, Ausgaben
  finances('Finanzen', '💰'),

  /// Freizeit - Hobbys, Sport, Entspannung
  leisure('Freizeit', '🎨'),

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
      case ContextType.health:
        return 'Körperliche Gesundheit oder Wohlbefinden';
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

  /// Get most common contexts (for quick selection)
  static List<ContextType> get common => [
        work,
        family,
        partnership,
        friends,
        health,
      ];
}
