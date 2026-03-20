import 'package:collection/collection.dart';
import 'package:innenkompass/core/constants/emotion_types.dart';
import 'package:innenkompass/core/constants/context_types.dart';
import 'package:innenkompass/core/constants/impulse_types.dart';
import 'package:innenkompass/core/constants/system_states.dart';
import 'package:innenkompass/core/constants/intervention_types.dart'
    show InterventionType;
import 'package:innenkompass/data/db/app_database.dart';
import 'package:innenkompass/domain/models/intervention.dart'
    show InterventionEffectiveness;
import 'package:innenkompass/domain/models/pattern_summary.dart';
import 'package:innenkompass/domain/services/intervention_resolver.dart';

/// Burnout-Risiko basierend auf aufeinanderfolgenden Tagen mit hoher Intensität
enum BurnoutRisk { low, medium, high }

/// Kontext-Emotions-Korrelation: Welche Emotionen überwiegen in einem Kontext
class ContextCorrelation {
  const ContextCorrelation({
    required this.context,
    required this.emotion,
    required this.contextPercentage,
    required this.emotionDominance,
    required this.occurrenceCount,
    required this.avgIntensity,
  });

  final ContextType context;
  final EmotionType emotion;

  /// Anteil dieser Kontext-Einträge an allen Einträgen (%)
  final double contextPercentage;

  /// Anteil der dominanten Emotion in diesem Kontext (%)
  final double emotionDominance;

  final int occurrenceCount;
  final double avgIntensity;
}

/// Service zur Analyse von Mustern in Situationseinträgen
class PatternAnalyzer {
  static String? buildEntryPatternHint({
    required SituationEntryData entry,
    required List<SituationEntryData> entries,
    int minMatches = 3,
  }) {
    final context = ContextType.fromRaw(entry.context);
    if (context == null) {
      return null;
    }

    final otherEntries = entries
        .where((candidate) => candidate.id != entry.id)
        .where((candidate) => candidate.context == entry.context)
        .toList(growable: false);
    if (otherEntries.length < minMatches) {
      return null;
    }

    final matchingStateEntries = otherEntries
        .where((candidate) => candidate.systemState == entry.systemState)
        .toList(growable: false);
    if (matchingStateEntries.length >= minMatches) {
      final state = SystemState.values
          .firstWhereOrNull((value) => value.name == entry.systemState);
      final stateLabel = state?.label.toLowerCase() ?? 'aehnlicher Belastung';
      return 'Dieses Muster taucht bei dir wiederholt in ${context.label} mit $stateLabel auf.';
    }

    final matchingEmotionEntries = otherEntries
        .where((candidate) => candidate.primaryEmotion == entry.primaryEmotion)
        .toList(growable: false);
    if (matchingEmotionEntries.length >= minMatches) {
      final emotion = EmotionType.values
          .firstWhereOrNull((value) => value.name == entry.primaryEmotion);
      final emotionLabel =
          emotion?.label.toLowerCase() ?? 'aehnlicher Reaktion';
      return 'Dieses Muster taucht bei dir wiederholt in ${context.label} mit $emotionLabel auf.';
    }

    final currentHighTension = entry.intensity >= 7 || entry.bodyTension >= 7;
    final highTensionEntries = currentHighTension
        ? otherEntries
            .where((candidate) =>
                candidate.intensity >= 7 || candidate.bodyTension >= 7)
            .toList(growable: false)
        : const <SituationEntryData>[];
    if (highTensionEntries.length >= minMatches) {
      return 'Dieses Muster taucht bei dir wiederholt in ${context.label} mit hoher Anspannung auf.';
    }

    return null;
  }

  /// Analysiert alle Einträge und gibt eine Zusammenfassung der Muster zurück
  static Future<PatternSummary> analyzePatterns(
    List<SituationEntryData> entries,
  ) async {
    if (entries.isEmpty) {
      return PatternSummary.empty();
    }

    final sortedEntries = List.of(entries)
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

    return PatternSummary(
      totalEntries: entries.length,
      startDate: sortedEntries.first.timestamp,
      endDate: sortedEntries.last.timestamp,
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
      final emotion = EmotionType.values
          .where((e) => e.name == entry.primaryEmotion)
          .firstOrNull;
      if (emotion != null) frequency[emotion] = (frequency[emotion] ?? 0) + 1;
    }
    return frequency;
  }

