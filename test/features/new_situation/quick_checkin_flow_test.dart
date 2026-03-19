import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:innenkompass/app/router.dart';

import '../../helpers/app_test_harness.dart';

void main() {
  group('Quick check-in flow', () {
    testWidgets('saves a normal quick check-in and returns to home',
        (WidgetTester tester) async {
      final harness = await pumpTestApp(tester);

      await tester.tap(find.text('Kurz einchecken'));
      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.text('Kurzcheck'), findsOneWidget);

      await tester.tap(find.text('Freude'));
      await tester.pump();
      await tester.tap(find.text('Einchecken'));
      await tester.pump();
      await tester.pumpAndSettle();

      expect(
        find.text('Möchtest du noch etwas mehr reflektieren?'),
        findsOneWidget,
      );

      await tester.tap(find.text('Nein, danke'));
      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.text('Was ist passiert?'), findsOneWidget);

      final entries = await harness.database.getAllSituationEntries();
      expect(entries, hasLength(1));
      expect(entries.single.primaryEmotion, 'joy');
      expect(entries.single.isCrisis, isFalse);
      expect(tester.takeException(), isNull);
    });

    testWidgets('routes high-intensity quick check-ins to crisis support',
        (WidgetTester tester) async {
      final harness = await pumpTestApp(tester);

      await harness.goTo(tester, AppRoutes.quickCheckin);

      await tester.tap(find.text('Angst'));
      await tester.pump();
      await tester.drag(find.byType(Slider), const Offset(500, 0));
      await tester.pumpAndSettle();

      expect(find.text('10 / 10'), findsOneWidget);

      await tester.tap(find.text('Einchecken'));
      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.text('Krisenhilfe'), findsOneWidget);
      expect(find.text('Notfallkontakte'), findsOneWidget);

      final entries = await harness.database.getAllSituationEntries();
      expect(entries, hasLength(1));
      expect(entries.single.isCrisis, isTrue);
      expect(entries.single.systemState, 'crisis');
      expect(tester.takeException(), isNull);
    });
  });
}
