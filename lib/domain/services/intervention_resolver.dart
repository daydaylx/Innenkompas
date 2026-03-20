import 'package:collection/collection.dart';
import 'package:innenkompass/core/constants/emotion_types.dart';
import 'package:innenkompass/core/constants/intervention_types.dart';
import 'package:innenkompass/core/constants/system_states.dart';
import 'package:innenkompass/domain/models/intervention.dart';
import 'package:innenkompass/domain/models/intervention_library.dart';
import 'package:innenkompass/domain/rules/intervention_selector.dart';

enum InterventionResolutionSource {
  directId,
  classification,
  legacyFallback,
}

class ResolvedInterventionRecommendation {
  const ResolvedInterventionRecommendation({
    required this.intervention,
    required this.source,
  });

  final Intervention intervention;
  final InterventionResolutionSource source;

  String get interventionId => intervention.id;
  InterventionType get interventionType => intervention.type;
}

class InterventionPresentation {
  const InterventionPresentation({
    required this.title,
    required this.isConcrete,
    this.interventionId,
    this.interventionType,
  });

  final String title;
  final bool isConcrete;
  final String? interventionId;
  final InterventionType? interventionType;
}

class InterventionResolver {
  InterventionResolver._();

  static List<ResolvedInterventionRecommendation> resolveRecommendations({
    required SystemState systemState,
    required EmotionType primaryEmotion,
    required int intensity,
  }) {
    final resolved = <ResolvedInterventionRecommendation>[];
    final seenIds = <String>{};
    final recommendedTypes = InterventionSelector.selectInterventions(
      systemState: systemState,
      primaryEmotion: primaryEmotion,
      intensity: intensity,
    );

    for (final type in recommendedTypes) {
      final recommendation = resolveForContext(
        systemState: systemState,
        primaryEmotion: primaryEmotion,
        intensity: intensity,
        preferredType: type,
        source: InterventionResolutionSource.classification,
      );
      if (recommendation == null) {
        continue;
      }
      if (seenIds.add(recommendation.interventionId)) {
        resolved.add(recommendation);
      }
    }

    return resolved;
  }

  static ResolvedInterventionRecommendation? resolveForStoredEntry({
    required String? storedInterventionId,
    required String? storedInterventionTypeRaw,
    required String systemStateRaw,
    required String primaryEmotionRaw,
    required int intensity,
  }) {
    final direct = resolveById(storedInterventionId);
    if (direct != null) {
      return direct;
    }

    final systemState = SystemState.values.firstWhereOrNull(
      (value) => value.name == systemStateRaw,
    );
    final primaryEmotion = EmotionType.values.firstWhereOrNull(
      (value) => value.name == primaryEmotionRaw,
    );
    if (systemState == null || primaryEmotion == null) {
      return null;
    }

    final preferredType = parseType(storedInterventionTypeRaw);
    if (preferredType != null) {
      return resolveForContext(
        systemState: systemState,
        primaryEmotion: primaryEmotion,
        intensity: intensity,
        preferredType: preferredType,
        source: InterventionResolutionSource.legacyFallback,
      );
    }

    return resolveRecommendations(
      systemState: systemState,
      primaryEmotion: primaryEmotion,
      intensity: intensity,
    ).firstOrNull;
  }

  static ResolvedInterventionRecommendation? resolveForContext({
    required SystemState systemState,
    required EmotionType primaryEmotion,
    required int intensity,
    InterventionType? preferredType,
    InterventionResolutionSource source =
        InterventionResolutionSource.classification,
  }) {
    final type =
        preferredType ?? InterventionSelector.getFallbackIntervention();
    final candidates = InterventionLibrary.getByType(type);
    if (candidates.isEmpty) {
      return null;
    }

    final ranked = candidates.toList()
      ..sort(
        (left, right) => _compareCandidates(
          left,
          right,
          systemState: systemState,
          primaryEmotion: primaryEmotion,
          intensity: intensity,
        ),
      );

    return ResolvedInterventionRecommendation(
      intervention: ranked.first,
      source: source,
    );
  }

