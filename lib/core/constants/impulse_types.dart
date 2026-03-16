/// Impulse types supported by Innenkompass.
///
/// These are the automatic behavioral impulses that can be selected
/// when logging a situation.
enum ImpulseType {
  /// Kontern - zurückangreifen, rechthaben, beweisen wollen
  counter('Kontern', '⚔️'),

  /// Flüchten - Situation verlassen, ausweichen, vermeiden
  flee('Flüchten', '🏃'),

  /// Grübeln - immer wieder denken, analysieren, nicht loslassen
  ruminate('Grübeln', '🔄'),

  /// Anpassen - nachgeben, harmonisieren, unterordnen
  comply('Anpassen', '🤝'),

  /// Erstarrten - einfrieren, nichts tun können, blockieren
  freeze('Erstarrten', '🧊'),

  /// Kontrollieren - alles im Griff behalten, organisieren
  control('Kontrollieren', '🎯'),

  /// Rückziehen - isolieren, nicht teilnehmen
  withdraw('Rückziehen', '🔒'),

  /// Selbstkritik - sich selbst verurteilen, abwerten
  selfCriticism('Selbstkritik', '🔪'),

  /// Perfektionismus - alles perfekt machen wollen
  perfectionism('Perfektionismus', '✨'),

  /// Sofortiges Handeln - jetzt sofort etwas tun, unüberlegt
  immediateAction('Sofort handeln', '⚡'),

  /// Ablenkung - etwas anderes tun, wegschauen
  distraction('Ablenkung', '📱'),

  /// Hilfe suchen - nach Unterstützung fragen
  seekHelp('Hilfe suchen', '🆘');

  final String label;
  final String emoji;

  const ImpulseType(this.label, this.emoji);

  /// Get display label with emoji
  String get displayLabel => '$emoji $label';

  /// Get a description for the impulse
  String get description {
    switch (this) {
      case ImpulseType.counter:
        return 'Zurückangreifen, rechthaben oder beweisen wollen';
      case ImpulseType.flee:
        return 'Situation verlassen, ausweichen oder vermeiden';
      case ImpulseType.ruminate:
        return 'Immer wieder denken, analysieren, nicht loslassen';
      case ImpulseType.comply:
        return 'Nachgeben, harmonisieren oder unterordnen';
      case ImpulseType.freeze:
        return 'Einfrieren, nichts tun können, blockieren';
      case ImpulseType.control:
        return 'Alles im Griff behalten, organisieren';
      case ImpulseType.withdraw:
        return 'Isolieren, sich zurückziehen, nicht teilnehmen';
      case ImpulseType.selfCriticism:
        return 'Sich selbst verurteilen oder abwerten';
      case ImpulseType.perfectionism:
        return 'Alles perfekt machen wollen';
      case ImpulseType.immediateAction:
        return 'Jetzt sofort etwas tun, unüberlegt handeln';
      case ImpulseType.distraction:
        return 'Etwas anderes tun, abgelenkt sein';
      case ImpulseType.seekHelp:
        return 'Nach Unterstützung oder Hilfe fragen';
    }
  }

  /// Get common reactions/interventions for this impulse
  List<String> get typicalInterventions {
    switch (this) {
      case ImpulseType.counter:
        return ['Impulspause', 'Fakt-vs-Deutung', 'Kommunikationshilfe'];
      case ImpulseType.flee:
        return ['Impulspause', 'Erdung', 'Reorientierung'];
      case ImpulseType.ruminate:
        return ['Grübelstopp', 'Reorientierung', 'Fakt-vs-Deutung'];
      case ImpulseType.comply:
        return ['Selbstabwertungscheck', 'Kommunikationshilfe'];
      case ImpulseType.freeze:
        return ['Erdung', 'Reorientierung', '4-6 Atmung'];
      case ImpulseType.control:
        return ['Loslassen-Übung', 'Reorientierung', 'Akzeptanz'];
      case ImpulseType.withdraw:
        return ['Reorientierung', 'Kommunikationshilfe', 'Aktivierung'];
      case ImpulseType.selfCriticism:
        return ['Selbstabwertungscheck', 'Selbstwert-Übung', 'Fakt-vs-Deutung'];
      case ImpulseType.perfectionism:
        return ['Gut-genug-Übung', 'Selbstwert-Check', 'Priorisierung'];
      case ImpulseType.immediateAction:
        return ['Impulspause', 'Reorientierung', '4-6 Atmung'];
      case ImpulseType.distraction:
        return ['Reorientierung', 'Fokus-Übung', 'Erdung'];
      case ImpulseType.seekHelp:
        return ['Kommunikationshilfe', 'Sozialer Rückhalt'];
    }
  }
}
