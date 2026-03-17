// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pattern_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FrequencyEntry _$FrequencyEntryFromJson(Map<String, dynamic> json) {
  return _FrequencyEntry.fromJson(json);
}

/// @nodoc
mixin _$FrequencyEntry {
  String get label => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  double get percentage => throw _privateConstructorUsedError;
  String? get emoji => throw _privateConstructorUsedError;

  /// Serializes this FrequencyEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FrequencyEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FrequencyEntryCopyWith<FrequencyEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FrequencyEntryCopyWith<$Res> {
  factory $FrequencyEntryCopyWith(
          FrequencyEntry value, $Res Function(FrequencyEntry) then) =
      _$FrequencyEntryCopyWithImpl<$Res, FrequencyEntry>;
  @useResult
  $Res call({String label, int count, double percentage, String? emoji});
}

/// @nodoc
class _$FrequencyEntryCopyWithImpl<$Res, $Val extends FrequencyEntry>
    implements $FrequencyEntryCopyWith<$Res> {
  _$FrequencyEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FrequencyEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? count = null,
    Object? percentage = null,
    Object? emoji = freezed,
  }) {
    return _then(_value.copyWith(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      percentage: null == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double,
      emoji: freezed == emoji
          ? _value.emoji
          : emoji // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FrequencyEntryImplCopyWith<$Res>
    implements $FrequencyEntryCopyWith<$Res> {
  factory _$$FrequencyEntryImplCopyWith(_$FrequencyEntryImpl value,
          $Res Function(_$FrequencyEntryImpl) then) =
      __$$FrequencyEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String label, int count, double percentage, String? emoji});
}

/// @nodoc
class __$$FrequencyEntryImplCopyWithImpl<$Res>
    extends _$FrequencyEntryCopyWithImpl<$Res, _$FrequencyEntryImpl>
    implements _$$FrequencyEntryImplCopyWith<$Res> {
  __$$FrequencyEntryImplCopyWithImpl(
      _$FrequencyEntryImpl _value, $Res Function(_$FrequencyEntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of FrequencyEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
    Object? count = null,
    Object? percentage = null,
    Object? emoji = freezed,
  }) {
    return _then(_$FrequencyEntryImpl(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      percentage: null == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double,
      emoji: freezed == emoji
          ? _value.emoji
          : emoji // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FrequencyEntryImpl implements _FrequencyEntry {
  const _$FrequencyEntryImpl(
      {required this.label,
      required this.count,
      required this.percentage,
      this.emoji});

  factory _$FrequencyEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$FrequencyEntryImplFromJson(json);

  @override
  final String label;
  @override
  final int count;
  @override
  final double percentage;
  @override
  final String? emoji;

  @override
  String toString() {
    return 'FrequencyEntry(label: $label, count: $count, percentage: $percentage, emoji: $emoji)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FrequencyEntryImpl &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage) &&
            (identical(other.emoji, emoji) || other.emoji == emoji));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, label, count, percentage, emoji);

  /// Create a copy of FrequencyEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FrequencyEntryImplCopyWith<_$FrequencyEntryImpl> get copyWith =>
      __$$FrequencyEntryImplCopyWithImpl<_$FrequencyEntryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FrequencyEntryImplToJson(
      this,
    );
  }
}

abstract class _FrequencyEntry implements FrequencyEntry {
  const factory _FrequencyEntry(
      {required final String label,
      required final int count,
      required final double percentage,
      final String? emoji}) = _$FrequencyEntryImpl;

  factory _FrequencyEntry.fromJson(Map<String, dynamic> json) =
      _$FrequencyEntryImpl.fromJson;

  @override
  String get label;
  @override
  int get count;
  @override
  double get percentage;
  @override
  String? get emoji;

  /// Create a copy of FrequencyEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FrequencyEntryImplCopyWith<_$FrequencyEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TrendDataPoint _$TrendDataPointFromJson(Map<String, dynamic> json) {
  return _TrendDataPoint.fromJson(json);
}

/// @nodoc
mixin _$TrendDataPoint {
  DateTime get date => throw _privateConstructorUsedError;
  double get value => throw _privateConstructorUsedError;
  double? get secondaryValue =>
      throw _privateConstructorUsedError; // z.B. Körperanspannung
  int? get entryCount => throw _privateConstructorUsedError;

  /// Serializes this TrendDataPoint to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TrendDataPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TrendDataPointCopyWith<TrendDataPoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrendDataPointCopyWith<$Res> {
  factory $TrendDataPointCopyWith(
          TrendDataPoint value, $Res Function(TrendDataPoint) then) =
      _$TrendDataPointCopyWithImpl<$Res, TrendDataPoint>;
  @useResult
  $Res call(
      {DateTime date, double value, double? secondaryValue, int? entryCount});
}

/// @nodoc
class _$TrendDataPointCopyWithImpl<$Res, $Val extends TrendDataPoint>
    implements $TrendDataPointCopyWith<$Res> {
  _$TrendDataPointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TrendDataPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? value = null,
    Object? secondaryValue = freezed,
    Object? entryCount = freezed,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      secondaryValue: freezed == secondaryValue
          ? _value.secondaryValue
          : secondaryValue // ignore: cast_nullable_to_non_nullable
              as double?,
      entryCount: freezed == entryCount
          ? _value.entryCount
          : entryCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TrendDataPointImplCopyWith<$Res>
    implements $TrendDataPointCopyWith<$Res> {
  factory _$$TrendDataPointImplCopyWith(_$TrendDataPointImpl value,
          $Res Function(_$TrendDataPointImpl) then) =
      __$$TrendDataPointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime date, double value, double? secondaryValue, int? entryCount});
}

/// @nodoc
class __$$TrendDataPointImplCopyWithImpl<$Res>
    extends _$TrendDataPointCopyWithImpl<$Res, _$TrendDataPointImpl>
    implements _$$TrendDataPointImplCopyWith<$Res> {
  __$$TrendDataPointImplCopyWithImpl(
      _$TrendDataPointImpl _value, $Res Function(_$TrendDataPointImpl) _then)
      : super(_value, _then);

  /// Create a copy of TrendDataPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? value = null,
    Object? secondaryValue = freezed,
    Object? entryCount = freezed,
  }) {
    return _then(_$TrendDataPointImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      secondaryValue: freezed == secondaryValue
          ? _value.secondaryValue
          : secondaryValue // ignore: cast_nullable_to_non_nullable
              as double?,
      entryCount: freezed == entryCount
          ? _value.entryCount
          : entryCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TrendDataPointImpl implements _TrendDataPoint {
  const _$TrendDataPointImpl(
      {required this.date,
      required this.value,
      this.secondaryValue,
      this.entryCount});

  factory _$TrendDataPointImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrendDataPointImplFromJson(json);

  @override
  final DateTime date;
  @override
  final double value;
  @override
  final double? secondaryValue;
// z.B. Körperanspannung
  @override
  final int? entryCount;

  @override
  String toString() {
    return 'TrendDataPoint(date: $date, value: $value, secondaryValue: $secondaryValue, entryCount: $entryCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrendDataPointImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.secondaryValue, secondaryValue) ||
                other.secondaryValue == secondaryValue) &&
            (identical(other.entryCount, entryCount) ||
                other.entryCount == entryCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, date, value, secondaryValue, entryCount);

  /// Create a copy of TrendDataPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TrendDataPointImplCopyWith<_$TrendDataPointImpl> get copyWith =>
      __$$TrendDataPointImplCopyWithImpl<_$TrendDataPointImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TrendDataPointImplToJson(
      this,
    );
  }
}

abstract class _TrendDataPoint implements TrendDataPoint {
  const factory _TrendDataPoint(
      {required final DateTime date,
      required final double value,
      final double? secondaryValue,
      final int? entryCount}) = _$TrendDataPointImpl;

  factory _TrendDataPoint.fromJson(Map<String, dynamic> json) =
      _$TrendDataPointImpl.fromJson;

  @override
  DateTime get date;
  @override
  double get value;
  @override
  double? get secondaryValue; // z.B. Körperanspannung
  @override
  int? get entryCount;

  /// Create a copy of TrendDataPoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TrendDataPointImplCopyWith<_$TrendDataPointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TriggerPattern _$TriggerPatternFromJson(Map<String, dynamic> json) {
  return _TriggerPattern.fromJson(json);
}

/// @nodoc
mixin _$TriggerPattern {
  /// Kontext der Situation
  ContextType get context => throw _privateConstructorUsedError;

  /// Häufigste Emotion in diesem Kontext
  EmotionType get emotion => throw _privateConstructorUsedError;

  /// Durchschnittliche Intensität
  double get avgIntensity => throw _privateConstructorUsedError;

  /// Häufigkeit dieses Musters
  int get occurrenceCount => throw _privateConstructorUsedError;

  /// Häufigster Impuls
  ImpulseType? get commonImpulse => throw _privateConstructorUsedError;

  /// Häufigster Systemzustand
  SystemState? get commonState => throw _privateConstructorUsedError;

  /// Serializes this TriggerPattern to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TriggerPattern
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TriggerPatternCopyWith<TriggerPattern> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TriggerPatternCopyWith<$Res> {
  factory $TriggerPatternCopyWith(
          TriggerPattern value, $Res Function(TriggerPattern) then) =
      _$TriggerPatternCopyWithImpl<$Res, TriggerPattern>;
  @useResult
  $Res call(
      {ContextType context,
      EmotionType emotion,
      double avgIntensity,
      int occurrenceCount,
      ImpulseType? commonImpulse,
      SystemState? commonState});
}

/// @nodoc
class _$TriggerPatternCopyWithImpl<$Res, $Val extends TriggerPattern>
    implements $TriggerPatternCopyWith<$Res> {
  _$TriggerPatternCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TriggerPattern
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? emotion = null,
    Object? avgIntensity = null,
    Object? occurrenceCount = null,
    Object? commonImpulse = freezed,
    Object? commonState = freezed,
  }) {
    return _then(_value.copyWith(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as ContextType,
      emotion: null == emotion
          ? _value.emotion
          : emotion // ignore: cast_nullable_to_non_nullable
              as EmotionType,
      avgIntensity: null == avgIntensity
          ? _value.avgIntensity
          : avgIntensity // ignore: cast_nullable_to_non_nullable
              as double,
      occurrenceCount: null == occurrenceCount
          ? _value.occurrenceCount
          : occurrenceCount // ignore: cast_nullable_to_non_nullable
              as int,
      commonImpulse: freezed == commonImpulse
          ? _value.commonImpulse
          : commonImpulse // ignore: cast_nullable_to_non_nullable
              as ImpulseType?,
      commonState: freezed == commonState
          ? _value.commonState
          : commonState // ignore: cast_nullable_to_non_nullable
              as SystemState?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TriggerPatternImplCopyWith<$Res>
    implements $TriggerPatternCopyWith<$Res> {
  factory _$$TriggerPatternImplCopyWith(_$TriggerPatternImpl value,
          $Res Function(_$TriggerPatternImpl) then) =
      __$$TriggerPatternImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ContextType context,
      EmotionType emotion,
      double avgIntensity,
      int occurrenceCount,
      ImpulseType? commonImpulse,
      SystemState? commonState});
}

/// @nodoc
class __$$TriggerPatternImplCopyWithImpl<$Res>
    extends _$TriggerPatternCopyWithImpl<$Res, _$TriggerPatternImpl>
    implements _$$TriggerPatternImplCopyWith<$Res> {
  __$$TriggerPatternImplCopyWithImpl(
      _$TriggerPatternImpl _value, $Res Function(_$TriggerPatternImpl) _then)
      : super(_value, _then);

  /// Create a copy of TriggerPattern
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? emotion = null,
    Object? avgIntensity = null,
    Object? occurrenceCount = null,
    Object? commonImpulse = freezed,
    Object? commonState = freezed,
  }) {
    return _then(_$TriggerPatternImpl(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as ContextType,
      emotion: null == emotion
          ? _value.emotion
          : emotion // ignore: cast_nullable_to_non_nullable
              as EmotionType,
      avgIntensity: null == avgIntensity
          ? _value.avgIntensity
          : avgIntensity // ignore: cast_nullable_to_non_nullable
              as double,
      occurrenceCount: null == occurrenceCount
          ? _value.occurrenceCount
          : occurrenceCount // ignore: cast_nullable_to_non_nullable
              as int,
      commonImpulse: freezed == commonImpulse
          ? _value.commonImpulse
          : commonImpulse // ignore: cast_nullable_to_non_nullable
              as ImpulseType?,
      commonState: freezed == commonState
          ? _value.commonState
          : commonState // ignore: cast_nullable_to_non_nullable
              as SystemState?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TriggerPatternImpl implements _TriggerPattern {
  const _$TriggerPatternImpl(
      {required this.context,
      required this.emotion,
      required this.avgIntensity,
      required this.occurrenceCount,
      this.commonImpulse,
      this.commonState});

  factory _$TriggerPatternImpl.fromJson(Map<String, dynamic> json) =>
      _$$TriggerPatternImplFromJson(json);

  /// Kontext der Situation
  @override
  final ContextType context;

  /// Häufigste Emotion in diesem Kontext
  @override
  final EmotionType emotion;

  /// Durchschnittliche Intensität
  @override
  final double avgIntensity;

  /// Häufigkeit dieses Musters
  @override
  final int occurrenceCount;

  /// Häufigster Impuls
  @override
  final ImpulseType? commonImpulse;

  /// Häufigster Systemzustand
  @override
  final SystemState? commonState;

  @override
  String toString() {
    return 'TriggerPattern(context: $context, emotion: $emotion, avgIntensity: $avgIntensity, occurrenceCount: $occurrenceCount, commonImpulse: $commonImpulse, commonState: $commonState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TriggerPatternImpl &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.emotion, emotion) || other.emotion == emotion) &&
            (identical(other.avgIntensity, avgIntensity) ||
                other.avgIntensity == avgIntensity) &&
            (identical(other.occurrenceCount, occurrenceCount) ||
                other.occurrenceCount == occurrenceCount) &&
            (identical(other.commonImpulse, commonImpulse) ||
                other.commonImpulse == commonImpulse) &&
            (identical(other.commonState, commonState) ||
                other.commonState == commonState));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, context, emotion, avgIntensity,
      occurrenceCount, commonImpulse, commonState);

  /// Create a copy of TriggerPattern
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TriggerPatternImplCopyWith<_$TriggerPatternImpl> get copyWith =>
      __$$TriggerPatternImplCopyWithImpl<_$TriggerPatternImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TriggerPatternImplToJson(
      this,
    );
  }
}

abstract class _TriggerPattern implements TriggerPattern {
  const factory _TriggerPattern(
      {required final ContextType context,
      required final EmotionType emotion,
      required final double avgIntensity,
      required final int occurrenceCount,
      final ImpulseType? commonImpulse,
      final SystemState? commonState}) = _$TriggerPatternImpl;

  factory _TriggerPattern.fromJson(Map<String, dynamic> json) =
      _$TriggerPatternImpl.fromJson;

  /// Kontext der Situation
  @override
  ContextType get context;

  /// Häufigste Emotion in diesem Kontext
  @override
  EmotionType get emotion;

  /// Durchschnittliche Intensität
  @override
  double get avgIntensity;

  /// Häufigkeit dieses Musters
  @override
  int get occurrenceCount;

  /// Häufigster Impuls
  @override
  ImpulseType? get commonImpulse;

  /// Häufigster Systemzustand
  @override
  SystemState? get commonState;

  /// Create a copy of TriggerPattern
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TriggerPatternImplCopyWith<_$TriggerPatternImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TimePatterns _$TimePatternsFromJson(Map<String, dynamic> json) {
  return _TimePatterns.fromJson(json);
}

/// @nodoc
mixin _$TimePatterns {
  /// Häufigkeit nach Wochentagen (0=Sonntag, 6=Samstag)
  List<int> get weekdayDistribution => throw _privateConstructorUsedError;

  /// Häufigkeit nach Tageszeiten (morgen, mittag, abend, nacht)
  Map<String, int> get timeOfDayDistribution =>
      throw _privateConstructorUsedError;

  /// Durchschnittliche Intensität nach Wochentag
  List<double> get avgIntensityByWeekday => throw _privateConstructorUsedError;

  /// Meiste Belastung an welchem Wochentag
  int get mostStressfulWeekday => throw _privateConstructorUsedError;

  /// Serializes this TimePatterns to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TimePatterns
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimePatternsCopyWith<TimePatterns> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimePatternsCopyWith<$Res> {
  factory $TimePatternsCopyWith(
          TimePatterns value, $Res Function(TimePatterns) then) =
      _$TimePatternsCopyWithImpl<$Res, TimePatterns>;
  @useResult
  $Res call(
      {List<int> weekdayDistribution,
      Map<String, int> timeOfDayDistribution,
      List<double> avgIntensityByWeekday,
      int mostStressfulWeekday});
}

/// @nodoc
class _$TimePatternsCopyWithImpl<$Res, $Val extends TimePatterns>
    implements $TimePatternsCopyWith<$Res> {
  _$TimePatternsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimePatterns
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weekdayDistribution = null,
    Object? timeOfDayDistribution = null,
    Object? avgIntensityByWeekday = null,
    Object? mostStressfulWeekday = null,
  }) {
    return _then(_value.copyWith(
      weekdayDistribution: null == weekdayDistribution
          ? _value.weekdayDistribution
          : weekdayDistribution // ignore: cast_nullable_to_non_nullable
              as List<int>,
      timeOfDayDistribution: null == timeOfDayDistribution
          ? _value.timeOfDayDistribution
          : timeOfDayDistribution // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      avgIntensityByWeekday: null == avgIntensityByWeekday
          ? _value.avgIntensityByWeekday
          : avgIntensityByWeekday // ignore: cast_nullable_to_non_nullable
              as List<double>,
      mostStressfulWeekday: null == mostStressfulWeekday
          ? _value.mostStressfulWeekday
          : mostStressfulWeekday // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimePatternsImplCopyWith<$Res>
    implements $TimePatternsCopyWith<$Res> {
  factory _$$TimePatternsImplCopyWith(
          _$TimePatternsImpl value, $Res Function(_$TimePatternsImpl) then) =
      __$$TimePatternsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<int> weekdayDistribution,
      Map<String, int> timeOfDayDistribution,
      List<double> avgIntensityByWeekday,
      int mostStressfulWeekday});
}

/// @nodoc
class __$$TimePatternsImplCopyWithImpl<$Res>
    extends _$TimePatternsCopyWithImpl<$Res, _$TimePatternsImpl>
    implements _$$TimePatternsImplCopyWith<$Res> {
  __$$TimePatternsImplCopyWithImpl(
      _$TimePatternsImpl _value, $Res Function(_$TimePatternsImpl) _then)
      : super(_value, _then);

  /// Create a copy of TimePatterns
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weekdayDistribution = null,
    Object? timeOfDayDistribution = null,
    Object? avgIntensityByWeekday = null,
    Object? mostStressfulWeekday = null,
  }) {
    return _then(_$TimePatternsImpl(
      weekdayDistribution: null == weekdayDistribution
          ? _value._weekdayDistribution
          : weekdayDistribution // ignore: cast_nullable_to_non_nullable
              as List<int>,
      timeOfDayDistribution: null == timeOfDayDistribution
          ? _value._timeOfDayDistribution
          : timeOfDayDistribution // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      avgIntensityByWeekday: null == avgIntensityByWeekday
          ? _value._avgIntensityByWeekday
          : avgIntensityByWeekday // ignore: cast_nullable_to_non_nullable
              as List<double>,
      mostStressfulWeekday: null == mostStressfulWeekday
          ? _value.mostStressfulWeekday
          : mostStressfulWeekday // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TimePatternsImpl implements _TimePatterns {
  const _$TimePatternsImpl(
      {required final List<int> weekdayDistribution,
      required final Map<String, int> timeOfDayDistribution,
      required final List<double> avgIntensityByWeekday,
      required this.mostStressfulWeekday})
      : _weekdayDistribution = weekdayDistribution,
        _timeOfDayDistribution = timeOfDayDistribution,
        _avgIntensityByWeekday = avgIntensityByWeekday;

  factory _$TimePatternsImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimePatternsImplFromJson(json);

  /// Häufigkeit nach Wochentagen (0=Sonntag, 6=Samstag)
  final List<int> _weekdayDistribution;

  /// Häufigkeit nach Wochentagen (0=Sonntag, 6=Samstag)
  @override
  List<int> get weekdayDistribution {
    if (_weekdayDistribution is EqualUnmodifiableListView)
      return _weekdayDistribution;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_weekdayDistribution);
  }

  /// Häufigkeit nach Tageszeiten (morgen, mittag, abend, nacht)
  final Map<String, int> _timeOfDayDistribution;

  /// Häufigkeit nach Tageszeiten (morgen, mittag, abend, nacht)
  @override
  Map<String, int> get timeOfDayDistribution {
    if (_timeOfDayDistribution is EqualUnmodifiableMapView)
      return _timeOfDayDistribution;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_timeOfDayDistribution);
  }

  /// Durchschnittliche Intensität nach Wochentag
  final List<double> _avgIntensityByWeekday;

  /// Durchschnittliche Intensität nach Wochentag
  @override
  List<double> get avgIntensityByWeekday {
    if (_avgIntensityByWeekday is EqualUnmodifiableListView)
      return _avgIntensityByWeekday;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_avgIntensityByWeekday);
  }

  /// Meiste Belastung an welchem Wochentag
  @override
  final int mostStressfulWeekday;

  @override
  String toString() {
    return 'TimePatterns(weekdayDistribution: $weekdayDistribution, timeOfDayDistribution: $timeOfDayDistribution, avgIntensityByWeekday: $avgIntensityByWeekday, mostStressfulWeekday: $mostStressfulWeekday)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimePatternsImpl &&
            const DeepCollectionEquality()
                .equals(other._weekdayDistribution, _weekdayDistribution) &&
            const DeepCollectionEquality()
                .equals(other._timeOfDayDistribution, _timeOfDayDistribution) &&
            const DeepCollectionEquality()
                .equals(other._avgIntensityByWeekday, _avgIntensityByWeekday) &&
            (identical(other.mostStressfulWeekday, mostStressfulWeekday) ||
                other.mostStressfulWeekday == mostStressfulWeekday));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_weekdayDistribution),
      const DeepCollectionEquality().hash(_timeOfDayDistribution),
      const DeepCollectionEquality().hash(_avgIntensityByWeekday),
      mostStressfulWeekday);

  /// Create a copy of TimePatterns
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimePatternsImplCopyWith<_$TimePatternsImpl> get copyWith =>
      __$$TimePatternsImplCopyWithImpl<_$TimePatternsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimePatternsImplToJson(
      this,
    );
  }
}

