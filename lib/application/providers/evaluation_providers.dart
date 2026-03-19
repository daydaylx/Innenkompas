import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:innenkompass/core/config/ai_evaluation_config.dart';
import 'package:innenkompass/data/services/direct_open_router_ai_evaluation_service.dart';
import 'package:innenkompass/data/services/open_router_ai_evaluation_service.dart';
import 'package:innenkompass/data/db/app_database.dart';
import 'package:innenkompass/domain/models/evaluation.dart';
import 'package:innenkompass/domain/services/ai_evaluation_service.dart';
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

/// Compile-time feature configuration for the optional AI evaluation flow.
final aiEvaluationConfigProvider = Provider<AiEvaluationConfig>((ref) {
  return AiEvaluationConfig.fromEnvironment();
});

/// HTTP-backed AI evaluation service. Returns null when the build is not
/// configured with an endpoint.
final aiEvaluationServiceProvider = Provider<AiEvaluationService?>((ref) {
  final config = ref.watch(aiEvaluationConfigProvider);
  if (!config.isEnabled) {
    return null;
  }

  try {
    if (config.hasDirectOpenRouterAccess && config.openRouterApiKey != null) {
      final service = DirectOpenRouterAiEvaluationService(
        apiKey: config.openRouterApiKey!,
        httpReferer: config.openRouterHttpReferer,
        appTitle: config.openRouterAppTitle,
        provider: config.provider,
        model: config.model,
        schemaVersion: config.schemaVersion,
      );
      ref.onDispose(service.dispose);
      return service;
    }

    if (config.baseUrl == null) {
      return null;
    }

    final service = OpenRouterAiEvaluationService(
      baseUrl: config.baseUrl!,
      appToken: config.appToken,
      provider: config.provider,
      model: config.model,
      schemaVersion: config.schemaVersion,
    );
    ref.onDispose(service.dispose);
    return service;
  } on AiEvaluationException {
    return null;
  }
});

/// Narrative Verlaufs-Insights für die Musteransicht.
final narrativeInsightsProvider = FutureProvider<List<String>>((ref) async {
  final db = ref.watch(databaseProvider);
  final entries = await db.getAllSituationEntries();
  return PatternAnalyzer.buildNarrativeInsights(entries);
});
