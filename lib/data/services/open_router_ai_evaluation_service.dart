import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../data/db/app_database.dart';
import '../../domain/models/ai_evaluation.dart';
import '../../domain/services/ai_evaluation_service.dart';

class OpenRouterAiEvaluationService implements AiEvaluationService {
  OpenRouterAiEvaluationService({
    required String baseUrl,
    required this.provider,
    required this.model,
    required this.schemaVersion,
    this.appToken,
    this.requestTimeout = const Duration(seconds: 20),
    http.Client? client,
  })  : _client = client ?? http.Client(),
        _endpoint = _resolveEndpoint(baseUrl);

  final http.Client _client;
  final Uri _endpoint;
  final String? appToken;
  final String provider;
  final String model;
  final int schemaVersion;
  final Duration requestTimeout;

  @override
  Future<AiEvaluationResponse> evaluateEntry({
    required SituationEntryData entry,
  }) async {
    if (entry.isCrisis || entry.systemState == 'crisis') {
      throw const AiEvaluationException(
        'Für akute Kriseneinträge ist die freie KI-Auswertung deaktiviert.',
      );
    }

    late http.Response response;
    try {
      response = await _client
          .post(
            _endpoint,
            headers: _buildHeaders(),
            body: jsonEncode(_buildRequestBody(entry)),
          )
          .timeout(requestTimeout);
    } on TimeoutException {
      throw const AiEvaluationException(
        'Die KI-Auswertung hat zu lange gebraucht. Bitte versuche es erneut.',
      );
    } on http.ClientException {
      throw const AiEvaluationException(
        'Die KI-Auswertung konnte gerade nicht erreicht werden.',
      );
    } catch (_) {
      throw const AiEvaluationException(
        'Die KI-Auswertung konnte gerade nicht erreicht werden.',
      );
    }

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw const AiEvaluationException(
        'Die KI-Auswertung ist im Moment nicht verfügbar.',
      );
    }

    final decoded = _decodeObject(response.body);
    final evaluationObject = _decodeEvaluationBody(decoded);
    final content = AiEvaluationContent.fromJson(evaluationObject);

