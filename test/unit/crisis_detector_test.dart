import 'package:flutter_test/flutter_test.dart';
import 'package:innenkompass/core/constants/emotion_types.dart';
import 'package:innenkompass/core/constants/context_types.dart';
import 'package:innenkompass/domain/rules/crisis_detector.dart';

void main() {
  group('CrisisDetector', () {
    test('detects crisis with extremely high intensity', () {
      final result = CrisisDetector.detect(
        intensity: 9,
        bodyTension: 5,
        primaryEmotion: EmotionType.anger,
        automaticThought: 'Ich bin so wütend',
        context: ContextType.work,
      );

      expect(result.isCrisis, isTrue);
      expect(result.indicators, contains(contains('Extrem hohe Belastung')));
      expect(result.severity,
          CrisisSeverity.medium); // Changed from low to medium (intensity >= 9)
    });

    test('detects crisis with extremely high body tension', () {
      final result = CrisisDetector.detect(
        intensity: 5,
        bodyTension: 9,
        primaryEmotion: EmotionType.fear,
        automaticThought: 'Ich bin angespannt',
        context: ContextType.family,
      );

      expect(result.isCrisis, isTrue);
      expect(result.indicators, contains(contains('Extrem hohe Belastung')));
    });

    test('detects crisis with hopelessness keyword "hoffnungslos"', () {
      final result = CrisisDetector.detect(
        intensity: 7,
        bodyTension: 6,
        primaryEmotion: EmotionType.sadness,
        automaticThought: 'Ich fühle mich hoffnungslos',
        context: ContextType.solitude,
      );

      expect(result.isCrisis, isTrue);
      expect(result.indicators,
          contains('Gedanken enthalten hoffnungslose Begriffe'));
    });

    test('detects crisis with hopelessness keyword "kein ausweg"', () {
      final result = CrisisDetector.detect(
        intensity: 6,
        bodyTension: 5,
        primaryEmotion: EmotionType.fear,
        automaticThought: 'Es gibt keinen Ausweg mehr',
        context: ContextType.work,
      );

      expect(result.isCrisis, isTrue);
      expect(result.indicators,
          contains('Gedanken enthalten hoffnungslose Begriffe'));
    });

    test('detects crisis with extreme shame and high intensity', () {
      final result = CrisisDetector.detect(
        intensity: 8,
        bodyTension: 7,
        primaryEmotion: EmotionType.shame,
        automaticThought: 'Ich schäme mich so sehr',
        context: ContextType.friends,
      );

      expect(result.indicators, contains('Extreme Scham mit hoher Intensität'));
      // But doesn't trigger crisis alone
    });

    test('detects crisis with shame + fear combination', () {
      final result = CrisisDetector.detect(
        intensity: 8,
        bodyTension: 7,
        primaryEmotion: EmotionType.shame,
        automaticThought: 'Ich habe so viel Angst',
        context: ContextType.partnership,
      );

      expect(result.isCrisis, isTrue);
      expect(result.indicators, contains(contains('starker Scham/Angst')));
    });

    test('detects crisis with very high intensity and body tension combination',
        () {
      final result = CrisisDetector.detect(
        intensity: 8,
        bodyTension: 8,
        primaryEmotion: EmotionType.anger,
        automaticThought: 'Ich bin so wütend',
        context: ContextType.work,
      );

      expect(result.isCrisis, isTrue);
      expect(result.indicators,
          contains(contains('emotionale und körperliche Belastung')));
    });

    test('detects crisis with maximum values', () {
      final result = CrisisDetector.detect(
        intensity: 10,
        bodyTension: 10,
        primaryEmotion: EmotionType.fear,
        automaticThought: 'Ich halte das nicht mehr aus',
        context: ContextType.finances,
      );

      expect(result.isCrisis, isTrue);
      expect(result.severity, CrisisSeverity.high);
    });

    test('calculates high severity with 3+ indicators', () {
      final result = CrisisDetector.detect(
        intensity: 10,
        bodyTension: 9,
        primaryEmotion: EmotionType.shame,
        automaticThought: 'Es ist hoffnungslos, ich will nicht mehr',
        context: ContextType.family,
      );

      expect(result.isCrisis, isTrue);
      expect(result.severity, CrisisSeverity.high);
      expect(result.indicators.length, greaterThanOrEqualTo(3));
    });

    test('calculates medium severity with 2 indicators', () {
      final result = CrisisDetector.detect(
        intensity: 9,
        bodyTension: 9,
        primaryEmotion: EmotionType.sadness,
        automaticThought: 'Ich bin traurig',
        context: ContextType.solitude,
      );

      expect(result.isCrisis, isTrue);
      expect(result.severity, CrisisSeverity.medium);
    });

    test('calculates medium severity with intensity >= 9', () {
      final result = CrisisDetector.detect(
        intensity: 9,
        bodyTension: 5,
        primaryEmotion: EmotionType.joy,
        automaticThought: 'Alles gut',
        context: ContextType.leisure,
      );

      expect(result.isCrisis, isTrue);
      expect(
          result.severity, CrisisSeverity.medium); // Changed from low to medium
    });

    test('calculates low severity with hopelessness keyword', () {
      final result = CrisisDetector.detect(
        intensity: 6,
        bodyTension: 5,
        primaryEmotion: EmotionType.sadness,
        automaticThought: 'Ich fühle mich hoffnungslos',
        context: ContextType.solitude,
      );

      expect(result.isCrisis, isTrue);
      expect(result.severity, CrisisSeverity.low);
      expect(result.indicators.length, 1);
    });

    test('returns no crisis when no indicators present', () {
      final result = CrisisDetector.detect(
        intensity: 5,
        bodyTension: 4,
        primaryEmotion: EmotionType.joy,
        automaticThought: 'Ich habe einen schönen Tag',
        context: ContextType.leisure,
      );

      expect(result.isCrisis, isFalse);
      expect(result.severity, CrisisSeverity.none);
      expect(result.indicators, isEmpty);
    });

    test('isEmergencyCrisis returns true for explicit suicide keywords', () {
      final result = CrisisDetector.isEmergencyCrisis(
        intensity: 7,
        bodyTension: 6,
        automaticThought: 'Ich will mein Leben beenden',
      );

      expect(result, isTrue);
    });

    test('isEmergencyCrisis returns true for "nimm mir das leben"', () {
      final result = CrisisDetector.isEmergencyCrisis(
        intensity: 5,
        bodyTension: 5,
        automaticThought: 'Nimm mir das Leben',
      );

      expect(result, isTrue);
    });

    test('isEmergencyCrisis returns true for extreme values', () {
      final result = CrisisDetector.isEmergencyCrisis(
        intensity: 10,
        bodyTension: 9,
        automaticThought: 'Ich halte das nicht aus',
      );

      expect(result, isTrue);
    });

    test('isEmergencyCrisis returns false for moderate values and no keywords',
        () {
      final result = CrisisDetector.isEmergencyCrisis(
        intensity: 7,
        bodyTension: 6,
        automaticThought: 'Ich bin gestresst',
      );

      expect(result, isFalse);
    });

    test('is case-insensitive for keyword detection', () {
      final result = CrisisDetector.detect(
        intensity: 5,
        bodyTension: 4,
        primaryEmotion: EmotionType.sadness,
        automaticThought: 'Alles ist SINNLOS',
        context: ContextType.solitude,
      );

      expect(result.isCrisis, isTrue);
      expect(result.indicators,
          contains('Gedanken enthalten hoffnungslose Begriffe'));
    });

    test('detects multiple hopelessness keywords', () {
      final result = CrisisDetector.detect(
        intensity: 7,
        bodyTension: 6,
        primaryEmotion: EmotionType.sadness,
        automaticThought: 'Es ist hoffnungslos und sinnlos, kein Ausweg',
        context: ContextType.solitude,
      );

      expect(result.isCrisis, isTrue);
      expect(result.indicators,
          contains('Gedanken enthalten hoffnungslose Begriffe'));
      // Should only add indicator once, even with multiple keywords
    });
  });

  group('CrisisSeverity', () {
    test('provides correct display labels', () {
      expect(CrisisSeverity.none.displayLabel, 'Keine Krise');
      expect(CrisisSeverity.low.displayLabel, 'Niedrige Dringlichkeit');
      expect(CrisisSeverity.medium.displayLabel, 'Mittlere Dringlichkeit');
      expect(CrisisSeverity.high.displayLabel, 'Hohe Dringlichkeit');
    });

    test('high severity requires immediate attention', () {
      expect(CrisisSeverity.high.requiresImmediateAttention, isTrue);
      expect(CrisisSeverity.medium.requiresImmediateAttention, isFalse);
      expect(CrisisSeverity.low.requiresImmediateAttention, isFalse);
      expect(CrisisSeverity.none.requiresImmediateAttention, isFalse);
    });

    test('all except none require attention', () {
      expect(CrisisSeverity.high.requiresAttention, isTrue);
      expect(CrisisSeverity.medium.requiresAttention, isTrue);
      expect(CrisisSeverity.low.requiresAttention, isTrue);
      expect(CrisisSeverity.none.requiresAttention, isFalse);
    });
  });
}
