// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intervention.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Intervention _$InterventionFromJson(Map<String, dynamic> json) {
  return _Intervention.fromJson(json);
}

/// @nodoc
mixin _$Intervention {
  /// Eindeutige ID der Intervention
  String get id => throw _privateConstructorUsedError;

  /// Typ der Intervention
  InterventionType get type => throw _privateConstructorUsedError;

  /// Titel der Intervention
  String get title => throw _privateConstructorUsedError;

  /// Zusammenfassung der Intervention
  String get summary => throw _privateConstructorUsedError;

  /// Detaillierte Beschreibung
  String get description => throw _privateConstructorUsedError;

  /// Liste aller Schritte
  List<InterventionStep> get steps => throw _privateConstructorUsedError;

  /// Geschätzte Dauer in Sekunden
  int get estimatedDurationSec => throw _privateConstructorUsedError;

  /// Für welche Systemzustände empfohlen
  List<SystemState> get recommendedForStates =>
      throw _privateConstructorUsedError;

  /// Für welche Emotionen empfohlen
  List<EmotionType> get recommendedForEmotions =>
      throw _privateConstructorUsedError;

  /// Mindest-Intensität für Empfehlung
  int? get minIntensity => throw _privateConstructorUsedError;

  /// Maximal-Intensität für Empfehlung
  int? get maxIntensity => throw _privateConstructorUsedError;

  /// Optional: Icon/Emoji für Darstellung
  String? get icon => throw _privateConstructorUsedError;

  /// Optional: Kategorie für Gruppierung
  String? get category => throw _privateConstructorUsedError;

  /// Optional: Schwierigkeitsgrad (1-5)
  int? get difficultyLevel => throw _privateConstructorUsedError;

  /// Serializes this Intervention to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Intervention
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InterventionCopyWith<Intervention> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InterventionCopyWith<$Res> {
  factory $InterventionCopyWith(
          Intervention value, $Res Function(Intervention) then) =
      _$InterventionCopyWithImpl<$Res, Intervention>;
  @useResult
  $Res call(
      {String id,
      InterventionType type,
      String title,
      String summary,
      String description,
      List<InterventionStep> steps,
      int estimatedDurationSec,
      List<SystemState> recommendedForStates,
      List<EmotionType> recommendedForEmotions,
      int? minIntensity,
      int? maxIntensity,
      String? icon,
      String? category,
      int? difficultyLevel});
}

/// @nodoc
class _$InterventionCopyWithImpl<$Res, $Val extends Intervention>
    implements $InterventionCopyWith<$Res> {
  _$InterventionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Intervention
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? title = null,
    Object? summary = null,
    Object? description = null,
    Object? steps = null,
    Object? estimatedDurationSec = null,
    Object? recommendedForStates = null,
    Object? recommendedForEmotions = null,
    Object? minIntensity = freezed,
    Object? maxIntensity = freezed,
    Object? icon = freezed,
    Object? category = freezed,
    Object? difficultyLevel = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as InterventionType,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      steps: null == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<InterventionStep>,
      estimatedDurationSec: null == estimatedDurationSec
          ? _value.estimatedDurationSec
          : estimatedDurationSec // ignore: cast_nullable_to_non_nullable
              as int,
      recommendedForStates: null == recommendedForStates
          ? _value.recommendedForStates
          : recommendedForStates // ignore: cast_nullable_to_non_nullable
              as List<SystemState>,
      recommendedForEmotions: null == recommendedForEmotions
          ? _value.recommendedForEmotions
          : recommendedForEmotions // ignore: cast_nullable_to_non_nullable
              as List<EmotionType>,
      minIntensity: freezed == minIntensity
          ? _value.minIntensity
          : minIntensity // ignore: cast_nullable_to_non_nullable
              as int?,
      maxIntensity: freezed == maxIntensity
          ? _value.maxIntensity
          : maxIntensity // ignore: cast_nullable_to_non_nullable
              as int?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      difficultyLevel: freezed == difficultyLevel
          ? _value.difficultyLevel
          : difficultyLevel // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InterventionImplCopyWith<$Res>
    implements $InterventionCopyWith<$Res> {
  factory _$$InterventionImplCopyWith(
          _$InterventionImpl value, $Res Function(_$InterventionImpl) then) =
      __$$InterventionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      InterventionType type,
      String title,
      String summary,
      String description,
      List<InterventionStep> steps,
      int estimatedDurationSec,
      List<SystemState> recommendedForStates,
      List<EmotionType> recommendedForEmotions,
      int? minIntensity,
      int? maxIntensity,
      String? icon,
      String? category,
      int? difficultyLevel});
}