abstract class _TimePatterns implements TimePatterns {
  const factory _TimePatterns(
      {required final List<int> weekdayDistribution,
      required final Map<String, int> timeOfDayDistribution,
      required final List<double> avgIntensityByWeekday,
      required final int mostStressfulWeekday}) = _$TimePatternsImpl;

  factory _TimePatterns.fromJson(Map<String, dynamic> json) =
      _$TimePatternsImpl.fromJson;

  /// Häufigkeit nach Wochentagen (0=Sonntag, 6=Samstag)
  @override
  List<int> get weekdayDistribution;

  /// Häufigkeit nach Tageszeiten (morgen, mittag, abend, nacht)
  @override
  Map<String, int> get timeOfDayDistribution;

  /// Durchschnittliche Intensität nach Wochentag
  @override
  List<double> get avgIntensityByWeekday;

  /// Meiste Belastung an welchem Wochentag
  @override
  int get mostStressfulWeekday;

  /// Create a copy of TimePatterns
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimePatternsImplCopyWith<_$TimePatternsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PatternSummary _$PatternSummaryFromJson(Map<String, dynamic> json) {
  return _PatternSummary.fromJson(json);
}

/// @nodoc
mixin _$PatternSummary {
  /// Gesamtanzahl der analysierten Einträge
  int get totalEntries => throw _privateConstructorUsedError;

  /// Zeitspanne der Analyse
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;

  /// Emotions-Häufigkeit
  Map<EmotionType, int> get emotionFrequency =>
      throw _privateConstructorUsedError;

  /// Kontext-Häufigkeit
  Map<ContextType, int> get contextFrequency =>
      throw _privateConstructorUsedError;

  /// Impuls-Häufigkeit
  Map<ImpulseType, int> get impulseFrequency =>
      throw _privateConstructorUsedError;

  /// Systemzustand-Häufigkeit
  Map<SystemState, int> get systemStateFrequency =>
      throw _privateConstructorUsedError;

  /// Belastungs-Trend über Zeit
  List<TrendDataPoint> get intensityTrend => throw _privateConstructorUsedError;

  /// Körperanspannungs-Trend über Zeit
  List<TrendDataPoint> get tensionTrend => throw _privateConstructorUsedError;

  /// Effektivste Interventionen
  List<InterventionEffectiveness> get mostEffectiveInterventions =>
      throw _privateConstructorUsedError;

  /// Häufigste Trigger-Muster
  List<TriggerPattern> get commonTriggers => throw _privateConstructorUsedError;

  /// Zeitmuster
  TimePatterns? get timePatterns => throw _privateConstructorUsedError;

  /// Durchschnittliche Intensität
  double get avgIntensity => throw _privateConstructorUsedError;

  /// Durchschnittliche Körperanspannung
  double get avgBodyTension => throw _privateConstructorUsedError;

  /// Verbesserung durch Interventionen (Durchschnitt)
  double get avgImprovement => throw _privateConstructorUsedError;

  /// Häufigste Emotion (Top 1)
  EmotionType? get mostCommonEmotion => throw _privateConstructorUsedError;

  /// Häufigster Kontext (Top 1)
  ContextType? get mostCommonContext => throw _privateConstructorUsedError;

  /// Häufigster Systemzustand (Top 1)
  SystemState? get mostCommonState => throw _privateConstructorUsedError;

  /// Serializes this PatternSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PatternSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PatternSummaryCopyWith<PatternSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PatternSummaryCopyWith<$Res> {
  factory $PatternSummaryCopyWith(
          PatternSummary value, $Res Function(PatternSummary) then) =
      _$PatternSummaryCopyWithImpl<$Res, PatternSummary>;
  @useResult
  $Res call(
      {int totalEntries,
      DateTime startDate,
      DateTime endDate,
      Map<EmotionType, int> emotionFrequency,
      Map<ContextType, int> contextFrequency,
      Map<ImpulseType, int> impulseFrequency,
      Map<SystemState, int> systemStateFrequency,
      List<TrendDataPoint> intensityTrend,
      List<TrendDataPoint> tensionTrend,
      List<InterventionEffectiveness> mostEffectiveInterventions,
      List<TriggerPattern> commonTriggers,
      TimePatterns? timePatterns,
      double avgIntensity,
      double avgBodyTension,
      double avgImprovement,
      EmotionType? mostCommonEmotion,
      ContextType? mostCommonContext,
      SystemState? mostCommonState});

  $TimePatternsCopyWith<$Res>? get timePatterns;
}

/// @nodoc
class _$PatternSummaryCopyWithImpl<$Res, $Val extends PatternSummary>
    implements $PatternSummaryCopyWith<$Res> {
  _$PatternSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PatternSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalEntries = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? emotionFrequency = null,
    Object? contextFrequency = null,
    Object? impulseFrequency = null,
    Object? systemStateFrequency = null,
    Object? intensityTrend = null,
    Object? tensionTrend = null,
    Object? mostEffectiveInterventions = null,
    Object? commonTriggers = null,
    Object? timePatterns = freezed,
    Object? avgIntensity = null,
    Object? avgBodyTension = null,
    Object? avgImprovement = null,
    Object? mostCommonEmotion = freezed,
    Object? mostCommonContext = freezed,
    Object? mostCommonState = freezed,
  }) {
    return _then(_value.copyWith(
      totalEntries: null == totalEntries
          ? _value.totalEntries
          : totalEntries // ignore: cast_nullable_to_non_nullable
              as int,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      emotionFrequency: null == emotionFrequency
          ? _value.emotionFrequency
          : emotionFrequency // ignore: cast_nullable_to_non_nullable
              as Map<EmotionType, int>,
      contextFrequency: null == contextFrequency
          ? _value.contextFrequency
          : contextFrequency // ignore: cast_nullable_to_non_nullable
              as Map<ContextType, int>,
      impulseFrequency: null == impulseFrequency
          ? _value.impulseFrequency
          : impulseFrequency // ignore: cast_nullable_to_non_nullable
              as Map<ImpulseType, int>,
      systemStateFrequency: null == systemStateFrequency
          ? _value.systemStateFrequency
          : systemStateFrequency // ignore: cast_nullable_to_non_nullable
              as Map<SystemState, int>,
      intensityTrend: null == intensityTrend
          ? _value.intensityTrend
          : intensityTrend // ignore: cast_nullable_to_non_nullable
              as List<TrendDataPoint>,
      tensionTrend: null == tensionTrend
          ? _value.tensionTrend
          : tensionTrend // ignore: cast_nullable_to_non_nullable
              as List<TrendDataPoint>,
      mostEffectiveInterventions: null == mostEffectiveInterventions
          ? _value.mostEffectiveInterventions
          : mostEffectiveInterventions // ignore: cast_nullable_to_non_nullable
              as List<InterventionEffectiveness>,
      commonTriggers: null == commonTriggers
          ? _value.commonTriggers
          : commonTriggers // ignore: cast_nullable_to_non_nullable
              as List<TriggerPattern>,
      timePatterns: freezed == timePatterns
          ? _value.timePatterns
          : timePatterns // ignore: cast_nullable_to_non_nullable
              as TimePatterns?,
      avgIntensity: null == avgIntensity
          ? _value.avgIntensity
          : avgIntensity // ignore: cast_nullable_to_non_nullable
              as double,
      avgBodyTension: null == avgBodyTension
          ? _value.avgBodyTension
          : avgBodyTension // ignore: cast_nullable_to_non_nullable
              as double,
      avgImprovement: null == avgImprovement
          ? _value.avgImprovement
          : avgImprovement // ignore: cast_nullable_to_non_nullable
              as double,
      mostCommonEmotion: freezed == mostCommonEmotion
          ? _value.mostCommonEmotion
          : mostCommonEmotion // ignore: cast_nullable_to_non_nullable
              as EmotionType?,
      mostCommonContext: freezed == mostCommonContext
          ? _value.mostCommonContext
          : mostCommonContext // ignore: cast_nullable_to_non_nullable
              as ContextType?,
      mostCommonState: freezed == mostCommonState
          ? _value.mostCommonState
          : mostCommonState // ignore: cast_nullable_to_non_nullable
              as SystemState?,
    ) as $Val);
  }

  /// Create a copy of PatternSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TimePatternsCopyWith<$Res>? get timePatterns {
    if (_value.timePatterns == null) {
      return null;
    }

    return $TimePatternsCopyWith<$Res>(_value.timePatterns!, (value) {
      return _then(_value.copyWith(timePatterns: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PatternSummaryImplCopyWith<$Res>
    implements $PatternSummaryCopyWith<$Res> {
  factory _$$PatternSummaryImplCopyWith(_$PatternSummaryImpl value,
          $Res Function(_$PatternSummaryImpl) then) =
      __$$PatternSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalEntries,
      DateTime startDate,
      DateTime endDate,
      Map<EmotionType, int> emotionFrequency,
      Map<ContextType, int> contextFrequency,
      Map<ImpulseType, int> impulseFrequency,
      Map<SystemState, int> systemStateFrequency,
      List<TrendDataPoint> intensityTrend,
      List<TrendDataPoint> tensionTrend,
      List<InterventionEffectiveness> mostEffectiveInterventions,
      List<TriggerPattern> commonTriggers,
      TimePatterns? timePatterns,
      double avgIntensity,
      double avgBodyTension,
      double avgImprovement,
      EmotionType? mostCommonEmotion,
      ContextType? mostCommonContext,
      SystemState? mostCommonState});

  @override
  $TimePatternsCopyWith<$Res>? get timePatterns;
}

/// @nodoc
class __$$PatternSummaryImplCopyWithImpl<$Res>
    extends _$PatternSummaryCopyWithImpl<$Res, _$PatternSummaryImpl>
    implements _$$PatternSummaryImplCopyWith<$Res> {
  __$$PatternSummaryImplCopyWithImpl(
      _$PatternSummaryImpl _value, $Res Function(_$PatternSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatternSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalEntries = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? emotionFrequency = null,
    Object? contextFrequency = null,
    Object? impulseFrequency = null,
    Object? systemStateFrequency = null,
    Object? intensityTrend = null,
    Object? tensionTrend = null,
    Object? mostEffectiveInterventions = null,
    Object? commonTriggers = null,
    Object? timePatterns = freezed,
    Object? avgIntensity = null,
    Object? avgBodyTension = null,
    Object? avgImprovement = null,
    Object? mostCommonEmotion = freezed,
    Object? mostCommonContext = freezed,
    Object? mostCommonState = freezed,
  }) {
    return _then(_$PatternSummaryImpl(
      totalEntries: null == totalEntries
          ? _value.totalEntries
          : totalEntries // ignore: cast_nullable_to_non_nullable
              as int,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      emotionFrequency: null == emotionFrequency
          ? _value._emotionFrequency
          : emotionFrequency // ignore: cast_nullable_to_non_nullable
              as Map<EmotionType, int>,
      contextFrequency: null == contextFrequency
          ? _value._contextFrequency
          : contextFrequency // ignore: cast_nullable_to_non_nullable
              as Map<ContextType, int>,
      impulseFrequency: null == impulseFrequency
          ? _value._impulseFrequency
          : impulseFrequency // ignore: cast_nullable_to_non_nullable
              as Map<ImpulseType, int>,
      systemStateFrequency: null == systemStateFrequency
          ? _value._systemStateFrequency
          : systemStateFrequency // ignore: cast_nullable_to_non_nullable
              as Map<SystemState, int>,
      intensityTrend: null == intensityTrend
          ? _value._intensityTrend
          : intensityTrend // ignore: cast_nullable_to_non_nullable
              as List<TrendDataPoint>,
      tensionTrend: null == tensionTrend
          ? _value._tensionTrend
          : tensionTrend // ignore: cast_nullable_to_non_nullable
              as List<TrendDataPoint>,
      mostEffectiveInterventions: null == mostEffectiveInterventions
          ? _value._mostEffectiveInterventions
          : mostEffectiveInterventions // ignore: cast_nullable_to_non_nullable
              as List<InterventionEffectiveness>,
      commonTriggers: null == commonTriggers
          ? _value._commonTriggers
          : commonTriggers // ignore: cast_nullable_to_non_nullable
              as List<TriggerPattern>,
      timePatterns: freezed == timePatterns
          ? _value.timePatterns
          : timePatterns // ignore: cast_nullable_to_non_nullable
              as TimePatterns?,
      avgIntensity: null == avgIntensity
          ? _value.avgIntensity
          : avgIntensity // ignore: cast_nullable_to_non_nullable
              as double,
      avgBodyTension: null == avgBodyTension
          ? _value.avgBodyTension
          : avgBodyTension // ignore: cast_nullable_to_non_nullable
              as double,
      avgImprovement: null == avgImprovement
          ? _value.avgImprovement
          : avgImprovement // ignore: cast_nullable_to_non_nullable
              as double,
      mostCommonEmotion: freezed == mostCommonEmotion
          ? _value.mostCommonEmotion
          : mostCommonEmotion // ignore: cast_nullable_to_non_nullable
              as EmotionType?,
      mostCommonContext: freezed == mostCommonContext
          ? _value.mostCommonContext
          : mostCommonContext // ignore: cast_nullable_to_non_nullable
              as ContextType?,
      mostCommonState: freezed == mostCommonState
          ? _value.mostCommonState
          : mostCommonState // ignore: cast_nullable_to_non_nullable
              as SystemState?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PatternSummaryImpl implements _PatternSummary {
  const _$PatternSummaryImpl(
      {required this.totalEntries,
      required this.startDate,
      required this.endDate,
      required final Map<EmotionType, int> emotionFrequency,
      required final Map<ContextType, int> contextFrequency,
      required final Map<ImpulseType, int> impulseFrequency,
      required final Map<SystemState, int> systemStateFrequency,
      required final List<TrendDataPoint> intensityTrend,
      required final List<TrendDataPoint> tensionTrend,
      required final List<InterventionEffectiveness> mostEffectiveInterventions,
      required final List<TriggerPattern> commonTriggers,
      this.timePatterns,
      required this.avgIntensity,
      required this.avgBodyTension,
      required this.avgImprovement,
      this.mostCommonEmotion,
      this.mostCommonContext,
      this.mostCommonState})
      : _emotionFrequency = emotionFrequency,
        _contextFrequency = contextFrequency,
        _impulseFrequency = impulseFrequency,
        _systemStateFrequency = systemStateFrequency,
        _intensityTrend = intensityTrend,
        _tensionTrend = tensionTrend,
        _mostEffectiveInterventions = mostEffectiveInterventions,
        _commonTriggers = commonTriggers;

  factory _$PatternSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$PatternSummaryImplFromJson(json);

  /// Gesamtanzahl der analysierten Einträge
  @override
  final int totalEntries;

  /// Zeitspanne der Analyse
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;

  /// Emotions-Häufigkeit
  final Map<EmotionType, int> _emotionFrequency;

  /// Emotions-Häufigkeit
  @override
  Map<EmotionType, int> get emotionFrequency {
    if (_emotionFrequency is EqualUnmodifiableMapView) return _emotionFrequency;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_emotionFrequency);
  }

  /// Kontext-Häufigkeit
  final Map<ContextType, int> _contextFrequency;

  /// Kontext-Häufigkeit
  @override
  Map<ContextType, int> get contextFrequency {
    if (_contextFrequency is EqualUnmodifiableMapView) return _contextFrequency;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_contextFrequency);
  }

  /// Impuls-Häufigkeit
  final Map<ImpulseType, int> _impulseFrequency;

  /// Impuls-Häufigkeit
  @override
  Map<ImpulseType, int> get impulseFrequency {
    if (_impulseFrequency is EqualUnmodifiableMapView) return _impulseFrequency;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_impulseFrequency);
  }

  /// Systemzustand-Häufigkeit
  final Map<SystemState, int> _systemStateFrequency;

  /// Systemzustand-Häufigkeit
  @override
  Map<SystemState, int> get systemStateFrequency {
    if (_systemStateFrequency is EqualUnmodifiableMapView)
      return _systemStateFrequency;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_systemStateFrequency);
  }

  /// Belastungs-Trend über Zeit
  final List<TrendDataPoint> _intensityTrend;

  /// Belastungs-Trend über Zeit
  @override
  List<TrendDataPoint> get intensityTrend {
    if (_intensityTrend is EqualUnmodifiableListView) return _intensityTrend;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_intensityTrend);
  }

  /// Körperanspannungs-Trend über Zeit
  final List<TrendDataPoint> _tensionTrend;

  /// Körperanspannungs-Trend über Zeit
  @override
  List<TrendDataPoint> get tensionTrend {
    if (_tensionTrend is EqualUnmodifiableListView) return _tensionTrend;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tensionTrend);
  }

  /// Effektivste Interventionen
  final List<InterventionEffectiveness> _mostEffectiveInterventions;

  /// Effektivste Interventionen
  @override
  List<InterventionEffectiveness> get mostEffectiveInterventions {
    if (_mostEffectiveInterventions is EqualUnmodifiableListView)
      return _mostEffectiveInterventions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mostEffectiveInterventions);
  }

  /// Häufigste Trigger-Muster
  final List<TriggerPattern> _commonTriggers;

  /// Häufigste Trigger-Muster
  @override
  List<TriggerPattern> get commonTriggers {
    if (_commonTriggers is EqualUnmodifiableListView) return _commonTriggers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_commonTriggers);
  }

  /// Zeitmuster
  @override
  final TimePatterns? timePatterns;

  /// Durchschnittliche Intensität
  @override
  final double avgIntensity;

  /// Durchschnittliche Körperanspannung
  @override
  final double avgBodyTension;

  /// Verbesserung durch Interventionen (Durchschnitt)
  @override
  final double avgImprovement;

  /// Häufigste Emotion (Top 1)
  @override
  final EmotionType? mostCommonEmotion;

  /// Häufigster Kontext (Top 1)
  @override
  final ContextType? mostCommonContext;

  /// Häufigster Systemzustand (Top 1)
  @override
  final SystemState? mostCommonState;

  @override
  String toString() {
    return 'PatternSummary(totalEntries: $totalEntries, startDate: $startDate, endDate: $endDate, emotionFrequency: $emotionFrequency, contextFrequency: $contextFrequency, impulseFrequency: $impulseFrequency, systemStateFrequency: $systemStateFrequency, intensityTrend: $intensityTrend, tensionTrend: $tensionTrend, mostEffectiveInterventions: $mostEffectiveInterventions, commonTriggers: $commonTriggers, timePatterns: $timePatterns, avgIntensity: $avgIntensity, avgBodyTension: $avgBodyTension, avgImprovement: $avgImprovement, mostCommonEmotion: $mostCommonEmotion, mostCommonContext: $mostCommonContext, mostCommonState: $mostCommonState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PatternSummaryImpl &&
            (identical(other.totalEntries, totalEntries) ||
                other.totalEntries == totalEntries) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            const DeepCollectionEquality()
                .equals(other._emotionFrequency, _emotionFrequency) &&
            const DeepCollectionEquality()
                .equals(other._contextFrequency, _contextFrequency) &&
            const DeepCollectionEquality()
                .equals(other._impulseFrequency, _impulseFrequency) &&
            const DeepCollectionEquality()
                .equals(other._systemStateFrequency, _systemStateFrequency) &&
            const DeepCollectionEquality()
                .equals(other._intensityTrend, _intensityTrend) &&
            const DeepCollectionEquality()
                .equals(other._tensionTrend, _tensionTrend) &&
            const DeepCollectionEquality().equals(
                other._mostEffectiveInterventions,
                _mostEffectiveInterventions) &&
            const DeepCollectionEquality()
                .equals(other._commonTriggers, _commonTriggers) &&
            (identical(other.timePatterns, timePatterns) ||
                other.timePatterns == timePatterns) &&
            (identical(other.avgIntensity, avgIntensity) ||
                other.avgIntensity == avgIntensity) &&
            (identical(other.avgBodyTension, avgBodyTension) ||
                other.avgBodyTension == avgBodyTension) &&
            (identical(other.avgImprovement, avgImprovement) ||
                other.avgImprovement == avgImprovement) &&
            (identical(other.mostCommonEmotion, mostCommonEmotion) ||
                other.mostCommonEmotion == mostCommonEmotion) &&
            (identical(other.mostCommonContext, mostCommonContext) ||
                other.mostCommonContext == mostCommonContext) &&
            (identical(other.mostCommonState, mostCommonState) ||
                other.mostCommonState == mostCommonState));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalEntries,
      startDate,
      endDate,
      const DeepCollectionEquality().hash(_emotionFrequency),
      const DeepCollectionEquality().hash(_contextFrequency),
      const DeepCollectionEquality().hash(_impulseFrequency),
      const DeepCollectionEquality().hash(_systemStateFrequency),
      const DeepCollectionEquality().hash(_intensityTrend),
      const DeepCollectionEquality().hash(_tensionTrend),
      const DeepCollectionEquality().hash(_mostEffectiveInterventions),
      const DeepCollectionEquality().hash(_commonTriggers),
      timePatterns,
      avgIntensity,
      avgBodyTension,
      avgImprovement,
      mostCommonEmotion,
      mostCommonContext,
      mostCommonState);

  /// Create a copy of PatternSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PatternSummaryImplCopyWith<_$PatternSummaryImpl> get copyWith =>
      __$$PatternSummaryImplCopyWithImpl<_$PatternSummaryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PatternSummaryImplToJson(
      this,
    );
  }
}

