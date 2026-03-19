import 'dart:convert';

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:innenkompass/application/providers/database_provider.dart';
import 'package:innenkompass/application/providers/evaluation_providers.dart';
import 'package:innenkompass/core/config/ai_evaluation_config.dart';
import 'package:innenkompass/data/db/app_database.dart';
import 'package:innenkompass/domain/models/evaluation.dart';
import 'package:innenkompass/features/evaluation/screens/entry_evaluation_screen.dart';

void main() {
  group('EntryEvaluationScreen AI section', () {
    testWidgets('shows spinner only for fresh pending requests',
        (WidgetTester tester) async {
      final database = AppDatabase.forTesting(NativeDatabase.memory());
      addTearDown(database.close);

      final entryId = await _insertEntry(
        database,
        status: 'pending',
        consentGiven: true,
        requestedAt: DateTime.now().subtract(const Duration(seconds: 30)),
      );

      await _pumpScreen(
        tester,
        database: database,
        entryId: entryId,
      );

      expect(
        find.textContaining('Die freie Einordnung wird gerade erstellt'),
        findsOneWidget,
      );
      expect(find.text('Erneut anfordern'), findsNothing);
    });

    testWidgets('shows recovery UI for stale pending requests',
        (WidgetTester tester) async {
      final database = AppDatabase.forTesting(NativeDatabase.memory());
      addTearDown(database.close);

      final entryId = await _insertEntry(
        database,
        status: 'pending',
        consentGiven: true,
        requestedAt: DateTime.now().subtract(const Duration(minutes: 3)),
      );

      await _pumpScreen(
        tester,
        database: database,
        entryId: entryId,
      );

      expect(
        find.textContaining('wurde nicht abgeschlossen'),
        findsOneWidget,
      );
      expect(
        find.textContaining('bereits gespeicherte Datenfreigabe'),
        findsOneWidget,
      );
      expect(find.text('Erneut anfordern'), findsOneWidget);
    });

    testWidgets('shows explicit consent reuse hint for failed requests',
        (WidgetTester tester) async {
      final database = AppDatabase.forTesting(NativeDatabase.memory());
      addTearDown(database.close);

      final entryId = await _insertEntry(
        database,
        status: 'failed',
        consentGiven: true,
        requestedAt: DateTime.now().subtract(const Duration(minutes: 1)),
      );

      await _pumpScreen(
        tester,
        database: database,
        entryId: entryId,
      );

      expect(
        find.textContaining('zuletzt nicht geladen werden'),
        findsOneWidget,
      );
      expect(
        find.textContaining('bereits gespeicherte Datenfreigabe'),
        findsOneWidget,
      );
      expect(find.text('Erneut anfordern'), findsOneWidget);
    });
  });
}

Future<void> _pumpScreen(
  WidgetTester tester, {
  required AppDatabase database,
  required int entryId,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(database),
        aiEvaluationConfigProvider.overrideWithValue(
          const AiEvaluationConfig(
            baseUrl: 'https://example.com/api',
            appToken: null,
            openRouterApiKey: null,
          ),
        ),
        evaluationContentProvider.overrideWith(
          (ref) async => EvaluationContentBundle.fallback,
        ),
      ],
      child: MaterialApp(
        home: EntryEvaluationScreen(entryId: entryId),
      ),
    ),
  );

  await tester.pump();
  await tester.pump();
}

Future<int> _insertEntry(
  AppDatabase database, {
  required String status,
  required bool consentGiven,
  required DateTime requestedAt,
}) {
  final now = DateTime(2026, 3, 19, 10, 0);
  return database.createSituationEntry(
    SituationEntriesCompanion.insert(
      situationDescription: 'Ein schwieriges Gespräch nach dem Meeting.',
      context: 'work',
      timestamp: now,
      involvedPerson: const Value('Kollege'),
      intensity: 7,
      bodyTension: 8,
      primaryEmotion: 'fear',
      secondaryEmotion: const Value('shame'),
      bodySymptoms: Value(jsonEncode(const ['Enge in der Brust', 'Zittern'])),
      automaticThought: 'Ich werde gleich falsch verstanden.',
      firstImpulse: 'withdraw',
      factInterpretationResult: const Value('mostlyInterpretation'),
      actualBehavior: const Value('Ich habe noch nichts geantwortet.'),
      needOrWoundedPoint: const Value('Ich will ernst genommen werden.'),
      nextStep: const Value('Ich notiere zuerst die Fakten.'),
      systemState: 'interpretation',
      isCrisis: const Value(false),
      evaluationHeadlineKey: const Value('interpretation_uncertain_facts'),
      evaluationMeaningKey: const Value('interpretation_not_certain'),
      suggestedTipIds: Value(
        jsonEncode(const [
          'check_facts_not_assumptions',
          'write_alternative_explanation',
        ]),
      ),
      suggestedNextActionKey: const Value('check_facts_first'),
      aiEvaluationStatus: Value(status),
      aiEvaluationRequestedAt: Value(requestedAt),
      aiEvaluationConsentGiven: Value(consentGiven),
      interventionType: const Value('factCheck'),
      isDraft: const Value(false),
    ),
  );
}