/// @nodoc
class __$$InterventionImplCopyWithImpl<$Res>
    extends _$InterventionCopyWithImpl<$Res, _$InterventionImpl>
    implements _$$InterventionImplCopyWith<$Res> {
  __$$InterventionImplCopyWithImpl(
      _$InterventionImpl _value, $Res Function(_$InterventionImpl) _then)
      : super(_value, _then);

  /// Create a copy of Intervention
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? title = null,
    Object? summary = null,
    Object? description = null,
    Object? steps = null,
    Object? estimatedDurationSec = null,
    Object? recommendedForStates = null,
    Object? recommendedForEmotions = null,
    Object? minIntensity = freezed,
    Object? maxIntensity = freezed,
    Object? icon = freezed,
    Object? category = freezed,
    Object? difficultyLevel = freezed,
  }) {
    return _then(_$InterventionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as InterventionType,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      steps: null == steps
          ? _value._steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<InterventionStep>,
      estimatedDurationSec: null == estimatedDurationSec
          ? _value.estimatedDurationSec
          : estimatedDurationSec // ignore: cast_nullable_to_non_nullable
              as int,
      recommendedForStates: null == recommendedForStates
          ? _value._recommendedForStates
          : recommendedForStates // ignore: cast_nullable_to_non_nullable
              as List<SystemState>,
      recommendedForEmotions: null == recommendedForEmotions
          ? _value._recommendedForEmotions
          : recommendedForEmotions // ignore: cast_nullable_to_non_nullable
              as List<EmotionType>,
      minIntensity: freezed == minIntensity
          ? _value.minIntensity
          : minIntensity // ignore: cast_nullable_to_non_nullable
              as int?,
      maxIntensity: freezed == maxIntensity
          ? _value.maxIntensity
          : maxIntensity // ignore: cast_nullable_to_non_nullable
              as int?,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      difficultyLevel: freezed == difficultyLevel
          ? _value.difficultyLevel
          : difficultyLevel // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InterventionImpl implements _Intervention {
  const _$InterventionImpl(
      {required this.id,
      required this.type,
      required this.title,
      required this.summary,
      required this.description,
      required final List<InterventionStep> steps,
      required this.estimatedDurationSec,
      required final List<SystemState> recommendedForStates,
      required final List<EmotionType> recommendedForEmotions,
      this.minIntensity,
      this.maxIntensity,
      this.icon,
      this.category,
      this.difficultyLevel})
      : _steps = steps,
        _recommendedForStates = recommendedForStates,
        _recommendedForEmotions = recommendedForEmotions;

  factory _$InterventionImpl.fromJson(Map<String, dynamic> json) =>
      _$$InterventionImplFromJson(json);

  /// Eindeutige ID der Intervention
  @override
  final String id;

  /// Typ der Intervention
  @override
  final InterventionType type;

  /// Titel der Intervention
  @override
  final String title;

  /// Zusammenfassung der Intervention
  @override
  final String summary;

  /// Detaillierte Beschreibung
  @override
  final String description;

  /// Liste aller Schritte
  final List<InterventionStep> _steps;

  /// Liste aller Schritte
  @override
  List<InterventionStep> get steps {
    if (_steps is EqualUnmodifiableListView) return _steps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_steps);
  }

  /// Geschätzte Dauer in Sekunden
  @override
  final int estimatedDurationSec;

  /// Für welche Systemzustände empfohlen
  final List<SystemState> _recommendedForStates;

  /// Für welche Systemzustände empfohlen
  @override
  List<SystemState> get recommendedForStates {
    if (_recommendedForStates is EqualUnmodifiableListView)
      return _recommendedForStates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendedForStates);
  }

  /// Für welche Emotionen empfohlen
  final List<EmotionType> _recommendedForEmotions;

  /// Für welche Emotionen empfohlen
  @override
  List<EmotionType> get recommendedForEmotions {
    if (_recommendedForEmotions is EqualUnmodifiableListView)
      return _recommendedForEmotions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendedForEmotions);
  }

  /// Mindest-Intensität für Empfehlung
  @override
  final int? minIntensity;

  /// Maximal-Intensität für Empfehlung
  @override
  final int? maxIntensity;

  /// Optional: Icon/Emoji für Darstellung
  @override
  final String? icon;

  /// Optional: Kategorie für Gruppierung
  @override
  final String? category;

  /// Optional: Schwierigkeitsgrad (1-5)
  @override
  final int? difficultyLevel;

  @override
  String toString() {
    return 'Intervention(id: $id, type: $type, title: $title, summary: $summary, description: $description, steps: $steps, estimatedDurationSec: $estimatedDurationSec, recommendedForStates: $recommendedForStates, recommendedForEmotions: $recommendedForEmotions, minIntensity: $minIntensity, maxIntensity: $maxIntensity, icon: $icon, category: $category, difficultyLevel: $difficultyLevel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InterventionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._steps, _steps) &&
            (identical(other.estimatedDurationSec, estimatedDurationSec) ||
                other.estimatedDurationSec == estimatedDurationSec) &&
            const DeepCollectionEquality()
                .equals(other._recommendedForStates, _recommendedForStates) &&
            const DeepCollectionEquality().equals(
                other._recommendedForEmotions, _recommendedForEmotions) &&
            (identical(other.minIntensity, minIntensity) ||
                other.minIntensity == minIntensity) &&
            (identical(other.maxIntensity, maxIntensity) ||
                other.maxIntensity == maxIntensity) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.difficultyLevel, difficultyLevel) ||
                other.difficultyLevel == difficultyLevel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      type,
      title,
      summary,
      description,
      const DeepCollectionEquality().hash(_steps),
      estimatedDurationSec,
      const DeepCollectionEquality().hash(_recommendedForStates),
      const DeepCollectionEquality().hash(_recommendedForEmotions),
      minIntensity,
      maxIntensity,
      icon,
      category,
      difficultyLevel);

  /// Create a copy of Intervention
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InterventionImplCopyWith<_$InterventionImpl> get copyWith =>
      __$$InterventionImplCopyWithImpl<_$InterventionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InterventionImplToJson(
      this,
    );
  }
}

