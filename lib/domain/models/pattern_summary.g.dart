// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pattern_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FrequencyEntryImpl _$$FrequencyEntryImplFromJson(Map<String, dynamic> json) =>
    _$FrequencyEntryImpl(
      label: json['label'] as String,
      count: (json['count'] as num).toInt(),
      percentage: (json['percentage'] as num).toDouble(),
      emoji: json['emoji'] as String?,
    );

Map<String, dynamic> _$$FrequencyEntryImplToJson(
        _$FrequencyEntryImpl instance) =>
    <String, dynamic>{
      'label': instance.label,
      'count': instance.count,
      'percentage': instance.percentage,
      'emoji': instance.emoji,
    };

_$TrendDataPointImpl _$$TrendDataPointImplFromJson(Map<String, dynamic> json) =>
    _$TrendDataPointImpl(
      date: DateTime.parse(json['date'] as String),
      value: (json['value'] as num).toDouble(),
      secondaryValue: (json['secondaryValue'] as num?)?.toDouble(),
      entryCount: (json['entryCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$TrendDataPointImplToJson(
        _$TrendDataPointImpl instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'value': instance.value,
      'secondaryValue': instance.secondaryValue,
      'entryCount': instance.entryCount,
    };

_$TriggerPatternImpl _$$TriggerPatternImplFromJson(Map<String, dynamic> json) =>
    _$TriggerPatternImpl(
      context: $enumDecode(_$ContextTypeEnumMap, json['context']),
      emotion: $enumDecode(_$EmotionTypeEnumMap, json['emotion']),
      avgIntensity: (json['avgIntensity'] as num).toDouble(),
      occurrenceCount: (json['occurrenceCount'] as num).toInt(),
      commonImpulse:
          $enumDecodeNullable(_$ImpulseTypeEnumMap, json['commonImpulse']),
      commonState:
          $enumDecodeNullable(_$SystemStateEnumMap, json['commonState']),
    );

Map<String, dynamic> _$$TriggerPatternImplToJson(
        _$TriggerPatternImpl instance) =>
    <String, dynamic>{
      'context': _$ContextTypeEnumMap[instance.context]!,
      'emotion': _$EmotionTypeEnumMap[instance.emotion]!,
      'avgIntensity': instance.avgIntensity,
      'occurrenceCount': instance.occurrenceCount,
      'commonImpulse': _$ImpulseTypeEnumMap[instance.commonImpulse],
      'commonState': _$SystemStateEnumMap[instance.commonState],
    };

const _$ContextTypeEnumMap = {
  ContextType.work: 'work',
  ContextType.family: 'family',
  ContextType.partnership: 'partnership',
  ContextType.friends: 'friends',
  ContextType.health: 'health',
  ContextType.finances: 'finances',
  ContextType.leisure: 'leisure',
  ContextType.solitude: 'solitude',
  ContextType.other: 'other',
};

const _$EmotionTypeEnumMap = {
  EmotionType.anger: 'anger',
  EmotionType.fear: 'fear',
  EmotionType.sadness: 'sadness',
  EmotionType.shame: 'shame',
  EmotionType.joy: 'joy',
  EmotionType.disgust: 'disgust',
  EmotionType.surprise: 'surprise',
  EmotionType.guilt: 'guilt',
  EmotionType.pride: 'pride',
  EmotionType.loneliness: 'loneliness',
};

const _$ImpulseTypeEnumMap = {
  ImpulseType.counter: 'counter',
  ImpulseType.flee: 'flee',
  ImpulseType.ruminate: 'ruminate',
  ImpulseType.comply: 'comply',
  ImpulseType.freeze: 'freeze',
  ImpulseType.control: 'control',
  ImpulseType.withdraw: 'withdraw',
  ImpulseType.selfCriticism: 'selfCriticism',
  ImpulseType.perfectionism: 'perfectionism',
  ImpulseType.immediateAction: 'immediateAction',
  ImpulseType.distraction: 'distraction',
  ImpulseType.seekHelp: 'seekHelp',
};

const _$SystemStateEnumMap = {
  SystemState.acuteActivation: 'acuteActivation',
  SystemState.reflectiveReady: 'reflectiveReady',
  SystemState.rumination: 'rumination',
  SystemState.conflict: 'conflict',
  SystemState.selfDevaluation: 'selfDevaluation',
  SystemState.overwhelm: 'overwhelm',
  SystemState.crisis: 'crisis',
};

_$TimePatternsImpl _$$TimePatternsImplFromJson(Map<String, dynamic> json) =>
    _$TimePatternsImpl(
      weekdayDistribution: (json['weekdayDistribution'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      timeOfDayDistribution:
          Map<String, int>.from(json['timeOfDayDistribution'] as Map),
      avgIntensityByWeekday: (json['avgIntensityByWeekday'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      mostStressfulWeekday: (json['mostStressfulWeekday'] as num).toInt(),
    );

Map<String, dynamic> _$$TimePatternsImplToJson(_$TimePatternsImpl instance) =>
    <String, dynamic>{
      'weekdayDistribution': instance.weekdayDistribution,
      'timeOfDayDistribution': instance.timeOfDayDistribution,
      'avgIntensityByWeekday': instance.avgIntensityByWeekday,
      'mostStressfulWeekday': instance.mostStressfulWeekday,
    };

_$PatternSummaryImpl _$$PatternSummaryImplFromJson(Map<String, dynamic> json) =>
    _$PatternSummaryImpl(
      totalEntries: (json['totalEntries'] as num).toInt(),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      emotionFrequency: (json['emotionFrequency'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry($enumDecode(_$EmotionTypeEnumMap, k), (e as num).toInt()),
      ),
      contextFrequency: (json['contextFrequency'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry($enumDecode(_$ContextTypeEnumMap, k), (e as num).toInt()),
      ),
      impulseFrequency: (json['impulseFrequency'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry($enumDecode(_$ImpulseTypeEnumMap, k), (e as num).toInt()),
      ),
      systemStateFrequency:
          (json['systemStateFrequency'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry($enumDecode(_$SystemStateEnumMap, k), (e as num).toInt()),
      ),
      intensityTrend: (json['intensityTrend'] as List<dynamic>)
          .map((e) => TrendDataPoint.fromJson(e as Map<String, dynamic>))
          .toList(),
      tensionTrend: (json['tensionTrend'] as List<dynamic>)
          .map((e) => TrendDataPoint.fromJson(e as Map<String, dynamic>))
          .toList(),
      mostEffectiveInterventions:
          (json['mostEffectiveInterventions'] as List<dynamic>)
              .map((e) =>
                  InterventionEffectiveness.fromJson(e as Map<String, dynamic>))
              .toList(),
      commonTriggers: (json['commonTriggers'] as List<dynamic>)
          .map((e) => TriggerPattern.fromJson(e as Map<String, dynamic>))
          .toList(),
      timePatterns: json['timePatterns'] == null
          ? null
          : TimePatterns.fromJson(json['timePatterns'] as Map<String, dynamic>),
      avgIntensity: (json['avgIntensity'] as num).toDouble(),
      avgBodyTension: (json['avgBodyTension'] as num).toDouble(),
      avgImprovement: (json['avgImprovement'] as num).toDouble(),
      mostCommonEmotion:
          $enumDecodeNullable(_$EmotionTypeEnumMap, json['mostCommonEmotion']),
      mostCommonContext:
          $enumDecodeNullable(_$ContextTypeEnumMap, json['mostCommonContext']),
      mostCommonState:
          $enumDecodeNullable(_$SystemStateEnumMap, json['mostCommonState']),
    );

Map<String, dynamic> _$$PatternSummaryImplToJson(
        _$PatternSummaryImpl instance) =>
    <String, dynamic>{
      'totalEntries': instance.totalEntries,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'emotionFrequency': instance.emotionFrequency
          .map((k, e) => MapEntry(_$EmotionTypeEnumMap[k]!, e)),
      'contextFrequency': instance.contextFrequency
          .map((k, e) => MapEntry(_$ContextTypeEnumMap[k]!, e)),
      'impulseFrequency': instance.impulseFrequency
          .map((k, e) => MapEntry(_$ImpulseTypeEnumMap[k]!, e)),
      'systemStateFrequency': instance.systemStateFrequency
          .map((k, e) => MapEntry(_$SystemStateEnumMap[k]!, e)),
      'intensityTrend': instance.intensityTrend,
      'tensionTrend': instance.tensionTrend,
      'mostEffectiveInterventions': instance.mostEffectiveInterventions,
      'commonTriggers': instance.commonTriggers,
      'timePatterns': instance.timePatterns,
      'avgIntensity': instance.avgIntensity,
      'avgBodyTension': instance.avgBodyTension,
      'avgImprovement': instance.avgImprovement,
      'mostCommonEmotion': _$EmotionTypeEnumMap[instance.mostCommonEmotion],
      'mostCommonContext': _$ContextTypeEnumMap[instance.mostCommonContext],
      'mostCommonState': _$SystemStateEnumMap[instance.mostCommonState],
    };

_$HistoryFilterImpl _$$HistoryFilterImplFromJson(Map<String, dynamic> json) =>
    _$HistoryFilterImpl(
      dateRange:
          $enumDecodeNullable(_$DateRangeFilterEnumMap, json['dateRange']),
      emotions: (json['emotions'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$EmotionTypeEnumMap, e))
          .toList(),
      contexts: (json['contexts'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$ContextTypeEnumMap, e))
          .toList(),
      systemStates: (json['systemStates'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$SystemStateEnumMap, e))
          .toList(),
      withInterventionOnly: json['withInterventionOnly'] as bool?,
      crisisOnly: json['crisisOnly'] as bool?,
      searchText: json['searchText'] as String?,
    );

Map<String, dynamic> _$$HistoryFilterImplToJson(_$HistoryFilterImpl instance) =>
    <String, dynamic>{
      'dateRange': _$DateRangeFilterEnumMap[instance.dateRange],
      'emotions':
          instance.emotions?.map((e) => _$EmotionTypeEnumMap[e]!).toList(),
      'contexts':
          instance.contexts?.map((e) => _$ContextTypeEnumMap[e]!).toList(),
      'systemStates':
          instance.systemStates?.map((e) => _$SystemStateEnumMap[e]!).toList(),
      'withInterventionOnly': instance.withInterventionOnly,
      'crisisOnly': instance.crisisOnly,
      'searchText': instance.searchText,
    };

const _$DateRangeFilterEnumMap = {
  DateRangeFilter.letzte7Tage: 'letzte7Tage',
  DateRangeFilter.letzte30Tage: 'letzte30Tage',
  DateRangeFilter.letzte90Tage: 'letzte90Tage',
  DateRangeFilter.alle: 'alle',
  DateRangeFilter.benutzerdefiniert: 'benutzerdefiniert',
};
