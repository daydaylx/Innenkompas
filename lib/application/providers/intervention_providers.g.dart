// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intervention_providers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InterventionFlowDataImpl _$$InterventionFlowDataImplFromJson(
        Map<String, dynamic> json) =>
    _$InterventionFlowDataImpl(
      currentStepIndex: (json['currentStepIndex'] as num).toInt(),
      stepResponses: (json['stepResponses'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k,
                InterventionStepResponse.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
      isCompleted: json['isCompleted'] as bool,
      startedAt: json['startedAt'] == null
          ? null
          : DateTime.parse(json['startedAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      wasAborted: json['wasAborted'] as bool,
      intervention: json['intervention'] == null
          ? null
          : Intervention.fromJson(json['intervention'] as Map<String, dynamic>),
      entryId: (json['entryId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$InterventionFlowDataImplToJson(
        _$InterventionFlowDataImpl instance) =>
    <String, dynamic>{
      'currentStepIndex': instance.currentStepIndex,
      'stepResponses': instance.stepResponses,
      'isCompleted': instance.isCompleted,
      'startedAt': instance.startedAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'wasAborted': instance.wasAborted,
      'intervention': instance.intervention,
      'entryId': instance.entryId,
    };

_$PostEvaluationDataImpl _$$PostEvaluationDataImplFromJson(
        Map<String, dynamic> json) =>
    _$PostEvaluationDataImpl(
      postIntensity: (json['postIntensity'] as num?)?.toInt(),
      postBodyTension: (json['postBodyTension'] as num?)?.toInt(),
      postClarity: (json['postClarity'] as num?)?.toInt(),
      helpfulnessRating: (json['helpfulnessRating'] as num?)?.toInt(),
      userNote: json['userNote'] as String?,
    );

Map<String, dynamic> _$$PostEvaluationDataImplToJson(
        _$PostEvaluationDataImpl instance) =>
    <String, dynamic>{
      'postIntensity': instance.postIntensity,
      'postBodyTension': instance.postBodyTension,
      'postClarity': instance.postClarity,
      'helpfulnessRating': instance.helpfulnessRating,
      'userNote': instance.userNote,
    };

_$TrendDataImpl _$$TrendDataImplFromJson(Map<String, dynamic> json) =>
    _$TrendDataImpl(
      avgIntensity: (json['avgIntensity'] as num).toDouble(),
      avgTension: (json['avgTension'] as num).toDouble(),
      entryCount: (json['entryCount'] as num).toInt(),
      mostCommonEmotion:
          $enumDecodeNullable(_$EmotionTypeEnumMap, json['mostCommonEmotion']),
    );

Map<String, dynamic> _$$TrendDataImplToJson(_$TrendDataImpl instance) =>
    <String, dynamic>{
      'avgIntensity': instance.avgIntensity,
      'avgTension': instance.avgTension,
      'entryCount': instance.entryCount,
      'mostCommonEmotion': _$EmotionTypeEnumMap[instance.mostCommonEmotion],
    };

const _$EmotionTypeEnumMap = {
  EmotionType.anger: 'anger',
  EmotionType.annoyance: 'annoyance',
  EmotionType.fear: 'fear',
  EmotionType.powerlessness: 'powerlessness',
  EmotionType.overwhelm: 'overwhelm',
  EmotionType.disappointment: 'disappointment',
  EmotionType.hurt: 'hurt',
  EmotionType.sadness: 'sadness',
  EmotionType.shame: 'shame',
  EmotionType.joy: 'joy',
  EmotionType.disgust: 'disgust',
  EmotionType.surprise: 'surprise',
  EmotionType.guilt: 'guilt',
  EmotionType.helplessness: 'helplessness',
  EmotionType.emptiness: 'emptiness',
  EmotionType.pride: 'pride',
  EmotionType.loneliness: 'loneliness',
};

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$recommendedInterventionsHash() =>
    r'ebee65b3235fadd6873fab07503225d68cbded83';

/// Provider für Interventionen basierend auf Klassifikation
///
/// Copied from [recommendedInterventions].
@ProviderFor(recommendedInterventions)
final recommendedInterventionsProvider =
    AutoDisposeProvider<List<Intervention>>.internal(
  recommendedInterventions,
  name: r'recommendedInterventionsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$recommendedInterventionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RecommendedInterventionsRef
    = AutoDisposeProviderRef<List<Intervention>>;
String _$currentInterventionIdHash() =>
    r'16ef0a76133ccc1047828a61a82e9b03e21c6f6e';

/// Provider für die ID der aktuell laufenden Intervention
///
/// Copied from [currentInterventionId].
@ProviderFor(currentInterventionId)
final currentInterventionIdProvider = AutoDisposeProvider<String?>.internal(
  currentInterventionId,
  name: r'currentInterventionIdProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentInterventionIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentInterventionIdRef = AutoDisposeProviderRef<String?>;
String _$patternSummaryHash() => r'1e010346d30eadc8ba048ac3d4c6bac474e2f41b';

/// Provider für Pattern-Analyse
///
/// Copied from [patternSummary].
@ProviderFor(patternSummary)
final patternSummaryProvider =
    AutoDisposeFutureProvider<PatternSummary>.internal(
  patternSummary,
  name: r'patternSummaryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$patternSummaryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PatternSummaryRef = AutoDisposeFutureProviderRef<PatternSummary>;
String _$filteredHistoryEntriesHash() =>
    r'2a79107526a0b5b2ffedd4bb4ec577baf5d0f3ab';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Provider für gefilterte Einträge
///
/// Copied from [filteredHistoryEntries].
@ProviderFor(filteredHistoryEntries)
const filteredHistoryEntriesProvider = FilteredHistoryEntriesFamily();

/// Provider für gefilterte Einträge
///
/// Copied from [filteredHistoryEntries].
class FilteredHistoryEntriesFamily
    extends Family<AsyncValue<List<SituationEntryData>>> {
  /// Provider für gefilterte Einträge
  ///
  /// Copied from [filteredHistoryEntries].
  const FilteredHistoryEntriesFamily();

  /// Provider für gefilterte Einträge
  ///
  /// Copied from [filteredHistoryEntries].
  FilteredHistoryEntriesProvider call(
    HistoryFilter filter,
  ) {
    return FilteredHistoryEntriesProvider(
      filter,
    );
  }

  @override
  FilteredHistoryEntriesProvider getProviderOverride(
    covariant FilteredHistoryEntriesProvider provider,
  ) {
    return call(
      provider.filter,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'filteredHistoryEntriesProvider';
}

/// Provider für gefilterte Einträge
///
/// Copied from [filteredHistoryEntries].
class FilteredHistoryEntriesProvider
    extends AutoDisposeFutureProvider<List<SituationEntryData>> {
  /// Provider für gefilterte Einträge
  ///
  /// Copied from [filteredHistoryEntries].
  FilteredHistoryEntriesProvider(
    HistoryFilter filter,
  ) : this._internal(
          (ref) => filteredHistoryEntries(
            ref as FilteredHistoryEntriesRef,
            filter,
          ),
          from: filteredHistoryEntriesProvider,
          name: r'filteredHistoryEntriesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$filteredHistoryEntriesHash,
          dependencies: FilteredHistoryEntriesFamily._dependencies,
          allTransitiveDependencies:
              FilteredHistoryEntriesFamily._allTransitiveDependencies,
          filter: filter,
        );

  FilteredHistoryEntriesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.filter,
  }) : super.internal();

  final HistoryFilter filter;

  @override
  Override overrideWith(
    FutureOr<List<SituationEntryData>> Function(
            FilteredHistoryEntriesRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FilteredHistoryEntriesProvider._internal(
        (ref) => create(ref as FilteredHistoryEntriesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        filter: filter,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<SituationEntryData>> createElement() {
    return _FilteredHistoryEntriesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FilteredHistoryEntriesProvider && other.filter == filter;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, filter.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FilteredHistoryEntriesRef
    on AutoDisposeFutureProviderRef<List<SituationEntryData>> {
  /// The parameter `filter` of this provider.
  HistoryFilter get filter;
}

class _FilteredHistoryEntriesProviderElement
    extends AutoDisposeFutureProviderElement<List<SituationEntryData>>
    with FilteredHistoryEntriesRef {
  _FilteredHistoryEntriesProviderElement(super.provider);

  @override
  HistoryFilter get filter => (origin as FilteredHistoryEntriesProvider).filter;
}

String _$emotionStatisticsHash() => r'0c714c1ad1359096776218ec6d14f7aff98dc7cc';

/// Provider für Emotions-Statistiken
///
/// Copied from [emotionStatistics].
@ProviderFor(emotionStatistics)
final emotionStatisticsProvider =
    AutoDisposeFutureProvider<Map<EmotionType, Map<String, dynamic>>>.internal(
  emotionStatistics,
  name: r'emotionStatisticsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$emotionStatisticsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EmotionStatisticsRef
    = AutoDisposeFutureProviderRef<Map<EmotionType, Map<String, dynamic>>>;
String _$last7DaysTrendHash() => r'83ce5bca65af434235c9be454683d53385b3fc85';

/// Provider für Trend-Daten der letzten 7 Tage
///
/// Copied from [last7DaysTrend].
@ProviderFor(last7DaysTrend)
final last7DaysTrendProvider = AutoDisposeFutureProvider<TrendData>.internal(
  last7DaysTrend,
  name: r'last7DaysTrendProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$last7DaysTrendHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef Last7DaysTrendRef = AutoDisposeFutureProviderRef<TrendData>;
String _$interventionEffectivenessHash() =>
    r'62127663dc0c35af02179996ebb7c5363a6664ba';

/// Provider für gespeicherte Interventionsergebnisse
///
/// Copied from [interventionEffectiveness].
@ProviderFor(interventionEffectiveness)
final interventionEffectivenessProvider =
    AutoDisposeFutureProvider<List<InterventionEffectiveness>>.internal(
  interventionEffectiveness,
  name: r'interventionEffectivenessProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$interventionEffectivenessHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef InterventionEffectivenessRef
    = AutoDisposeFutureProviderRef<List<InterventionEffectiveness>>;
String _$interventionFlowStateHash() =>
    r'f23ec7dad1cbd8ca644d6454a18af9b1953eb0a3';

/// State für den Intervention-Flow
///
/// Copied from [InterventionFlowState].
@ProviderFor(InterventionFlowState)
final interventionFlowStateProvider = AutoDisposeNotifierProvider<
    InterventionFlowState, InterventionFlowData>.internal(
  InterventionFlowState.new,
  name: r'interventionFlowStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$interventionFlowStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$InterventionFlowState = AutoDisposeNotifier<InterventionFlowData>;
String _$postEvaluationStateHash() =>
    r'2c8ea86ad803bd2af3f9b8153e27fd9f6ebedb2b';

/// State für die Nachbewertung
///
/// Copied from [PostEvaluationState].
@ProviderFor(PostEvaluationState)
final postEvaluationStateProvider = AutoDisposeNotifierProvider<
    PostEvaluationState, PostEvaluationData>.internal(
  PostEvaluationState.new,
  name: r'postEvaluationStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$postEvaluationStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PostEvaluationState = AutoDisposeNotifier<PostEvaluationData>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