abstract class _PatternSummary implements PatternSummary {
  const factory _PatternSummary(
      {required final int totalEntries,
      required final DateTime startDate,
      required final DateTime endDate,
      required final Map<EmotionType, int> emotionFrequency,
      required final Map<ContextType, int> contextFrequency,
      required final Map<ImpulseType, int> impulseFrequency,
      required final Map<SystemState, int> systemStateFrequency,
      required final List<TrendDataPoint> intensityTrend,
      required final List<TrendDataPoint> tensionTrend,
      required final List<InterventionEffectiveness> mostEffectiveInterventions,
      required final List<TriggerPattern> commonTriggers,
      final TimePatterns? timePatterns,
      required final double avgIntensity,
      required final double avgBodyTension,
      required final double avgImprovement,
      final EmotionType? mostCommonEmotion,
      final ContextType? mostCommonContext,
      final SystemState? mostCommonState}) = _$PatternSummaryImpl;

  factory _PatternSummary.fromJson(Map<String, dynamic> json) =
      _$PatternSummaryImpl.fromJson;

  /// Gesamtanzahl der analysierten Einträge
  @override
  int get totalEntries;

  /// Zeitspanne der Analyse
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;

  /// Emotions-Häufigkeit
  @override
  Map<EmotionType, int> get emotionFrequency;

