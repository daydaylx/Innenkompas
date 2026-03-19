import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:innenkompass/data/db/app_database.dart';
import 'package:innenkompass/shared/widgets/navigation/app_main_navigation.dart';

import '../../helpers/app_test_harness.dart';

void main() {
  group('History navigation', () {
    testWidgets('opens entry details from the history list',
        (WidgetTester tester) async {
      final entryDescription = 'Das Feedback im Termin hat mich kalt erwischt.';
      final database = AppDatabase.forTesting(NativeDatabase.memory());
      final entryId = await insertSituationEntry(
        database,
        situationDescription: entryDescription,
      );

      final harness = await pumpTestApp(
        tester,
        database: database,
      );

      expect(entryId, greaterThan(0));

      await tester.tap(
        find.descendant(
          of: find.byType(AppMainNavigationBar),
          matching: find.text('Verlauf'),
        ),
      );
      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.text(entryDescription), findsOneWidget);

      await tester.tap(find.text(entryDescription));
      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.text('Eintragdetails'), findsOneWidget);
      expect(find.text('Situation'), findsOneWidget);
      expect(find.text('Gedanken & Impulse'), findsOneWidget);
      expect(find.text('Ich will ernst genommen werden.'), findsOneWidget);
      expect(tester.takeException(), isNull);

      final entry = await harness.database.getSituationEntryById(entryId);
      expect(entry, isNotNull);
    });
  });
}
