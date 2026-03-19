import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:innenkompass/data/db/app_database.dart';
import 'package:innenkompass/data/services/direct_open_router_ai_evaluation_service.dart';
import 'package:innenkompass/domain/services/ai_evaluation_service.dart';

void main() {
  group('DirectOpenRouterAiEvaluationService', () {
    test('posts direct OpenRouter request and parses response', () async {
      final client = MockClient((request) async {
        expect(
          request.url.toString(),
          'https://openrouter.ai/api/v1/chat/completions',
        );
        expect(request.method, 'POST');
        expect(request.headers['Authorization'], 'Bearer test-openrouter-key');
        expect(request.headers['X-Title'], 'Innenkompass');

        final body = jsonDecode(request.body) as Map<String, dynamic>;
        expect(body['model'], 'openai/gpt-4.1-mini');
        expect(body['response_format'], isA<Map<String, dynamic>>());
        expect(body['messages'], isA<List<dynamic>>());

        return http.Response(
          jsonEncode({
            'created': 1_710_842_100,
            'choices': [
              {
                'message': {
                  'content': jsonEncode({
                    'was_auffaellt': 'Der Eintrag wirkt stark angespannt.',
                    'einordnung': 'Die Situation klingt nach Alarmmodus.',
                    'praktisch_hilfreich':
                        'Erst Abstand, dann Fakten sortieren.',
                  }),
                },
              },
            ],
          }),
          200,
          headers: {'content-type': 'application/json'},
        );
      });

      final service = DirectOpenRouterAiEvaluationService(
        apiKey: 'test-openrouter-key',
        provider: 'openrouter',
        model: 'openai/gpt-4.1-mini',
        schemaVersion: 1,
        appTitle: 'Innenkompass',
        client: client,
      );

      final result = await service.evaluateEntry(entry: _entry());

      expect(result.provider, 'openrouter');
      expect(result.model, 'openai/gpt-4.1-mini');
      expect(result.schemaVersion, 1);
      expect(result.content.wasAuffaellt, contains('angespannt'));
      expect(result.content.praktischHilfreich, contains('Abstand'));
    });

    test('blocks crisis entries before the network call', () async {
      final client = MockClient((request) async {
        fail('network should not be called for crisis entries');
      });
      final service = DirectOpenRouterAiEvaluationService(
        apiKey: 'test-openrouter-key',
        provider: 'openrouter',
        model: 'openai/gpt-4.1-mini',
        schemaVersion: 1,
        client: client,
      );

      await expectLater(
        () => service.evaluateEntry(entry: _entry(isCrisis: true)),
        throwsA(isA<AiEvaluationException>()),
      );
    });

    test('surfaces timeouts as ai evaluation exceptions', () async {
      final completer = Completer<http.Response>();
      final client = MockClient((request) => completer.future);
      final service = DirectOpenRouterAiEvaluationService(
        apiKey: 'test-openrouter-key',
        provider: 'openrouter',
        model: 'openai/gpt-4.1-mini',
        schemaVersion: 1,
        client: client,
        requestTimeout: const Duration(milliseconds: 1),
      );

      await expectLater(
        service.evaluateEntry(entry: _entry()),
        throwsA(
          isA<AiEvaluationException>().having(
            (error) => error.message,
            'message',
            contains('zu lange gebraucht'),
          ),
        ),
      );
    });

    test('rejects successful responses without usable content', () async {
      final client = MockClient((request) async {
        return http.Response(
          jsonEncode({
            'choices': [
              {
                'message': {'content': ''},
              },
            ],
          }),
          200,
          headers: {'content-type': 'application/json'},
        );
      });
      final service = DirectOpenRouterAiEvaluationService(
        apiKey: 'test-openrouter-key',
        provider: 'openrouter',
        model: 'openai/gpt-4.1-mini',
        schemaVersion: 1,
        client: client,
      );

      await expectLater(
        service.evaluateEntry(entry: _entry()),
        throwsA(isA<AiEvaluationException>()),
      );
    });
  });
}

SituationEntryData _entry({bool isCrisis = false}) {
  final now = DateTime(2026, 3, 19, 10, 0);
  return SituationEntryData(
    id: 7,
    situationDescription: 'Ein schwieriges Gespräch nach dem Meeting.',
    context: 'work',
    timestamp: now,
    involvedPerson: 'Kollege',
    intensity: 7,
    bodyTension: 8,
    primaryEmotion: 'fear',
    secondaryEmotion: 'shame',
    bodySymptoms: jsonEncode(const ['Enge in der Brust', 'Zittern']),
    automaticThought: 'Ich werde gleich falsch verstanden.',
    firstImpulse: 'withdraw',
    factInterpretationResult: 'mostlyInterpretation',
    actualBehavior: 'Ich habe noch nichts geantwortet.',
    needOrWoundedPoint: 'Ich will ernst genommen werden.',
    nextStep: 'Ich notiere zuerst die Fakten.',
    systemState: isCrisis ? 'crisis' : 'interpretation',
    isCrisis: isCrisis,
    evaluationHeadlineKey: 'interpretation_uncertain_facts',
    evaluationMeaningKey: 'interpretation_not_certain',
    suggestedTipIds: jsonEncode(const [
      'check_facts_not_assumptions',
      'write_alternative_explanation',
    ]),
    suggestedNextActionKey: 'check_facts_first',
    selectedNextActionKey: null,
    aiEvaluationStatus: null,
    aiEvaluationProvider: null,
    aiEvaluationModel: null,
    aiEvaluationRequestedAt: null,
    aiEvaluationCompletedAt: null,
    aiEvaluationConsentGiven: false,
    aiEvaluationText: null,
    aiEvaluationSchemaVersion: null,
    interventionType: 'factCheck',
    interventionId: null,
    interventionCompleted: false,
    interventionDurationSec: null,
    postIntensity: null,
    postBodyTension: null,
    postClarity: null,
    helpfulnessRating: null,
    postNote: null,
    createdAt: now,
    updatedAt: now,
    isDraft: false,
  );
}