  /// Kontext-Häufigkeit
  @override
  Map<ContextType, int> get contextFrequency;

  /// Impuls-Häufigkeit
  @override
  Map<ImpulseType, int> get impulseFrequency;

  /// Systemzustand-Häufigkeit
  @override
  Map<SystemState, int> get systemStateFrequency;

  /// Belastungs-Trend über Zeit
  @override
  List<TrendDataPoint> get intensityTrend;

  /// Körperanspannungs-Trend über Zeit
  @override
  List<TrendDataPoint> get tensionTrend;

  /// Effektivste Interventionen
  @override
  List<InterventionEffectiveness> get mostEffectiveInterventions;

  /// Häufigste Trigger-Muster
  @override
  List<TriggerPattern> get commonTriggers;

  /// Zeitmuster
  @override
  TimePatterns? get timePatterns;

  /// Durchschnittliche Intensität
  @override
  double get avgIntensity;

  /// Durchschnittliche Körperanspannung
  @override
  double get avgBodyTension;

  /// Verbesserung durch Interventionen (Durchschnitt)
  @override
  double get avgImprovement;

  /// Häufigste Emotion (Top 1)
  @override
  EmotionType? get mostCommonEmotion;

  /// Häufigster Kontext (Top 1)
  @override
  ContextType? get mostCommonContext;