abstract class _Intervention implements Intervention {
  const factory _Intervention(
      {required final String id,
      required final InterventionType type,
      required final String title,
      required final String summary,
      required final String description,
      required final List<InterventionStep> steps,
      required final int estimatedDurationSec,
      required final List<SystemState> recommendedForStates,
      required final List<EmotionType> recommendedForEmotions,
      final int? minIntensity,
      final int? maxIntensity,
      final String? icon,
      final String? category,
      final int? difficultyLevel}) = _$InterventionImpl;

  factory _Intervention.fromJson(Map<String, dynamic> json) =
      _$InterventionImpl.fromJson;

  /// Eindeutige ID der Intervention
  @override
  String get id;

  /// Typ der Intervention
  @override
  InterventionType get type;

  /// Titel der Intervention
  @override
  String get title;

  /// Zusammenfassung der Intervention
  @override
  String get summary;

  /// Detaillierte Beschreibung
  @override
  String get description;

  /// Liste aller Schritte
  @override
  List<InterventionStep> get steps;

  /// Geschätzte Dauer in Sekunden
  @override
  int get estimatedDurationSec;

  /// Für welche Systemzustände empfohlen
  @override
  List<SystemState> get recommendedForStates;

  /// Für welche Emotionen empfohlen
  @override
  List<EmotionType> get recommendedForEmotions;

  /// Mindest-Intensität für Empfehlung
  @override
  int? get minIntensity;

  /// Maximal-Intensität für Empfehlung
  @override
  int? get maxIntensity;

  /// Optional: Icon/Emoji für Darstellung
  @override
  String? get icon;

