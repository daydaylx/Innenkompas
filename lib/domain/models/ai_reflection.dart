import 'dart:convert';

import 'package:flutter/foundation.dart';

enum AiReflectionMode {
  understand(
    label: 'Verstehen',
    title: 'Was war hier eigentlich los?',
    shortDescription:
        'Trigger, Hintergrundthema und innere Voranspannung sortieren.',
  ),
  redirect(
    label: 'Anders abbiegen',
    title: 'Wo hättest du realistischer anders reagieren können?',
    shortDescription: 'Frühesten Kipppunkt und machbare Alternative benennen.',
  ),
  organize(
    label: 'Kurz ordnen',
    title: 'Hilf mir, das kurz und klar zu ordnen.',
    shortDescription:
        'Ohne Tiefenanalyse den Kern und den nächsten Schritt verdichten.',
  ),
  stabilize(
    label: 'Erst runterkommen',
    title: 'Was hilft jetzt mehr als weiteres Nachdenken?',
    shortDescription:
        'Stabilisieren statt analysieren, wenn die Spannung noch hoch ist.',
  );

  const AiReflectionMode({
    required this.label,
    required this.title,
    required this.shortDescription,
  });

  final String label;
  final String title;
  final String shortDescription;

  static AiReflectionMode? fromRaw(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    for (final mode in values) {
      if (mode.name == value) {
        return mode;
      }
    }
    return null;
  }
}

enum AiReflectionStatus {
  notStarted,
  inProgress,
  completed,
  deferred;

  static AiReflectionStatus fromRaw(String? value) {
    if (value == null || value.isEmpty) {
      return AiReflectionStatus.notStarted;
    }

    switch (value) {
      case 'in_progress':
        return AiReflectionStatus.inProgress;
      case 'completed':
        return AiReflectionStatus.completed;
      case 'deferred':
        return AiReflectionStatus.deferred;
      default:
        return AiReflectionStatus.notStarted;
    }
  }

  String get rawValue {
    switch (this) {
      case AiReflectionStatus.notStarted:
        return 'not_started';
      case AiReflectionStatus.inProgress:
        return 'in_progress';
      case AiReflectionStatus.completed:
        return 'completed';
      case AiReflectionStatus.deferred:
        return 'deferred';
    }
  }
}

enum AiReflectionPhase {
  startPending,
  readyForReply,
  completePending,
  failedStart,
  failedComplete,
  completed;

  static AiReflectionPhase? fromRaw(String? value) {
    switch (value) {
      case 'start_pending':
        return AiReflectionPhase.startPending;
      case 'ready_for_reply':
        return AiReflectionPhase.readyForReply;
      case 'complete_pending':
        return AiReflectionPhase.completePending;
      case 'failed_start':
        return AiReflectionPhase.failedStart;
      case 'failed_complete':
        return AiReflectionPhase.failedComplete;
      case 'completed':
        return AiReflectionPhase.completed;
      default:
        return null;
    }
  }

  String get rawValue {
    switch (this) {
      case AiReflectionPhase.startPending:
        return 'start_pending';
      case AiReflectionPhase.readyForReply:
        return 'ready_for_reply';
      case AiReflectionPhase.completePending:
        return 'complete_pending';
      case AiReflectionPhase.failedStart:
        return 'failed_start';
      case AiReflectionPhase.failedComplete:
        return 'failed_complete';
      case AiReflectionPhase.completed:
        return 'completed';
    }
  }
}

enum AiReflectionErrorCode {
  timeout,
  network,
  unavailable,
  unauthorized,
  rateLimited,
  blocked,
  invalidResponse,
  invalidRequest,
  staleSession,
  disabled,
  unknown;

  static AiReflectionErrorCode? fromRaw(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    for (final code in values) {
      if (code.name == value) {
        return code;
      }
    }
    return null;
  }
}

class AiReflectionStartContent {
  const AiReflectionStartContent({
    required this.observation,
    required this.question,
    this.helperStarters = const [],
  });

  final String observation;
  final String question;
  final List<String> helperStarters;

  Map<String, dynamic> toJson() => {
        'observation': observation,
        'question': question,
        'helper_starters': helperStarters,
      };

