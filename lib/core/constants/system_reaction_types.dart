enum SystemReactionType {
  attack(
    'Angreifen',
    'Dagegengehen, zurückschießen oder Druck machen',
  ),
  withdrawal(
    'Rückzug',
    'Dichtmachen, innerlich weggehen oder abbrechen',
  ),
  flight(
    'Flucht',
    'Rausgehen, vermeiden oder schnell weg wollen',
  ),
  freeze(
    'Erstarren',
    'Blockiert sein, nichts mehr sortieren können',
  ),
  appease(
    'Beschwichtigen-Anpassen',
    'Glätten, nachgeben oder sich kleiner machen',
  ),
  control(
    'Kontrollieren',
    'Ordnen, absichern oder alles im Griff behalten wollen',
  ),
  unknown(
    'Weiß ich nicht',
    'Die erste Reaktion lässt sich gerade nicht klar benennen.',
  );

  const SystemReactionType(this.label, this.description);

  final String label;
  final String description;

  static SystemReactionType? fromRaw(String? rawValue) {
    if (rawValue == null || rawValue.isEmpty) return null;
    for (final value in SystemReactionType.values) {
      if (value.name == rawValue) {
        return value;
      }
    }
    return null;
  }
}
