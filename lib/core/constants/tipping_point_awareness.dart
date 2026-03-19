enum TippingPointAwareness {
  early(
    'Ja, früh',
    'Du hast rechtzeitig gemerkt, dass es kippt.',
  ),
  late(
    'Ja, aber erst spät',
    'Du hast es gemerkt, als die Eskalation schon lief.',
  ),
  afterwards(
    'Erst im Nachhinein',
    'Erst nach der Situation war klar, wann es gekippt ist.',
  ),
  none(
    'Nein',
    'In dem Moment gab es kein klares Bemerken.',
  );

  const TippingPointAwareness(this.label, this.description);

  final String label;
  final String description;

  static TippingPointAwareness? fromRaw(String? rawValue) {
    if (rawValue == null || rawValue.isEmpty) return null;
    for (final value in TippingPointAwareness.values) {
      if (value.name == rawValue) {
        return value;
      }
    }
    return null;
  }
}
