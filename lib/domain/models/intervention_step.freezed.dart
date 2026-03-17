// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intervention_step.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

InterventionStep _$InterventionStepFromJson(Map<String, dynamic> json) {
  return _InterventionStep.fromJson(json);
}

/// @nodoc
mixin _$InterventionStep {
  /// Eindeutige ID des Schritts
  String get id => throw _privateConstructorUsedError;

  /// Typ des Schritts
  InterventionStepType get type => throw _privateConstructorUsedError;

  /// Titel des Schritts
  String get title => throw _privateConstructorUsedError;

  /// Hauptinhalt/Anweisung
  String get body => throw _privateConstructorUsedError;

  /// Optionale Dauer in Sekunden (für Timer/Breathing)
  int? get durationSec => throw _privateConstructorUsedError;

  /// Optionale Auswahlmöglichkeiten (für selection/reflection)
  List<String>? get options => throw _privateConstructorUsedError;

  /// Optionale Metadaten für spezifische Step-Typen
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Optional: Untertitel für zusätzliche Informationen
  String? get subtitle => throw _privateConstructorUsedError;

  /// Optional: Hilfetext
  String? get helpText => throw _privateConstructorUsedError;

  /// Serializes this InterventionStep to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InterventionStep
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InterventionStepCopyWith<InterventionStep> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InterventionStepCopyWith<$Res> {
  factory $InterventionStepCopyWith(
          InterventionStep value, $Res Function(InterventionStep) then) =
      _$InterventionStepCopyWithImpl<$Res, InterventionStep>;
  @useResult
  $Res call(
      {String id,
      InterventionStepType type,
      String title,
      String body,
      int? durationSec,
      List<String>? options,
      Map<String, dynamic>? metadata,
      String? subtitle,
      String? helpText});
}

/// @nodoc
class _$InterventionStepCopyWithImpl<$Res, $Val extends InterventionStep>
    implements $InterventionStepCopyWith<$Res> {
  _$InterventionStepCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InterventionStep
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? title = null,
    Object? body = null,
    Object? durationSec = freezed,
    Object? options = freezed,
    Object? metadata = freezed,
    Object? subtitle = freezed,
    Object? helpText = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as InterventionStepType,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      durationSec: freezed == durationSec
          ? _value.durationSec
          : durationSec // ignore: cast_nullable_to_non_nullable
              as int?,
      options: freezed == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      subtitle: freezed == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String?,
      helpText: freezed == helpText
          ? _value.helpText
          : helpText // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InterventionStepImplCopyWith<$Res>
    implements $InterventionStepCopyWith<$Res> {
  factory _$$InterventionStepImplCopyWith(_$InterventionStepImpl value,
          $Res Function(_$InterventionStepImpl) then) =
      __$$InterventionStepImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      InterventionStepType type,
      String title,
      String body,
      int? durationSec,
      List<String>? options,
      Map<String, dynamic>? metadata,
      String? subtitle,
      String? helpText});
}

