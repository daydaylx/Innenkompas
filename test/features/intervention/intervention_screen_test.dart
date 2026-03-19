import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:innenkompass/application/providers/intervention_providers.dart';
import 'package:innenkompass/domain/models/intervention_library.dart';
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
  });
}