  static ResolvedInterventionRecommendation? resolveById(
      String? interventionId) {
    final normalizedId = interventionId?.trim();
    if (normalizedId == null || normalizedId.isEmpty) {
      return null;
    }

    final intervention = InterventionLibrary.getById(normalizedId);
    if (intervention == null) {
      return null;
    }

    return ResolvedInterventionRecommendation(
      intervention: intervention,
      source: InterventionResolutionSource.directId,
    );
  }

  static InterventionPresentation? describeStoredReference({
    String? interventionId,
    String? interventionTypeRaw,
  }) {
    final direct = resolveById(interventionId);
    if (direct != null) {
      return InterventionPresentation(
        title: direct.intervention.title,
        isConcrete: true,
        interventionId: direct.interventionId,
        interventionType: direct.interventionType,
      );
    }

    final type = parseType(interventionTypeRaw);
    if (type != null) {
      return InterventionPresentation(
        title: type.label,
        isConcrete: false,
        interventionType: type,
      );
    }

    return null;
  }

  static String labelForStoredReference({
    String? interventionId,
    String? interventionTypeRaw,
  }) {
    final presentation = describeStoredReference(
      interventionId: interventionId,
      interventionTypeRaw: interventionTypeRaw,
    );
    return presentation?.title ??
        interventionTypeRaw?.trim() ??
        interventionId?.trim() ??
        'Unbekannte Intervention';
  }

  static InterventionType? typeForStoredReference({
    String? interventionId,
    String? interventionTypeRaw,
  }) {
    final direct = resolveById(interventionId);
    if (direct != null) {
      return direct.interventionType;
    }
    return parseType(interventionTypeRaw);
  }

  static InterventionType? parseType(String? rawValue) {
    final normalized = rawValue?.trim();
    if (normalized == null || normalized.isEmpty) {
      return null;
    }
    return InterventionType.values.firstWhereOrNull(
      (value) => value.name == normalized,
    );
  }

  static int _compareCandidates(
    Intervention left,
    Intervention right, {
    required SystemState systemState,
    required EmotionType primaryEmotion,
    required int intensity,
  }) {
    final scoreDifference = _score(
          right,
          systemState: systemState,
          primaryEmotion: primaryEmotion,
          intensity: intensity,
        ) -
        _score(
          left,
          systemState: systemState,
          primaryEmotion: primaryEmotion,
          intensity: intensity,
        );
    if (scoreDifference != 0) {
      return scoreDifference;
    }

    return _libraryOrderFor(left.id).compareTo(_libraryOrderFor(right.id));
  }

  static int _score(
    Intervention candidate, {
    required SystemState systemState,
    required EmotionType primaryEmotion,
    required int intensity,
  }) {
    var score = 0;

    if (candidate.recommendedForStates.contains(systemState)) {
      score += 100;
      if (systemState == SystemState.crisis) {
        score += 40;
      }
    }

    if (candidate.recommendedForEmotions.contains(primaryEmotion)) {
      score += 35;
    }

    if (_fitsIntensity(candidate, intensity)) {
      score += 30;
    } else {
      score -= 60;
    }

    final minIntensity = candidate.minIntensity;
    if (minIntensity != null && intensity >= minIntensity) {
      score += minIntensity;
    }

    final maxIntensity = candidate.maxIntensity;
    if (maxIntensity != null && intensity <= maxIntensity) {
      score += 8;
    }

    score += 10 - (candidate.difficultyLevel ?? 3);

    return score;
  }

  static bool _fitsIntensity(Intervention candidate, int intensity) {
    if (candidate.minIntensity != null && intensity < candidate.minIntensity!) {
      return false;
    }
    if (candidate.maxIntensity != null && intensity > candidate.maxIntensity!) {
      return false;
    }
    return true;
  }

  static int _libraryOrderFor(String interventionId) {
    final index = InterventionLibrary.allInterventions.indexWhere(
      (value) => value.id == interventionId,
    );
    return index == -1 ? InterventionLibrary.allInterventions.length : index;
  }
}