  /// Berechnet die Häufigkeit jedes Kontexts
  static Map<ContextType, int> _calculateContextFrequency(
    List<SituationEntryData> entries,
  ) {
    final frequency = <ContextType, int>{};
    for (final entry in entries) {
      final ctx =
          ContextType.values.where((e) => e.name == entry.context).firstOrNull;
      if (ctx != null) frequency[ctx] = (frequency[ctx] ?? 0) + 1;
    }
    return frequency;
  }

  /// Berechnet die Häufigkeit jedes Impulses
  static Map<ImpulseType, int> _calculateImpulseFrequency(
    List<SituationEntryData> entries,
  ) {
    final frequency = <ImpulseType, int>{};
    for (final entry in entries) {
      final impulse = ImpulseType.values
          .where((e) => e.name == entry.firstImpulse)
          .firstOrNull;
      if (impulse != null) frequency[impulse] = (frequency[impulse] ?? 0) + 1;
    }
    return frequency;
  }

  /// Berechnet die Häufigkeit jedes Systemzustands
  static Map<SystemState, int> _calculateSystemStateFrequency(
    List<SituationEntryData> entries,
  ) {
    final frequency = <SystemState, int>{};
    for (final entry in entries) {
      try {
        final state = SystemState.values
            .where((e) => e.name == entry.systemState)
            .firstOrNull;
        if (state == null) continue;
        frequency[state] = (frequency[state] ?? 0) + 1;
      } catch (_) {
        // Ungültiger State überspringen
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
        entry.timestamp.year,
        entry.timestamp.month,
        entry.timestamp.day,
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
        entry.timestamp.year,
        entry.timestamp.month,
        entry.timestamp.day,
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
            e.interventionCompleted == true &&
            e.postIntensity != null &&
            e.postBodyTension != null)
        .toList();

    if (withIntervention.isEmpty) return [];

    // Gruppiere bevorzugt nach konkreter Intervention, sonst nach Legacy-Typ.
    final grouped = <String, List<SituationEntryData>>{};
    for (final entry in withIntervention) {
      final key = _interventionKey(entry);
      grouped[key] = [...grouped[key] ?? [], entry];
    }

    // Berechne Effektivität pro Intervention
    final effectiveness = grouped.entries.map((e) {
      final typeEntries = e.value;
      final sampleEntry = typeEntries.first;
      final improvements = <double>[];
      final tensionImprovements = <double>[];
      final clarityGains = <double>[];
      final helpfulnessRatings = <double>[];

      for (final entry in typeEntries) {
        improvements
            .add((entry.intensity - (entry.postIntensity ?? 0)).toDouble());
        tensionImprovements
            .add((entry.bodyTension - (entry.postBodyTension ?? 0)).toDouble());
        clarityGains.add((entry.postClarity ?? 0).toDouble());
        helpfulnessRatings.add(entry.helpfulnessRating?.toDouble() ?? 0);
      }

      return InterventionEffectiveness(
        interventionId: e.key,
        title: _getInterventionTitle(sampleEntry),
        type: _getInterventionType(sampleEntry),
        usageCount: typeEntries.length,
        avgImprovement:
            improvements.reduce((a, b) => a + b) / improvements.length,
        avgTensionImprovement: tensionImprovements.isEmpty
            ? 0
            : tensionImprovements.reduce((a, b) => a + b) /
                tensionImprovements.length,
        avgClarityGain: clarityGains.isEmpty
            ? 0
            : clarityGains.reduce((a, b) => a + b) / clarityGains.length,
        avgHelpfulnessRating: helpfulnessRatings.isEmpty
            ? 0
            : helpfulnessRatings.reduce((a, b) => a + b) /
                helpfulnessRatings.length,
        lastUsedAt: typeEntries
            .map((e) => e.timestamp)
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
      final ctx =
          ContextType.values.where((e) => e.name == entry.context).firstOrNull;
      if (ctx == null) continue;
      byContext[ctx] = [...byContext[ctx] ?? [], entry];
    }

    // Für jeden Kontext: häufigste Emotion finden
    final patterns = <TriggerPattern>[];
    for (final entry in byContext.entries) {
      if (entry.value.length < 2) continue; // Mindestens 2 Vorkommnisse

      // Häufigste Emotion
      final emotionFreq = <EmotionType, int>{};
      for (final e in entry.value) {
        final em = EmotionType.values
            .where((et) => et.name == e.primaryEmotion)
            .firstOrNull;
        if (em != null) emotionFreq[em] = (emotionFreq[em] ?? 0) + 1;
      }
      final mostCommonEmotion =
          emotionFreq.entries.reduce((a, b) => a.value > b.value ? a : b).key;

      // Durchschnittliche Intensität
      final avgIntensity =
          entry.value.map((e) => e.intensity).reduce((a, b) => a + b) /
              entry.value.length;

      // Häufigster Impuls
      final impulseFreq = <ImpulseType, int>{};
      for (final e in entry.value) {
        final imp = ImpulseType.values
            .where((it) => it.name == e.firstImpulse)
            .firstOrNull;
        if (imp != null) impulseFreq[imp] = (impulseFreq[imp] ?? 0) + 1;
      }
      final commonImpulse = impulseFreq.entries.isNotEmpty
          ? impulseFreq.entries.reduce((a, b) => a.value > b.value ? a : b).key
          : null;

      // Häufigster Systemzustand
      final stateFreq = <SystemState, int>{};
      for (final e in entry.value) {
        final state = SystemState.values
            .where((s) => s.name == e.systemState)
            .firstOrNull;
        if (state != null) stateFreq[state] = (stateFreq[state] ?? 0) + 1;
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
      final weekday = entry.timestamp.weekday - 1; // 0=Montag, 6=Sonntag
      weekdayDist[weekday]++;
      weekdayIntensity[weekday].add(entry.intensity.toDouble());

      final hour = entry.timestamp.hour;
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
      return (intensities.reduce((a, b) => a + b) / intensities.length)
          .toDouble();
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
    return (entries.map((e) => e.intensity).reduce((a, b) => a + b) /
            entries.length)
        .toDouble();
  }

  /// Berechnet die durchschnittliche Körperanspannung
  static double _calculateAverageBodyTension(List<SituationEntryData> entries) {
    if (entries.isEmpty) return 0;
    return (entries.map((e) => e.bodyTension).reduce((a, b) => a + b) /
            entries.length)
        .toDouble();
  }

  /// Berechnet die durchschnittliche Verbesserung
  static double _calculateAverageImprovement(List<SituationEntryData> entries) {
    final withPost = entries.where((e) => e.postIntensity != null).toList();

    if (withPost.isEmpty) return 0;

    final improvements =
        withPost.map((e) => e.intensity - e.postIntensity!).toList();

    return (improvements.reduce((a, b) => a + b) / improvements.length)
        .toDouble();
  }

  /// Findet die häufigste Emotion
  static EmotionType? _findMostCommonEmotion(List<SituationEntryData> entries) {
    if (entries.isEmpty) return null;

    final freq = _calculateEmotionFrequency(entries);
    if (freq.isEmpty) return null;

    return freq.entries.reduce((a, b) => a.value > b.value ? a : b).key;
  }

  /// Findet den häufigsten Kontext
  static ContextType? _findMostCommonContext(List<SituationEntryData> entries) {
    if (entries.isEmpty) return null;

    final freq = _calculateContextFrequency(entries);
    if (freq.isEmpty) return null;

    return freq.entries.reduce((a, b) => a.value > b.value ? a : b).key;
  }

  /// Findet den häufigsten Systemzustand
  static SystemState? _findMostCommonState(List<SituationEntryData> entries) {
    if (entries.isEmpty) return null;

    final freq = _calculateSystemStateFrequency(entries);
    if (freq.isEmpty) return null;

    return freq.entries.reduce((a, b) => a.value > b.value ? a : b).key;
  }

  /// Hilfsfunktion: Titel einer Intervention
  static String _getInterventionTitle(SituationEntryData entry) {
    return InterventionResolver.labelForStoredReference(
      interventionId: entry.interventionId,
      interventionTypeRaw: entry.interventionType,
    );
  }

  /// Hilfsfunktion: InterventionType aus String
  static InterventionType _getInterventionType(SituationEntryData entry) {
    return InterventionResolver.typeForStoredReference(
          interventionId: entry.interventionId,
          interventionTypeRaw: entry.interventionType,
        ) ??
        InterventionType.regulation;
  }

  static String _interventionKey(SituationEntryData entry) {
    final interventionId = entry.interventionId?.trim();
    if (interventionId != null && interventionId.isNotEmpty) {
      return interventionId;
    }

    final interventionType = entry.interventionType?.trim();
    if (interventionType != null && interventionType.isNotEmpty) {
      return interventionType;
    }

    return 'unknown';
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
        filtered =
            filtered.where((e) => e.timestamp.isAfter(startDate)).toList();
      }
    }

    // Emotionen-Filter
    if (filter.emotions != null && filter.emotions!.isNotEmpty) {
      filtered = filtered
          .where(
            (e) => filter.emotions!
                .any((emotion) => emotion.name == e.primaryEmotion),
          )
          .toList();
    }

    // Kontext-Filter
    if (filter.contexts != null && filter.contexts!.isNotEmpty) {
      filtered = filtered
          .where(
            (e) => filter.contexts!.any((context) => context.name == e.context),
          )
          .toList();
    }

    // Systemzustand-Filter
    if (filter.systemStates != null && filter.systemStates!.isNotEmpty) {
      filtered = filtered
          .where(
              (e) => filter.systemStates!.any((s) => s.name == e.systemState))
          .toList();
    }

    // Nur mit Intervention
    if (filter.withInterventionOnly == true) {
      filtered = filtered
          .where(
            (e) =>
                (e.interventionType?.trim().isNotEmpty ?? false) ||
                (e.interventionId?.trim().isNotEmpty ?? false),
          )
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
              e.situationDescription.toLowerCase().contains(searchLower) ||
              e.automaticThought.toLowerCase().contains(searchLower))
          .toList();
    }

    return filtered;
  }

  /// E-01: Berechnet die Steigung des Intensitäts-Trends (lineare Regression).
  /// Positiv = steigende Belastung, negativ = sinkende Belastung.
  /// Einheit: Intensitätspunkte pro Tag.
  static double computeTrendSlope(List<TrendDataPoint> trend) {
    if (trend.length < 2) return 0;
    final n = trend.length.toDouble();
    double sumX = 0, sumY = 0, sumXY = 0, sumX2 = 0;
    for (int i = 0; i < trend.length; i++) {
      final x = i.toDouble();
      final y = trend[i].value;
      sumX += x;
      sumY += y;
      sumXY += x * y;
      sumX2 += x * x;
    }
    final denom = n * sumX2 - sumX * sumX;
    if (denom == 0) return 0;
    return (n * sumXY - sumX * sumY) / denom;
  }

  /// E-03: Burnout-Risiko basierend auf aufeinanderfolgenden Trendpunkten
  /// mit Durchschnittsintensität ≥ 7.
  static BurnoutRisk computeBurnoutRisk(List<TrendDataPoint> intensityTrend) {
    if (intensityTrend.isEmpty) return BurnoutRisk.low;

    final sorted = [...intensityTrend]
      ..sort((a, b) => a.date.compareTo(b.date));

    int consecutiveDays = 0;
    for (int i = sorted.length - 1; i >= 0; i--) {
      if (sorted[i].value >= 7.0) {
        consecutiveDays++;
      } else {
        break;
      }
    }

    if (consecutiveDays >= 7) return BurnoutRisk.high;
    if (consecutiveDays >= 4) return BurnoutRisk.medium;
    return BurnoutRisk.low;
  }

  /// E-02: Berechnet Kontext-Emotions-Korrelationen für die Top-3-Kontexte.
  static List<ContextCorrelation> computeContextCorrelations(
    List<SituationEntryData> entries,
  ) {
    if (entries.isEmpty) return [];

    final totalEntries = entries.length;

    // Gruppiere nach Kontext
    final byContext = <ContextType, List<SituationEntryData>>{};
    for (final entry in entries) {
      final ctx =
          ContextType.values.where((e) => e.name == entry.context).firstOrNull;
      if (ctx == null) continue;
      byContext[ctx] = [...byContext[ctx] ?? [], entry];
    }

    // Top-3 Kontexte nach Häufigkeit
    final sortedContexts = byContext.entries.toList()
      ..sort((a, b) => b.value.length.compareTo(a.value.length));

    final correlations = <ContextCorrelation>[];
    for (final entry in sortedContexts.take(3)) {
      final contextEntries = entry.value;
      if (contextEntries.length < 2) continue;

      // Häufigste Emotion in diesem Kontext
      final emotionFreq = <EmotionType, int>{};
      for (final e in contextEntries) {
        final em = EmotionType.values
            .where((et) => et.name == e.primaryEmotion)
            .firstOrNull;
        if (em != null) emotionFreq[em] = (emotionFreq[em] ?? 0) + 1;
      }
      if (emotionFreq.isEmpty) continue;

      final dominantEntry =
          emotionFreq.entries.reduce((a, b) => a.value > b.value ? a : b);

      final avgIntensity =
          contextEntries.map((e) => e.intensity).reduce((a, b) => a + b) /
              contextEntries.length;

      correlations.add(ContextCorrelation(
        context: entry.key,
        emotion: dominantEntry.key,
        contextPercentage: contextEntries.length / totalEntries * 100,
        emotionDominance: dominantEntry.value / contextEntries.length * 100,
        occurrenceCount: contextEntries.length,
        avgIntensity: avgIntensity.toDouble(),
      ));
    }

    return correlations;
  }

  /// Narrative Insight-Sätze für die Musteransicht.
  static List<String> buildNarrativeInsights(List<SituationEntryData> entries) {
    if (entries.length < 2) {
      return const [];
    }

    final insights = <String>[];
    final triggers = _findCommonTriggers(entries);
    final topTrigger = triggers.firstOrNull;
    if (topTrigger != null && topTrigger.occurrenceCount >= 2) {
      insights.add(
        '${topTrigger.context.label} führt bei dir oft zu ${topTrigger.emotion.label.toLowerCase()}.',
      );
    }

    final state = _findMostCommonState(entries);
    if (state != null &&
        state != SystemState.reflectiveReady &&
        state != SystemState.crisis) {
      insights.add(
        '${state.label} taucht in deinem Verlauf gerade besonders häufig auf.',
      );
    }

    final avgTension = _calculateAverageBodyTension(entries);
    final avgIntensity = _calculateAverageIntensity(entries);
    if (avgTension >= 7 && avgIntensity >= 6) {
      insights.add(
        'Wenn Anspannung und Belastung gleichzeitig hoch sind, hilft dir meist erst Regulation und dann Analyse.',
      );
    }

    final actionFrequency = <String, int>{};
    for (final entry in entries) {
      final actionKey = entry.selectedNextActionKey;
      if (actionKey == null || actionKey.isEmpty) continue;
      actionFrequency[actionKey] = (actionFrequency[actionKey] ?? 0) + 1;
    }
    if (actionFrequency.isNotEmpty) {
      final topAction =
          actionFrequency.entries.reduce((a, b) => a.value >= b.value ? a : b);
      if (topAction.value >= 2) {
        insights.add(
          'Als nächster Schritt wählst du häufig: ${_nextActionLabel(topAction.key).toLowerCase()}.',
        );
      }
    }

    return insights.take(4).toList(growable: false);
  }

  /// Fallback-Liste für auswählbare Nächste-Schritt-Optionen.
  static List<String> nextActionFallbacks({
    String? suggestedNextActionKey,
    required String systemStateName,
  }) {
    final state = SystemState.values
        .where((candidate) => candidate.name == systemStateName)
        .firstOrNull;

    final options = <String>[
      if (suggestedNextActionKey != null && suggestedNextActionKey.isNotEmpty)
        suggestedNextActionKey,
      ...switch (state) {
        SystemState.acuteActivation => const [
            'regulate_body_first',
            'pause_now',
            'do_not_reply_now',
          ],
        SystemState.rumination => const [
            'limit_thinking_loop',
            'write_alternative_view',
            'choose_one_step',
          ],
        SystemState.conflict => const [
            'do_not_reply_now',
            'write_observation_first',
            'address_later',
          ],
        SystemState.selfDevaluation => const [
            'collect_counterevidence',
            'write_alternative_view',
            'pause_now',
          ],
        SystemState.overwhelm => const [
            'choose_one_step',
            'reduce_stimuli',
            'pause_now',
          ],
        SystemState.interpretation => const [
            'check_facts_first',
            'write_alternative_view',
            'pause_now',
          ],
        SystemState.crisis => const [
            'seek_support_now',
            'regulate_body_first',
            'pause_now',
          ],
        _ => const [
            'choose_one_step',
            'pause_now',
            'address_later',
          ],
      },
    ];

    return options.toSet().take(3).toList(growable: false);
  }

  static String _nextActionLabel(String actionKey) {
    const labels = {
      'pause_now': 'Jetzt kurz Abstand schaffen',
      'regulate_body_first': 'Erst den Körper beruhigen, dann weiterdenken',
      'do_not_reply_now': 'Nicht im ersten Impuls antworten',
      'address_later': 'Das Thema später ruhiger ansprechen',
      'write_observation_first': 'Erst den sachlichen Kern notieren',
      'check_facts_first': 'Fakten sammeln, bevor du weiter deutest',
      'write_alternative_view': 'Eine alternative Erklärung aufschreiben',
      'limit_thinking_loop': 'Die Denkschleife bewusst begrenzen',
      'choose_one_step': 'Nur einen kleinen nächsten Schritt festlegen',
      'reduce_stimuli': 'Reize reduzieren, bevor du planst',
      'collect_counterevidence': 'Gegenbelege sammeln, bevor du dich bewertest',
      'seek_support_now': 'Jetzt Unterstützung oder sichere Begleitung holen',
    };

    return labels[actionKey] ?? actionKey;
  }

  /// Berechnet Statistiken für eine einzelne Emotion
  static Map<String, dynamic> getEmotionStats(
    List<SituationEntryData> entries,
    EmotionType emotion,
  ) {
    final emotionEntries =
        entries.where((e) => e.primaryEmotion == emotion.name).toList();

    if (emotionEntries.isEmpty) {
      return {
        'count': 0,
        'avgIntensity': 0.0,
        'avgTension': 0.0,
        'mostCommonContext': null,
        'mostCommonImpulse': null,
      };
    }

    final avgIntensity =
        emotionEntries.map((e) => e.intensity).reduce((a, b) => a + b) /
            emotionEntries.length;

    final avgTension =
        emotionEntries.map((e) => e.bodyTension).reduce((a, b) => a + b) /
            emotionEntries.length;

    // Häufigster Kontext für diese Emotion
    final contextFreq = <ContextType, int>{};
    for (final e in emotionEntries) {
      final ctx =
          ContextType.values.where((c) => c.name == e.context).firstOrNull;
      if (ctx != null) contextFreq[ctx] = (contextFreq[ctx] ?? 0) + 1;
    }
    final mostCommonContext = contextFreq.entries.isNotEmpty
        ? contextFreq.entries.reduce((a, b) => a.value > b.value ? a : b).key
        : null;

    // Häufigster Impuls für diese Emotion
    final impulseFreq = <ImpulseType, int>{};
    for (final e in emotionEntries) {
      final imp =
          ImpulseType.values.where((i) => i.name == e.firstImpulse).firstOrNull;
      if (imp != null) impulseFreq[imp] = (impulseFreq[imp] ?? 0) + 1;
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
