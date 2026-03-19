import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/app_test_harness.dart';

void main() {
  group('New situation flow smoke', () {
    testWidgets('captures a full situation and lands on evaluation',
        (WidgetTester tester) async {
      final harness = await pumpTestApp(tester);

      Future<void> tapVisible(Finder finder) async {
        await tester.ensureVisible(finder);
        await tester.pump();
        await tester.tap(finder);
        await tester.pump();
        await tester.pumpAndSettle();
      }

      Finder gestureTarget(String label) {
        return find.ancestor(
          of: find.text(label).first,
          matching: find.byType(GestureDetector),
        ).hitTestable().first;
      }

      Finder choiceChipTarget(String label) {
        return find.ancestor(
          of: find.text(label),
          matching: find.byType(ChoiceChip),
        ).hitTestable().first;
      }

      await tester.tap(find.text('Was ist passiert?'));
      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.text('Situation erfassen'), findsOneWidget);

      await tester.enterText(
        find.byType(TextField).first,
        'Das Gespräch im Meeting wurde plötzlich angespannt.',
      );
      await tapVisible(gestureTarget('Arbeit'));
      await tapVisible(find.text('Weiter'));

      expect(find.text('Emotionen erfassen'), findsOneWidget);

      await tapVisible(gestureTarget('Angst'));
      await tapVisible(find.text('Weiter'));

      expect(find.text('Gedanken und Impulse'), findsOneWidget);

      await tester.enterText(
        find.byType(TextField).first,
        'Ich werde jetzt sicher falsch verstanden.',
      );
      await tester.drag(
        find.byType(SingleChildScrollView),
        const Offset(0, -500),
      );
      await tester.pumpAndSettle();
      await tapVisible(gestureTarget('Rückziehen'));
      await tapVisible(choiceChipTarget('Gemischt'));
      await tapVisible(find.text('Weiter'));

      expect(find.text('Einordnen und weitergehen'), findsOneWidget);

      await tester.enterText(
        find.byType(TextField).first,
        'Ich brauche gerade mehr Sicherheit.',
      );
      await tester.enterText(
        find.byType(TextField).at(1),
        'Ich schreibe mir zuerst die Fakten auf.',
      );

      await tapVisible(find.text('Speichern'));

      expect(find.text('Deine Auswertung'), findsOneWidget);
      expect(find.text('Was auffällt'), findsOneWidget);

      final entries = await harness.database.getAllSituationEntries();
      expect(entries, hasLength(1));
      expect(
        entries.single.situationDescription,
        'Das Gespräch im Meeting wurde plötzlich angespannt.',
      );
      expect(entries.single.primaryEmotion, 'fear');
      expect(tester.takeException(), isNull);
    });
  });
}
