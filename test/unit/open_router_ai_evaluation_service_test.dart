import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:innenkompass/data/db/app_database.dart';
import 'package:innenkompass/data/services/open_router_ai_evaluation_service.dart';
import 'package:innenkompass/domain/services/ai_evaluation_service.dart';

void main() {
  group('OpenRouterAiEvaluationService', () {
    test('posts entry payload to configured endpoint and parses response',
        () async {
      final client = MockClient((request) async {
        expect(
          request.url.toString(),
          'https://example.com/api/ai-evaluations',
        );
        expect(request.method, 'POST');

        final body = jsonDecode(request.body) as Map<String, dynamic>;
        expect(body['consent_given'], isTrue);
        expect(
          (body['entry'] as Map<String, dynamic>)['situation_description'],
          'Ein schwieriges Gespräch nach dem Meeting.',
        );

        return http.Response(
          jsonEncode({
            'provider': 'openrouter',
            'model': 'openai/gpt-4.1-mini',
            'schema_version': 1,
            'completed_at': '2026-03-19T10:15:00Z',
            'evaluation': {
              'was_auffaellt': 'Der Eintrag wirkt stark angespannt.',
              'einordnung': 'Die Situation klingt nach Alarmmodus.',
              'praktisch_hilfreich': 'Erst Abstand, dann Fakten sortieren.',
            },
          }),
          200,
          headers: {'content-type': 'application/json'},
        );
      });

      final service = OpenRouterAiEvaluationService(
        baseUrl: 'https://example.com/api',
        provider: 'openrouter',
        model: 'openai/gpt-4.1-mini',
        schemaVersion: 1,
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
      final service = OpenRouterAiEvaluationService(
        baseUrl: 'https://example.com',
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

    test('normalizes sub-path base URLs to ai-evaluations endpoint', () async {
      final client = MockClient((request) async {
        expect(
          request.url.toString(),
          'https://example.com/v1/ai-evaluations',
        );
        return http.Response(
          jsonEncode({
            'provider': 'openrouter',
            'model': 'openai/gpt-4.1-mini',
            'schema_version': 1,
            'completed_at': '2026-03-19T10:15:00Z',
            'evaluation': {
              'was_auffaellt': 'Etwas fällt auf.',
              'einordnung': 'Etwas wird eingeordnet.',
              'praktisch_hilfreich': 'Etwas ist praktisch hilfreich.',
            },
          }),
          200,
          headers: {'content-type': 'application/json'},
        );
      });

      final service = OpenRouterAiEvaluationService(
        baseUrl: 'https://example.com/v1',
        provider: 'openrouter',
        model: 'openai/gpt-4.1-mini',
        schemaVersion: 1,
        client: client,
      );

      final result = await service.evaluateEntry(entry: _entry());

      expect(result.content.wasAuffaellt, 'Etwas fällt auf.');
    });

    test('surfaces timeouts as ai evaluation exceptions', () async {
      final completer = Completer<http.Response>();
      final client = MockClient((request) => completer.future);
      final service = OpenRouterAiEvaluationService(
        baseUrl: 'https://example.com',
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

    test('surfaces network failures as ai evaluation exceptions', () async {
      final client = MockClient((request) async {
        throw http.ClientException('connection refused');
      });
      final service = OpenRouterAiEvaluationService(
        baseUrl: 'https://example.com',
        provider: 'openrouter',
        model: 'openai/gpt-4.1-mini',
        schemaVersion: 1,
        client: client,
      );

      await expectLater(
        service.evaluateEntry(entry: _entry()),
        throwsA(
          isA<AiEvaluationException>().having(
            (error) => error.message,
            'message',
            contains('nicht erreicht'),
          ),
        ),
      );
    });

    test('rejects successful responses without evaluation payload', () async {
      final client = MockClient((request) async {
        return http.Response(
          jsonEncode({
            'provider': 'openrouter',
            'model': 'openai/gpt-4.1-mini',
            'schema_version': 1,
            'completed_at': '2026-03-19T10:15:00Z',
            'error': 'Upstream failed',
          }),
          200,
          headers: {'content-type': 'application/json'},
        );
      });
      final service = OpenRouterAiEvaluationService(
        baseUrl: 'https://example.com',
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