/// @nodoc
class __$$InterventionStepImplCopyWithImpl<$Res>
    extends _$InterventionStepCopyWithImpl<$Res, _$InterventionStepImpl>
    implements _$$InterventionStepImplCopyWith<$Res> {
  __$$InterventionStepImplCopyWithImpl(_$InterventionStepImpl _value,
      $Res Function(_$InterventionStepImpl) _then)
      : super(_value, _then);

  /// Create a copy of InterventionStep
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? title = null,
    Object? body = null,
    Object? durationSec = freezed,
    Object? options = freezed,
    Object? metadata = freezed,
    Object? subtitle = freezed,
    Object? helpText = freezed,
  }) {
    return _then(_$InterventionStepImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as InterventionStepType,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      durationSec: freezed == durationSec
          ? _value.durationSec
          : durationSec // ignore: cast_nullable_to_non_nullable
              as int?,
      options: freezed == options
          ? _value._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      subtitle: freezed == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String?,
      helpText: freezed == helpText
          ? _value.helpText
          : helpText // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InterventionStepImpl implements _InterventionStep {
  const _$InterventionStepImpl(
      {required this.id,
      required this.type,
      required this.title,
      required this.body,
      this.durationSec,
      final List<String>? options,
      final Map<String, dynamic>? metadata,
      this.subtitle,
      this.helpText})
      : _options = options,
        _metadata = metadata;

  factory _$InterventionStepImpl.fromJson(Map<String, dynamic> json) =>
      _$$InterventionStepImplFromJson(json);

  /// Eindeutige ID des Schritts
  @override
  final String id;

  /// Typ des Schritts
  @override
  final InterventionStepType type;

  /// Titel des Schritts
  @override
  final String title;

  /// Hauptinhalt/Anweisung
  @override
  final String body;

  /// Optionale Dauer in Sekunden (für Timer/Breathing)
  @override
  final int? durationSec;

  /// Optionale Auswahlmöglichkeiten (für selection/reflection)
  final List<String>? _options;

  /// Optionale Auswahlmöglichkeiten (für selection/reflection)
  @override
  List<String>? get options {
    final value = _options;
    if (value == null) return null;
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Optionale Metadaten für spezifische Step-Typen
  final Map<String, dynamic>? _metadata;

  /// Optionale Metadaten für spezifische Step-Typen
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// Optional: Untertitel für zusätzliche Informationen
  @override
  final String? subtitle;

  /// Optional: Hilfetext
  @override
  final String? helpText;

  @override
  String toString() {
    return 'InterventionStep(id: $id, type: $type, title: $title, body: $body, durationSec: $durationSec, options: $options, metadata: $metadata, subtitle: $subtitle, helpText: $helpText)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InterventionStepImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.durationSec, durationSec) ||
                other.durationSec == durationSec) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.helpText, helpText) ||
                other.helpText == helpText));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      type,
      title,
      body,
      durationSec,
      const DeepCollectionEquality().hash(_options),
      const DeepCollectionEquality().hash(_metadata),
      subtitle,
      helpText);

  /// Create a copy of InterventionStep
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InterventionStepImplCopyWith<_$InterventionStepImpl> get copyWith =>
      __$$InterventionStepImplCopyWithImpl<_$InterventionStepImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InterventionStepImplToJson(
      this,
    );
  }
}

abstract class _InterventionStep implements InterventionStep {
  const factory _InterventionStep(
      {required final String id,
      required final InterventionStepType type,
      required final String title,
      required final String body,
      final int? durationSec,
      final List<String>? options,
      final Map<String, dynamic>? metadata,
      final String? subtitle,
      final String? helpText}) = _$InterventionStepImpl;

  factory _InterventionStep.fromJson(Map<String, dynamic> json) =
      _$InterventionStepImpl.fromJson;

  /// Eindeutige ID des Schritts
  @override
  String get id;

  /// Typ des Schritts
  @override
  InterventionStepType get type;

  /// Titel des Schritts
  @override
  String get title;

  /// Hauptinhalt/Anweisung
  @override
  String get body;

  /// Optionale Dauer in Sekunden (für Timer/Breathing)
  @override
  int? get durationSec;

  /// Optionale Auswahlmöglichkeiten (für selection/reflection)
  @override
  List<String>? get options;

  /// Optionale Metadaten für spezifische Step-Typen
  @override
  Map<String, dynamic>? get metadata;

  /// Optional: Untertitel für zusätzliche Informationen
  @override
  String? get subtitle;

  /// Optional: Hilfetext
  @override
  String? get helpText;

