import 'package:collection/collection.dart';
import 'package:innenkompass/core/constants/emotion_types.dart';
import 'package:innenkompass/core/constants/context_types.dart';
import 'package:innenkompass/core/constants/impulse_types.dart';
import 'package:innenkompass/core/constants/system_states.dart';
import 'package:innenkompass/data/db/app_database.dart';
import 'package:innenkompass/domain/models/pattern_summary.dart';

/// Service zur Analyse von Mustern in Situationseinträgen
class PatternAnalyzer {
  /// Analysiert alle Einträge und gibt eine Zusammenfassung der Muster zurück
  static Future<PatternSummary> analyzePatterns(
    List<SituationEntryData> entries,
  ) async {
    if (entries.isEmpty) {
      return PatternSummary.empty();
    }

    final sortedEntries = entries..sort((a, b) => a.createdAt.compareTo(b.createdAt));

    return PatternSummary(
      totalEntries: entries.length,
      startDate: sortedEntries.first.createdAt,
      endDate: sortedEntries.last.createdAt,
      emotionFrequency: _calculateEmotionFrequency(entries),
      contextFrequency: _calculateContextFrequency(entries),
      impulseFrequency: _calculateImpulseFrequency(entries),
      systemStateFrequency: _calculateSystemStateFrequency(entries),
      intensityTrend: _calculateIntensityTrend(sortedEntries),
      tensionTrend: _calculateTensionTrend(sortedEntries),
      mostEffectiveInterventions: _findMostEffectiveInterventions(entries),
      commonTriggers: _findCommonTriggers(entries),
      timePatterns: _analyzeTimePatterns(entries),
      avgIntensity: _calculateAverageIntensity(entries),
      avgBodyTension: _calculateAverageBodyTension(entries),
      avgImprovement: _calculateAverageImprovement(entries),
      mostCommonEmotion: _findMostCommonEmotion(entries),
      mostCommonContext: _findMostCommonContext(entries),
      mostCommonState: _findMostCommonState(entries),
    );
  }

  /// Berechnet die Häufigkeit jeder Emotion
  static Map<EmotionType, int> _calculateEmotionFrequency(
    List<SituationEntryData> entries,
  ) {
    final frequency = <EmotionType, int>{};
    for (final entry in entries) {
      final emotion = entry.primaryEmotion;
      frequency[emotion] = (frequency[emotion] ?? 0) + 1;
    }
    return frequency;
  }

  /// Berechnet die Häufigkeit jedes Kontexts
  static Map<ContextType, int> _calculateContextFrequency(
    List<SituationEntryData> entries,
  ) {
    final frequency = <ContextType, int>{};
    for (final entry in entries) {
      final context = entry.context;
      frequency[context] = (frequency[context] ?? 0) + 1;
    }
    return frequency;
  }

  /// Berechnet die Häufigkeit jedes Impulses
  static Map<ImpulseType, int> _calculateImpulseFrequency(
    List<SituationEntryData> entries,
  ) {
    final frequency = <ImpulseType, int>{};
    for (final entry in entries) {
      final impulse = entry.firstImpulse;
      frequency[impulse] = (frequency[impulse] ?? 0) + 1;
    }
    return frequency;
  }

  /// Berechnet die Häufigkeit jedes Systemzustands
  static Map<SystemState, int> _calculateSystemStateFrequency(
    List<SituationEntryData> entries,
  ) {
    final frequency = <SystemState, int>{};
    for (final entry in entries) {
      if (entry.systemState != null) {
        try {
          final state = SystemState.fromString(entry.systemState!);
          frequency[state] = (frequency[state] ?? 0) + 1;
        } catch (_) {
          // Ungültiger State überspringen
        }
      }
    }
    return frequency;
  }

