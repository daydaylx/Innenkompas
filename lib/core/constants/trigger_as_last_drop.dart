enum TriggerAsLastDrop {
  yes(
    'Ja, ziemlich sicher',
    'Die Kleinigkeit war eher der letzte Tropfen als das Hauptthema.',
  ),
  partly(
    'Teilweise',
    'Es war teils Auslöser, teils steckt mehr dahinter.',
  ),
  no(
    'Eher nicht',
    'Der Auslöser selbst war wahrscheinlich das zentrale Thema.',
  ),
  unknown(
    'Weiß ich noch nicht',
    'Gerade ist noch offen, wie viel Hintergrund mitgespielt hat.',
  );

  const TriggerAsLastDrop(this.label, this.description);

  final String label;
  final String description;

  static TriggerAsLastDrop? fromRaw(String? rawValue) {
    if (rawValue == null || rawValue.isEmpty) return null;
    for (final value in TriggerAsLastDrop.values) {
      if (value.name == rawValue) {
        return value;
      }
    }
    return null;
  }
}