  /// Create a copy of InterventionStep
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InterventionStepImplCopyWith<_$InterventionStepImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InterventionStepResponse _$InterventionStepResponseFromJson(
    Map<String, dynamic> json) {
  return _InterventionStepResponse.fromJson(json);
}

/// @nodoc
mixin _$InterventionStepResponse {
  /// ID des Schritts
  String get stepId => throw _privateConstructorUsedError;

  /// Typ des Schritts
  InterventionStepType get type => throw _privateConstructorUsedError;

  /// Text-Antwort (für reflection)
  String? get textResponse => throw _privateConstructorUsedError;

  /// Auswahl-Antwort (für selection)
  String? get selectionResponse => throw _privateConstructorUsedError;

  /// Bewertungs-Antwort (für rating)
  int? get ratingResponse => throw _privateConstructorUsedError;

  /// Bool-Antwort (für action/confirmation)
  bool? get boolResponse => throw _privateConstructorUsedError;

  /// Optional: Dauer die der Nutzer gebraucht hat
  int? get actualDurationSec => throw _privateConstructorUsedError;

  /// Zeitstempel der Antwort
  DateTime get answeredAt => throw _privateConstructorUsedError;

  /// Serializes this InterventionStepResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InterventionStepResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InterventionStepResponseCopyWith<InterventionStepResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InterventionStepResponseCopyWith<$Res> {
  factory $InterventionStepResponseCopyWith(InterventionStepResponse value,
          $Res Function(InterventionStepResponse) then) =
      _$InterventionStepResponseCopyWithImpl<$Res, InterventionStepResponse>;
  @useResult
  $Res call(
      {String stepId,
      InterventionStepType type,
      String? textResponse,
      String? selectionResponse,
      int? ratingResponse,
      bool? boolResponse,
      int? actualDurationSec,
      DateTime answeredAt});
}

/// @nodoc
class _$InterventionStepResponseCopyWithImpl<$Res,
        $Val extends InterventionStepResponse>
    implements $InterventionStepResponseCopyWith<$Res> {
  _$InterventionStepResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InterventionStepResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stepId = null,
    Object? type = null,
    Object? textResponse = freezed,
    Object? selectionResponse = freezed,
    Object? ratingResponse = freezed,
    Object? boolResponse = freezed,
    Object? actualDurationSec = freezed,
    Object? answeredAt = null,
  }) {
    return _then(_value.copyWith(
      stepId: null == stepId
          ? _value.stepId
          : stepId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as InterventionStepType,
      textResponse: freezed == textResponse
          ? _value.textResponse
          : textResponse // ignore: cast_nullable_to_non_nullable
              as String?,
      selectionResponse: freezed == selectionResponse
          ? _value.selectionResponse
          : selectionResponse // ignore: cast_nullable_to_non_nullable
              as String?,
      ratingResponse: freezed == ratingResponse
          ? _value.ratingResponse
          : ratingResponse // ignore: cast_nullable_to_non_nullable
              as int?,
      boolResponse: freezed == boolResponse
          ? _value.boolResponse
          : boolResponse // ignore: cast_nullable_to_non_nullable
              as bool?,
      actualDurationSec: freezed == actualDurationSec
          ? _value.actualDurationSec
          : actualDurationSec // ignore: cast_nullable_to_non_nullable
              as int?,
      answeredAt: null == answeredAt
          ? _value.answeredAt
          : answeredAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InterventionStepResponseImplCopyWith<$Res>
    implements $InterventionStepResponseCopyWith<$Res> {
  factory _$$InterventionStepResponseImplCopyWith(
          _$InterventionStepResponseImpl value,
          $Res Function(_$InterventionStepResponseImpl) then) =
      __$$InterventionStepResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String stepId,
      InterventionStepType type,
      String? textResponse,
      String? selectionResponse,
      int? ratingResponse,
      bool? boolResponse,
      int? actualDurationSec,
      DateTime answeredAt});
}

/// @nodoc
class __$$InterventionStepResponseImplCopyWithImpl<$Res>
    extends _$InterventionStepResponseCopyWithImpl<$Res,
        _$InterventionStepResponseImpl>
    implements _$$InterventionStepResponseImplCopyWith<$Res> {
  __$$InterventionStepResponseImplCopyWithImpl(
      _$InterventionStepResponseImpl _value,
      $Res Function(_$InterventionStepResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of InterventionStepResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stepId = null,
    Object? type = null,
    Object? textResponse = freezed,
    Object? selectionResponse = freezed,
    Object? ratingResponse = freezed,
    Object? boolResponse = freezed,
    Object? actualDurationSec = freezed,
    Object? answeredAt = null,
  }) {
    return _then(_$InterventionStepResponseImpl(
      stepId: null == stepId
          ? _value.stepId
          : stepId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as InterventionStepType,
      textResponse: freezed == textResponse
          ? _value.textResponse
          : textResponse // ignore: cast_nullable_to_non_nullable
              as String?,
      selectionResponse: freezed == selectionResponse
          ? _value.selectionResponse
          : selectionResponse // ignore: cast_nullable_to_non_nullable
              as String?,
      ratingResponse: freezed == ratingResponse
          ? _value.ratingResponse
          : ratingResponse // ignore: cast_nullable_to_non_nullable
              as int?,
      boolResponse: freezed == boolResponse
          ? _value.boolResponse
          : boolResponse // ignore: cast_nullable_to_non_nullable
              as bool?,
      actualDurationSec: freezed == actualDurationSec
          ? _value.actualDurationSec
          : actualDurationSec // ignore: cast_nullable_to_non_nullable
              as int?,
      answeredAt: null == answeredAt
          ? _value.answeredAt
          : answeredAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InterventionStepResponseImpl implements _InterventionStepResponse {
  const _$InterventionStepResponseImpl(
      {required this.stepId,
      required this.type,
      this.textResponse,
      this.selectionResponse,
      this.ratingResponse,
      this.boolResponse,
      this.actualDurationSec,
      required this.answeredAt});

  factory _$InterventionStepResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$InterventionStepResponseImplFromJson(json);

  /// ID des Schritts
  @override
  final String stepId;

  /// Typ des Schritts
  @override
  final InterventionStepType type;

  /// Text-Antwort (für reflection)
  @override
  final String? textResponse;

  /// Auswahl-Antwort (für selection)
  @override
  final String? selectionResponse;

  /// Bewertungs-Antwort (für rating)
  @override
  final int? ratingResponse;

  /// Bool-Antwort (für action/confirmation)
  @override
  final bool? boolResponse;

  /// Optional: Dauer die der Nutzer gebraucht hat
  @override
  final int? actualDurationSec;

  /// Zeitstempel der Antwort
  @override
  final DateTime answeredAt;

  @override
  String toString() {
    return 'InterventionStepResponse(stepId: $stepId, type: $type, textResponse: $textResponse, selectionResponse: $selectionResponse, ratingResponse: $ratingResponse, boolResponse: $boolResponse, actualDurationSec: $actualDurationSec, answeredAt: $answeredAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InterventionStepResponseImpl &&
            (identical(other.stepId, stepId) || other.stepId == stepId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.textResponse, textResponse) ||
                other.textResponse == textResponse) &&
            (identical(other.selectionResponse, selectionResponse) ||
                other.selectionResponse == selectionResponse) &&
            (identical(other.ratingResponse, ratingResponse) ||
                other.ratingResponse == ratingResponse) &&
            (identical(other.boolResponse, boolResponse) ||
                other.boolResponse == boolResponse) &&
            (identical(other.actualDurationSec, actualDurationSec) ||
                other.actualDurationSec == actualDurationSec) &&
            (identical(other.answeredAt, answeredAt) ||
                other.answeredAt == answeredAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      stepId,
      type,
      textResponse,
      selectionResponse,
      ratingResponse,
      boolResponse,
      actualDurationSec,
      answeredAt);

  /// Create a copy of InterventionStepResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InterventionStepResponseImplCopyWith<_$InterventionStepResponseImpl>
      get copyWith => __$$InterventionStepResponseImplCopyWithImpl<
          _$InterventionStepResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InterventionStepResponseImplToJson(
      this,
    );
  }
}

abstract class _InterventionStepResponse implements InterventionStepResponse {
  const factory _InterventionStepResponse(
      {required final String stepId,
      required final InterventionStepType type,
      final String? textResponse,
      final String? selectionResponse,
      final int? ratingResponse,
      final bool? boolResponse,
      final int? actualDurationSec,
      required final DateTime answeredAt}) = _$InterventionStepResponseImpl;

  factory _InterventionStepResponse.fromJson(Map<String, dynamic> json) =
      _$InterventionStepResponseImpl.fromJson;

  /// ID des Schritts
  @override
  String get stepId;

  /// Typ des Schritts
  @override
  InterventionStepType get type;

  /// Text-Antwort (für reflection)
  @override
  String? get textResponse;

  /// Auswahl-Antwort (für selection)
  @override
  String? get selectionResponse;

  /// Bewertungs-Antwort (für rating)
  @override
  int? get ratingResponse;

  /// Bool-Antwort (für action/confirmation)
  @override
  bool? get boolResponse;

  /// Optional: Dauer die der Nutzer gebraucht hat
  @override
  int? get actualDurationSec;

  /// Zeitstempel der Antwort
  @override
  DateTime get answeredAt;

  /// Create a copy of InterventionStepResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InterventionStepResponseImplCopyWith<_$InterventionStepResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
