import 'dart:convert';

import 'package:flutter/foundation.dart';

enum AiEvaluationStatus {
  pending,
  success,
  failed;

  static AiEvaluationStatus? fromRaw(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    for (final status in AiEvaluationStatus.values) {
      if (status.name == value) {
        return status;
      }
    }
    return null;
  }
}

const Duration aiEvaluationPendingStaleAfter = Duration(minutes: 2);

extension AiEvaluationStatusX on AiEvaluationStatus {
  bool isPendingStale({
    required DateTime? requestedAt,
    DateTime? now,
    Duration staleAfter = aiEvaluationPendingStaleAfter,
  }) {
    if (this != AiEvaluationStatus.pending || requestedAt == null) {
      return false;
    }

    final currentTime = now ?? DateTime.now();
    return currentTime.toUtc().difference(requestedAt.toUtc()) >= staleAfter;
  }
}

class AiEvaluationContent {
  const AiEvaluationContent({
    required this.wasAuffaellt,
    required this.einordnung,
    required this.praktischHilfreich,
    this.vorsichtshinweis,
  });

  final String wasAuffaellt;
  final String einordnung;
  final String praktischHilfreich;
  final String? vorsichtshinweis;

  bool get hasVorsichtshinweis =>
      vorsichtshinweis != null && vorsichtshinweis!.trim().isNotEmpty;

  Map<String, dynamic> toJson() => {
        'was_auffaellt': wasAuffaellt,
        'einordnung': einordnung,
        'praktisch_hilfreich': praktischHilfreich,
        if (hasVorsichtshinweis) 'vorsichtshinweis': vorsichtshinweis,
      };

  String toJsonString() => jsonEncode(toJson());

  factory AiEvaluationContent.fromJson(Map<String, dynamic> json) {
    final wasAuffaellt = (json['was_auffaellt'] as String? ?? '').trim();
    final einordnung = (json['einordnung'] as String? ?? '').trim();
    final praktischHilfreich =
        (json['praktisch_hilfreich'] as String? ?? '').trim();
    final vorsichtshinweis = (json['vorsichtshinweis'] as String?)?.trim();

    if (wasAuffaellt.isEmpty ||
        einordnung.isEmpty ||
        praktischHilfreich.isEmpty) {
      throw const FormatException(
        'AI-Auswertung ist unvollständig oder ungültig.',
      );
    }

    return AiEvaluationContent(
      wasAuffaellt: wasAuffaellt,
      einordnung: einordnung,
      praktischHilfreich: praktischHilfreich,
      vorsichtshinweis: (vorsichtshinweis == null || vorsichtshinweis.isEmpty)
          ? null
          : vorsichtshinweis,
    );
  }

  static AiEvaluationContent? tryParse(String? raw) {
    if (raw == null || raw.trim().isEmpty) {
      return null;
    }

    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) {
        return null;
      }
      return AiEvaluationContent.fromJson(decoded);
    } catch (error) {
      debugPrint('AiEvaluationContent.tryParse failed: $error');
      return null;
    }
  }
}

class AiEvaluationResponse {
  const AiEvaluationResponse({
    required this.provider,
    required this.model,
    required this.schemaVersion,
    required this.completedAt,
    required this.content,
  });

  final String provider;
  final String model;
  final int schemaVersion;
  final DateTime completedAt;
  final AiEvaluationContent content;
}
