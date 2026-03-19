/// Emotion types supported by Innenkompass.
///
/// Based on the PRD specification, these are the primary emotions
/// that can be selected when logging a situation.
enum EmotionType {
  /// Wut - Ärger, Groll, Frustration
  anger('Wut', '😠'),

  /// Genervtheit - gereizt, genervt, dünnhäutig
  annoyance('Genervtheit', '😤'),

  /// Angst - Sorge, Furcht, Panik
  fear('Angst', '😨'),

  /// Ohnmacht - ausgeliefert, kein Einfluss
  powerlessness('Ohnmacht', '🫥'),

  /// Überforderung - zu viel auf einmal, innerer Druck
  overwhelm('Überforderung', '🫨'),

  /// Enttäuschung - verletzt durch ausbleibende Erwartung
  disappointment('Enttäuschung', '😞'),

  /// Kränkung - getroffen, verletzt, abgewertet
  hurt('Kränkung', '💔'),

  /// Trauer - Niedergeschlagenheit, Verlust, Leere
  sadness('Trauer', '😢'),

  /// Scham - Beschämung, Bloßstellung, Wertlosigkeit
  shame('Scham', '😳'),

  /// Freude - Glück, Zufriedenheit, Erleichterung
  joy('Freude', '😊'),

  /// Ekel - Abneigung, Widerwillen
  disgust('Ekel', '🤢'),

  /// Überraschung - Staunen, Schock
  surprise('Überraschung', '😲'),

  /// Schuldgefühle - Reue, Gewissensbisse
  guilt('Schuld', '😔'),

  /// Hilflosigkeit - nicht wissen, wie weiter
  helplessness('Hilflosigkeit', '🫳'),

  /// Leere - innerlich leer oder abgeschnitten
  emptiness('Leere', '🕳️'),

  /// Stolz - Selbstwertgefühl, Zufriedenheit mit sich
  pride('Stolz', '😌'),

  /// Einsamkeit - isoliert, nicht verbunden
  loneliness('Einsamkeit', '😶');

  final String label;
  final String emoji;

  const EmotionType(this.label, this.emoji);

  /// Get all negative emotions (used for filtering and patterns)
  static List<EmotionType> get negativeEmotions => [
        anger,
        fear,
        powerlessness,
        overwhelm,
        disappointment,
        hurt,
        sadness,
        shame,
        disgust,
        guilt,
        helplessness,
        emptiness,
        loneliness,
      ];

  /// Get all positive emotions
  static List<EmotionType> get positiveEmotions => [
        joy,
        pride,
        surprise,
      ];

  static List<EmotionType> get flowOptions => [
        anger,
        shame,
        fear,
        powerlessness,
        overwhelm,
        disappointment,
        hurt,
        sadness,
        helplessness,
        annoyance,
        guilt,
        emptiness,
      ];

  /// Get display label with emoji
  String get displayLabel => '$emoji $label';

  /// Check if this is a negative emotion
  bool get isNegative => negativeEmotions.contains(this);

  /// Check if this is a positive emotion
  bool get isPositive => positiveEmotions.contains(this);
}

/// Extension for EmotionType with additional helper methods
extension EmotionTypeExtension on EmotionType {
  /// Get a description for the emotion
  String get description {
    switch (this) {
      case EmotionType.anger:
        return 'Gefühl von Ärger, Groll oder Frustration';
      case EmotionType.annoyance:
        return 'Gereizt, genervt oder schnell angefasst';
      case EmotionType.fear:
        return 'Sorgen, Ängste oder Furcht vor etwas';
      case EmotionType.powerlessness:
        return 'Gefühl von Ausgeliefertsein oder fehlendem Einfluss';
      case EmotionType.overwhelm:
        return 'Zu viel auf einmal, innerer Druck oder Überlastung';
      case EmotionType.disappointment:
        return 'Enttäuscht oder innerlich abgesackt';
      case EmotionType.hurt:
        return 'Innerlich getroffen, gekränkt oder verletzt';
      case EmotionType.sadness:
        return 'Niedergeschlagenheit, Trauer oder Leere';
      case EmotionType.shame:
        return 'Gefühl von Beschämung oder Bloßstellung';
      case EmotionType.joy:
        return 'Glück, Zufriedenheit oder Erleichterung';
      case EmotionType.disgust:
        return 'Abneigung oder Widerwillen';
      case EmotionType.surprise:
        return 'Überraschung oder unerwartete Ereignisse';
      case EmotionType.guilt:
        return 'Schuldgefühle oder Reue';
      case EmotionType.helplessness:
        return 'Gefühl, nicht zu wissen, wie es weitergeht';
      case EmotionType.emptiness:
        return 'Innerlich leer oder abgeschnitten';
      case EmotionType.pride:
        return 'Stolz auf etwas oder sich selbst';
      case EmotionType.loneliness:
        return 'Gefühl der Isolation oder Einsamkeit';
    }
  }

  /// Get color code associated with this emotion
  int get colorCode {
    switch (this) {
      case EmotionType.anger:
        return 0xFFC05C5C; // Red
      case EmotionType.annoyance:
        return 0xFFCF7A4C; // Orange-red
      case EmotionType.fear:
        return 0xFF8B5FBF; // Purple
      case EmotionType.powerlessness:
        return 0xFF847F96; // Muted violet
      case EmotionType.overwhelm:
        return 0xFFD4A574; // Brownish
      case EmotionType.disappointment:
        return 0xFF8E7C71; // Warm gray
      case EmotionType.hurt:
        return 0xFFB56576; // Rose
      case EmotionType.sadness:
        return 0xFF6B8E9B; // Blue-gray
      case EmotionType.shame:
        return 0xFFD4A574; // Brownish
      case EmotionType.joy:
        return 0xFF6B9080; // Green
      case EmotionType.disgust:
        return 0xFF9B8B5F; // Olive
      case EmotionType.surprise:
        return 0xFFE9B44C; // Orange
      case EmotionType.guilt:
        return 0xFF7B8FA1; // Gray-blue
      case EmotionType.helplessness:
        return 0xFF6C7A89; // Slate
      case EmotionType.emptiness:
        return 0xFF6E7280; // Neutral gray
      case EmotionType.pride:
        return 0xFF4A6FA5; // Blue
      case EmotionType.loneliness:
        return 0xFF8899A6; // Desaturated blue
    }
  }
}
