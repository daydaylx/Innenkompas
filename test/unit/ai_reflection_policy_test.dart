import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:innenkompass/data/db/app_database.dart';
import 'package:innenkompass/domain/models/ai_reflection.dart';
import 'package:innenkompass/domain/services/ai_reflection_policy.dart';

void main() {
  group('AiReflectionPolicy', () {
    test('offers understand, redirect and organize for regular entries', () {
      final result = AiReflectionPolicy.evaluateEntry(_entry());

      expect(
        result.availableModes,
        const [
          AiReflectionMode.understand,
          AiReflectionMode.redirect,
          AiReflectionMode.organize,
        ],
      );
      expect(result.shouldPrioritizeStabilize, isFalse);
      expect(result.isBlockedByCrisis, isFalse);
    });

    test('prioritizes stabilize for high escalation', () {
      final result = AiReflectionPolicy.evaluateEntry(
        _entry(
          intensity: 9,
          bodyTension: 9,
          evaluationStatusKeys: const ['acute_escalation'],
        ),
      );

      expect(result.availableModes, const [AiReflectionMode.stabilize]);
      expect(result.shouldPrioritizeStabilize, isTrue);
      expect(result.isBlockedByCrisis, isFalse);
    });

    test('recognizes escalating behavior keys after normalization', () {
      final result = AiReflectionPolicy.evaluateEntry(
        _entry(
          intensity: 7,
          bodyTension: 7,
          actualBehaviorTags: const ['throw_objects'],
        ),
      );

      expect(result.availableModes, const [AiReflectionMode.stabilize]);
      expect(result.shouldPrioritizeStabilize, isTrue);
    });

    test('blocks reflection for crisis entries', () {
      final result = AiReflectionPolicy.evaluateEntry(
        _entry(isCrisis: true, systemState: 'crisis'),
      );

      expect(result.availableModes, isEmpty);
      expect(result.isBlockedByCrisis, isTrue);
      expect(result.canDefer, isTrue);
    });
  });
}

SituationEntryData _entry({
  int intensity = 7,
  int bodyTension = 8,
  bool isCrisis = false,
  String systemState = 'interpretation',
  List<String> evaluationStatusKeys = const [],
  List<String> actualBehaviorTags = const ['zurückgezogen'],
}) {
  final now = DateTime(2026, 3, 19, 10, 0);
  return SituationEntryData(
    id: 7,
    situationDescription: 'Ein schwieriges Gespräch nach dem Meeting.',
    context: 'work',
    timestamp: now,
    involvedPerson: 'Kollege',
    intensity: intensity,
    bodyTension: bodyTension,
    primaryEmotion: 'fear',
    automaticThought: 'Ich werde gleich falsch verstanden.',
    firstImpulse: 'withdraw',
    actualBehaviorTags: jsonEncode(actualBehaviorTags),
    systemState: systemState,
    isCrisis: isCrisis,
    evaluationStatusKeys: jsonEncode(evaluationStatusKeys),
    aiEvaluationConsentGiven: false,
    interventionCompleted: false,
    createdAt: now,
    updatedAt: now,
    isDraft: false,
  );
}
