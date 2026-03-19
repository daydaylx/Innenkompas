// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:innenkompass/application/providers/database_provider.dart';
import 'package:innenkompass/app/app.dart';
import 'package:innenkompass/data/db/app_database.dart';

void main() {
  testWidgets('App zeigt Splash-UI waehrend des Bootstrap',
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
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(tester.takeException(), isNull);
  });
}