  /// Optional: Kategorie für Gruppierung
  @override
  String? get category;

  /// Optional: Schwierigkeitsgrad (1-5)
  @override
  int? get difficultyLevel;

  /// Create a copy of Intervention
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InterventionImplCopyWith<_$InterventionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InterventionResult _$InterventionResultFromJson(Map<String, dynamic> json) {
  return _InterventionResult.fromJson(json);
}

/// @nodoc
mixin _$InterventionResult {
  /// ID der durchgeführten Intervention
  String get interventionId => throw _privateConstructorUsedError;

  /// Titel der Intervention
  String get title => throw _privateConstructorUsedError;

  /// Typ der Intervention
  InterventionType get type => throw _privateConstructorUsedError;

  /// Startzeitpunkt
  DateTime get startedAt => throw _privateConstructorUsedError;

  /// Endzeitpunkt
  DateTime get completedAt => throw _privateConstructorUsedError;

  /// Tatsächliche Dauer in Sekunden
  int get actualDurationSec => throw _privateConstructorUsedError;

  /// Antworten auf alle Schritte
  List<InterventionStepResponse> get stepResponses =>
      throw _privateConstructorUsedError;

  /// Wurde die Intervention abgebrochen?
  bool get wasCompleted => throw _privateConstructorUsedError;

  /// Abbruch-Grund (falls abgebrochen)
  String? get abortReason => throw _privateConstructorUsedError;

  /// Optional: Nutzer-Notiz nach Intervention
  String? get userNote => throw _privateConstructorUsedError;

  /// Serializes this InterventionResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InterventionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InterventionResultCopyWith<InterventionResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InterventionResultCopyWith<$Res> {
  factory $InterventionResultCopyWith(
          InterventionResult value, $Res Function(InterventionResult) then) =
      _$InterventionResultCopyWithImpl<$Res, InterventionResult>;
  @useResult
  $Res call(
      {String interventionId,
      String title,
      InterventionType type,
      DateTime startedAt,
      DateTime completedAt,
      int actualDurationSec,
      List<InterventionStepResponse> stepResponses,
      bool wasCompleted,
      String? abortReason,
      String? userNote});
}

/// @nodoc
class _$InterventionResultCopyWithImpl<$Res, $Val extends InterventionResult>
    implements $InterventionResultCopyWith<$Res> {
  _$InterventionResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InterventionResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? interventionId = null,
    Object? title = null,
    Object? type = null,
    Object? startedAt = null,
    Object? completedAt = null,
    Object? actualDurationSec = null,
    Object? stepResponses = null,
    Object? wasCompleted = null,
    Object? abortReason = freezed,
    Object? userNote = freezed,
  }) {
    return _then(_value.copyWith(
      interventionId: null == interventionId
          ? _value.interventionId
          : interventionId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as InterventionType,
      startedAt: null == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      completedAt: null == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      actualDurationSec: null == actualDurationSec
          ? _value.actualDurationSec
          : actualDurationSec // ignore: cast_nullable_to_non_nullable
              as int,
      stepResponses: null == stepResponses
          ? _value.stepResponses
          : stepResponses // ignore: cast_nullable_to_non_nullable
              as List<InterventionStepResponse>,
      wasCompleted: null == wasCompleted
          ? _value.wasCompleted
          : wasCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      abortReason: freezed == abortReason
          ? _value.abortReason
          : abortReason // ignore: cast_nullable_to_non_nullable
              as String?,
      userNote: freezed == userNote
          ? _value.userNote
          : userNote // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InterventionResultImplCopyWith<$Res>
    implements $InterventionResultCopyWith<$Res> {
  factory _$$InterventionResultImplCopyWith(_$InterventionResultImpl value,
          $Res Function(_$InterventionResultImpl) then) =
      __$$InterventionResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String interventionId,
      String title,
      InterventionType type,
      DateTime startedAt,
      DateTime completedAt,
      int actualDurationSec,
      List<InterventionStepResponse> stepResponses,
      bool wasCompleted,
      String? abortReason,
      String? userNote});
}

/// @nodoc
class __$$InterventionResultImplCopyWithImpl<$Res>
    extends _$InterventionResultCopyWithImpl<$Res, _$InterventionResultImpl>
    implements _$$InterventionResultImplCopyWith<$Res> {
  __$$InterventionResultImplCopyWithImpl(_$InterventionResultImpl _value,
      $Res Function(_$InterventionResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of InterventionResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? interventionId = null,
    Object? title = null,
    Object? type = null,
    Object? startedAt = null,
    Object? completedAt = null,
    Object? actualDurationSec = null,
    Object? stepResponses = null,
    Object? wasCompleted = null,
    Object? abortReason = freezed,
    Object? userNote = freezed,
  }) {
    return _then(_$InterventionResultImpl(
      interventionId: null == interventionId
          ? _value.interventionId
          : interventionId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as InterventionType,
      startedAt: null == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      completedAt: null == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      actualDurationSec: null == actualDurationSec
          ? _value.actualDurationSec
          : actualDurationSec // ignore: cast_nullable_to_non_nullable
              as int,
      stepResponses: null == stepResponses
          ? _value._stepResponses
          : stepResponses // ignore: cast_nullable_to_non_nullable
              as List<InterventionStepResponse>,
      wasCompleted: null == wasCompleted
          ? _value.wasCompleted
          : wasCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      abortReason: freezed == abortReason
          ? _value.abortReason
          : abortReason // ignore: cast_nullable_to_non_nullable
              as String?,
      userNote: freezed == userNote
          ? _value.userNote
          : userNote // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InterventionResultImpl implements _InterventionResult {
  const _$InterventionResultImpl(
      {required this.interventionId,
      required this.title,
      required this.type,
      required this.startedAt,
      required this.completedAt,
      required this.actualDurationSec,
      required final List<InterventionStepResponse> stepResponses,
      required this.wasCompleted,
      this.abortReason,
      this.userNote})
      : _stepResponses = stepResponses;

  factory _$InterventionResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$InterventionResultImplFromJson(json);

  /// ID der durchgeführten Intervention
  @override
  final String interventionId;

  /// Titel der Intervention
  @override
  final String title;

  /// Typ der Intervention
  @override
  final InterventionType type;

  /// Startzeitpunkt
  @override
  final DateTime startedAt;

  /// Endzeitpunkt
  @override
  final DateTime completedAt;

  /// Tatsächliche Dauer in Sekunden
  @override
  final int actualDurationSec;

  /// Antworten auf alle Schritte
  final List<InterventionStepResponse> _stepResponses;

  /// Antworten auf alle Schritte
  @override
  List<InterventionStepResponse> get stepResponses {
    if (_stepResponses is EqualUnmodifiableListView) return _stepResponses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stepResponses);
  }

  /// Wurde die Intervention abgebrochen?
  @override
  final bool wasCompleted;

  /// Abbruch-Grund (falls abgebrochen)
  @override
  final String? abortReason;

  /// Optional: Nutzer-Notiz nach Intervention
  @override
  final String? userNote;

  @override
  String toString() {
    return 'InterventionResult(interventionId: $interventionId, title: $title, type: $type, startedAt: $startedAt, completedAt: $completedAt, actualDurationSec: $actualDurationSec, stepResponses: $stepResponses, wasCompleted: $wasCompleted, abortReason: $abortReason, userNote: $userNote)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InterventionResultImpl &&
            (identical(other.interventionId, interventionId) ||
                other.interventionId == interventionId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.actualDurationSec, actualDurationSec) ||
                other.actualDurationSec == actualDurationSec) &&
            const DeepCollectionEquality()
                .equals(other._stepResponses, _stepResponses) &&
            (identical(other.wasCompleted, wasCompleted) ||
                other.wasCompleted == wasCompleted) &&
            (identical(other.abortReason, abortReason) ||
                other.abortReason == abortReason) &&
            (identical(other.userNote, userNote) ||
                other.userNote == userNote));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      interventionId,
      title,
      type,
      startedAt,
      completedAt,
      actualDurationSec,
      const DeepCollectionEquality().hash(_stepResponses),
      wasCompleted,
      abortReason,
      userNote);

  /// Create a copy of InterventionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InterventionResultImplCopyWith<_$InterventionResultImpl> get copyWith =>
      __$$InterventionResultImplCopyWithImpl<_$InterventionResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InterventionResultImplToJson(
      this,
    );
  }
}

