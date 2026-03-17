// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intervention_providers.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

InterventionFlowData _$InterventionFlowDataFromJson(Map<String, dynamic> json) {
  return _InterventionFlowData.fromJson(json);
}

/// @nodoc
mixin _$InterventionFlowData {
  /// Aktueller Schritt-Index
  int get currentStepIndex => throw _privateConstructorUsedError;

  /// Antworten aller Schritte (key: stepId)
  Map<String, InterventionStepResponse> get stepResponses =>
      throw _privateConstructorUsedError;

  /// Ist die Intervention abgeschlossen?
  bool get isCompleted => throw _privateConstructorUsedError;

  /// Startzeitpunkt
  DateTime? get startedAt => throw _privateConstructorUsedError;

  /// Endzeitpunkt
  DateTime? get completedAt => throw _privateConstructorUsedError;

  /// Wurde abgebrochen?
  bool get wasAborted => throw _privateConstructorUsedError;

  /// Die aktuelle Intervention
  Intervention? get intervention => throw _privateConstructorUsedError;

  /// Zugehörige Entry-ID (für Post-Evaluation)
  int? get entryId => throw _privateConstructorUsedError;

  /// Serializes this InterventionFlowData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InterventionFlowData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InterventionFlowDataCopyWith<InterventionFlowData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InterventionFlowDataCopyWith<$Res> {
  factory $InterventionFlowDataCopyWith(InterventionFlowData value,
          $Res Function(InterventionFlowData) then) =
      _$InterventionFlowDataCopyWithImpl<$Res, InterventionFlowData>;
  @useResult
  $Res call(
      {int currentStepIndex,
      Map<String, InterventionStepResponse> stepResponses,
      bool isCompleted,
      DateTime? startedAt,
      DateTime? completedAt,
      bool wasAborted,
      Intervention? intervention,
      int? entryId});

  $InterventionCopyWith<$Res>? get intervention;
}

