enum PatternFamiliarity {
  often(
    'Ja, oft',
    'Dieses Muster taucht in ähnlicher Form öfter auf.',
  ),
  sometimes(
    'Manchmal',
    'Es ist nicht neu, aber auch nicht ständig da.',
  ),
  rarely(
    'Eher selten',
    'Das kommt vor, ist aber nicht typisch.',
  ),
  firstTime(
    'Zum ersten Mal',
    'So oder ähnlich wirkt es gerade neu.',
  ),
  unknown(
    'Weiß ich nicht',
    'Noch nicht klar, ob es ein bekanntes Muster ist.',
  );

  const PatternFamiliarity(this.label, this.description);

  final String label;
  final String description;

  static PatternFamiliarity? fromRaw(String? rawValue) {
    if (rawValue == null || rawValue.isEmpty) return null;
    for (final value in PatternFamiliarity.values) {
      if (value.name == rawValue) {
        return value;
      }
    }
    return null;
  }
}
