import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:innenkompass/data/db/app_database.dart';
import 'package:innenkompass/data/services/direct_open_router_ai_reflection_service.dart';
import 'package:innenkompass/domain/models/ai_reflection.dart';
import 'package:innenkompass/domain/services/ai_reflection_service.dart';

void main() {
  group('DirectOpenRouterAiReflectionService', () {
    test('posts direct OpenRouter start request and parses response', () async {
      final client = MockClient((request) async {
        expect(
          request.url.toString(),
          'https://openrouter.ai/api/v1/chat/completions',
        );
        expect(request.method, 'POST');

        final body = jsonDecode(request.body) as Map<String, dynamic>;
        expect(body['model'], 'openai/gpt-4.1-mini');
        expect(body['messages'], isA<List<dynamic>>());
        final messages = body['messages'] as List<dynamic>;
        final payload = jsonDecode(messages[1]['content'] as String)
            as Map<String, dynamic>;
        final entry = payload['entry'] as Map<String, dynamic>;
        expect(entry['needed_supports'], contains('Verständnis'));
        expect(entry['need_or_wounded_point'], contains('ernst genommen'));
        expect(entry['pattern_familiarity'], 'sometimes');

        return http.Response(
          jsonEncode({
            'created': 1_710_842_100,
            'choices': [
              {
                'message': {
                  'content': jsonEncode({
                    'observation':
                        'Der Trigger wirkt eher wie der letzte Tropfen.',
                    'question':
                        'Was war deiner Meinung nach schon vorher das größere Thema?',
                    'helper_starters': [
                      'Ich glaube eher ...',
                      'Eigentlich ging es darum ...',
                    ],
                  }),
                },
              },
            ],
          }),
          200,
          headers: {'content-type': 'application/json'},
        );
      });

      final service = DirectOpenRouterAiReflectionService(
        apiKey: 'test-openrouter-key',
        provider: 'openrouter',
        model: 'openai/gpt-4.1-mini',
        schemaVersion: 1,
        client: client,
      );

      final result = await service.startReflection(
        entry: _entry(),
        mode: AiReflectionMode.understand,
      );

      expect(result.content.observation, contains('letzte Tropfen'));
      expect(result.content.helperStarters, isNotEmpty);
    });

    test('posts direct OpenRouter completion request and parses result',
        () async {
      final client = MockClient((request) async {
        return http.Response(
          jsonEncode({
            'created': 1_710_842_200,
            'choices': [
              {
                'message': {
                  'content': jsonEncode({
                    'summary':
                        'Nicht nur der Anlass, sondern auch die Voranspannung war entscheidend.',
                    'likely_core': 'Voranspannung plus Trigger.',
                    'early_turning_point':
                        'Als selbst Kleinigkeiten schon stark gereizt haben.',
                    'alternative':
                        'Kurz stoppen statt direkt innerlich hochzugehen.',
                    'next_step':
                        'Jetzt erst runterfahren und später neu sortieren.',
                    'mantra': 'Voller Kopf plus Trigger.',
                  }),
                },
              },
            ],
          }),
          200,
          headers: {'content-type': 'application/json'},
        );
      });

      final service = DirectOpenRouterAiReflectionService(
        apiKey: 'test-openrouter-key',
        provider: 'openrouter',
        model: 'openai/gpt-4.1-mini',
        schemaVersion: 1,
        client: client,
      );

      final result = await service.completeReflection(
        entry: _entry(),
        mode: AiReflectionMode.redirect,
        userReply: 'Ich war eigentlich schon vorher völlig angespannt.',
      );

      expect(result.result.likelyCore, contains('Voranspannung'));
      expect(result.result.mantra, contains('Trigger'));
    });

    test('blocks crisis entries before the network call', () async {
      final client = MockClient((request) async {
        fail('network should not be called for crisis entries');
      });
      final service = DirectOpenRouterAiReflectionService(
        apiKey: 'test-openrouter-key',
        provider: 'openrouter',
        model: 'openai/gpt-4.1-mini',
        schemaVersion: 1,
        client: client,
      );

      await expectLater(
        () => service.startReflection(
          entry: _entry(isCrisis: true),
          mode: AiReflectionMode.stabilize,
        ),
        throwsA(isA<AiReflectionException>()),
      );
    });

    test('surfaces timeouts as ai reflection exceptions', () async {
      final completer = Completer<http.Response>();
      final client = MockClient((request) => completer.future);
      final service = DirectOpenRouterAiReflectionService(
        apiKey: 'test-openrouter-key',
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

    test('maps unauthorized upstream responses to explicit error codes',
        () async {
      final client = MockClient((request) async {
        return http.Response(
          jsonEncode({
            'error': {
              'message': 'Invalid API key',
              'code': 'invalid_api_key',
            },
          }),
          401,
          headers: {'content-type': 'application/json'},
        );
      });
      final service = DirectOpenRouterAiReflectionService(
        apiKey: 'test-openrouter-key',
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
            AiReflectionErrorCode.unauthorized,
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
    needOrWoundedPoint: 'Ich will ernst genommen werden.',
    neededSupports: jsonEncode(const ['Verständnis']),
    realisticAlternative: 'Kurz stoppen und sagen, dass ich später antworte.',
    patternFamiliarity: 'sometimes',
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