/// @nodoc
class _$InterventionFlowDataCopyWithImpl<$Res,
        $Val extends InterventionFlowData>
    implements $InterventionFlowDataCopyWith<$Res> {
  _$InterventionFlowDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InterventionFlowData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentStepIndex = null,
    Object? stepResponses = null,
    Object? isCompleted = null,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
    Object? wasAborted = null,
    Object? intervention = freezed,
    Object? entryId = freezed,
  }) {
    return _then(_value.copyWith(
      currentStepIndex: null == currentStepIndex
          ? _value.currentStepIndex
          : currentStepIndex // ignore: cast_nullable_to_non_nullable
              as int,
      stepResponses: null == stepResponses
          ? _value.stepResponses
          : stepResponses // ignore: cast_nullable_to_non_nullable
              as Map<String, InterventionStepResponse>,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      wasAborted: null == wasAborted
          ? _value.wasAborted
          : wasAborted // ignore: cast_nullable_to_non_nullable
              as bool,
      intervention: freezed == intervention
          ? _value.intervention
          : intervention // ignore: cast_nullable_to_non_nullable
              as Intervention?,
      entryId: freezed == entryId
          ? _value.entryId
          : entryId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }

  /// Create a copy of InterventionFlowData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InterventionCopyWith<$Res>? get intervention {
    if (_value.intervention == null) {
      return null;
    }

    return $InterventionCopyWith<$Res>(_value.intervention!, (value) {
      return _then(_value.copyWith(intervention: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$InterventionFlowDataImplCopyWith<$Res>
    implements $InterventionFlowDataCopyWith<$Res> {
  factory _$$InterventionFlowDataImplCopyWith(_$InterventionFlowDataImpl value,
          $Res Function(_$InterventionFlowDataImpl) then) =
      __$$InterventionFlowDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int currentStepIndex,
      Map<String, InterventionStepResponse> stepResponses,
      bool isCompleted,
      DateTime? startedAt,
      DateTime? completedAt,
      bool wasAborted,
      Intervention? intervention,
      int? entryId});

  @override
  $InterventionCopyWith<$Res>? get intervention;
}

/// @nodoc
class __$$InterventionFlowDataImplCopyWithImpl<$Res>
    extends _$InterventionFlowDataCopyWithImpl<$Res, _$InterventionFlowDataImpl>
    implements _$$InterventionFlowDataImplCopyWith<$Res> {
  __$$InterventionFlowDataImplCopyWithImpl(_$InterventionFlowDataImpl _value,
      $Res Function(_$InterventionFlowDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of InterventionFlowData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentStepIndex = null,
    Object? stepResponses = null,
    Object? isCompleted = null,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
    Object? wasAborted = null,
    Object? intervention = freezed,
    Object? entryId = freezed,
  }) {
    return _then(_$InterventionFlowDataImpl(
      currentStepIndex: null == currentStepIndex
          ? _value.currentStepIndex
          : currentStepIndex // ignore: cast_nullable_to_non_nullable
              as int,
      stepResponses: null == stepResponses
          ? _value._stepResponses
          : stepResponses // ignore: cast_nullable_to_non_nullable
              as Map<String, InterventionStepResponse>,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      wasAborted: null == wasAborted
          ? _value.wasAborted
          : wasAborted // ignore: cast_nullable_to_non_nullable
              as bool,
      intervention: freezed == intervention
          ? _value.intervention
          : intervention // ignore: cast_nullable_to_non_nullable
              as Intervention?,
      entryId: freezed == entryId
          ? _value.entryId
          : entryId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InterventionFlowDataImpl implements _InterventionFlowData {
  const _$InterventionFlowDataImpl(
      {required this.currentStepIndex,
      final Map<String, InterventionStepResponse> stepResponses = const {},
      required this.isCompleted,
      this.startedAt,
      this.completedAt,
      required this.wasAborted,
      this.intervention,
      this.entryId})
      : _stepResponses = stepResponses;

  factory _$InterventionFlowDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$InterventionFlowDataImplFromJson(json);

  /// Aktueller Schritt-Index
  @override
  final int currentStepIndex;

  /// Antworten aller Schritte (key: stepId)
  final Map<String, InterventionStepResponse> _stepResponses;

  /// Antworten aller Schritte (key: stepId)
  @override
  @JsonKey()
  Map<String, InterventionStepResponse> get stepResponses {
    if (_stepResponses is EqualUnmodifiableMapView) return _stepResponses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_stepResponses);
  }

  /// Ist die Intervention abgeschlossen?
  @override
  final bool isCompleted;

  /// Startzeitpunkt
  @override
  final DateTime? startedAt;

  /// Endzeitpunkt
  @override
  final DateTime? completedAt;

  /// Wurde abgebrochen?
  @override
  final bool wasAborted;

  /// Die aktuelle Intervention
  @override
  final Intervention? intervention;

  /// Zugehörige Entry-ID (für Post-Evaluation)
  @override
  final int? entryId;

  @override
  String toString() {
    return 'InterventionFlowData(currentStepIndex: $currentStepIndex, stepResponses: $stepResponses, isCompleted: $isCompleted, startedAt: $startedAt, completedAt: $completedAt, wasAborted: $wasAborted, intervention: $intervention, entryId: $entryId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InterventionFlowDataImpl &&
            (identical(other.currentStepIndex, currentStepIndex) ||
                other.currentStepIndex == currentStepIndex) &&
            const DeepCollectionEquality()
                .equals(other._stepResponses, _stepResponses) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.wasAborted, wasAborted) ||
                other.wasAborted == wasAborted) &&
            (identical(other.intervention, intervention) ||
                other.intervention == intervention) &&
            (identical(other.entryId, entryId) || other.entryId == entryId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      currentStepIndex,
      const DeepCollectionEquality().hash(_stepResponses),
      isCompleted,
      startedAt,
      completedAt,
      wasAborted,
      intervention,
      entryId);

  /// Create a copy of InterventionFlowData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InterventionFlowDataImplCopyWith<_$InterventionFlowDataImpl>
      get copyWith =>
          __$$InterventionFlowDataImplCopyWithImpl<_$InterventionFlowDataImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InterventionFlowDataImplToJson(
      this,
    );
  }
}

abstract class _InterventionFlowData implements InterventionFlowData {
  const factory _InterventionFlowData(
      {required final int currentStepIndex,
      final Map<String, InterventionStepResponse> stepResponses,
      required final bool isCompleted,
      final DateTime? startedAt,
      final DateTime? completedAt,
      required final bool wasAborted,
      final Intervention? intervention,
      final int? entryId}) = _$InterventionFlowDataImpl;

  factory _InterventionFlowData.fromJson(Map<String, dynamic> json) =
      _$InterventionFlowDataImpl.fromJson;

  /// Aktueller Schritt-Index
  @override
  int get currentStepIndex;

  /// Antworten aller Schritte (key: stepId)
  @override
  Map<String, InterventionStepResponse> get stepResponses;

  /// Ist die Intervention abgeschlossen?
  @override
  bool get isCompleted;

  /// Startzeitpunkt
  @override
  DateTime? get startedAt;

  /// Endzeitpunkt
  @override
  DateTime? get completedAt;

  /// Wurde abgebrochen?
  @override
  bool get wasAborted;

  /// Die aktuelle Intervention
  @override
  Intervention? get intervention;

  /// Zugehörige Entry-ID (für Post-Evaluation)
  @override
  int? get entryId;

  /// Create a copy of InterventionFlowData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InterventionFlowDataImplCopyWith<_$InterventionFlowDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}

PostEvaluationData _$PostEvaluationDataFromJson(Map<String, dynamic> json) {
  return _PostEvaluationData.fromJson(json);
}

/// @nodoc
mixin _$PostEvaluationData {
  /// Belastung nach der Intervention (1-10)
  int? get postIntensity => throw _privateConstructorUsedError;

  /// Körperanspannung nach der Intervention (1-10)
  int? get postBodyTension => throw _privateConstructorUsedError;

  /// Klarheit nach der Intervention (1-10)
  int? get postClarity => throw _privateConstructorUsedError;

  /// Hilfreichkeits-Rating (1-10)
  int? get helpfulnessRating => throw _privateConstructorUsedError;

  /// Optionale Nutzer-Notiz
  String? get userNote => throw _privateConstructorUsedError;

  /// Serializes this PostEvaluationData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PostEvaluationData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostEvaluationDataCopyWith<PostEvaluationData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostEvaluationDataCopyWith<$Res> {
  factory $PostEvaluationDataCopyWith(
          PostEvaluationData value, $Res Function(PostEvaluationData) then) =
      _$PostEvaluationDataCopyWithImpl<$Res, PostEvaluationData>;
  @useResult
  $Res call(
      {int? postIntensity,
      int? postBodyTension,
      int? postClarity,
      int? helpfulnessRating,
      String? userNote});
}

/// @nodoc
class _$PostEvaluationDataCopyWithImpl<$Res, $Val extends PostEvaluationData>
    implements $PostEvaluationDataCopyWith<$Res> {
  _$PostEvaluationDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PostEvaluationData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postIntensity = freezed,
    Object? postBodyTension = freezed,
    Object? postClarity = freezed,
    Object? helpfulnessRating = freezed,
    Object? userNote = freezed,
  }) {
    return _then(_value.copyWith(
      postIntensity: freezed == postIntensity
          ? _value.postIntensity
          : postIntensity // ignore: cast_nullable_to_non_nullable
              as int?,
      postBodyTension: freezed == postBodyTension
          ? _value.postBodyTension
          : postBodyTension // ignore: cast_nullable_to_non_nullable
              as int?,
      postClarity: freezed == postClarity
          ? _value.postClarity
          : postClarity // ignore: cast_nullable_to_non_nullable
              as int?,
      helpfulnessRating: freezed == helpfulnessRating
          ? _value.helpfulnessRating
          : helpfulnessRating // ignore: cast_nullable_to_non_nullable
              as int?,
      userNote: freezed == userNote
          ? _value.userNote
          : userNote // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PostEvaluationDataImplCopyWith<$Res>
    implements $PostEvaluationDataCopyWith<$Res> {
  factory _$$PostEvaluationDataImplCopyWith(_$PostEvaluationDataImpl value,
          $Res Function(_$PostEvaluationDataImpl) then) =
      __$$PostEvaluationDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? postIntensity,
      int? postBodyTension,
      int? postClarity,
      int? helpfulnessRating,
      String? userNote});
}

/// @nodoc
class __$$PostEvaluationDataImplCopyWithImpl<$Res>
    extends _$PostEvaluationDataCopyWithImpl<$Res, _$PostEvaluationDataImpl>
    implements _$$PostEvaluationDataImplCopyWith<$Res> {
  __$$PostEvaluationDataImplCopyWithImpl(_$PostEvaluationDataImpl _value,
      $Res Function(_$PostEvaluationDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of PostEvaluationData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postIntensity = freezed,
    Object? postBodyTension = freezed,
    Object? postClarity = freezed,
    Object? helpfulnessRating = freezed,
    Object? userNote = freezed,
  }) {
    return _then(_$PostEvaluationDataImpl(
      postIntensity: freezed == postIntensity
          ? _value.postIntensity
          : postIntensity // ignore: cast_nullable_to_non_nullable
              as int?,
      postBodyTension: freezed == postBodyTension
          ? _value.postBodyTension
          : postBodyTension // ignore: cast_nullable_to_non_nullable
              as int?,
      postClarity: freezed == postClarity
          ? _value.postClarity
          : postClarity // ignore: cast_nullable_to_non_nullable
              as int?,
      helpfulnessRating: freezed == helpfulnessRating
          ? _value.helpfulnessRating
          : helpfulnessRating // ignore: cast_nullable_to_non_nullable
              as int?,
      userNote: freezed == userNote
          ? _value.userNote
          : userNote // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PostEvaluationDataImpl implements _PostEvaluationData {
  const _$PostEvaluationDataImpl(
      {this.postIntensity,
      this.postBodyTension,
      this.postClarity,
      this.helpfulnessRating,
      this.userNote});

  factory _$PostEvaluationDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostEvaluationDataImplFromJson(json);

  /// Belastung nach der Intervention (1-10)
  @override
  final int? postIntensity;

  /// Körperanspannung nach der Intervention (1-10)
  @override
  final int? postBodyTension;

  /// Klarheit nach der Intervention (1-10)
  @override
  final int? postClarity;

  /// Hilfreichkeits-Rating (1-10)
  @override
  final int? helpfulnessRating;

  /// Optionale Nutzer-Notiz
  @override
  final String? userNote;

  @override
  String toString() {
    return 'PostEvaluationData(postIntensity: $postIntensity, postBodyTension: $postBodyTension, postClarity: $postClarity, helpfulnessRating: $helpfulnessRating, userNote: $userNote)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostEvaluationDataImpl &&
            (identical(other.postIntensity, postIntensity) ||
                other.postIntensity == postIntensity) &&
            (identical(other.postBodyTension, postBodyTension) ||
                other.postBodyTension == postBodyTension) &&
            (identical(other.postClarity, postClarity) ||
                other.postClarity == postClarity) &&
            (identical(other.helpfulnessRating, helpfulnessRating) ||
                other.helpfulnessRating == helpfulnessRating) &&
            (identical(other.userNote, userNote) ||
                other.userNote == userNote));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, postIntensity, postBodyTension,
      postClarity, helpfulnessRating, userNote);

  /// Create a copy of PostEvaluationData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostEvaluationDataImplCopyWith<_$PostEvaluationDataImpl> get copyWith =>
      __$$PostEvaluationDataImplCopyWithImpl<_$PostEvaluationDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostEvaluationDataImplToJson(
      this,
    );
  }
}

abstract class _PostEvaluationData implements PostEvaluationData {
  const factory _PostEvaluationData(
      {final int? postIntensity,
      final int? postBodyTension,
      final int? postClarity,
      final int? helpfulnessRating,
      final String? userNote}) = _$PostEvaluationDataImpl;

  factory _PostEvaluationData.fromJson(Map<String, dynamic> json) =
      _$PostEvaluationDataImpl.fromJson;

  /// Belastung nach der Intervention (1-10)
  @override
  int? get postIntensity;

  /// Körperanspannung nach der Intervention (1-10)
  @override
  int? get postBodyTension;

  /// Klarheit nach der Intervention (1-10)
  @override
  int? get postClarity;

  /// Hilfreichkeits-Rating (1-10)
  @override
  int? get helpfulnessRating;

  /// Optionale Nutzer-Notiz
  @override
  String? get userNote;

  /// Create a copy of PostEvaluationData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostEvaluationDataImplCopyWith<_$PostEvaluationDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TrendData _$TrendDataFromJson(Map<String, dynamic> json) {
  return _TrendData.fromJson(json);
}

/// @nodoc
mixin _$TrendData {
  double get avgIntensity => throw _privateConstructorUsedError;
  double get avgTension => throw _privateConstructorUsedError;
  int get entryCount => throw _privateConstructorUsedError;
  EmotionType? get mostCommonEmotion => throw _privateConstructorUsedError;

  /// Serializes this TrendData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TrendData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TrendDataCopyWith<TrendData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrendDataCopyWith<$Res> {
  factory $TrendDataCopyWith(TrendData value, $Res Function(TrendData) then) =
      _$TrendDataCopyWithImpl<$Res, TrendData>;
  @useResult
  $Res call(
      {double avgIntensity,
      double avgTension,
      int entryCount,
      EmotionType? mostCommonEmotion});
}

/// @nodoc
class _$TrendDataCopyWithImpl<$Res, $Val extends TrendData>
    implements $TrendDataCopyWith<$Res> {
  _$TrendDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TrendData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? avgIntensity = null,
    Object? avgTension = null,
    Object? entryCount = null,
    Object? mostCommonEmotion = freezed,
  }) {
    return _then(_value.copyWith(
      avgIntensity: null == avgIntensity
          ? _value.avgIntensity
          : avgIntensity // ignore: cast_nullable_to_non_nullable
              as double,
      avgTension: null == avgTension
          ? _value.avgTension
          : avgTension // ignore: cast_nullable_to_non_nullable
              as double,
      entryCount: null == entryCount
          ? _value.entryCount
          : entryCount // ignore: cast_nullable_to_non_nullable
              as int,
      mostCommonEmotion: freezed == mostCommonEmotion
          ? _value.mostCommonEmotion
          : mostCommonEmotion // ignore: cast_nullable_to_non_nullable
              as EmotionType?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TrendDataImplCopyWith<$Res>
    implements $TrendDataCopyWith<$Res> {
  factory _$$TrendDataImplCopyWith(
          _$TrendDataImpl value, $Res Function(_$TrendDataImpl) then) =
      __$$TrendDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double avgIntensity,
      double avgTension,
      int entryCount,
      EmotionType? mostCommonEmotion});
}

/// @nodoc
class __$$TrendDataImplCopyWithImpl<$Res>
    extends _$TrendDataCopyWithImpl<$Res, _$TrendDataImpl>
    implements _$$TrendDataImplCopyWith<$Res> {
  __$$TrendDataImplCopyWithImpl(
      _$TrendDataImpl _value, $Res Function(_$TrendDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of TrendData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? avgIntensity = null,
    Object? avgTension = null,
    Object? entryCount = null,
    Object? mostCommonEmotion = freezed,
  }) {
    return _then(_$TrendDataImpl(
      avgIntensity: null == avgIntensity
          ? _value.avgIntensity
          : avgIntensity // ignore: cast_nullable_to_non_nullable
              as double,
      avgTension: null == avgTension
          ? _value.avgTension
          : avgTension // ignore: cast_nullable_to_non_nullable
              as double,
      entryCount: null == entryCount
          ? _value.entryCount
          : entryCount // ignore: cast_nullable_to_non_nullable
              as int,
      mostCommonEmotion: freezed == mostCommonEmotion
          ? _value.mostCommonEmotion
          : mostCommonEmotion // ignore: cast_nullable_to_non_nullable
              as EmotionType?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TrendDataImpl implements _TrendData {
  const _$TrendDataImpl(
      {required this.avgIntensity,
      required this.avgTension,
      required this.entryCount,
      required this.mostCommonEmotion});

  factory _$TrendDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrendDataImplFromJson(json);

  @override
  final double avgIntensity;
  @override
  final double avgTension;
  @override
  final int entryCount;
  @override
  final EmotionType? mostCommonEmotion;

  @override
  String toString() {
    return 'TrendData(avgIntensity: $avgIntensity, avgTension: $avgTension, entryCount: $entryCount, mostCommonEmotion: $mostCommonEmotion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrendDataImpl &&
            (identical(other.avgIntensity, avgIntensity) ||
                other.avgIntensity == avgIntensity) &&
            (identical(other.avgTension, avgTension) ||
                other.avgTension == avgTension) &&
            (identical(other.entryCount, entryCount) ||
                other.entryCount == entryCount) &&
            (identical(other.mostCommonEmotion, mostCommonEmotion) ||
                other.mostCommonEmotion == mostCommonEmotion));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, avgIntensity, avgTension, entryCount, mostCommonEmotion);

  /// Create a copy of TrendData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TrendDataImplCopyWith<_$TrendDataImpl> get copyWith =>
      __$$TrendDataImplCopyWithImpl<_$TrendDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TrendDataImplToJson(
      this,
    );
  }
}

abstract class _TrendData implements TrendData {
  const factory _TrendData(
      {required final double avgIntensity,
      required final double avgTension,
      required final int entryCount,
      required final EmotionType? mostCommonEmotion}) = _$TrendDataImpl;

  factory _TrendData.fromJson(Map<String, dynamic> json) =
      _$TrendDataImpl.fromJson;

  @override
  double get avgIntensity;
  @override
  double get avgTension;
  @override
  int get entryCount;
  @override
  EmotionType? get mostCommonEmotion;

  /// Create a copy of TrendData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TrendDataImplCopyWith<_$TrendDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
