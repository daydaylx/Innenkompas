// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intervention_step.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InterventionStepImpl _$$InterventionStepImplFromJson(
        Map<String, dynamic> json) =>
    _$InterventionStepImpl(
      id: json['id'] as String,
      type: $enumDecode(_$InterventionStepTypeEnumMap, json['type']),
      title: json['title'] as String,
      body: json['body'] as String,
      durationSec: (json['durationSec'] as num?)?.toInt(),
      options:
          (json['options'] as List<dynamic>?)?.map((e) => e as String).toList(),
      metadata: json['metadata'] as Map<String, dynamic>?,
      subtitle: json['subtitle'] as String?,
      helpText: json['helpText'] as String?,
    );

Map<String, dynamic> _$$InterventionStepImplToJson(
        _$InterventionStepImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$InterventionStepTypeEnumMap[instance.type]!,
      'title': instance.title,
      'body': instance.body,
      'durationSec': instance.durationSec,
      'options': instance.options,
      'metadata': instance.metadata,
      'subtitle': instance.subtitle,
      'helpText': instance.helpText,
    };

const _$InterventionStepTypeEnumMap = {
  InterventionStepType.text: 'text',
  InterventionStepType.breathing: 'breathing',
  InterventionStepType.timer: 'timer',
  InterventionStepType.reflection: 'reflection',
  InterventionStepType.selection: 'selection',
  InterventionStepType.action: 'action',
  InterventionStepType.factCheck: 'factCheck',
  InterventionStepType.rating: 'rating',
};

_$InterventionStepResponseImpl _$$InterventionStepResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$InterventionStepResponseImpl(
      stepId: json['stepId'] as String,
      type: $enumDecode(_$InterventionStepTypeEnumMap, json['type']),
      textResponse: json['textResponse'] as String?,
      selectionResponse: json['selectionResponse'] as String?,
      ratingResponse: (json['ratingResponse'] as num?)?.toInt(),
      boolResponse: json['boolResponse'] as bool?,
      actualDurationSec: (json['actualDurationSec'] as num?)?.toInt(),
      answeredAt: DateTime.parse(json['answeredAt'] as String),
    );

Map<String, dynamic> _$$InterventionStepResponseImplToJson(
        _$InterventionStepResponseImpl instance) =>
    <String, dynamic>{
      'stepId': instance.stepId,
      'type': _$InterventionStepTypeEnumMap[instance.type]!,
      'textResponse': instance.textResponse,
      'selectionResponse': instance.selectionResponse,
      'ratingResponse': instance.ratingResponse,
      'boolResponse': instance.boolResponse,
      'actualDurationSec': instance.actualDurationSec,
      'answeredAt': instance.answeredAt.toIso8601String(),
    };
