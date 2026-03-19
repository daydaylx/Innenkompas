import 'dart:convert';

import '../../core/constants/actual_behavior_types.dart';
import '../../data/db/app_database.dart';
import '../models/ai_reflection.dart';

class AiReflectionPolicyResult {
  const AiReflectionPolicyResult({
    required this.availableModes,
    required this.canDefer,
    required this.isBlockedByCrisis,
    required this.shouldPrioritizeStabilize,
    required this.hintText,
  });

  final List<AiReflectionMode> availableModes;
  final bool canDefer;
  final bool isBlockedByCrisis;
  final bool shouldPrioritizeStabilize;
  final String? hintText;
}

class AiReflectionPolicy {
  AiReflectionPolicy._();

  static const _stabilizeFirstStatusKeys = {
    'acute_escalation',
    'reflection_limited',
    'stabilize_before_analysis',
    'safety_relevant_moment',
    'strong_inner_pressure',
  };

  static const _escalatingBehaviorTags = {
    'throw_objects',
    'scream',
    'raise_voice',
    'freeze_block',
  };

  static AiReflectionPolicyResult evaluateEntry(SituationEntryData entry) {
    final reflectionStatus =
        AiReflectionStatus.fromRaw(entry.aiReflectionStatus);
    final statusKeys = _decodeStringList(entry.evaluationStatusKeys).toSet();
    final behaviorTags = ActualBehaviorTypes.normalizeAll(
      _decodeStringList(entry.actualBehaviorTags),
    ).toSet();
    final isBlockedByCrisis = entry.isCrisis || entry.systemState == 'crisis';
    final shouldPrioritizeStabilize = !isBlockedByCrisis &&
        (entry.intensity >= 9 ||
            entry.bodyTension >= 9 ||
            statusKeys.intersection(_stabilizeFirstStatusKeys).isNotEmpty ||
            behaviorTags.intersection(_escalatingBehaviorTags).isNotEmpty);

    if (isBlockedByCrisis) {
      return AiReflectionPolicyResult(
        availableModes: const [],
        canDefer: true,
        isBlockedByCrisis: true,
        shouldPrioritizeStabilize: false,
        hintText:
            'Für akute Kriseneinträge bleibt es bewusst bei Stabilisierung und bestehenden Sicherheitswegen.',
      );
    }

    if (shouldPrioritizeStabilize) {
      return AiReflectionPolicyResult(
        availableModes: const [AiReflectionMode.stabilize],
        canDefer: true,
        isBlockedByCrisis: false,
        shouldPrioritizeStabilize: true,
        hintText:
            'Gerade wirkt Stabilisierung hilfreicher als weitere Analyse.',
      );
    }

    final hintText = switch (reflectionStatus) {
      AiReflectionStatus.completed =>
        'Für diesen Eintrag liegt bereits eine gespeicherte KI-Nachreflexion vor.',
      AiReflectionStatus.deferred =>
        'Dieser Eintrag ist für eine spätere Nachreflexion vorgemerkt.',
      AiReflectionStatus.inProgress =>
        'Für diesen Eintrag wurde bereits eine Nachreflexion begonnen.',
      AiReflectionStatus.notStarted => null,
    };

    return AiReflectionPolicyResult(
      availableModes: const [
        AiReflectionMode.understand,
        AiReflectionMode.redirect,
        AiReflectionMode.organize,
      ],
      canDefer: true,
      isBlockedByCrisis: false,
      shouldPrioritizeStabilize: false,
      hintText: hintText,
    );
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
