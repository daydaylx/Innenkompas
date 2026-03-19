import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:innenkompass/application/providers/database_provider.dart';
import 'package:innenkompass/application/providers/evaluation_providers.dart';
import 'package:innenkompass/data/db/app_database.dart';
import 'package:innenkompass/domain/models/ai_reflection.dart';
import 'package:innenkompass/domain/services/ai_reflection_service.dart';
import 'package:innenkompass/features/evaluation/screens/ai_reflection_screen.dart';

void main() {
  testWidgets('starts reflection, completes it and saves result',
      (WidgetTester tester) async {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(database.close);

    final entryId = await _insertEntry(database);
    final service = _FakeAiReflectionService();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(database),
          aiReflectionServiceProvider.overrideWithValue(service),
        ],
        child: const MaterialApp(
          home: AiReflectionScreen(
            entryId: 1,
            mode: AiReflectionMode.understand,
          ),
        ),
      ),
    );

    await tester.pump();
    await tester.pumpAndSettle();
    final messenger = ScaffoldMessenger.of(
      tester.element(find.byType(Scaffold)),
    );
    messenger.removeCurrentSnackBar();
    await tester.pumpAndSettle();

    expect(find.text('Was die KI aus dem Eintrag sieht'), findsOneWidget);
    expect(find.textContaining('letzte Tropfen'), findsOneWidget);
    expect(
      find.textContaining('größere Thema'),
      findsOneWidget,
    );
    expect(find.text('Schritt 1 von 2'), findsOneWidget);

    await tester.enterText(
      find.byType(TextField),
      'Eigentlich war ich schon vorher völlig angespannt.',
    );
    await tester.ensureVisible(find.text('Verdichten'));
    await tester.tap(find.text('Verdichten'));
    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.text('Ergebnis gespeichert'), findsOneWidget);
    expect(find.text('Wahrscheinlichster Kern'), findsOneWidget);
    expect(service.startCalls, 1);
    expect(service.completeCalls, 1);

    final savedEntry = await database.getSituationEntryById(entryId);
    expect(savedEntry, isNotNull);
    expect(savedEntry!.aiReflectionStatus, 'completed');
    expect(savedEntry.aiReflectionMode, 'understand');
    expect(savedEntry.aiReflectionProvider, 'test');
    expect(savedEntry.aiReflectionModel, 'test-model');
    expect(savedEntry.aiReflectionSessionId, isNotNull);
    expect(savedEntry.aiReflectionInputHash, isNotNull);
    expect(savedEntry.aiReflectionSummary, contains('Voranspannung'));
    expect(savedEntry.aiReflectionNextStep, contains('runterfahren'));
  });

  testWidgets('falls back to local reflection when no ai service is available',
      (WidgetTester tester) async {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(database.close);

    final entryId = await _insertEntry(database);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(database),
          aiReflectionServiceProvider.overrideWithValue(null),
        ],
        child: const MaterialApp(
          home: AiReflectionScreen(
            entryId: 1,
            mode: AiReflectionMode.redirect,
          ),
        ),
      ),
    );

    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.text('Was die KI aus dem Eintrag sieht'), findsOneWidget);

    await tester.enterText(
      find.byType(TextField),
      'Realistisch wäre gewesen, kurz Abstand zu schaffen.',
    );
    final submitButton = tester.widget<ElevatedButton>(
      find.widgetWithText(ElevatedButton, 'Verdichten'),
    );
    submitButton.onPressed!.call();
    await tester.pump();
    await tester.pumpAndSettle();

    final savedEntry = await database.getSituationEntryById(entryId);
    expect(savedEntry, isNotNull);
    expect(savedEntry!.aiReflectionStatus, 'completed');
    expect(savedEntry.aiReflectionProvider, 'local_fallback');
    expect(savedEntry.aiReflectionModel, 'local_rules');
    expect(savedEntry.aiReflectionAlternative, isNotEmpty);
  });
}

class _FakeAiReflectionService implements AiReflectionService {
  int startCalls = 0;
  int completeCalls = 0;

  @override
  Future<AiReflectionStartResponse> startReflection({
    required SituationEntryData entry,
    required AiReflectionMode mode,
  }) async {
    startCalls++;
    return AiReflectionStartResponse(
      provider: 'test',
      model: 'test-model',
      schemaVersion: 1,
      completedAt: DateTime(2026, 3, 19, 10, 5),
      content: const AiReflectionStartContent(
        observation:
            'Der Eintrag wirkt so, als wäre der Auslöser eher der letzte Tropfen gewesen.',
        question:
            'Was war deiner Meinung nach schon vor dem eigentlichen Moment das größere Thema?',
        helperStarters: [
          'Ich glaube eher ...',
          'Eigentlich ging es darum ...',
        ],
      ),
    );
  }

  @override
  Future<AiReflectionCompleteResponse> completeReflection({
    required SituationEntryData entry,
    required AiReflectionMode mode,
    required String userReply,
  }) async {
    completeCalls++;
    return AiReflectionCompleteResponse(
      provider: 'test',
      model: 'test-model',
      schemaVersion: 1,
      completedAt: DateTime(2026, 3, 19, 10, 6),
      result: const AiReflectionResult(
        summary:
            'Wahrscheinlich war nicht nur der Anlass schwierig, sondern auch die vorherige Voranspannung.',
        likelyCore: 'Voranspannung plus Trigger haben zusammen gewirkt.',
        earlyTurningPoint:
            'Gekippt ist es wohl schon, als selbst kleine Dinge gereizt haben.',
        alternative: 'Kurz stoppen statt sofort innerlich hochzufahren.',
        nextStep: 'Jetzt erst runterfahren und das Thema später neu ansehen.',
        mantra: 'Nicht nur die Kleinigkeit war das Problem.',
      ),
    );
  }
}

Future<int> _insertEntry(AppDatabase database) {
  final now = DateTime(2026, 3, 19, 10, 0);
  return database.createSituationEntry(
    SituationEntriesCompanion.insert(
      situationDescription: 'Ein angespanntes Gespräch nach einem Meeting.',
      context: 'work',
      timestamp: now,
      involvedPerson: const Value('Kollege'),
      intensity: 7,
      bodyTension: 8,
      primaryEmotion: 'fear',
      automaticThought: 'Ich werde gleich falsch verstanden.',
      firstImpulse: 'withdraw',
      systemState: 'interpretation',
      isDraft: const Value(false),
    ),
  );
}
