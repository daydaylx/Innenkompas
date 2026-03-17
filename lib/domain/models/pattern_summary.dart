import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:innenkompass/core/constants/emotion_types.dart';
import 'package:innenkompass/core/constants/context_types.dart';
import 'package:innenkompass/core/constants/impulse_types.dart';
import 'package:innenkompass/core/constants/system_states.dart';
import 'package:innenkompass/domain/models/intervention.dart';

part 'pattern_summary.freezed.dart';
part 'pattern_summary.g.dart';

/// Häufigkeit eines Elements mit Prozentanteil
@freezed
class FrequencyEntry with _$FrequencyEntry {
  const factory FrequencyEntry({
    required String label,
    required int count,
    required double percentage,
    String? emoji,
  }) = _FrequencyEntry;

  factory FrequencyEntry.fromJson(Map<String, dynamic> json) =>
      _$FrequencyEntryFromJson(json);
}

/// Trend-Datenpunkt für Zeitverläufe
@freezed
class TrendDataPoint with _$TrendDataPoint {
  const factory TrendDataPoint({
    required DateTime date,
    required double value,
    double? secondaryValue, // z.B. Körperanspannung
    int? entryCount,
  }) = _TrendDataPoint;

  factory TrendDataPoint.fromJson(Map<String, dynamic> json) =>
      _$TrendDataPointFromJson(json);
}

/// Trigger-Muster: Welche Kombinationen treten häufig auf
@freezed
class TriggerPattern with _$TriggerPattern {
  const factory TriggerPattern({
    /// Kontext der Situation
    required ContextType context,

    /// Häufigste Emotion in diesem Kontext
    required EmotionType emotion,

    /// Durchschnittliche Intensität
    required double avgIntensity,

    /// Häufigkeit dieses Musters
    required int occurrenceCount,

    /// Häufigster Impuls
    ImpulseType? commonImpulse,

    /// Häufigster Systemzustand
    SystemState? commonState,
  }) = _TriggerPattern;

  factory TriggerPattern.fromJson(Map<String, dynamic> json) =>
      _$TriggerPatternFromJson(json);
}

/// Zeitmuster: Zu welchen Zeiten treten welche Emotionen auf
@freezed
class TimePatterns with _$TimePatterns {
  const factory TimePatterns({
    /// Häufigkeit nach Wochentagen (0=Sonntag, 6=Samstag)
    required List<int> weekdayDistribution,

    /// Häufigkeit nach Tageszeiten (morgen, mittag, abend, nacht)
    required Map<String, int> timeOfDayDistribution,

    /// Durchschnittliche Intensität nach Wochentag
    required List<double> avgIntensityByWeekday,

    /// Meiste Belastung an welchem Wochentag
    required int mostStressfulWeekday,
  }) = _TimePatterns;

  factory TimePatterns.fromJson(Map<String, dynamic> json) =>
      _$TimePatternsFromJson(json);
}

/// Zusammenfassung aller Muster in den Einträgen
@freezed
class PatternSummary with _$PatternSummary {
  const factory PatternSummary({
    /// Gesamtanzahl der analysierten Einträge
    required int totalEntries,

    /// Zeitspanne der Analyse
    required DateTime startDate,
    required DateTime endDate,

    /// Emotions-Häufigkeit
    required Map<EmotionType, int> emotionFrequency,

    /// Kontext-Häufigkeit
    required Map<ContextType, int> contextFrequency,

    /// Impuls-Häufigkeit
    required Map<ImpulseType, int> impulseFrequency,

    /// Systemzustand-Häufigkeit
    required Map<SystemState, int> systemStateFrequency,

    /// Belastungs-Trend über Zeit
    required List<TrendDataPoint> intensityTrend,

    /// Körperanspannungs-Trend über Zeit
    required List<TrendDataPoint> tensionTrend,

    /// Effektivste Interventionen
    required List<InterventionEffectiveness> mostEffectiveInterventions,

    /// Häufigste Trigger-Muster
    required List<TriggerPattern> commonTriggers,

    /// Zeitmuster
    TimePatterns? timePatterns,

    /// Durchschnittliche Intensität
    required double avgIntensity,

    /// Durchschnittliche Körperanspannung
    required double avgBodyTension,

    /// Verbesserung durch Interventionen (Durchschnitt)
    required double avgImprovement,

    /// Häufigste Emotion (Top 1)
    EmotionType? mostCommonEmotion,

    /// Häufigster Kontext (Top 1)
    ContextType? mostCommonContext,

    /// Häufigster Systemzustand (Top 1)
    SystemState? mostCommonState,
  }) = _PatternSummary;

  factory PatternSummary.fromJson(Map<String, dynamic> json) =>
      _$PatternSummaryFromJson(json);

  /// Leere PatternSummary für keinen Datensatz
  factory PatternSummary.empty() => PatternSummary(
        totalEntries: 0,
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        emotionFrequency: {},
        contextFrequency: {},
        impulseFrequency: {},
        systemStateFrequency: {},
        intensityTrend: [],
        tensionTrend: [],
        mostEffectiveInterventions: [],
        commonTriggers: [],
        timePatterns: null,
        avgIntensity: 0,
        avgBodyTension: 0,
        avgImprovement: 0,
      );
}

/// Filter-Kriterien für die Verlaufsanzeige
@freezed
class HistoryFilter with _$HistoryFilter {
  const factory HistoryFilter({
    /// Zeitraum-Filter
    DateRangeFilter? dateRange,

    /// Emotionen-Filter
    List<EmotionType>? emotions,

    /// Kontext-Filter
    List<ContextType>? contexts,

    /// Systemzustand-Filter
    List<SystemState>? systemStates,

    /// Nur Einträge mit Intervention?
    bool? withInterventionOnly,

    /// Nur Einträge mit Krisen-Flag?
    bool? crisisOnly,

    /// Suchtext (in Beschreibung/Gedanke)
    String? searchText,
  }) = _HistoryFilter;

  factory HistoryFilter.fromJson(Map<String, dynamic> json) =>
      _$HistoryFilterFromJson(json);
}

/// Zeitraum-Filter für Verlauf
enum DateRangeFilter {
  letzte7Tage,
  letzte30Tage,
  letzte90Tage,
  alle,
  benutzerdefiniert,
}

extension DateRangeFilterExtension on DateRangeFilter {
  DateTime? getStartDate() {
    final now = DateTime.now();
    switch (this) {
      case DateRangeFilter.letzte7Tage:
        return now.subtract(const Duration(days: 7));
      case DateRangeFilter.letzte30Tage:
        return now.subtract(const Duration(days: 30));
      case DateRangeFilter.letzte90Tage:
        return now.subtract(const Duration(days: 90));
      case DateRangeFilter.alle:
        return null;
      case DateRangeFilter.benutzerdefiniert:
        return null;
    }
  }

  String toDisplayString() {
    switch (this) {
      case DateRangeFilter.letzte7Tage:
        return 'Letzte 7 Tage';
      case DateRangeFilter.letzte30Tage:
        return 'Letzte 30 Tage';
      case DateRangeFilter.letzte90Tage:
        return 'Letzte 90 Tage';
      case DateRangeFilter.alle:
        return 'Alle Einträge';
      case DateRangeFilter.benutzerdefiniert:
        return 'Benutzerdefiniert';
    }
  }
}
