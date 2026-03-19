class ActualBehaviorTypes {
  ActualBehaviorTypes._();

  static const Map<String, String> keyToLabel = {
    'raise_voice': 'laut geworden',
    'scream': 'geschrien',
    'throw_objects': 'Dinge geworfen',
    'argue': 'diskutiert',
    'leave_room': 'Raum verlassen',
    'withdraw': 'zurückgezogen',
    'cry': 'geweint',
    'freeze_block': 'blockiert',
    'seek_help': 'Hilfe geholt',
    'distract': 'abgelenkt',
  };

  static const Map<String, String> _legacyAliases = {
    'laut geworden': 'raise_voice',
    'geschrien': 'scream',
    'Dinge geworfen': 'throw_objects',
    'diskutiert': 'argue',
    'Raum verlassen': 'leave_room',
    'zurückgezogen': 'withdraw',
    'geweint': 'cry',
    'blockiert': 'freeze_block',
    'Hilfe geholt': 'seek_help',
    'abgelenkt': 'distract',
  };

  static const List<String> optionLabels = [
    'laut geworden',
    'geschrien',
    'Dinge geworfen',
    'diskutiert',
    'Raum verlassen',
    'zurückgezogen',
    'geweint',
    'blockiert',
    'Hilfe geholt',
    'abgelenkt',
  ];

  static String normalize(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      return trimmed;
    }
    if (keyToLabel.containsKey(trimmed)) {
      return trimmed;
    }
    return _legacyAliases[trimmed] ?? trimmed;
  }

  static List<String> normalizeAll(Iterable<String> values) {
    return values
        .map(normalize)
        .where((value) => value.isNotEmpty)
        .toSet()
        .toList(growable: false);
  }

  static String labelFor(String value) {
    final normalized = normalize(value);
    return keyToLabel[normalized] ?? value;
  }

  static List<String> labelsFor(Iterable<String> values) {
    return values
        .map(labelFor)
        .where((value) => value.trim().isNotEmpty)
        .toList(growable: false);
  }

  static String? keyForLabel(String? label) {
    if (label == null) {
      return null;
    }
    final normalized = normalize(label);
    return normalized.isEmpty ? null : normalized;
  }
}
