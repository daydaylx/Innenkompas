/// Emotion types supported by Innenkompass.
///
/// Based on the PRD specification, these are the primary emotions
/// that can be selected when logging a situation.
enum EmotionType {
  /// Wut - Ärger, Groll, Frustration
  anger('Wut', '😠'),

  /// Angst - Sorge, Furcht, Panik
  fear('Angst', '😨'),

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
        sadness,
        shame,
        disgust,
        guilt,
        loneliness,
      ];

  /// Get all positive emotions
  static List<EmotionType> get positiveEmotions => [
        joy,
        pride,
        surprise,
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
      case EmotionType.fear:
        return 'Sorgen, Ängste oder Furcht vor etwas';
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
      case EmotionType.fear:
        return 0xFF8B5FBF; // Purple
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
      case EmotionType.pride:
        return 0xFF4A6FA5; // Blue
      case EmotionType.loneliness:
        return 0xFF8899A6; // Desaturated blue
    }
  }
}
