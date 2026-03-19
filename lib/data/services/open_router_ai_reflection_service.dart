import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../data/db/app_database.dart';
import '../../domain/models/ai_reflection.dart';
import '../../domain/services/ai_reflection_service.dart';
import 'ai_reflection_request_codec.dart';

class OpenRouterAiReflectionService implements AiReflectionService {
  OpenRouterAiReflectionService({
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
  Future<AiReflectionStartResponse> startReflection({
    required SituationEntryData entry,
    required AiReflectionMode mode,
  }) async {
    _guardEntry(entry);
    final decoded = await _post(
      body: buildAiReflectionPayload(
        entry: entry,
        mode: mode,
        phase: 'start',
        schemaVersion: schemaVersion,
      ),
    );
    final content = AiReflectionStartContent.fromJson(
      _decodeReflectionBody(decoded),
    );
    return AiReflectionStartResponse(
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

  @override
  Future<AiReflectionCompleteResponse> completeReflection({
    required SituationEntryData entry,
    required AiReflectionMode mode,
    required String userReply,
  }) async {
    _guardEntry(entry);
    if (userReply.trim().isEmpty) {
      throw const AiReflectionException(
        'Bitte antworte erst kurz auf die fokussierte Rückfrage.',
        code: AiReflectionErrorCode.invalidRequest,
      );
    }

    final decoded = await _post(
      body: buildAiReflectionPayload(
        entry: entry,
        mode: mode,
        phase: 'complete',
        schemaVersion: schemaVersion,
        userReply: userReply,
      ),
    );
    final result = AiReflectionResult.fromJson(_decodeReflectionBody(decoded));
    return AiReflectionCompleteResponse(
      provider: _normalizeOrFallback(decoded['provider'] as String?, provider),
      model: _normalizeOrFallback(decoded['model'] as String?, model),
      schemaVersion:
          (decoded['schema_version'] as num?)?.toInt() ?? schemaVersion,
      completedAt:
          DateTime.tryParse(decoded['completed_at'] as String? ?? '') ??
              DateTime.now().toUtc(),
      result: result,
    );
  }

  void dispose() {
    _client.close();
  }

  Future<Map<String, dynamic>> _post({
    required Map<String, dynamic> body,
  }) async {
    late http.Response response;
    try {
      response = await _client
          .post(
            _endpoint,
            headers: _buildHeaders(),
            body: jsonEncode(body),
          )
          .timeout(requestTimeout);
    } on TimeoutException {
      throw const AiReflectionException(
        'Die KI-Nachreflexion hat zu lange gebraucht. Bitte versuche es erneut.',
        code: AiReflectionErrorCode.timeout,
      );
    } on http.ClientException {
      throw const AiReflectionException(
        'Die KI-Nachreflexion konnte gerade nicht erreicht werden.',
        code: AiReflectionErrorCode.network,
      );
    } catch (_) {
      throw const AiReflectionException(
        'Die KI-Nachreflexion konnte gerade nicht erreicht werden.',
        code: AiReflectionErrorCode.network,
      );
    }

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw _errorForResponse(response);
    }

    final decoded = _decodeObject(response.body);
    if (decoded is! Map<String, dynamic>) {
      throw const AiReflectionException(
        'Die KI-Nachreflexion konnte nicht verarbeitet werden.',
        code: AiReflectionErrorCode.invalidResponse,
      );
    }
    return decoded;
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

  void _guardEntry(SituationEntryData entry) {
    if (entry.isCrisis || entry.systemState == 'crisis') {
      throw const AiReflectionException(
        'Für akute Kriseneinträge bleibt die KI-Nachreflexion deaktiviert.',
        code: AiReflectionErrorCode.blocked,
      );
    }
  }

  static Uri _resolveEndpoint(String baseUrl) {
    final base = Uri.parse(baseUrl.trim());
    final scheme = base.scheme.toLowerCase();
    if (scheme != 'https') {
      throw const AiReflectionException(
        'Die KI-Nachreflexion muss über eine HTTPS-URL konfiguriert werden.',
        code: AiReflectionErrorCode.invalidRequest,
      );
    }
    if (base.host.trim().isEmpty) {
      throw const AiReflectionException(
        'Die KI-Nachreflexion benötigt eine gültige Endpoint-URL.',
        code: AiReflectionErrorCode.invalidRequest,
      );
    }
    final segments = base.pathSegments
        .where((segment) => segment.isNotEmpty)
        .toList(growable: true);
    if (segments.isEmpty || segments.last != 'ai-reflections') {
      segments.add('ai-reflections');
    }
    return base.replace(pathSegments: segments);
  }

  static Map<String, dynamic> _decodeReflectionBody(
    Map<String, dynamic> decoded,
  ) {
    final reflection = decoded['reflection'];
    if (reflection is Map<String, dynamic>) {
      return reflection;
    }
    if (reflection is String) {
      final parsed = jsonDecode(reflection);
      if (parsed is Map<String, dynamic>) {
        return parsed;
      }
    }
    final content = decoded['content'];
    if (content is Map<String, dynamic>) {
      return content;
    }
    throw const AiReflectionException(
      'Die KI-Nachreflexion konnte nicht verarbeitet werden.',
      code: AiReflectionErrorCode.invalidResponse,
    );
  }

  static String _normalizeOrFallback(String? value, String fallback) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return fallback;
    }
    return trimmed;
  }

  static dynamic _decodeObject(String raw) {
    try {
      return jsonDecode(raw);
    } on FormatException {
      throw const AiReflectionException(
        'Die KI-Nachreflexion konnte nicht verarbeitet werden.',
        code: AiReflectionErrorCode.invalidResponse,
      );
    }
  }

  static AiReflectionException _errorForResponse(http.Response response) {
    final decoded = _tryDecodeObject(response.body);
    final rawErrorCode = decoded?['error_code'] as String?;
    final errorCode = AiReflectionErrorCode.fromRaw(rawErrorCode) ??
        _statusToCode(response.statusCode);
    final errorMessage = _extractErrorMessage(decoded);
    return AiReflectionException(
      errorMessage ?? _messageForCode(errorCode),
      code: errorCode,
    );
  }

  static Map<String, dynamic>? _tryDecodeObject(String raw) {
    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
    } catch (_) {
      return null;
    }
    return null;
  }

  static String? _extractErrorMessage(Map<String, dynamic>? decoded) {
    final error = decoded?['error'];
    if (error is String && error.trim().isNotEmpty) {
      return error.trim();
    }
    return null;
  }

  static AiReflectionErrorCode _statusToCode(int statusCode) {
    if (statusCode == 400) {
      return AiReflectionErrorCode.invalidRequest;
    }
    if (statusCode == 401 || statusCode == 403) {
      return AiReflectionErrorCode.unauthorized;
    }
    if (statusCode == 409) {
      return AiReflectionErrorCode.blocked;
    }
    if (statusCode == 429) {
      return AiReflectionErrorCode.rateLimited;
    }
    if (statusCode == 502 || statusCode == 503 || statusCode == 504) {
      return AiReflectionErrorCode.unavailable;
    }
    return AiReflectionErrorCode.unavailable;
  }

  static String _messageForCode(AiReflectionErrorCode code) {
    switch (code) {
      case AiReflectionErrorCode.timeout:
        return 'Die KI-Nachreflexion hat zu lange gebraucht. Bitte versuche es erneut.';
      case AiReflectionErrorCode.network:
        return 'Die KI-Nachreflexion konnte gerade nicht erreicht werden.';
      case AiReflectionErrorCode.unavailable:
        return 'Die KI-Nachreflexion ist im Moment nicht verfügbar.';
      case AiReflectionErrorCode.unauthorized:
        return 'Die KI-Nachreflexion ist gerade nicht korrekt konfiguriert.';
      case AiReflectionErrorCode.rateLimited:
        return 'Die KI-Nachreflexion ist gerade ausgelastet. Bitte versuche es gleich noch einmal.';
      case AiReflectionErrorCode.blocked:
        return 'Für diesen Eintrag bleibt die KI-Nachreflexion deaktiviert.';
      case AiReflectionErrorCode.invalidResponse:
        return 'Die KI-Nachreflexion konnte nicht verarbeitet werden.';
      case AiReflectionErrorCode.invalidRequest:
        return 'Die KI-Nachreflexion ist gerade nicht korrekt konfiguriert.';
      case AiReflectionErrorCode.staleSession:
        return 'Die Nachreflexion wurde zwischenzeitlich verändert. Bitte starte sie neu.';
      case AiReflectionErrorCode.disabled:
        return 'Die KI-Nachreflexion ist in dieser Konfiguration deaktiviert.';
      case AiReflectionErrorCode.unknown:
        return 'Die KI-Nachreflexion konnte gerade nicht abgeschlossen werden.';
    }
  }
}
