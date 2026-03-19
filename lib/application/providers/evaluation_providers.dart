import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innenkompass/data/db/app_database.dart';
import 'package:innenkompass/domain/models/evaluation.dart';
import 'package:innenkompass/domain/services/pattern_analyzer.dart';

import 'database_provider.dart';

/// Lädt lokale Texte und Tippinhalte für die Auswertungsansicht.
final evaluationContentProvider =
    FutureProvider<EvaluationContentBundle>((ref) async {
  return EvaluationContentBundle.load();
});

/// Holt einen einzelnen Eintrag für die Auswertungsansicht.
final evaluationEntryProvider =
    FutureProvider.family<SituationEntryData?, int>((ref, entryId) async {
  final db = ref.watch(databaseProvider);
  return db.getSituationEntryById(entryId);
});

/// Narrative Verlaufs-Insights für die Musteransicht.
final narrativeInsightsProvider = FutureProvider<List<String>>((ref) async {
  final db = ref.watch(databaseProvider);
  final entries = await db.getAllSituationEntries();
  return PatternAnalyzer.buildNarrativeInsights(entries);
});
