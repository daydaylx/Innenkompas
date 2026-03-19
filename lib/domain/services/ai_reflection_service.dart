import '../../data/db/app_database.dart';
import '../models/ai_reflection.dart';

abstract class AiReflectionService {
  Future<AiReflectionStartResponse> startReflection({
    required SituationEntryData entry,
    required AiReflectionMode mode,
  });

  Future<AiReflectionCompleteResponse> completeReflection({
    required SituationEntryData entry,
    required AiReflectionMode mode,
    required String userReply,
  });
}

class AiReflectionException implements Exception {
  const AiReflectionException(
    this.message, {
    this.code = AiReflectionErrorCode.unknown,
  });

  final String message;
  final AiReflectionErrorCode code;

  @override
  String toString() => message;
}