abstract class _InterventionResult implements InterventionResult {
  const factory _InterventionResult(
      {required final String interventionId,
      required final String title,
      required final InterventionType type,
      required final DateTime startedAt,
      required final DateTime completedAt,
      required final int actualDurationSec,
      required final List<InterventionStepResponse> stepResponses,
      required final bool wasCompleted,
      final String? abortReason,
      final String? userNote}) = _$InterventionResultImpl;

  factory _InterventionResult.fromJson(Map<String, dynamic> json) =
      _$InterventionResultImpl.fromJson;

  /// ID der durchgeführten Intervention
  @override
  String get interventionId;

  /// Titel der Intervention
  @override
  String get title;

  /// Typ der Intervention
  @override
  InterventionType get type;

  /// Startzeitpunkt
  @override
  DateTime get startedAt;

  /// Endzeitpunkt
  @override
  DateTime get completedAt;

  /// Tatsächliche Dauer in Sekunden
  @override
  int get actualDurationSec;

  /// Antworten auf alle Schritte
  @override
  List<InterventionStepResponse> get stepResponses;

  /// Wurde die Intervention abgebrochen?
  @override
  bool get wasCompleted;

  /// Abbruch-Grund (falls abgebrochen)
  @override
  String? get abortReason;

  /// Optional: Nutzer-Notiz nach Intervention
  @override
  String? get userNote;

