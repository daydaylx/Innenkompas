import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:innenkompass/data/db/app_database.dart';
import 'package:innenkompass/domain/models/ai_reflection.dart';
import 'package:innenkompass/domain/services/ai_reflection_local_fallback.dart';

void main() {
  test('quotes user reply instead of concatenating it grammatically', () {
    final result = AiReflectionLocalFallback.buildResult(
      entry: _entry(),
      mode: AiReflectionMode.understand,
      userReply: 'eigentlich ging es eher um Druck im Kopf',
    );

    expect(
      result.summary,
      contains(
        'Du benennst als wichtiges Hintergrundthema: "eigentlich ging es eher um Druck im Kopf".',
      ),
    );
    expect(
      result.summary,
      isNot(contains('Deine Antwort spricht eher dafür, dass')),
    );
  });

  test('uses the existing alternative as redirect starting point', () {
    final start = AiReflectionLocalFallback.buildStartState(
      entry: _entry(),
      mode: AiReflectionMode.redirect,
      sessionId: 'session',
      inputHash: 'hash',
      startedAt: DateTime(2026, 3, 20, 10, 1),
    );

    expect(start.content.question, contains('Du hast schon notiert'));
    expect(start.content.question, isNot(contains('Welcher kleine Schritt')));
    expect(start.content.helperStarters,
        contains('Dafür hätte ich gebraucht ...'));
  });
}

SituationEntryData _entry() {
  final now = DateTime(2026, 3, 20, 10, 0);
  return SituationEntryData(
    id: 7,
    situationDescription: 'Ein schwieriges Gespräch nach dem Meeting.',
    context: 'work',
    timestamp: now,
    involvedPerson: 'Kollege',
    preTriggerPreoccupation: 'Ich war schon völlig überladen.',
    triggerDescription: 'Eine kleine Rückfrage im falschen Moment.',
    preTriggerLoad: 8,
    intensity: 7,
    bodyTension: 8,
    primaryEmotion: 'fear',
    secondaryEmotion: 'shame',
    initialBodyReactions: jsonEncode(const ['Druck', 'Unruhe']),
    thoughtFocus: 'Ich dachte noch an das vorige Problem.',
    automaticThought: 'Ich werde gleich falsch verstanden.',
    firstImpulse: 'withdraw',
    factInterpretationResult: 'mostlyInterpretation',
    actualBehavior: 'Ich habe erst einmal nichts geantwortet.',
    actualBehaviorTags: jsonEncode(const ['withdraw']),
    neededSupports: jsonEncode(const ['Verständnis']),
    realisticAlternative: 'Kurz stoppen und sagen, dass ich später antworte.',
    nextStep: 'Ich notiere zuerst die Fakten.',
    systemState: 'interpretation',
    isCrisis: false,
    evaluationHeadlineKey: 'interpretation_uncertain_facts',
    evaluationMeaningKey: 'interpretation_not_certain',
    evaluationStatusKeys: jsonEncode(const ['strong_inner_pressure']),
    suggestedTipIds: jsonEncode(const [
      'check_facts_not_assumptions',
      'write_alternative_explanation',
    ]),
    suggestedNextActionKey: 'check_facts_first',
    aiEvaluationConsentGiven: false,
    interventionCompleted: false,
    createdAt: now,
    updatedAt: now,
    isDraft: false,
  );
}