  factory AiReflectionStartContent.fromJson(Map<String, dynamic> json) {
    final observation = (json['observation'] as String? ?? '').trim();
    final question = (json['question'] as String? ?? '').trim();
    final helperStarters =
        (json['helper_starters'] as List<dynamic>? ?? const [])
            .whereType<String>()
            .map((value) => value.trim())
            .where((value) => value.isNotEmpty)
            .toList(growable: false);

    if (observation.isEmpty || question.isEmpty) {
      throw const FormatException(
        'KI-Nachreflexion konnte nicht gestartet werden.',
      );
    }

    return AiReflectionStartContent(
      observation: observation,
      question: question,
      helperStarters: helperStarters,
    );
  }
}

class AiReflectionResult {
  const AiReflectionResult({
    required this.summary,
    required this.likelyCore,
    required this.earlyTurningPoint,
    required this.alternative,
    required this.nextStep,
    this.mantra,
  });

  final String summary;
  final String likelyCore;
  final String earlyTurningPoint;
  final String alternative;
  final String nextStep;
  final String? mantra;

  bool get hasMantra => mantra != null && mantra!.trim().isNotEmpty;

  Map<String, dynamic> toJson() => {
        'summary': summary,
        'likely_core': likelyCore,
        'early_turning_point': earlyTurningPoint,
        'alternative': alternative,
        'next_step': nextStep,
        if (hasMantra) 'mantra': mantra,
      };

  String toJsonString() => jsonEncode(toJson());

  factory AiReflectionResult.fromJson(Map<String, dynamic> json) {
    final summary = (json['summary'] as String? ?? '').trim();
    final likelyCore = (json['likely_core'] as String? ?? '').trim();
    final earlyTurningPoint =
        (json['early_turning_point'] as String? ?? '').trim();
    final alternative = (json['alternative'] as String? ?? '').trim();
    final nextStep = (json['next_step'] as String? ?? '').trim();
    final mantra = (json['mantra'] as String?)?.trim();

    if (summary.isEmpty ||
        likelyCore.isEmpty ||
        earlyTurningPoint.isEmpty ||
        alternative.isEmpty ||
        nextStep.isEmpty) {
      throw const FormatException(
        'KI-Nachreflexion ist unvollständig oder ungültig.',
      );
    }

    return AiReflectionResult(
      summary: summary,
      likelyCore: likelyCore,
      earlyTurningPoint: earlyTurningPoint,
      alternative: alternative,
      nextStep: nextStep,
      mantra: (mantra == null || mantra.isEmpty) ? null : mantra,
    );
  }

  static AiReflectionResult? tryParse(String? raw) {
    if (raw == null || raw.trim().isEmpty) {
      return null;
    }

    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) {
        return null;
      }
      return AiReflectionResult.fromJson(decoded);
    } catch (error) {
      debugPrint('AiReflectionResult.tryParse failed: $error');
      return null;
    }
  }
}

class AiReflectionStartResponse {
  const AiReflectionStartResponse({
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
  final AiReflectionStartContent content;
}

class AiReflectionCompleteResponse {
  const AiReflectionCompleteResponse({
    required this.provider,
    required this.model,
    required this.schemaVersion,
    required this.completedAt,
    required this.result,
  });

  final String provider;
  final String model;
  final int schemaVersion;
  final DateTime completedAt;
  final AiReflectionResult result;
}

class AiReflectionStartState {
  const AiReflectionStartState({
    required this.sessionId,
    required this.inputHash,
    required this.content,
    required this.provider,
    required this.model,
    required this.schemaVersion,
    required this.startedAt,
  });

  final String sessionId;
  final String inputHash;
  final AiReflectionStartContent content;
  final String provider;
  final String model;
  final int schemaVersion;
  final DateTime startedAt;

  Map<String, dynamic> toJson() => {
        'session_id': sessionId,
        'input_hash': inputHash,
        'provider': provider,
        'model': model,
        'schema_version': schemaVersion,
        'started_at': startedAt.toIso8601String(),
        'content': content.toJson(),
      };
}
