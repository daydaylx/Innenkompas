import '../../data/db/app_database.dart';
import '../models/ai_evaluation.dart';

abstract class AiEvaluationService {
  Future<AiEvaluationResponse> evaluateEntry({
    required SituationEntryData entry,
  });
}

class AiEvaluationException implements Exception {
  const AiEvaluationException(this.message);

  final String message;

  @override
  String toString() => message;
}
