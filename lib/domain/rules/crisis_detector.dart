import '../../core/constants/emotion_types.dart';
import '../../core/constants/context_types.dart';

/// Crisis detector for identifying potential crisis situations.
///
/// In the MVP, this uses explicit flags and pattern-based detection
/// rather than free text analysis. It checks for:
/// - Extreme intensity/body tension values
/// - Hopelessness keywords in thoughts
/// - Extreme emotional combinations
///
/// This is a safety-critical component - when in doubt, it should
/// err on the side of caution and flag potential crisis.
class CrisisDetector {
  CrisisDetector._();

  /// Detect whether the current situation indicates a crisis.
  ///
  /// Returns a [CrisisDetectionResult] containing the crisis status,
  /// list of indicators found, and severity level.
  static CrisisDetectionResult detect({
    required int intensity,
    required int bodyTension,
    required EmotionType primaryEmotion,
    required String automaticThought,
    required ContextType context,
  }) {
    final indicators = <String>[];
    bool isCrisis = false;

    // Criterion 1: Extremely high burden (intensity or body tension at max)
    if (intensity >= 9 || bodyTension >= 9) {
      indicators.add(
          'Extrem hohe Belastung (Intensität: $intensity, Anspannung: $bodyTension)');
      isCrisis = true;
    }

    // Criterion 2: Hopelessness keywords in thought
    if (_containsHopelessnessKeywords(automaticThought)) {
      indicators.add('Gedanken enthalten hoffnungslose Begriffe');
      isCrisis = true;
    }

    // Criterion 3: Extreme shame with high intensity
    // Only flagged if combined with other factors
    if (primaryEmotion == EmotionType.shame && intensity >= 8) {
      indicators.add('Extreme Scham mit hoher Intensität');
      // This alone doesn't trigger crisis - needs other indicators
      // But we track it
    }

    // Criterion 4: Hopelessness-emotion combinations
    // Shame + fear at high intensity
    if ((primaryEmotion == EmotionType.shame ||
            primaryEmotion == EmotionType.fear) &&
        intensity >= 8 &&
        bodyTension >= 7) {
      indicators
          .add('Kombination aus starker Scham/Angst und hoher Anspannung');
      isCrisis = true;
    }

    // Criterion 5: Extremely high values in both metrics
    if (intensity >= 8 && bodyTension >= 8) {
      if (!indicators.any((i) => i.contains('Extrem hohe Belastung'))) {
        indicators.add('Sehr hohe emotionale und körperliche Belastung');
      }
      isCrisis = true;
    }

    return CrisisDetectionResult(
      isCrisis: isCrisis,
      indicators: indicators,
      severity: _calculateSeverity(indicators, intensity, bodyTension),
    );
  }

  /// Check if the thought contains hopelessness-related keywords.
  static bool _containsHopelessnessKeywords(String thought) {
    final keywords = [
      'hoffnungslos',
      'kein ausweg',
      'keinen ausweg', // Added more natural German phrasing
      'nimm mir das leben',
      'sterben',
      'tot',
      'ende',
      'niemand',
      'sinnlos',
      'kann nicht mehr',
      'lieber tot',
      'leben ist sinnlos',
      'wunsch zu sterben',
      'schluss machen',
    ];

    final lowerThought = thought.toLowerCase();
    return keywords.any((keyword) => lowerThought.contains(keyword));
  }

  /// Calculate the severity level based on indicators and values.
  static CrisisSeverity _calculateSeverity(
    List<String> indicators,
    int intensity,
    int bodyTension,
  ) {
    if (indicators.isEmpty) {
      return CrisisSeverity.none;
    }

    // High severity: Multiple indicators or extreme values
    if (indicators.length >= 3 || intensity == 10 || bodyTension == 10) {
      return CrisisSeverity.high;
    }

    // Medium severity: 2 indicators or very high values
    if (indicators.length >= 2 || intensity >= 9 || bodyTension >= 9) {
      return CrisisSeverity.medium;
    }

    // Low severity: 1 indicator
    if (indicators.length == 1) {
      return CrisisSeverity.low;
    }

    return CrisisSeverity.none;
  }

  /// Quick check for crisis (used in emergency flows).
  ///
  /// Returns true if any critical crisis indicators are present.
  static bool isEmergencyCrisis({
    required int intensity,
    required int bodyTension,
    required String automaticThought,
  }) {
    // Check for explicit keywords indicating immediate danger
    final emergencyKeywords = [
      'nimm mir das leben',
      'sterben will',
      'selbstmord',
      'suizid',
      'leben beenden',
    ];

    final lowerThought = automaticThought.toLowerCase();
    if (emergencyKeywords.any((k) => lowerThought.contains(k))) {
      return true;
    }

    // Check for extreme burden
    if (intensity == 10 && bodyTension >= 8) {
      return true;
    }

    return false;
  }
}

/// Result of crisis detection.
class CrisisDetectionResult {
  const CrisisDetectionResult({
    required this.isCrisis,
    required this.indicators,
    required this.severity,
  });

  /// Whether a crisis was detected.
  final bool isCrisis;

  /// List of indicators that contributed to the crisis detection.
  final List<String> indicators;

  /// Severity level of the crisis.
  final CrisisSeverity severity;

  @override
  String toString() {
    return 'CrisisDetectionResult(isCrisis: $isCrisis, severity: $severity, indicators: $indicators)';
  }
}

/// Severity levels for crisis detection.
enum CrisisSeverity {
  /// No crisis detected.
  none,

  /// Low severity - some indicators present, but not critical.
  low,

  /// Medium severity - multiple indicators or high values.
  medium,

  /// High severity - strong indicators, immediate attention recommended.
  high,
}

/// Extension for CrisisSeverity with helper methods.
extension CrisisSeverityExtension on CrisisSeverity {
  /// Get display label for this severity.
  String get displayLabel {
    switch (this) {
      case CrisisSeverity.none:
        return 'Keine Krise';
      case CrisisSeverity.low:
        return 'Niedrige Dringlichkeit';
      case CrisisSeverity.medium:
        return 'Mittlere Dringlichkeit';
      case CrisisSeverity.high:
        return 'Hohe Dringlichkeit';
    }
  }

  /// Get color code for this severity.
  int get colorCode {
    switch (this) {
      case CrisisSeverity.none:
        return 0xFF6B9080; // Green
      case CrisisSeverity.low:
        return 0xFFE9B44C; // Orange
      case CrisisSeverity.medium:
        return 0xFFD4A574; // Brown-orange
      case CrisisSeverity.high:
        return 0xFFB03030; // Dark red
    }
  }

  /// Check if this severity requires immediate attention.
  bool get requiresImmediateAttention {
    return this == CrisisSeverity.high;
  }

  /// Check if this severity requires some attention.
  bool get requiresAttention {
    return this != CrisisSeverity.none;
  }
}
