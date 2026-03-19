import 'package:flutter_test/flutter_test.dart';

import 'package:innenkompass/app/router.dart';

import '../../helpers/app_test_harness.dart';

void main() {
  group('Router redirects', () {
    testWidgets('shows onboarding when onboarding is not completed',
        (WidgetTester tester) async {
      await pumpTestApp(
        tester,
        onboardingCompleted: false,
      );

      expect(find.text('Willkommen bei Innenkompass'), findsOneWidget);
      expect(find.text('Loslegen'), findsNothing);
      expect(tester.takeException(), isNull);
    });

    testWidgets('shows home when onboarding is completed',
        (WidgetTester tester) async {
      await pumpTestApp(tester);

      expect(find.text('Was ist passiert?'), findsOneWidget);
      expect(
        find.text('Hier kannst du kurz landen, sortieren und weiterdenken.'),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('keeps crisis route reachable while app is locked',
        (WidgetTester tester) async {
      final harness = await pumpTestApp(
        tester,
        lockEnabled: true,
        isLocked: true,
      );

      expect(find.text('Innenkompass entsperren'), findsOneWidget);

      await harness.goTo(tester, AppRoutes.crisis);

      expect(find.text('Krisenhilfe'), findsOneWidget);
      expect(find.text('Notfallkontakte'), findsOneWidget);
      expect(find.text('Innenkompass entsperren'), findsNothing);
      expect(tester.takeException(), isNull);
    });
  });
}
