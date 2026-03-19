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

    testWidgets(
        'prefills emotion and moment intensity when continuing reflection',
        (WidgetTester tester) async {
      final harness = await pumpTestApp(tester);

      Finder textFieldByHint(String hintText) {
        return find.byWidgetPredicate(
          (widget) =>
              widget is TextField && widget.decoration?.hintText == hintText,
        );
      }

      Finder choiceChipTarget(String label) {
        return find
            .ancestor(
              of: find.text(label),
              matching: find.byType(ChoiceChip),
            )
            .first;
      }

      Finder gestureTarget(String label) {
        return find
            .ancestor(
              of: find.text(label).first,
              matching: find.byType(GestureDetector),
            )
            .first;
      }

      Finder elevatedButtonTarget(String label) {
        return find.widgetWithText(ElevatedButton, label).first;
      }

      Future<void> tapVisible(Finder finder) async {
        final scrollables = find.byType(Scrollable);
        if (scrollables.evaluate().isNotEmpty) {
          await tester.scrollUntilVisible(
            finder,
            200,
            scrollable: scrollables.first,
          );
        } else {
          await tester.ensureVisible(finder);
        }
        await tester.pumpAndSettle();
        await tester.tap(finder, warnIfMissed: false);
        await tester.pumpAndSettle();
      }

      await harness.goTo(tester, AppRoutes.quickCheckin);

      await tester.tap(find.text('Angst'));
      await tester.pump();
      expect(find.text('5 / 10'), findsOneWidget);

      await tester.tap(find.text('Einchecken'));
      await tester.pump();
      await tester.pumpAndSettle();

      await tester.tap(find.text('Ja, weiter reflektieren'));
      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.text('Situation und Vorlauf'), findsOneWidget);

      await tester.enterText(
        textFieldByHint(
          'Zum Beispiel: Im Gespräch fiel ein Satz, der mich sofort hochgefahren hat.',
        ),
        'Das Meeting wurde scharf.',
      );
      await tester.enterText(
        textFieldByHint(
          'Zum Beispiel: Ich war schon erschöpft, habe über Arbeit nachgedacht oder innerlich Druck gemacht.',
        ),
        'Ich war schon innerlich angespannt.',
      );
      await tapVisible(choiceChipTarget('Teilweise'));
      await tester.enterText(
        textFieldByHint(
          'Zum Beispiel: Ein bestimmter Satz, Blick, eine Nachricht oder ein kleiner Fehler.',
        ),
        'Ein Kommentar vor allen.',
      );
      await tapVisible(gestureTarget('Arbeit'));
      await tapVisible(elevatedButtonTarget('Weiter'));

      expect(find.text('Körper und Gefühle'), findsOneWidget);
      expect(find.text('5 / 10'), findsOneWidget);

      await tapVisible(elevatedButtonTarget('Weiter'));

      expect(find.text('Gedanken, Muster und Verhalten'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
