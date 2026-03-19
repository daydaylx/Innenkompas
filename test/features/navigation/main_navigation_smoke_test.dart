import 'package:flutter_test/flutter_test.dart';

import 'package:innenkompass/shared/widgets/navigation/app_main_navigation.dart';

import '../../helpers/app_test_harness.dart';

void main() {
  group('Main navigation smoke', () {
    testWidgets('navigates across primary areas from the bottom navigation',
        (WidgetTester tester) async {
      await pumpTestApp(tester);

      Future<void> tapNav(String label) async {
        await tester.tap(
          find.descendant(
            of: find.byType(AppMainNavigationBar),
            matching: find.text(label),
          ),
        );
        await tester.pump();
        await tester.pumpAndSettle();
      }

      expect(find.text('Was ist passiert?'), findsOneWidget);

      await tapNav('Verlauf');
      expect(find.text('Dein ruhiges Archiv'), findsOneWidget);
      expect(find.text('Noch keine Einträge'), findsOneWidget);

      await tapNav('Muster');
      expect(find.text('Noch nicht genug Eintraege'), findsOneWidget);

      await tapNav('Hilfe');
      expect(find.text('Krisenhilfe'), findsOneWidget);
      expect(find.text('Notfallkontakte'), findsOneWidget);

      await tapNav('Mehr');
      expect(find.text('Ruhige Grundeinstellungen'), findsOneWidget);
      expect(find.text('App-Sperre'), findsOneWidget);

      await tapNav('Start');
      expect(find.text('Was ist passiert?'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
