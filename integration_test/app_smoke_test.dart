import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:innenkompass/application/providers/database_provider.dart';
import 'package:innenkompass/app/app.dart';
import 'package:innenkompass/data/db/app_database.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Future<void> pumpApp(
    WidgetTester tester,
    AppDatabase database,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(database),
        ],
        child: const InnenkompassApp(),
      ),
    );
  }

  testWidgets('cold start reaches onboarding and main CTA',
      (WidgetTester tester) async {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(database.close);

    await pumpApp(tester, database);

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Willkommen bei Innenkompass'), findsOneWidget);
    expect(find.text('Weiter'), findsOneWidget);
  });

  testWidgets('skip onboarding reaches home with main navigation',
      (WidgetTester tester) async {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(database.close);

    await pumpApp(tester, database);

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pump(const Duration(milliseconds: 300));

    await tester.tap(find.text('Überspringen'));
    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.text('Ruhiger Einstieg'), findsOneWidget);
    expect(find.text('Was ist passiert?'), findsOneWidget);
    expect(find.text('Start'), findsOneWidget);
    expect(find.text('Hilfe'), findsOneWidget);
  });
}
