import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/app_test_harness.dart';

void main() {
  group('New situation flow smoke', () {
    testWidgets('captures a full situation and lands on evaluation',
        (WidgetTester tester) async {
      final harness = await pumpTestApp(tester);

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

      Finder gestureTarget(String label) {
        return find
            .ancestor(
              of: find.text(label).first,
              matching: find.byType(GestureDetector),
            )
            .first;
      }

      Finder choiceChipTarget(String label) {
        return find
            .ancestor(
              of: find.text(label),
              matching: find.byType(ChoiceChip),
            )
            .first;
      }

      Finder filterChipTarget(String label) {
        return find
            .ancestor(
              of: find.text(label),
              matching: find.byType(FilterChip),
            )
            .first;
      }

      Finder elevatedButtonTarget(String label) {
        return find.widgetWithText(ElevatedButton, label).first;
      }

      Finder textFieldByHint(String hintText) {
        return find.byWidgetPredicate(
          (widget) =>
              widget is TextField && widget.decoration?.hintText == hintText,
        );
      }

      await tester.tap(find.text('Was ist passiert?'));
      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.text('Situation und Vorlauf'), findsOneWidget);

      await tester.enterText(
        textFieldByHint(
          'Zum Beispiel: Im Gespräch fiel ein Satz, der mich sofort hochgefahren hat.',
        ),
        'Das Gespräch im Meeting wurde plötzlich angespannt.',
      );
      await tester.enterText(
        textFieldByHint(
          'Zum Beispiel: Ich war schon erschöpft, habe über Arbeit nachgedacht oder innerlich Druck gemacht.',
        ),
        'Ich war schon vorher unter Druck und gedanklich bei dem Termin.',
      );
      await tester.enterText(
        textFieldByHint(
          'Zum Beispiel: Ein bestimmter Satz, Blick, eine Nachricht oder ein kleiner Fehler.',
        ),
        'Ein scharfer Kommentar vor allen anderen.',
      );
      await tapVisible(gestureTarget('Arbeit'));
      expect(
        tester.widget<ElevatedButton>(elevatedButtonTarget('Weiter')).onPressed,
        isNotNull,
      );
      await tapVisible(elevatedButtonTarget('Weiter'));

      expect(find.text('Körper und Gefühle'), findsOneWidget);

      await tapVisible(gestureTarget('Angst'));
      expect(
        tester.widget<ElevatedButton>(elevatedButtonTarget('Weiter')).onPressed,
        isNotNull,
      );
      await tapVisible(elevatedButtonTarget('Weiter'));

      expect(find.text('Gedanken, Muster und Verhalten'), findsOneWidget);

      await tester.enterText(
        textFieldByHint(
          'Zum Beispiel: Ich war schon bei den nächsten Problemen oder habe innerlich etwas durchgespielt.',
        ),
        'Ich war gedanklich schon bei meinem Fehler von davor.',
      );
      await tester.enterText(
        textFieldByHint(
          '"Das ist wieder typisch" oder "Ich bin zu blöd dafür"',
        ),
        'Ich werde jetzt sicher falsch verstanden.',
      );
      await tester.drag(
        find.byType(SingleChildScrollView),
        const Offset(0, -500),
      );
      await tester.pumpAndSettle();
      await tapVisible(choiceChipTarget('Gemischt'));
      await tapVisible(choiceChipTarget('Rückzug'));
      await tapVisible(filterChipTarget('zurückgezogen'));
      await tapVisible(choiceChipTarget('Erst im Nachhinein'));
      expect(
        tester.widget<ElevatedButton>(elevatedButtonTarget('Weiter')).onPressed,
        isNotNull,
      );
      await tapVisible(elevatedButtonTarget('Weiter'));

      expect(find.text('Einordnen und weitergehen'), findsOneWidget);

      await tapVisible(choiceChipTarget('Ja, ziemlich sicher'));
      await tapVisible(filterChipTarget('Respekt'));
      await tapVisible(filterChipTarget('Klarheit'));

      expect(
        tester
            .widget<ElevatedButton>(elevatedButtonTarget('Speichern'))
            .onPressed,
        isNotNull,
      );
      await tapVisible(elevatedButtonTarget('Speichern'));

      expect(find.text('Deine Auswertung'), findsOneWidget);
      expect(find.text('Was auffällt'), findsOneWidget);

      final entries = await harness.database.getAllSituationEntries();
      expect(entries, hasLength(1));
      expect(
        entries.single.situationDescription,
        'Das Gespräch im Meeting wurde plötzlich angespannt.',
      );
      expect(
        entries.single.preTriggerPreoccupation,
        'Ich war schon vorher unter Druck und gedanklich bei dem Termin.',
      );
      expect(
        entries.single.triggerDescription,
        'Ein scharfer Kommentar vor allen anderen.',
      );
      expect(entries.single.primaryEmotion, 'fear');
      expect(tester.takeException(), isNull);
    });
  });
}
