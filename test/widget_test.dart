// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:innenkompass/application/providers/database_provider.dart';
import 'package:innenkompass/app/app.dart';
import 'package:innenkompass/data/db/app_database.dart';

void main() {
  testWidgets('App startet ueber Splash in den Onboarding-Fluss',
      (WidgetTester tester) async {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(database.close);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(database),
        ],
        child: InnenkompassApp(),
      ),
    );

    expect(find.text('Innenkompass'), findsOneWidget);
    expect(find.text('Lokale Daten werden vorbereitet.'), findsOneWidget);

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    await tester.pump(const Duration(milliseconds: 200));

    expect(find.text('Willkommen bei Innenkompass'), findsOneWidget);
    expect(find.text('Überspringen'), findsOneWidget);
    expect(find.text('Weiter'), findsOneWidget);
  });
}
