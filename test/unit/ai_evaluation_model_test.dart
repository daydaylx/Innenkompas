import 'package:flutter_test/flutter_test.dart';
import 'package:innenkompass/domain/models/ai_evaluation.dart';

void main() {
  group('AiEvaluationContent', () {
    test('parses valid JSON payload', () {
      final content = AiEvaluationContent.fromJson(const {
        'was_auffaellt': 'Der Eintrag wirkt stark aufgeladen.',
        'einordnung':
            'Vieles klingt nach Alarmmodus statt nach ruhiger Sortierung.',
        'praktisch_hilfreich':
            'Erst beruhigen, dann den nächsten kleinen Schritt wählen.',
        'vorsichtshinweis':
            'Wenn die Belastung kippt, hole dir direkte Unterstützung.',
      });

      expect(content.wasAuffaellt, contains('aufgeladen'));
      expect(content.einordnung, contains('Alarmmodus'));
      expect(content.praktischHilfreich, contains('kleinen Schritt'));
      expect(content.hasVorsichtshinweis, isTrue);
    });

    test('roundtrips as JSON string', () {
      const content = AiEvaluationContent(
        wasAuffaellt: 'Starker Rückzugsimpuls.',
        einordnung: 'Die Lage wirkt emotional enger als sachlich klar.',
        praktischHilfreich: 'Nicht sofort reagieren.',
      );

      final decoded = AiEvaluationContent.tryParse(content.toJsonString());

      expect(decoded, isNotNull);
      expect(decoded!.wasAuffaellt, content.wasAuffaellt);
      expect(decoded.einordnung, content.einordnung);
      expect(decoded.praktischHilfreich, content.praktischHilfreich);
      expect(decoded.vorsichtshinweis, isNull);
    });

    test('rejects incomplete payloads', () {
      expect(
        () => AiEvaluationContent.fromJson(const {
          'was_auffaellt': 'Nur ein Feld',
          'einordnung': '',
          'praktisch_hilfreich': 'Fehlt praktisch',
        }),
        throwsFormatException,
      );
    });

    test('returns null for invalid raw payloads', () {
      expect(
        AiEvaluationContent.tryParse('{"was_auffaellt":'),
        isNull,
      );
    });
  });

  group('AiEvaluationStatus', () {
    test('maps raw values safely', () {
      expect(
        AiEvaluationStatus.fromRaw('success'),
        AiEvaluationStatus.success,
      );
      expect(AiEvaluationStatus.fromRaw('unknown'), isNull);
      expect(AiEvaluationStatus.fromRaw(null), isNull);
    });

    test('marks old pending requests as stale', () {
      final requestedAt = DateTime(2026, 3, 19, 10, 0);

      final isStale = AiEvaluationStatus.pending.isPendingStale(
        requestedAt: requestedAt,
        now: requestedAt.add(aiEvaluationPendingStaleAfter),
      );

      expect(isStale, isTrue);
      expect(
        AiEvaluationStatus.success.isPendingStale(
          requestedAt: requestedAt,
          now: requestedAt.add(aiEvaluationPendingStaleAfter),
        ),
        isFalse,
      );
    });
  });
}
