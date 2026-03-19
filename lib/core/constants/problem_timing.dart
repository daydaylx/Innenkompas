enum ProblemTiming {
  alreadyThere(
    'Ja, eher schon vorher',
    'Das Thema war innerlich oder äußerlich schon vor dem Auslöser da.',
  ),
  partly(
    'Teilweise',
    'Ein Teil war schon da, ein Teil ist erst in dem Moment entstanden.',
  ),
  onlyThen(
    'Nein, eher erst in dem Moment',
    'Das eigentliche Problem wirkte erst mit dieser Situation so stark.',
  ),
  unknown(
    'Weiß ich nicht',
    'Gerade ist noch nicht klar, ob das Thema schon vorher da war.',
  );

  const ProblemTiming(this.label, this.description);

  final String label;
  final String description;

  static ProblemTiming? fromRaw(String? rawValue) {
    if (rawValue == null || rawValue.isEmpty) return null;
    for (final value in ProblemTiming.values) {
      if (value.name == rawValue) {
        return value;
      }
    }
    return null;
  }
}
