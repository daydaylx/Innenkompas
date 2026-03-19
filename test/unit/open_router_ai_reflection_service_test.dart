import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:innenkompass/data/db/app_database.dart';
import 'package:innenkompass/data/services/open_router_ai_reflection_service.dart';
import 'package:innenkompass/domain/models/ai_reflection.dart';
import 'package:innenkompass/domain/services/ai_reflection_service.dart';

void main() {
  group('OpenRouterAiReflectionService', () {
    test('posts start payload to configured endpoint and parses response',
        () async {
      final client = MockClient((request) async {
        expect(
          request.url.toString(),
          'https://example.com/api/ai-reflections',
        );
        expect(request.method, 'POST');

        final body = jsonDecode(request.body) as Map<String, dynamic>;
        expect(body['phase'], 'start');
        expect(body['mode'], 'understand');

        return http.Response(
          jsonEncode({
            'provider': 'openrouter',
            'model': 'openai/gpt-4.1-mini',
            'schema_version': 1,
            'completed_at': '2026-03-19T10:15:00Z',
            'reflection': {
              'observation':
                  'Der Eintrag spricht eher für Voranspannung plus Trigger.',
              'question':
                  'Was war deiner Meinung nach schon vorher das größere Thema?',
              'helper_starters': [
                'Ich glaube eher ...',
                'Eigentlich ging es darum ...',
              ],
            },
          }),
          200,
          headers: {'content-type': 'application/json'},
        );
      });

      final service = OpenRouterAiReflectionService(
        baseUrl: 'https://example.com/api',
        provider: 'openrouter',
        model: 'openai/gpt-4.1-mini',
        schemaVersion: 1,
        client: client,
      );

      final result = await service.startReflection(
        entry: _entry(),
        mode: AiReflectionMode.understand,
      );

      expect(result.content.observation, contains('Voranspannung'));
      expect(result.content.question, contains('größere Thema'));
    });

    test('posts completion payload and parses reflection result', () async {
      final client = MockClient((request) async {
        final body = jsonDecode(request.body) as Map<String, dynamic>;
        expect(body['phase'], 'complete');
        expect(body['mode'], 'redirect');
        expect(body['user_reply'], isNotEmpty);

        return http.Response(
          jsonEncode({
            'provider': 'openrouter',
            'model': 'openai/gpt-4.1-mini',
            'schema_version': 1,
            'completed_at': '2026-03-19T10:16:00Z',
            'reflection': {
              'summary':
                  'Nicht nur der Anlass war schwierig, sondern auch der volle Kopf davor.',
              'likely_core': 'Voller Kopf plus Trigger.',
              'early_turning_point':
                  'Als du gemerkt hast, dass selbst kleine Dinge stark gereizt haben.',
              'alternative': 'Kurz stoppen und Abstand schaffen.',
              'next_step':
                  'Erst körperlich runterfahren und später neu draufschauen.',
            },
          }),
          200,
          headers: {'content-type': 'application/json'},
        );
      });

      final service = OpenRouterAiReflectionService(
        baseUrl: 'https://example.com/api',
        provider: 'openrouter',
        model: 'openai/gpt-4.1-mini',
        schemaVersion: 1,
        client: client,
      );

      final result = await service.completeReflection(
        entry: _entry(),
        mode: AiReflectionMode.redirect,
        userReply: 'Ich war eigentlich schon vorher voll.',
      );

      expect(result.result.alternative, contains('Abstand'));
      expect(result.result.nextStep, contains('runterfahren'));
    });

    test('normalizes sub-path base URLs to ai-reflections endpoint', () async {
      final client = MockClient((request) async {
        expect(
          request.url.toString(),
          'https://example.com/v1/ai-reflections',
        );
        return http.Response(
          jsonEncode({
            'provider': 'openrouter',
            'model': 'openai/gpt-4.1-mini',
            'schema_version': 1,
            'completed_at': '2026-03-19T10:15:00Z',
            'reflection': {
              'observation': 'Kurzer Blick auf den Eintrag.',
              'question': 'Was war schon vorher los?',
              'helper_starters': ['Ich glaube eher ...'],
            },
          }),
          200,
          headers: {'content-type': 'application/json'},
        );
      });

      final service = OpenRouterAiReflectionService(
        baseUrl: 'https://example.com/v1',
        provider: 'openrouter',
        model: 'openai/gpt-4.1-mini',
        schemaVersion: 1,
        client: client,
      );

      final result = await service.startReflection(
        entry: _entry(),
        mode: AiReflectionMode.organize,
      );

      expect(result.content.question, 'Was war schon vorher los?');
    });

    test('rejects non-https base URLs during configuration', () {
      expect(
        () => OpenRouterAiReflectionService(
          baseUrl: 'http://example.com',
          provider: 'openrouter',
          model: 'openai/gpt-4.1-mini',
          schemaVersion: 1,
        ),
        throwsA(
          isA<AiReflectionException>().having(
            (error) => error.message,
            'message',
            contains('HTTPS-URL'),
          ),
        ),
      );
    });

    test('surfaces timeouts as ai reflection exceptions', () async {
      final completer = Completer<http.Response>();
      final client = MockClient((request) => completer.future);
      final service = OpenRouterAiReflectionService(
        baseUrl: 'https://example.com',
        provider: 'openrouter',
        model: 'openai/gpt-4.1-mini',
        schemaVersion: 1,
        client: client,
        requestTimeout: const Duration(milliseconds: 1),
      );

      await expectLater(
        service.startReflection(
          entry: _entry(),
          mode: AiReflectionMode.organize,
        ),
        throwsA(
          isA<AiReflectionException>().having(
            (error) => error.code,
            'code',
            AiReflectionErrorCode.timeout,
          ),
        ),
      );
    });

    test('maps worker error codes from non-200 responses', () async {
      final client = MockClient((request) async {
        return http.Response(
          jsonEncode({
            'error': 'Rate limit exceeded',
            'error_code': 'rateLimited',
          }),
          429,
          headers: {'content-type': 'application/json'},
        );
      });
      final service = OpenRouterAiReflectionService(
        baseUrl: 'https://example.com',
        provider: 'openrouter',
        model: 'openai/gpt-4.1-mini',
        schemaVersion: 1,
        client: client,
      );

      await expectLater(
        service.startReflection(
          entry: _entry(),
          mode: AiReflectionMode.organize,
        ),
        throwsA(
          isA<AiReflectionException>().having(
            (error) => error.code,
            'code',
            AiReflectionErrorCode.rateLimited,
          ),
        ),
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
    actualBehaviorTags: jsonEncode(const ['zurückgezogen']),
    realisticAlternative: 'Kurz stoppen und sagen, dass ich später antworte.',
    nextStep: 'Ich notiere zuerst die Fakten.',
    systemState: isCrisis ? 'crisis' : 'interpretation',
    isCrisis: isCrisis,
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