  /// Berechnet den Intensitäts-Trend über Zeit
  static List<TrendDataPoint> _calculateIntensityTrend(
    List<SituationEntryData> sortedEntries,
  ) {
    // Gruppiere nach Tag
    final grouped = <DateTime, List<double>>{};
    for (final entry in sortedEntries) {
      final day = DateTime(
        entry.createdAt.year,
        entry.createdAt.month,
        entry.createdAt.day,
      );
      grouped[day] = [...grouped[day] ?? [], entry.intensity.toDouble()];
    }

    // Berechne Durchschnitt pro Tag
    return grouped.entries
        .map((e) => TrendDataPoint(
              date: e.key,
              value: e.value.reduce((a, b) => a + b) / e.value.length,
              entryCount: e.value.length,
            ))
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));
  }

  /// Berechnet den Körperanspannungs-Trend über Zeit
  static List<TrendDataPoint> _calculateTensionTrend(
    List<SituationEntryData> sortedEntries,
  ) {
    // Gruppiere nach Tag
    final grouped = <DateTime, List<double>>{};
    for (final entry in sortedEntries) {
      final day = DateTime(
        entry.createdAt.year,
        entry.createdAt.month,
        entry.createdAt.day,
      );
      grouped[day] = [...grouped[day] ?? [], entry.bodyTension.toDouble()];
    }

    // Berechne Durchschnitt pro Tag
    return grouped.entries
        .map((e) => TrendDataPoint(
              date: e.key,
              value: e.value.reduce((a, b) => a + b) / e.value.length,
              entryCount: e.value.length,
            ))
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));
  }

  /// Findet die effektivsten Interventionen
  static List<InterventionEffectiveness> _findMostEffectiveInterventions(
    List<SituationEntryData> entries,
  ) {
    // Nur Einträge mit abgeschlossener Intervention
    final withIntervention = entries
        .where((e) =>
            e.interventionCompletedAt != null &&
            e.postIntensity != null &&
            e.postBodyTension != null)
        .toList();

    if (withIntervention.isEmpty) return [];

    // Gruppiere nach Interventionstyp
    final grouped = <String, List<SituationEntryData>>{};
    for (final entry in withIntervention) {
      final type = entry.interventionType ?? 'unknown';
      grouped[type] = [...grouped[type] ?? [], entry];
    }

    // Berechne Effektivität pro Typ
    final effectiveness = grouped.entries.map((e) {
      final typeEntries = e.value;
      final improvements = <double>[];
      final tensionImprovements = <double>[];
      final clarityGains = <double>[];
      final helpfulnessRatings = <double>[];

      for (final entry in typeEntries) {
        improvements.add(entry.intensity - (entry.postIntensity ?? 0));
        tensionImprovements
            .add(entry.bodyTension - (entry.postBodyTension ?? 0));
        clarityGains.add(entry.postClarity ?? 0);
        helpfulnessRatings.add(entry.helpfulnessRating?.toDouble() ?? 0);
      }

      return InterventionEffectiveness(
        interventionId: e.key,
        title: _getInterventionTitle(e.key),
        type: _getInterventionType(e.key),
        usageCount: typeEntries.length,
        avgImprovement: improvements.reduce((a, b) => a + b) / improvements.length,
        avgTensionImprovement: tensionImprovements.isEmpty
            ? 0
            : tensionImprovements.reduce((a, b) => a + b) / tensionImprovements.length,
        avgClarityGain: clarityGains.isEmpty
            ? 0
            : clarityGains.reduce((a, b) => a + b) / clarityGains.length,
        avgHelpfulnessRating: helpfulnessRatings.isEmpty
            ? 0
            : helpfulnessRatings.reduce((a, b) => a + b) / helpfulnessRatings.length,
        lastUsedAt: typeEntries
            .map((e) => e.interventionCompletedAt ?? e.createdAt)
            .reduce((a, b) => a.isAfter(b) ? a : b),
      );
    }).toList();

    // Sortiere nach durchschnittlicher Verbesserung
    effectiveness.sort((a, b) => b.avgImprovement.compareTo(a.avgImprovement));
    return effectiveness;
  }

  /// Findet häufigste Trigger-Muster
  static List<TriggerPattern> _findCommonTriggers(
    List<SituationEntryData> entries,
  ) {
    // Gruppiere nach Kontext
    final byContext = <ContextType, List<SituationEntryData>>{};
    for (final entry in entries) {
      byContext[entry.context] = [...byContext[entry.context] ?? [], entry];
    }

    // Für jeden Kontext: häufigste Emotion finden
    final patterns = <TriggerPattern>[];
    for (final entry in byContext.entries) {
      if (entry.value.length < 2) continue; // Mindestens 2 Vorkommnisse

      // Häufigste Emotion
      final emotionFreq = <EmotionType, int>{};
      for (final e in entry.value) {
        emotionFreq[e.primaryEmotion] = (emotionFreq[e.primaryEmotion] ?? 0) + 1;
      }
      final mostCommonEmotion = emotionFreq.entries
          .reduce((a, b) => a.value > b.value ? a : b)
          .key;

      // Durchschnittliche Intensität
      final avgIntensity = entry.value
              .map((e) => e.intensity)
              .reduce((a, b) => a + b) /
          entry.value.length;

      // Häufigster Impuls
      final impulseFreq = <ImpulseType, int>{};
      for (final e in entry.value) {
        impulseFreq[e.firstImpulse] = (impulseFreq[e.firstImpulse] ?? 0) + 1;
      }
      final commonImpulse = impulseFreq.entries.isNotEmpty
          ? impulseFreq.entries.reduce((a, b) => a.value > b.value ? a : b).key
          : null;

      // Häufigster Systemzustand
      final stateFreq = <SystemState, int>{};
      for (final e in entry.value) {
        if (e.systemState != null) {
          try {
            final state = SystemState.fromString(e.systemState!);
            stateFreq[state] = (stateFreq[state] ?? 0) + 1;
          } catch (_) {}
        }
      }
      final commonState = stateFreq.entries.isNotEmpty
          ? stateFreq.entries.reduce((a, b) => a.value > b.value ? a : b).key
          : null;

      patterns.add(TriggerPattern(
        context: entry.key,
        emotion: mostCommonEmotion,
        avgIntensity: avgIntensity,
        occurrenceCount: entry.value.length,
        commonImpulse: commonImpulse,
        commonState: commonState,
      ));
    }

    // Sortiere nach Häufigkeit
    patterns.sort((a, b) => b.occurrenceCount.compareTo(a.occurrenceCount));
    return patterns.take(5).toList();
  }

  /// Analysiert Zeitmuster
  static TimePatterns? _analyzeTimePatterns(
    List<SituationEntryData> entries,
  ) {
    if (entries.isEmpty) return null;

    // Verteilung nach Wochentagen (0=Sonntag, 6=Samstag)
    final weekdayDist = List.filled(7, 0);
    final weekdayIntensity = List.filled(7, <double>[]);

    // Verteilung nach Tageszeiten
    final timeOfDayDist = <String, int>{
      'morgen': 0,
      'mittag': 0,
      'abend': 0,
      'nacht': 0,
    };

    for (final entry in entries) {
      final weekday = entry.createdAt.weekday % 7; // 0=Montag, 6=Sonntag
      weekdayDist[weekday]++;
      weekdayIntensity[weekday].add(entry.intensity.toDouble());

      final hour = entry.createdAt.hour;
      if (hour >= 6 && hour < 12) {
        timeOfDayDist['morgen'] = timeOfDayDist['morgen']! + 1;
      } else if (hour >= 12 && hour < 18) {
        timeOfDayDist['mittag'] = timeOfDayDist['mittag']! + 1;
      } else if (hour >= 18 && hour < 23) {
        timeOfDayDist['abend'] = timeOfDayDist['abend']! + 1;
      } else {
        timeOfDayDist['nacht'] = timeOfDayDist['nacht']! + 1;
      }
    }

    // Berechne durchschnittliche Intensität pro Wochentag
    final avgIntensityByWeekday = weekdayIntensity.map((intensities) {
      if (intensities.isEmpty) return 0.0;
      return intensities.reduce((a, b) => a + b) / intensities.length;
    }).toList();

    // Finde stressigsten Wochentag
    final mostStressfulWeekday = avgIntensityByWeekday
        .indexOf(avgIntensityByWeekday.reduce((a, b) => a > b ? a : b));

    return TimePatterns(
      weekdayDistribution: weekdayDist,
      timeOfDayDistribution: timeOfDayDist,
      avgIntensityByWeekday: avgIntensityByWeekday,
      mostStressfulWeekday: mostStressfulWeekday,
    );
  }

  /// Berechnet die durchschnittliche Intensität
  static double _calculateAverageIntensity(List<SituationEntryData> entries) {
    if (entries.isEmpty) return 0;
    return entries.map((e) => e.intensity).reduce((a, b) => a + b) / entries.length;
  }

  /// Berechnet die durchschnittliche Körperanspannung
  static double _calculateAverageBodyTension(List<SituationEntryData> entries) {
    if (entries.isEmpty) return 0;
    return entries.map((e) => e.bodyTension).reduce((a, b) => a + b) / entries.length;
  }

  /// Berechnet die durchschnittliche Verbesserung
  static double _calculateAverageImprovement(List<SituationEntryData> entries) {
    final withPost = entries
        .where((e) => e.postIntensity != null)
        .toList();

    if (withPost.isEmpty) return 0;

    final improvements = withPost
        .map((e) => e.intensity - e.postIntensity!)
        .toList();

    return improvements.reduce((a, b) => a + b) / improvements.length;
  }

  /// Findet die häufigste Emotion
  static EmotionType? _findMostCommonEmotion(List<SituationEntryData> entries) {
    if (entries.isEmpty) return null;

    final freq = _calculateEmotionFrequency(entries);
    if (freq.isEmpty) return null;

    return freq.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }

  /// Findet den häufigsten Kontext
  static ContextType? _findMostCommonContext(List<SituationEntryData> entries) {
    if (entries.isEmpty) return null;

    final freq = _calculateContextFrequency(entries);
    if (freq.isEmpty) return null;

    return freq.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }

  /// Findet den häufigsten Systemzustand
  static SystemState? _findMostCommonState(List<SituationEntryData> entries) {
    final withState = entries.where((e) => e.systemState != null).toList();
    if (withState.isEmpty) return null;

    final freq = _calculateSystemStateFrequency(withState);
    if (freq.isEmpty) return null;

    return freq.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }

  /// Hilfsfunktion: Titel einer Intervention
  static String _getInterventionTitle(String typeId) {
    final titleMap = {
      'regulation': 'Regulation',
      'factCheck': 'Fakt vs. Deutung',
      'impulsePause': 'Impulspause',
      'ruminationStop': 'Grübelstopp',
      'communication': 'Kommunikationshilfe',
      'overwhelmStructure': 'Überforderungsstruktur',
      'selfValueCheck': 'Selbstabwertungscheck',
    };
    return titleMap[typeId] ?? typeId;
  }

  /// Hilfsfunktion: InterventionType aus String
  static InterventionType _getInterventionType(String typeId) {
    final typeMap = {
      'regulation': InterventionType.regulation,
      'factCheck': InterventionType.factCheck,
      'impulsePause': InterventionType.impulsePause,
      'ruminationStop': InterventionType.ruminationStop,
      'communication': InterventionType.communication,
      'overwhelmStructure': InterventionType.overwhelmStructure,
      'selfValueCheck': InterventionType.selfValueCheck,
    };
    return typeMap[typeId] ?? InterventionType.regulation;
  }

  /// Filtert Einträge basierend auf Filter-Kriterien
  static List<SituationEntryData> filterEntries(
    List<SituationEntryData> entries,
    HistoryFilter filter,
  ) {
    var filtered = List<SituationEntryData>.from(entries);

    // Zeitraum-Filter
    if (filter.dateRange != null) {
      final startDate = filter.dateRange!.getStartDate();
      if (startDate != null) {
        filtered = filtered.where((e) => e.createdAt.isAfter(startDate)).toList();
      }
    }

    // Emotionen-Filter
    if (filter.emotions != null && filter.emotions!.isNotEmpty) {
      filtered = filtered
          .where((e) => filter.emotions!.contains(e.primaryEmotion))
          .toList();
    }

    // Kontext-Filter
    if (filter.contexts != null && filter.contexts!.isNotEmpty) {
      filtered = filtered
          .where((e) => filter.contexts!.contains(e.context))
          .toList();
    }

    // Systemzustand-Filter
    if (filter.systemStates != null && filter.systemStates!.isNotEmpty) {
      filtered = filtered
          .where((e) =>
              e.systemState != null &&
              filter.systemStates!.any((s) => s.name == e.systemState))
          .toList();
    }

    // Nur mit Intervention
    if (filter.withInterventionOnly == true) {
      filtered = filtered
          .where((e) => e.interventionType != null)
          .toList();
    }

    // Nur Krisen-Einträge
    if (filter.crisisOnly == true) {
      filtered = filtered.where((e) => e.isCrisis == true).toList();
    }

    // Suchtext
    if (filter.searchText != null && filter.searchText!.isNotEmpty) {
      final searchLower = filter.searchText!.toLowerCase();
      filtered = filtered
          .where((e) =>
              e.description.toLowerCase().contains(searchLower) ||
              e.automaticThought.toLowerCase().contains(searchLower))
          .toList();
    }

    return filtered;
  }

  /// Berechnet Statistiken für eine einzelne Emotion
  static Map<String, dynamic> getEmotionStats(
    List<SituationEntryData> entries,
    EmotionType emotion,
  ) {
    final emotionEntries = entries.where((e) => e.primaryEmotion == emotion).toList();

    if (emotionEntries.isEmpty) {
      return {
        'count': 0,
        'avgIntensity': 0.0,
        'avgTension': 0.0,
        'mostCommonContext': null,
        'mostCommonImpulse': null,
      };
    }

    final avgIntensity = emotionEntries
            .map((e) => e.intensity)
            .reduce((a, b) => a + b) /
        emotionEntries.length;

    final avgTension = emotionEntries
            .map((e) => e.bodyTension)
            .reduce((a, b) => a + b) /
        emotionEntries.length;

    // Häufigster Kontext für diese Emotion
    final contextFreq = <ContextType, int>{};
    for (final e in emotionEntries) {
      contextFreq[e.context] = (contextFreq[e.context] ?? 0) + 1;
    }
    final mostCommonContext = contextFreq.entries.isNotEmpty
        ? contextFreq.entries.reduce((a, b) => a.value > b.value ? a : b).key
        : null;

    // Häufigster Impuls für diese Emotion
    final impulseFreq = <ImpulseType, int>{};
    for (final e in emotionEntries) {
      impulseFreq[e.firstImpulse] = (impulseFreq[e.firstImpulse] ?? 0) + 1;
    }
    final mostCommonImpulse = impulseFreq.entries.isNotEmpty
        ? impulseFreq.entries.reduce((a, b) => a.value > b.value ? a : b).key
        : null;

    return {
      'count': emotionEntries.length,
      'avgIntensity': avgIntensity,
      'avgTension': avgTension,
      'mostCommonContext': mostCommonContext,
      'mostCommonImpulse': mostCommonImpulse,
    };
  }
}