  /// Häufigster Systemzustand (Top 1)
  @override
  SystemState? get mostCommonState;

  /// Create a copy of PatternSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PatternSummaryImplCopyWith<_$PatternSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HistoryFilter _$HistoryFilterFromJson(Map<String, dynamic> json) {
  return _HistoryFilter.fromJson(json);
}

/// @nodoc
mixin _$HistoryFilter {
  /// Zeitraum-Filter
  DateRangeFilter? get dateRange => throw _privateConstructorUsedError;

  /// Emotionen-Filter
  List<EmotionType>? get emotions => throw _privateConstructorUsedError;

  /// Kontext-Filter
  List<ContextType>? get contexts => throw _privateConstructorUsedError;

  /// Systemzustand-Filter
  List<SystemState>? get systemStates => throw _privateConstructorUsedError;

  /// Nur Einträge mit Intervention?
  bool? get withInterventionOnly => throw _privateConstructorUsedError;

  /// Nur Einträge mit Krisen-Flag?
  bool? get crisisOnly => throw _privateConstructorUsedError;

  /// Suchtext (in Beschreibung/Gedanke)
  String? get searchText => throw _privateConstructorUsedError;

  /// Serializes this HistoryFilter to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HistoryFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HistoryFilterCopyWith<HistoryFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistoryFilterCopyWith<$Res> {
  factory $HistoryFilterCopyWith(
          HistoryFilter value, $Res Function(HistoryFilter) then) =
      _$HistoryFilterCopyWithImpl<$Res, HistoryFilter>;
  @useResult
  $Res call(
      {DateRangeFilter? dateRange,
      List<EmotionType>? emotions,
      List<ContextType>? contexts,
      List<SystemState>? systemStates,
      bool? withInterventionOnly,
      bool? crisisOnly,
      String? searchText});
}

