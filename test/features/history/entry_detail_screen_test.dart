import 'package:flutter_test/flutter_test.dart';

import 'package:innenkompass/app/router.dart';
import 'package:innenkompass/data/services/ai_reflection_request_codec.dart';
import 'package:innenkompass/domain/models/ai_reflection.dart';

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

    testWidgets('shows stored ai reflection result',
        (WidgetTester tester) async {
      final harness = await pumpTestApp(tester);

      final entryId = await insertSituationEntry(
        harness.database,
        situationDescription: 'Ein schwieriges Gespräch nach dem Meeting.',
      );
      final entry = await harness.database.getSituationEntryById(entryId);
      expect(entry, isNotNull);
      final inputHash = computeAiReflectionInputHash(
        entry: entry!,
        mode: AiReflectionMode.understand,
      );
      const sessionId = 'test-session';
      final startedAt = DateTime(2026, 3, 19, 10, 25);

      await harness.database.markAiReflectionInProgress(
        entryId: entryId,
        mode: AiReflectionMode.understand,
        sessionId: sessionId,
        inputHash: inputHash,
        startedAt: startedAt,
      );
      await harness.database.saveAiReflectionStartContent(
        entryId: entryId,
        sessionId: sessionId,
        inputHash: inputHash,
        mode: AiReflectionMode.understand,
        content: const AiReflectionStartContent(
          observation: 'Voranspannung plus Trigger.',
          question: 'Was war schon vorher größer?',
          helperStarters: ['Ich glaube eher ...'],
        ),
        provider: 'openrouter',
        model: 'openai/gpt-4.1-mini',
        schemaVersion: 1,
        startedAt: startedAt,
      );

      await harness.database.saveAiReflectionCompleted(
        entryId: entryId,
        mode: AiReflectionMode.understand,
        sessionId: sessionId,
        inputHash: inputHash,
        provider: 'openrouter',
        model: 'openai/gpt-4.1-mini',
        schemaVersion: 1,
        result: const AiReflectionResult(
          summary:
              'Wahrscheinlich war nicht nur der Anlass schwierig, sondern auch der volle Kopf davor.',
          likelyCore: 'Voranspannung plus Trigger.',
          earlyTurningPoint:
              'Als selbst Kleinigkeiten schon stark gereizt haben.',
          alternative: 'Kurz stoppen statt sofort reagieren.',
          nextStep: 'Erst runterfahren und später neu ansehen.',
          mantra: 'Nicht nur die Kleinigkeit war das Problem.',
        ),
        completedAt: DateTime(2026, 3, 19, 10, 30),
      );

      await harness.goTo(
        tester,
        AppRoutes.entryDetail.replaceFirst(':id', '$entryId'),
      );

      expect(find.text('KI-Nachreflexion'), findsOneWidget);
      expect(find.text('Wahrscheinlichster Kern'), findsOneWidget);
      expect(find.text('Voranspannung plus Trigger.'), findsOneWidget);
      expect(find.text('Merksatz'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
