import 'package:flutter_test/flutter_test.dart';

import 'package:innenkompass/app/router.dart';

import '../../helpers/app_test_harness.dart';

void main() {
  group('EntryDetailScreen legacy fallbacks', () {
    testWidgets('shows legacy impulse, legacy meaning and next step',
        (WidgetTester tester) async {
      final harness = await pumpTestApp(tester);

      final entryId = await insertSituationEntry(
        harness.database,
        situationDescription: 'Ein schwieriges Gespräch nach dem Meeting.',
        firstImpulse: 'withdraw',
        needOrWoundedPoint: 'Ich will ernst genommen werden.',
        nextStep: 'Ich notiere zuerst die Fakten.',
      );

      await harness.goTo(
        tester,
        AppRoutes.entryDetail.replaceFirst(':id', '$entryId'),
      );

      expect(find.text('Eintragdetails'), findsOneWidget);
      expect(find.text('Früher erfasster Erstimpuls:'), findsOneWidget);
      expect(find.text('Rückziehen'), findsOneWidget);
      expect(find.text('Einordnung aus älterem Eintrag:'), findsOneWidget);
      expect(find.text('Ich will ernst genommen werden.'), findsOneWidget);
      expect(find.text('Notierter nächster Schritt:'), findsOneWidget);
      expect(find.text('Ich notiere zuerst die Fakten.'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
