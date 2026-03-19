import 'package:flutter_test/flutter_test.dart';
import 'package:innenkompass/data/db/app_database.dart';
import 'package:innenkompass/domain/services/pattern_analyzer.dart';

void main() {
  test('uses timestamp instead of createdAt for pattern date boundaries', () async {
    final entries = [
      SituationEntryData(
        id: 1,
        situationDescription: 'Frueheres Ereignis, spaeter gespeichert',
        context: 'work',
        timestamp: DateTime(2026, 3, 1, 8, 0),
        involvedPerson: null,
        intensity: 7,
        bodyTension: 6,
        primaryEmotion: 'fear',
        secondaryEmotion: null,
        bodySymptoms: null,
        automaticThought: 'Das wird schiefgehen.',
        firstImpulse: 'withdraw',
        factInterpretationResult: null,
        actualBehavior: null,
        needOrWoundedPoint: null,
        nextStep: null,
        systemState: 'reflectiveReady',
        isCrisis: false,
        evaluationHeadlineKey: null,
        evaluationMeaningKey: null,
        suggestedTipIds: null,
        suggestedNextActionKey: null,
        selectedNextActionKey: null,
        interventionType: null,
        interventionId: null,
        interventionCompleted: false,
        interventionDurationSec: null,
        postIntensity: null,
        postBodyTension: null,
        postClarity: null,
        helpfulnessRating: null,
        postNote: null,
        createdAt: DateTime(2026, 3, 10, 12, 0),
        updatedAt: DateTime(2026, 3, 10, 12, 0),
        isDraft: false,
      ),
      SituationEntryData(
        id: 2,
        situationDescription: 'Spaeteres Ereignis, frueher gespeichert',
        context: 'family',
        timestamp: DateTime(2026, 3, 5, 18, 30),
        involvedPerson: null,
        intensity: 5,
        bodyTension: 4,
        primaryEmotion: 'sadness',
        secondaryEmotion: null,
        bodySymptoms: null,
        automaticThought: 'Ich brauche Ruhe.',
        firstImpulse: 'withdraw',
        factInterpretationResult: null,
        actualBehavior: null,
        needOrWoundedPoint: null,
        nextStep: null,
        systemState: 'rumination',
        isCrisis: false,
        evaluationHeadlineKey: null,
        evaluationMeaningKey: null,
        suggestedTipIds: null,
        suggestedNextActionKey: null,
        selectedNextActionKey: null,
        interventionType: null,
        interventionId: null,
        interventionCompleted: false,
        interventionDurationSec: null,
        postIntensity: null,
        postBodyTension: null,
        postClarity: null,
        helpfulnessRating: null,
        postNote: null,
        createdAt: DateTime(2026, 3, 2, 9, 0),
        updatedAt: DateTime(2026, 3, 2, 9, 0),
        isDraft: false,
      ),
    ];

    final summary = await PatternAnalyzer.analyzePatterns(entries);

    expect(summary.startDate, DateTime(2026, 3, 1, 8, 0));
    expect(summary.endDate, DateTime(2026, 3, 5, 18, 30));
    expect(summary.intensityTrend.first.date, DateTime(2026, 3, 1));
    expect(summary.intensityTrend.last.date, DateTime(2026, 3, 5));
  });
}
