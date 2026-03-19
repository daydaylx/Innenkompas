/// System states for Innenkompass.
///
/// These are the 7 possible emotional/mental states that the system
/// can classify a situation into based on the rule engine.
enum SystemState {
  /// Akute Aktivierung - Hohe emotionale Erregung, Handlungsdruck
  acuteActivation('Akute Aktivierung', '🔥', 1),

  /// Reflexionsbereit - moderate Belastung, noch zugänglich für Reflexion
  reflectiveReady('Reflexionsbereit', '🤔', 2),

  /// Interpretationsmodus - viele Annahmen bei unsicherer Faktenlage
  interpretation('Interpretationsmodus', '🧭', 3),

  /// Grübelmodus - wiederkehrende Gedanken, festgefahren
  rumination('Grübelmodus', '🔄', 4),

  /// Konflikt - zwischen eigenem Bedürfnis und äußerer Anforderung
  conflict('Konflikt', '⚔️', 5),

  /// Selbstabwertung - negatives Selbstbild, innere Kritik
  selfDevaluation('Selbstabwertung', '📉', 6),

  /// Überforderung - zu viele Anforderungen, nicht bewältigbar
  overwhelm('Überforderung', '🌊', 7),

  /// Krise - akute Not, Sicherheitsrisiko
  crisis('Krise', '🆘', 8);

  final String label;
  final String emoji;
  final int severityLevel;

  const SystemState(this.label, this.emoji, this.severityLevel);

  /// Get display label with emoji
  String get displayLabel => '$emoji $label';

  /// Get description for this state
  String get description {
    switch (this) {
      case SystemState.acuteActivation:
        return 'Hohe emotionale Erregung mit starkem Handlungsdruck';
      case SystemState.reflectiveReady:
        return 'Moderate Belastung, noch gut für Reflexion zugänglich';
      case SystemState.interpretation:
        return 'Starke Deutung bei noch unsicherer Faktenlage';
      case SystemState.rumination:
        return 'Wiederkehrende Gedanken, festgefahrene Denkmuster';
      case SystemState.conflict:
        return 'Zwischen eigenem Bedürfnis und äußerer Anforderung';
      case SystemState.selfDevaluation:
        return 'Negatives Selbstbild, starke innere Kritik';
      case SystemState.overwhelm:
        return 'Zu viele Anforderungen, erscheint nicht bewältigbar';
      case SystemState.crisis:
        return 'Akute Not, mögliches Sicherheitsrisiko';
    }
  }

  /// Check if this state requires immediate crisis support
  bool get isCrisis => this == SystemState.crisis;

  /// Check if this state is high severity (5+)
  bool get isHighSeverity => severityLevel >= 5;

  /// Check if this state is low severity (1-2)
  bool get isLowSeverity => severityLevel <= 2;

  /// Get recommended intervention categories for this state
  List<String> get recommendedInterventionCategories {
    switch (this) {
      case SystemState.acuteActivation:
        return ['Regulation', 'Impulspause', 'Erdung'];
      case SystemState.reflectiveReady:
        return ['Fakt-vs-Deutung', 'Kommunikationshilfe', 'Reflexion'];
      case SystemState.interpretation:
        return ['Fakt-vs-Deutung', 'Alternative Erklärung', 'Realitätsprüfung'];
      case SystemState.rumination:
        return ['Grübelstopp', 'Reorientierung', 'Aktivierung'];
      case SystemState.conflict:
        return ['Impulspause', 'Kommunikationshilfe', 'Fakt-vs-Deutung'];
      case SystemState.selfDevaluation:
        return ['Selbstabwertungscheck', 'Selbstwert-Übung', 'Fakt-vs-Deutung'];
      case SystemState.overwhelm:
        return ['Überforderungsstruktur', 'Priorisierung', 'Regulation'];
      case SystemState.crisis:
        return ['Krisenplan', 'Sofortige Hilfe', 'Sicherheitsplan'];
    }
  }

  /// Get states sorted by severity (lowest first)
  static List<SystemState> get bySeverity => SystemState.values.toList()
    ..sort((a, b) => a.severityLevel.compareTo(b.severityLevel));
}

/// Extension for SystemState with additional helper methods
extension SystemStateExtension on SystemState {
  /// Get color code associated with this state
  int get colorCode {
    switch (this) {
      case SystemState.acuteActivation:
        return 0xFFE9B44C; // Orange
      case SystemState.reflectiveReady:
        return 0xFF6B9080; // Green
      case SystemState.interpretation:
        return 0xFF7A8C62; // Moss
      case SystemState.rumination:
        return 0xFF7B8FA1; // Gray-blue
      case SystemState.conflict:
        return 0xFFC05C5C; // Red
      case SystemState.selfDevaluation:
        return 0xFF8B5FBF; // Purple
      case SystemState.overwhelm:
        return 0xFFD4A574; // Brownish
      case SystemState.crisis:
        return 0xFFB03030; // Dark red
    }
  }

  /// Check if this state typically benefits from reflection
  bool get benefitsFromReflection {
    switch (this) {
      case SystemState.reflectiveReady:
      case SystemState.interpretation:
      case SystemState.rumination:
      case SystemState.conflict:
      case SystemState.selfDevaluation:
        return true;
      case SystemState.acuteActivation:
      case SystemState.overwhelm:
      case SystemState.crisis:
        return false;
    }
  }

  /// Check if this state requires regulation before reflection
  bool get needsRegulationFirst {
    switch (this) {
      case SystemState.acuteActivation:
      case SystemState.overwhelm:
      case SystemState.crisis:
        return true;
      case SystemState.reflectiveReady:
      case SystemState.interpretation:
      case SystemState.rumination:
      case SystemState.conflict:
      case SystemState.selfDevaluation:
        return false;
    }
  }
}