/// @nodoc
class _$HistoryFilterCopyWithImpl<$Res, $Val extends HistoryFilter>
    implements $HistoryFilterCopyWith<$Res> {
  _$HistoryFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HistoryFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateRange = freezed,
    Object? emotions = freezed,
    Object? contexts = freezed,
    Object? systemStates = freezed,
    Object? withInterventionOnly = freezed,
    Object? crisisOnly = freezed,
    Object? searchText = freezed,
  }) {
    return _then(_value.copyWith(
      dateRange: freezed == dateRange
          ? _value.dateRange
          : dateRange // ignore: cast_nullable_to_non_nullable
              as DateRangeFilter?,
      emotions: freezed == emotions
          ? _value.emotions
          : emotions // ignore: cast_nullable_to_non_nullable
              as List<EmotionType>?,
      contexts: freezed == contexts
          ? _value.contexts
          : contexts // ignore: cast_nullable_to_non_nullable
              as List<ContextType>?,
      systemStates: freezed == systemStates
          ? _value.systemStates
          : systemStates // ignore: cast_nullable_to_non_nullable
              as List<SystemState>?,
      withInterventionOnly: freezed == withInterventionOnly
          ? _value.withInterventionOnly
          : withInterventionOnly // ignore: cast_nullable_to_non_nullable
              as bool?,
      crisisOnly: freezed == crisisOnly
          ? _value.crisisOnly
          : crisisOnly // ignore: cast_nullable_to_non_nullable
              as bool?,
      searchText: freezed == searchText
          ? _value.searchText
          : searchText // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HistoryFilterImplCopyWith<$Res>
    implements $HistoryFilterCopyWith<$Res> {
  factory _$$HistoryFilterImplCopyWith(
          _$HistoryFilterImpl value, $Res Function(_$HistoryFilterImpl) then) =
      __$$HistoryFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateRangeFilter? dateRange,
      List<EmotionType>? emotions,
      List<ContextType>? contexts,
      List<SystemState>? systemStates,
      bool? withInterventionOnly,
      bool? crisisOnly,
      String? searchText});
}

/// @nodoc
class __$$HistoryFilterImplCopyWithImpl<$Res>
    extends _$HistoryFilterCopyWithImpl<$Res, _$HistoryFilterImpl>
    implements _$$HistoryFilterImplCopyWith<$Res> {
  __$$HistoryFilterImplCopyWithImpl(
      _$HistoryFilterImpl _value, $Res Function(_$HistoryFilterImpl) _then)
      : super(_value, _then);

  /// Create a copy of HistoryFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateRange = freezed,
    Object? emotions = freezed,
    Object? contexts = freezed,
    Object? systemStates = freezed,
    Object? withInterventionOnly = freezed,
    Object? crisisOnly = freezed,
    Object? searchText = freezed,
  }) {
    return _then(_$HistoryFilterImpl(
      dateRange: freezed == dateRange
          ? _value.dateRange
          : dateRange // ignore: cast_nullable_to_non_nullable
              as DateRangeFilter?,
      emotions: freezed == emotions
          ? _value._emotions
          : emotions // ignore: cast_nullable_to_non_nullable
              as List<EmotionType>?,
      contexts: freezed == contexts
          ? _value._contexts
          : contexts // ignore: cast_nullable_to_non_nullable
              as List<ContextType>?,
      systemStates: freezed == systemStates
          ? _value._systemStates
          : systemStates // ignore: cast_nullable_to_non_nullable
              as List<SystemState>?,
      withInterventionOnly: freezed == withInterventionOnly
          ? _value.withInterventionOnly
          : withInterventionOnly // ignore: cast_nullable_to_non_nullable
              as bool?,
      crisisOnly: freezed == crisisOnly
          ? _value.crisisOnly
          : crisisOnly // ignore: cast_nullable_to_non_nullable
              as bool?,
      searchText: freezed == searchText
          ? _value.searchText
          : searchText // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HistoryFilterImpl implements _HistoryFilter {
  const _$HistoryFilterImpl(
      {this.dateRange,
      final List<EmotionType>? emotions,
      final List<ContextType>? contexts,
      final List<SystemState>? systemStates,
      this.withInterventionOnly,
      this.crisisOnly,
      this.searchText})
      : _emotions = emotions,
        _contexts = contexts,
        _systemStates = systemStates;

  factory _$HistoryFilterImpl.fromJson(Map<String, dynamic> json) =>
      _$$HistoryFilterImplFromJson(json);

  /// Zeitraum-Filter
  @override
  final DateRangeFilter? dateRange;

  /// Emotionen-Filter
  final List<EmotionType>? _emotions;

  /// Emotionen-Filter
  @override
  List<EmotionType>? get emotions {
    final value = _emotions;
    if (value == null) return null;
    if (_emotions is EqualUnmodifiableListView) return _emotions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Kontext-Filter
  final List<ContextType>? _contexts;

  /// Kontext-Filter
  @override
  List<ContextType>? get contexts {
    final value = _contexts;
    if (value == null) return null;
    if (_contexts is EqualUnmodifiableListView) return _contexts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Systemzustand-Filter
  final List<SystemState>? _systemStates;

  /// Systemzustand-Filter
  @override
  List<SystemState>? get systemStates {
    final value = _systemStates;
    if (value == null) return null;
    if (_systemStates is EqualUnmodifiableListView) return _systemStates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Nur Einträge mit Intervention?
  @override
  final bool? withInterventionOnly;

  /// Nur Einträge mit Krisen-Flag?
  @override
  final bool? crisisOnly;

  /// Suchtext (in Beschreibung/Gedanke)
  @override
  final String? searchText;

  @override
  String toString() {
    return 'HistoryFilter(dateRange: $dateRange, emotions: $emotions, contexts: $contexts, systemStates: $systemStates, withInterventionOnly: $withInterventionOnly, crisisOnly: $crisisOnly, searchText: $searchText)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HistoryFilterImpl &&
            (identical(other.dateRange, dateRange) ||
                other.dateRange == dateRange) &&
            const DeepCollectionEquality().equals(other._emotions, _emotions) &&
            const DeepCollectionEquality().equals(other._contexts, _contexts) &&
            const DeepCollectionEquality()
                .equals(other._systemStates, _systemStates) &&
            (identical(other.withInterventionOnly, withInterventionOnly) ||
                other.withInterventionOnly == withInterventionOnly) &&
            (identical(other.crisisOnly, crisisOnly) ||
                other.crisisOnly == crisisOnly) &&
            (identical(other.searchText, searchText) ||
                other.searchText == searchText));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      dateRange,
      const DeepCollectionEquality().hash(_emotions),
      const DeepCollectionEquality().hash(_contexts),
      const DeepCollectionEquality().hash(_systemStates),
      withInterventionOnly,
      crisisOnly,
      searchText);

  /// Create a copy of HistoryFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HistoryFilterImplCopyWith<_$HistoryFilterImpl> get copyWith =>
      __$$HistoryFilterImplCopyWithImpl<_$HistoryFilterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HistoryFilterImplToJson(
      this,
    );
  }
}

abstract class _HistoryFilter implements HistoryFilter {
  const factory _HistoryFilter(
      {final DateRangeFilter? dateRange,
      final List<EmotionType>? emotions,
      final List<ContextType>? contexts,
      final List<SystemState>? systemStates,
      final bool? withInterventionOnly,
      final bool? crisisOnly,
      final String? searchText}) = _$HistoryFilterImpl;

  factory _HistoryFilter.fromJson(Map<String, dynamic> json) =
      _$HistoryFilterImpl.fromJson;

  /// Zeitraum-Filter
  @override
  DateRangeFilter? get dateRange;

  /// Emotionen-Filter
  @override
  List<EmotionType>? get emotions;

  /// Kontext-Filter
  @override
  List<ContextType>? get contexts;

  /// Systemzustand-Filter
  @override
  List<SystemState>? get systemStates;

  /// Nur Einträge mit Intervention?
  @override
  bool? get withInterventionOnly;

  /// Nur Einträge mit Krisen-Flag?
  @override
  bool? get crisisOnly;

  /// Suchtext (in Beschreibung/Gedanke)
  @override
  String? get searchText;

  /// Create a copy of HistoryFilter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HistoryFilterImplCopyWith<_$HistoryFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
