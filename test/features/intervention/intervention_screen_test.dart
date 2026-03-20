import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';

import 'package:innenkompass/application/providers/intervention_providers.dart';
import 'package:innenkompass/application/providers/database_provider.dart';
import 'package:innenkompass/data/db/app_database.dart';
import 'package:innenkompass/domain/models/intervention_library.dart';
import 'package:innenkompass/domain/models/intervention_step.dart';
import 'package:innenkompass/features/intervention/screens/intervention_screen.dart';

void main() {
  group('InterventionScreen', () {
    testWidgets('starts direct-open breathing intervention after first frame',
        (WidgetTester tester) async {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final flowSub = container.listen(
        interventionFlowStateProvider,
        (_, __) {},
        fireImmediately: true,
      );
      addTearDown(flowSub.close);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(
            home: InterventionScreen(
              interventionId: 'regulation_4_6_breathing',
            ),
          ),
        ),
      );

      await tester.pump();

      final flowState = container.read(interventionFlowStateProvider);

      expect(flowState.intervention?.id, 'regulation_4_6_breathing');
      expect(find.text('4-6-8 Atmung'), findsOneWidget);
      expect(tester.takeException(), isNull);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
    });

    testWidgets('starts direct-open grounding intervention after first frame',
        (WidgetTester tester) async {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final flowSub = container.listen(
        interventionFlowStateProvider,
        (_, __) {},
        fireImmediately: true,
      );
      addTearDown(flowSub.close);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(
            home: InterventionScreen(
              interventionId: 'grounding_5_4_3_2_1',
            ),
          ),
        ),
      );

      await tester.pump();

      final flowState = container.read(interventionFlowStateProvider);

      expect(flowState.intervention?.id, 'grounding_5_4_3_2_1');
      expect(find.text('5-4-3-2-1 Erdung'), findsOneWidget);
      expect(tester.takeException(), isNull);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
    });

    testWidgets('keeps existing started flow and preserves entry id',
        (WidgetTester tester) async {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final flowSub = container.listen(
        interventionFlowStateProvider,
        (_, __) {},
        fireImmediately: true,
      );
      addTearDown(flowSub.close);

      final intervention =
          InterventionLibrary.getById('regulation_4_6_breathing');
      expect(intervention, isNotNull);

      container
          .read(interventionFlowStateProvider.notifier)
          .startIntervention(intervention!, entryId: 42);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(
            home: InterventionScreen(
              interventionId: 'regulation_4_6_breathing',
            ),
          ),
        ),
      );

      await tester.pump();

      final flowState = container.read(interventionFlowStateProvider);

      expect(flowState.intervention?.id, 'regulation_4_6_breathing');
      expect(flowState.entryId, 42);
      expect(find.text('4-6-8 Atmung'), findsOneWidget);
      expect(tester.takeException(), isNull);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
    });

    testWidgets('restarts direct-open flow without entry id from step zero',
        (WidgetTester tester) async {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final flowSub = container.listen(
        interventionFlowStateProvider,
        (_, __) {},
        fireImmediately: true,
      );
      addTearDown(flowSub.close);

      final intervention =
          InterventionLibrary.getById('regulation_4_6_breathing');
      expect(intervention, isNotNull);

      container
          .read(interventionFlowStateProvider.notifier)
          .startIntervention(intervention!);
      container.read(interventionFlowStateProvider.notifier).nextStep();

      expect(
        container.read(interventionFlowStateProvider).currentStepIndex,
        1,
      );

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(
            home: InterventionScreen(
              interventionId: 'regulation_4_6_breathing',
            ),
          ),
        ),
      );

      await tester.pump();

      final flowState = container.read(interventionFlowStateProvider);

      expect(flowState.currentStepIndex, 0);
      expect(flowState.entryId, isNull);
      expect(find.text('Willkommen'), findsOneWidget);
      expect(tester.takeException(), isNull);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
    });

    testWidgets(
        'shows a contextual intro when the intervention is tied to an entry',
        (WidgetTester tester) async {
      final database = AppDatabase.forTesting(NativeDatabase.memory());
      addTearDown(database.close);

      final entryId = await database.createSituationEntry(
        SituationEntriesCompanion.insert(
          situationDescription: 'Ein schwieriger Moment im Meeting.',
          context: 'work',
          timestamp: DateTime(2026, 3, 20, 9, 0),
          intensity: 8,
          bodyTension: 8,
          primaryEmotion: 'fear',
          automaticThought: 'Das kippt gleich.',
          firstImpulse: 'withdraw',
          initialBodyReactions: Value(jsonEncode(const ['Druck'])),
          systemState: 'overwhelm',
          isDraft: const Value(false),
        ),
      );

      final container = ProviderContainer(
        overrides: [
          databaseProvider.overrideWithValue(database),
        ],
      );
      addTearDown(container.dispose);
      final flowSub = container.listen(
        interventionFlowStateProvider,
        (_, __) {},
        fireImmediately: true,
      );
      addTearDown(flowSub.close);

      final intervention =
          InterventionLibrary.getById('regulation_4_6_breathing');
      expect(intervention, isNotNull);

      container
          .read(interventionFlowStateProvider.notifier)
          .startIntervention(intervention!, entryId: entryId);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(
            home: InterventionScreen(),
          ),
        ),
      );

      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.textContaining('Du hast druck beschrieben'), findsOneWidget);
    });

    testWidgets(
        'resumes the new-situation flow instead of opening post-evaluation when a completion route is configured',
        (WidgetTester tester) async {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final flowSub = container.listen(
        interventionFlowStateProvider,
        (_, __) {},
        fireImmediately: true,
      );
      addTearDown(flowSub.close);

      final intervention =
          InterventionLibrary.getById('regulation_4_6_breathing');
      expect(intervention, isNotNull);

      container
          .read(interventionFlowStateProvider.notifier)
          .startIntervention(intervention!);
      container.read(interventionFlowStateProvider.notifier).goToStep(
            intervention.steps.length - 1,
          );
      container.read(interventionFlowStateProvider.notifier).saveStepResponse(
            InterventionStepResponse(
              stepId: intervention.steps.last.id,
              type: intervention.steps.last.type,
              textResponse: 'Etwas ruhiger.',
              answeredAt: DateTime(2026, 3, 20, 11, 0),
            ),
          );

      final router = GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(
            path: '/',
            builder: (_, __) =>
                const InterventionScreen(completionRoute: '/resume'),
          ),
          GoRoute(
            path: '/resume',
            builder: (_, __) => const Scaffold(
              body: Text('Resume Flow'),
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

      await tester.pumpAndSettle();
      await tester.tap(find.text('Fertigstellen'));
      await tester.pumpAndSettle();

      expect(find.text('Resume Flow'), findsOneWidget);
      expect(
        container.read(interventionFlowStateProvider).intervention,
        isNull,
      );
    });
  });
}
