/// Einschätzung, wie stark ein Gedanke auf Fakten oder Interpretation beruht.
enum FactInterpretationResult {
  mostlyFacts(
    'Eher Fakten',
    'Das meiste davon ist gerade beobachtbar oder belegt.',
  ),
  mixed(
    'Gemischt',
    'Ein Teil ist belegt, ein Teil ist Deutung oder Vermutung.',
  ),
  mostlyInterpretation(
    'Eher Interpretation',
    'Vieles davon ist Annahme, Befürchtung oder Zuschreibung.',
  );

  const FactInterpretationResult(this.label, this.description);

  final String label;
  final String description;

  bool get isUncertain => this != FactInterpretationResult.mostlyFacts;
}