  /// Create a copy of InterventionResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InterventionResultImplCopyWith<_$InterventionResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InterventionEffectiveness _$InterventionEffectivenessFromJson(
    Map<String, dynamic> json) {
  return _InterventionEffectiveness.fromJson(json);
}

/// @nodoc
mixin _$InterventionEffectiveness {
  /// ID der Intervention
  String get interventionId => throw _privateConstructorUsedError;

  /// Titel der Intervention
  String get title => throw _privateConstructorUsedError;

  /// Typ der Intervention
  InterventionType get type => throw _privateConstructorUsedError;

  /// Anzahl der Durchführungen
  int get usageCount => throw _privateConstructorUsedError;

  /// Durchschnittliche Verbesserung der Belastung (vorher-nachher)
  double get avgImprovement => throw _privateConstructorUsedError;

  /// Durchschnittliche Verbesserung der Körperanspannung
  double get avgTensionImprovement => throw _privateConstructorUsedError;

  /// Durchschnittliche Klarheit nach Intervention
  double get avgClarityGain => throw _privateConstructorUsedError;

  /// Hilfreichkeits-Rating (1-10)
  double get avgHelpfulnessRating => throw _privateConstructorUsedError;

  /// Letzte Verwendung
  DateTime get lastUsedAt => throw _privateConstructorUsedError;

  /// Serializes this InterventionEffectiveness to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InterventionEffectiveness
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InterventionEffectivenessCopyWith<InterventionEffectiveness> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InterventionEffectivenessCopyWith<$Res> {
  factory $InterventionEffectivenessCopyWith(InterventionEffectiveness value,
          $Res Function(InterventionEffectiveness) then) =
      _$InterventionEffectivenessCopyWithImpl<$Res, InterventionEffectiveness>;
  @useResult
  $Res call(
      {String interventionId,
      String title,
      InterventionType type,
      int usageCount,
      double avgImprovement,
      double avgTensionImprovement,
      double avgClarityGain,
      double avgHelpfulnessRating,
      DateTime lastUsedAt});
}

/// @nodoc
class _$InterventionEffectivenessCopyWithImpl<$Res,
        $Val extends InterventionEffectiveness>
    implements $InterventionEffectivenessCopyWith<$Res> {
  _$InterventionEffectivenessCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InterventionEffectiveness
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? interventionId = null,
    Object? title = null,
    Object? type = null,
    Object? usageCount = null,
    Object? avgImprovement = null,
    Object? avgTensionImprovement = null,
    Object? avgClarityGain = null,
    Object? avgHelpfulnessRating = null,
    Object? lastUsedAt = null,
  }) {
    return _then(_value.copyWith(
      interventionId: null == interventionId
          ? _value.interventionId
          : interventionId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as InterventionType,
      usageCount: null == usageCount
          ? _value.usageCount
          : usageCount // ignore: cast_nullable_to_non_nullable
              as int,
      avgImprovement: null == avgImprovement
          ? _value.avgImprovement
          : avgImprovement // ignore: cast_nullable_to_non_nullable
              as double,
      avgTensionImprovement: null == avgTensionImprovement
          ? _value.avgTensionImprovement
          : avgTensionImprovement // ignore: cast_nullable_to_non_nullable
              as double,
      avgClarityGain: null == avgClarityGain
          ? _value.avgClarityGain
          : avgClarityGain // ignore: cast_nullable_to_non_nullable
              as double,
      avgHelpfulnessRating: null == avgHelpfulnessRating
          ? _value.avgHelpfulnessRating
          : avgHelpfulnessRating // ignore: cast_nullable_to_non_nullable
              as double,
      lastUsedAt: null == lastUsedAt
          ? _value.lastUsedAt
          : lastUsedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InterventionEffectivenessImplCopyWith<$Res>
    implements $InterventionEffectivenessCopyWith<$Res> {
  factory _$$InterventionEffectivenessImplCopyWith(
          _$InterventionEffectivenessImpl value,
          $Res Function(_$InterventionEffectivenessImpl) then) =
      __$$InterventionEffectivenessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String interventionId,
      String title,
      InterventionType type,
      int usageCount,
      double avgImprovement,
      double avgTensionImprovement,
      double avgClarityGain,
      double avgHelpfulnessRating,
      DateTime lastUsedAt});
}

/// @nodoc
class __$$InterventionEffectivenessImplCopyWithImpl<$Res>
    extends _$InterventionEffectivenessCopyWithImpl<$Res,
        _$InterventionEffectivenessImpl>
    implements _$$InterventionEffectivenessImplCopyWith<$Res> {
  __$$InterventionEffectivenessImplCopyWithImpl(
      _$InterventionEffectivenessImpl _value,
      $Res Function(_$InterventionEffectivenessImpl) _then)
      : super(_value, _then);

  /// Create a copy of InterventionEffectiveness
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? interventionId = null,
    Object? title = null,
    Object? type = null,
    Object? usageCount = null,
    Object? avgImprovement = null,
    Object? avgTensionImprovement = null,
    Object? avgClarityGain = null,
    Object? avgHelpfulnessRating = null,
    Object? lastUsedAt = null,
  }) {
    return _then(_$InterventionEffectivenessImpl(
      interventionId: null == interventionId
          ? _value.interventionId
          : interventionId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as InterventionType,
      usageCount: null == usageCount
          ? _value.usageCount
          : usageCount // ignore: cast_nullable_to_non_nullable
              as int,
      avgImprovement: null == avgImprovement
          ? _value.avgImprovement
          : avgImprovement // ignore: cast_nullable_to_non_nullable
              as double,
      avgTensionImprovement: null == avgTensionImprovement
          ? _value.avgTensionImprovement
          : avgTensionImprovement // ignore: cast_nullable_to_non_nullable
              as double,
      avgClarityGain: null == avgClarityGain
          ? _value.avgClarityGain
          : avgClarityGain // ignore: cast_nullable_to_non_nullable
              as double,
      avgHelpfulnessRating: null == avgHelpfulnessRating
          ? _value.avgHelpfulnessRating
          : avgHelpfulnessRating // ignore: cast_nullable_to_non_nullable
              as double,
      lastUsedAt: null == lastUsedAt
          ? _value.lastUsedAt
          : lastUsedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InterventionEffectivenessImpl implements _InterventionEffectiveness {
  const _$InterventionEffectivenessImpl(
      {required this.interventionId,
      required this.title,
      required this.type,
      required this.usageCount,
      required this.avgImprovement,
      required this.avgTensionImprovement,
      required this.avgClarityGain,
      required this.avgHelpfulnessRating,
      required this.lastUsedAt});

  factory _$InterventionEffectivenessImpl.fromJson(Map<String, dynamic> json) =>
      _$$InterventionEffectivenessImplFromJson(json);

  /// ID der Intervention
  @override
  final String interventionId;

  /// Titel der Intervention
  @override
  final String title;

  /// Typ der Intervention
  @override
  final InterventionType type;

  /// Anzahl der Durchführungen
  @override
  final int usageCount;

  /// Durchschnittliche Verbesserung der Belastung (vorher-nachher)
  @override
  final double avgImprovement;

  /// Durchschnittliche Verbesserung der Körperanspannung
  @override
  final double avgTensionImprovement;

  /// Durchschnittliche Klarheit nach Intervention
  @override
  final double avgClarityGain;

  /// Hilfreichkeits-Rating (1-10)
  @override
  final double avgHelpfulnessRating;

  /// Letzte Verwendung
  @override
  final DateTime lastUsedAt;

  @override
  String toString() {
    return 'InterventionEffectiveness(interventionId: $interventionId, title: $title, type: $type, usageCount: $usageCount, avgImprovement: $avgImprovement, avgTensionImprovement: $avgTensionImprovement, avgClarityGain: $avgClarityGain, avgHelpfulnessRating: $avgHelpfulnessRating, lastUsedAt: $lastUsedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InterventionEffectivenessImpl &&
            (identical(other.interventionId, interventionId) ||
                other.interventionId == interventionId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.usageCount, usageCount) ||
                other.usageCount == usageCount) &&
            (identical(other.avgImprovement, avgImprovement) ||
                other.avgImprovement == avgImprovement) &&
            (identical(other.avgTensionImprovement, avgTensionImprovement) ||
                other.avgTensionImprovement == avgTensionImprovement) &&
            (identical(other.avgClarityGain, avgClarityGain) ||
                other.avgClarityGain == avgClarityGain) &&
            (identical(other.avgHelpfulnessRating, avgHelpfulnessRating) ||
                other.avgHelpfulnessRating == avgHelpfulnessRating) &&
            (identical(other.lastUsedAt, lastUsedAt) ||
                other.lastUsedAt == lastUsedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      interventionId,
      title,
      type,
      usageCount,
      avgImprovement,
      avgTensionImprovement,
      avgClarityGain,
      avgHelpfulnessRating,
      lastUsedAt);

  /// Create a copy of InterventionEffectiveness
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InterventionEffectivenessImplCopyWith<_$InterventionEffectivenessImpl>
      get copyWith => __$$InterventionEffectivenessImplCopyWithImpl<
          _$InterventionEffectivenessImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InterventionEffectivenessImplToJson(
      this,
    );
  }
}

abstract class _InterventionEffectiveness implements InterventionEffectiveness {
  const factory _InterventionEffectiveness(
      {required final String interventionId,
      required final String title,
      required final InterventionType type,
      required final int usageCount,
      required final double avgImprovement,
      required final double avgTensionImprovement,
      required final double avgClarityGain,
      required final double avgHelpfulnessRating,
      required final DateTime lastUsedAt}) = _$InterventionEffectivenessImpl;

  factory _InterventionEffectiveness.fromJson(Map<String, dynamic> json) =
      _$InterventionEffectivenessImpl.fromJson;

  /// ID der Intervention
  @override
  String get interventionId;

  /// Titel der Intervention
  @override
  String get title;

  /// Typ der Intervention
  @override
  InterventionType get type;

  /// Anzahl der Durchführungen
  @override
  int get usageCount;

  /// Durchschnittliche Verbesserung der Belastung (vorher-nachher)
  @override
  double get avgImprovement;

  /// Durchschnittliche Verbesserung der Körperanspannung
  @override
  double get avgTensionImprovement;

  /// Durchschnittliche Klarheit nach Intervention
  @override
  double get avgClarityGain;

  /// Hilfreichkeits-Rating (1-10)
  @override
  double get avgHelpfulnessRating;

  /// Letzte Verwendung
  @override
  DateTime get lastUsedAt;

  /// Create a copy of InterventionEffectiveness
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InterventionEffectivenessImplCopyWith<_$InterventionEffectivenessImpl>
      get copyWith => throw _privateConstructorUsedError;
}