    return AiEvaluationResponse(
      provider: _normalizeOrFallback(decoded['provider'] as String?, provider),
      model: _normalizeOrFallback(decoded['model'] as String?, model),
      schemaVersion:
          (decoded['schema_version'] as num?)?.toInt() ?? schemaVersion,
      completedAt:
          DateTime.tryParse(decoded['completed_at'] as String? ?? '') ??
              DateTime.now().toUtc(),
      content: content,
    );
  }

  void dispose() {
    _client.close();
  }

  Map<String, String> _buildHeaders() {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (appToken != null && appToken!.trim().isNotEmpty) {
      headers['Authorization'] = 'Bearer ${appToken!.trim()}';
    }

    return headers;
  }

  Map<String, dynamic> _buildRequestBody(SituationEntryData entry) {
    return {
      'schema_version': schemaVersion,
      'consent_given': true,
      'entry': {
        'id': entry.id,
        'timestamp': entry.timestamp.toIso8601String(),
        'context': entry.context,
        'situation_description': entry.situationDescription,
        'involved_person': entry.involvedPerson,
        'involved_entities': entry.involvedEntities,
        'pre_trigger_preoccupation': entry.preTriggerPreoccupation,
        'problem_timing': entry.problemTiming,
        'trigger_description': entry.triggerDescription,
        'pre_trigger_load': entry.preTriggerLoad,
        'intensity': entry.intensity,
        'body_tension': entry.bodyTension,
        'primary_emotion': entry.primaryEmotion,
        'secondary_emotion': entry.secondaryEmotion,
        'body_symptoms': _decodeStringList(entry.bodySymptoms),
        'initial_body_reactions': _decodeStringList(entry.initialBodyReactions),
        'additional_emotions': _decodeStringList(entry.additionalEmotions),
        'thought_focus': entry.thoughtFocus,
        'automatic_thought': entry.automaticThought,
        'first_impulse': entry.firstImpulse,
        'fact_interpretation_result': entry.factInterpretationResult,
        'system_reaction': entry.systemReaction,
        'thought_patterns': _decodeStringList(entry.thoughtPatterns),
        'actual_behavior_tags': _decodeStringList(entry.actualBehaviorTags),
        'actual_behavior': entry.actualBehavior,
        'tipping_point_awareness': entry.tippingPointAwareness,
        'fear_or_pressure_point': entry.fearOrPressurePoint,
        'need_or_wounded_point': entry.needOrWoundedPoint,
        'touched_themes': _decodeStringList(entry.touchedThemes),
        'needed_supports': _decodeStringList(entry.neededSupports),
        'realistic_alternative': entry.realisticAlternative,
        'trigger_as_last_drop': entry.triggerAsLastDrop,
        'background_theme': entry.backgroundTheme,
        'pre_escalation_relief': entry.preEscalationRelief,
        'pattern_familiarity': entry.patternFamiliarity,
        'next_step': entry.nextStep,
        'system_state': entry.systemState,
        'is_crisis': entry.isCrisis,
        'local_evaluation': {
          'headline_key': entry.evaluationHeadlineKey,
          'meaning_key': entry.evaluationMeaningKey,
          'helpful_now_key': entry.evaluationHelpfulNowKey,
          'learning_point_key': entry.evaluationLearningPointKey,
          'status_keys': _decodeStringList(entry.evaluationStatusKeys),
          'suggested_tip_ids': _decodeStringList(entry.suggestedTipIds),
          'suggested_next_action_key': entry.suggestedNextActionKey,
          'selected_next_action_key': entry.selectedNextActionKey,
        },
      },
    };
  }

  static Uri _resolveEndpoint(String baseUrl) {
    final base = Uri.parse(baseUrl.trim());
    final scheme = base.scheme.toLowerCase();
    if (scheme != 'https') {
      throw const AiEvaluationException(
        'Die KI-Auswertung muss über eine HTTPS-URL konfiguriert werden.',
      );
    }
    if (base.host.trim().isEmpty) {
      throw const AiEvaluationException(
        'Die KI-Auswertung benötigt eine gültige Endpoint-URL.',
      );
    }
    final segments = base.pathSegments
        .where((segment) => segment.isNotEmpty)
        .toList(growable: true);
    if (segments.isEmpty || segments.last != 'ai-evaluations') {
      segments.add('ai-evaluations');
    }
    return base.replace(pathSegments: segments);
  }

  static Map<String, dynamic> _decodeObject(String raw) {
    final decoded = jsonDecode(raw);
    if (decoded is! Map<String, dynamic>) {
      throw const AiEvaluationException(
        'Die KI-Auswertung konnte nicht verarbeitet werden.',
      );
    }
    return decoded;
  }

  static Map<String, dynamic> _decodeEvaluationBody(
    Map<String, dynamic> decoded,
  ) {
    final evaluation = decoded['evaluation'];
    if (evaluation is Map<String, dynamic>) {
      return evaluation;
    }
    if (evaluation is String) {
      return _decodeObject(evaluation);
    }

    final content = decoded['content'];
    if (content is Map<String, dynamic>) {
      return content;
    }
    if (content is String) {
      return _decodeObject(content);
    }

    throw const AiEvaluationException(
      'Die KI-Auswertung konnte nicht verarbeitet werden.',
    );
  }

  static String _normalizeOrFallback(String? value, String fallback) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return fallback;
    }
    return trimmed;
  }

  static List<String> _decodeStringList(String? raw) {
    if (raw == null || raw.trim().isEmpty) {
      return const [];
    }

    try {
      final decoded = jsonDecode(raw);
      if (decoded is List) {
        return decoded.whereType<String>().toList(growable: false);
      }
    } catch (_) {
      return const [];
    }

    return const [];
  }
}
