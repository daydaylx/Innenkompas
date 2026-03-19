import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:innenkompass/app/router.dart';
import 'package:innenkompass/application/providers/database_provider.dart';
import 'package:innenkompass/application/providers/evaluation_providers.dart';
import 'package:innenkompass/application/providers/intervention_providers.dart';
import 'package:innenkompass/core/constants/intervention_types.dart';
import 'package:innenkompass/data/db/app_database.dart';
import 'package:innenkompass/domain/models/evaluation.dart';
import 'package:innenkompass/domain/models/intervention_library.dart';
import 'package:innenkompass/features/evaluation/screens/entry_evaluation_screen.dart';
import 'package:innenkompass/features/intervention/screens/intervention_screen.dart';
import 'package:innenkompass/features/intervention/screens/post_evaluation_screen.dart';

import '../../helpers/app_test_harness.dart';

void main() {
  group('Intervention smoke', () {
    testWidgets('persists the intervention CTA selection from evaluation',
        (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1600));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final database = AppDatabase.forTesting(NativeDatabase.memory());
      addTearDown(database.close);

      final entryId = await insertSituationEntry(
        database,
        interventionType: InterventionType.regulation.name,
      );

      final container = ProviderContainer(
        overrides: [
          databaseProvider.overrideWithValue(database),
          evaluationContentProvider.overrideWith(
            (ref) async => EvaluationContentBundle.fallback,
          ),
        ],
      );
      addTearDown(container.dispose);

      final router = GoRouter(
        initialLocation: '/eval',
        routes: [
          GoRoute(
            path: '/eval',
            builder: (context, state) => EntryEvaluationScreen(entryId: entryId),
          ),
          GoRoute(
            path: AppRoutes.intervention,
            builder: (context, state) => Consumer(
              builder: (context, ref, _) => InterventionScreen(
                interventionId: ref
                    .watch(interventionFlowStateProvider)
                    .intervention
                    ?.id,
              ),
            ),
          ),
        ],
      );
      addTearDown(router.dispose);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp.router(
            routerConfig: router,
          ),
        ),
      );
      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.text('Deine Auswertung'), findsOneWidget);
      expect(find.text('Passende Übung starten'), findsOneWidget);

      final startButton = find.ancestor(
        of: find.text('Passende Übung starten'),
        matching: find.byType(ElevatedButton),
      );
      expect(
        tester.widget<ElevatedButton>(startButton).onPressed,
        isNotNull,
      );

      tester.widget<ElevatedButton>(startButton).onPressed!.call();
      await tester.pump();
      await tester.pumpAndSettle();

      final updatedEntry = await database.getSituationEntryById(entryId);
      expect(updatedEntry, isNotNull);
      expect(updatedEntry!.selectedNextActionKey, 'choose_one_step');
      expect(tester.takeException(), isNull);
    });

    testWidgets('saves post evaluation and returns to home',
        (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1600));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final database = AppDatabase.forTesting(NativeDatabase.memory());
      addTearDown(database.close);

      final entryId = await insertSituationEntry(
        database,
        interventionType: InterventionType.regulation.name,
      );

      final container = ProviderContainer(
        overrides: [
          databaseProvider.overrideWithValue(database),
        ],
      );
      addTearDown(container.dispose);

      final intervention =
          InterventionLibrary.getById('regulation_4_6_breathing');
      expect(intervention, isNotNull);

      container
          .read(interventionFlowStateProvider.notifier)
          .startIntervention(intervention!, entryId: entryId);
      container
          .read(interventionFlowStateProvider.notifier)
          .completeIntervention();

      final router = GoRouter(
        initialLocation: AppRoutes.postEvaluation,
        routes: [
          GoRoute(
            path: AppRoutes.postEvaluation,
            builder: (context, state) => const PostEvaluationScreen(),
          ),
          GoRoute(
            path: AppRoutes.home,
            builder: (context, state) => const Scaffold(
              body: Center(
                child: Text('Home'),
              ),
            ),
          ),
        ],
      );
      addTearDown(router.dispose);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp.router(
            routerConfig: router,
          ),
        ),
      );
      await tester.pump();
      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.text('Wie fühlst du dich jetzt?'), findsOneWidget);

      await tester.enterText(
        find.byType(TextField).first,
        'Die Übung hat mich deutlich beruhigt.',
      );
      await tester.ensureVisible(find.text('Speichern und abschließen'));
      await tester.pump();
      await tester.tap(find.text('Speichern und abschließen'));
      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.text('Home'), findsOneWidget);

      final updatedEntry = await database.getSituationEntryById(entryId);
      expect(updatedEntry, isNotNull);
      expect(updatedEntry!.postIntensity, 5);
      expect(updatedEntry.postBodyTension, 5);
      expect(updatedEntry.postClarity, 5);
      expect(updatedEntry.helpfulnessRating, 7);
      expect(updatedEntry.postNote, 'Die Übung hat mich deutlich beruhigt.');
      expect(tester.takeException(), isNull);
    });
  });
}
