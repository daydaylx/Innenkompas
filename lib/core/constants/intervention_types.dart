/// Intervention types in Innenkompass.
///
/// These are the categories of interventions available in the system.
/// abc3 and rsaAbcde are worksheet-style templates added per konzeptv2neu.md.
enum InterventionType {
  regulation,
  factCheck,
  impulsePause,
  ruminationStop,
  communication,
  overwhelmStructure,
  selfValueCheck,

  /// ABC-3 Kurzprotokoll: Auslöser → Bewertung → Konsequenzen (Gefühl/Körper/Verhalten)
  abc3,

  /// RSA/ABCDE: Rationale Selbstanalyse mit Disputation und rationaler Alternative
  rsaAbcde;

  /// Get display label with emoji
  String get displayLabel {
    switch (this) {
      case InterventionType.regulation:
        return '🌿 Regulation';
      case InterventionType.factCheck:
        return '🔍 Fakt-vs-Deutung';
      case InterventionType.impulsePause:
        return '⏸️ Impulspause';
      case InterventionType.ruminationStop:
        return '🛑 Grübelstopp';
      case InterventionType.communication:
        return '💬 Kommunikationshilfe';
      case InterventionType.overwhelmStructure:
        return '📋 Überforderungsstruktur';
      case InterventionType.selfValueCheck:
        return '💪 Selbstabwertungscheck';
      case InterventionType.abc3:
        return '📝 ABC-3 Protokoll';
      case InterventionType.rsaAbcde:
        return '🔬 Rationale Selbstanalyse';
    }
  }

  /// Get display label (emoji only)
  String get emoji {
    switch (this) {
      case InterventionType.regulation:
        return '🌿';
      case InterventionType.factCheck:
        return '🔍';
      case InterventionType.impulsePause:
        return '⏸️';
      case InterventionType.ruminationStop:
        return '🛑';
      case InterventionType.communication:
        return '💬';
      case InterventionType.overwhelmStructure:
        return '📋';
      case InterventionType.selfValueCheck:
        return '💪';
      case InterventionType.abc3:
        return '📝';
      case InterventionType.rsaAbcde:
        return '🔬';
    }
  }

  /// Get label (text only)
  String get label {
    switch (this) {
      case InterventionType.regulation:
        return 'Regulation';
      case InterventionType.factCheck:
        return 'Fakt-vs-Deutung';
      case InterventionType.impulsePause:
        return 'Impulspause';
      case InterventionType.ruminationStop:
        return 'Grübelstopp';
      case InterventionType.communication:
        return 'Kommunikationshilfe';
      case InterventionType.overwhelmStructure:
        return 'Überforderungsstruktur';
      case InterventionType.selfValueCheck:
        return 'Selbstabwertungscheck';
      case InterventionType.abc3:
        return 'ABC-3 Protokoll';
      case InterventionType.rsaAbcde:
        return 'Rationale Selbstanalyse';
    }
  }

  /// Get description for this intervention type
  String get description {
    switch (this) {
      case InterventionType.regulation:
        return 'Atmung, Erdung und Reorientierung zur Beruhigung';
      case InterventionType.factCheck:
        return 'Kognitive Reframing und Realitätsprüfung';
      case InterventionType.impulsePause:
        return 'Innehalten, bevor dem Impuls gefolgt wird';
      case InterventionType.ruminationStop:
        return 'Unterbrechen von Grübelkreisläufen';
      case InterventionType.communication:
        return 'Unterstützung für schwierige Gespräche';
      case InterventionType.overwhelmStructure:
        return 'Überforderung in handhabbare Schritte aufteilen';
      case InterventionType.selfValueCheck:
        return 'Erkennen und challengen von Selbstabwertung';
      case InterventionType.abc3:
        return 'Situation, Gedanken und Konsequenzen strukturiert erfassen';
      case InterventionType.rsaAbcde:
        return 'Gedanken prüfen (Wahr? Hilfreich?) und rationale Alternative entwickeln';
    }
  }

  /// Get typical duration in seconds for this intervention type
  int get typicalDuration {
    switch (this) {
      case InterventionType.regulation:
        return 180; // 3 minutes
      case InterventionType.factCheck:
        return 300; // 5 minutes
      case InterventionType.impulsePause:
        return 120; // 2 minutes
      case InterventionType.ruminationStop:
        return 240; // 4 minutes
      case InterventionType.communication:
        return 420; // 7 minutes
      case InterventionType.overwhelmStructure:
        return 360; // 6 minutes
      case InterventionType.selfValueCheck:
        return 300; // 5 minutes
      case InterventionType.abc3:
        return 480; // 8 minutes
      case InterventionType.rsaAbcde:
        return 720; // 12 minutes
    }
  }

  /// Get minimum duration in seconds
  int get minDuration {
    switch (this) {
      case InterventionType.regulation:
        return 60; // 1 minute
      case InterventionType.factCheck:
        return 120; // 2 minutes
      case InterventionType.impulsePause:
        return 30; // 30 seconds
      case InterventionType.ruminationStop:
        return 60; // 1 minute
      case InterventionType.communication:
        return 180; // 3 minutes
      case InterventionType.overwhelmStructure:
        return 120; // 2 minutes
      case InterventionType.selfValueCheck:
        return 120; // 2 minutes
      case InterventionType.abc3:
        return 300; // 5 minutes
      case InterventionType.rsaAbcde:
        return 480; // 8 minutes
    }
  }

  /// Get maximum duration in seconds
  int get maxDuration {
    switch (this) {
      case InterventionType.regulation:
        return 600; // 10 minutes
      case InterventionType.factCheck:
        return 900; // 15 minutes
      case InterventionType.impulsePause:
        return 300; // 5 minutes
      case InterventionType.ruminationStop:
        return 600; // 10 minutes
      case InterventionType.communication:
        return 1200; // 20 minutes
      case InterventionType.overwhelmStructure:
        return 900; // 15 minutes
      case InterventionType.selfValueCheck:
        return 900; // 15 minutes
      case InterventionType.abc3:
        return 900; // 15 minutes
      case InterventionType.rsaAbcde:
        return 1800; // 30 minutes
    }
  }

  /// Check if this intervention is suitable for acute states
  bool get suitableForAcuteStates {
    switch (this) {
      case InterventionType.regulation:
      case InterventionType.impulsePause:
        return true;
      case InterventionType.factCheck:
      case InterventionType.ruminationStop:
      case InterventionType.communication:
      case InterventionType.overwhelmStructure:
      case InterventionType.selfValueCheck:
      case InterventionType.abc3:
      case InterventionType.rsaAbcde:
        return false;
    }
  }

  /// Check if this intervention requires active participation
  bool get requiresActiveParticipation {
    switch (this) {
      case InterventionType.factCheck:
      case InterventionType.communication:
      case InterventionType.overwhelmStructure:
      case InterventionType.selfValueCheck:
      case InterventionType.abc3:
      case InterventionType.rsaAbcde:
        return true;
      case InterventionType.regulation:
      case InterventionType.impulsePause:
      case InterventionType.ruminationStop:
        return false;
    }
  }
}

/// Intervention step types
enum InterventionStepType {
  text,
  breathing,
  timer,
  reflection,
  selection,
  action,
  factCheck,
  rating;

  /// Convert from string
  static InterventionStepType fromString(String value) {
    return InterventionStepType.values.firstWhere(
      (type) => type.name == value,
      orElse: () => InterventionStepType.text,
    );
  }
}
