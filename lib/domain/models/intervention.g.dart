// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intervention.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InterventionImpl _$$InterventionImplFromJson(Map<String, dynamic> json) =>
    _$InterventionImpl(
      id: json['id'] as String,
      type: $enumDecode(_$InterventionTypeEnumMap, json['type']),
      title: json['title'] as String,
      summary: json['summary'] as String,
      description: json['description'] as String,
      steps: (json['steps'] as List<dynamic>)
          .map((e) => InterventionStep.fromJson(e as Map<String, dynamic>))
          .toList(),
      estimatedDurationSec: (json['estimatedDurationSec'] as num).toInt(),
      recommendedForStates: (json['recommendedForStates'] as List<dynamic>)
          .map((e) => $enumDecode(_$SystemStateEnumMap, e))
          .toList(),
      recommendedForEmotions: (json['recommendedForEmotions'] as List<dynamic>)
          .map((e) => $enumDecode(_$EmotionTypeEnumMap, e))
          .toList(),
      minIntensity: (json['minIntensity'] as num?)?.toInt(),
      maxIntensity: (json['maxIntensity'] as num?)?.toInt(),
      icon: json['icon'] as String?,
      category: json['category'] as String?,
      difficultyLevel: (json['difficultyLevel'] as num?)?.toInt(),
      licenseTag: $enumDecode(_$ContentLicenseTagEnumMap, json['licenseTag']),
      licenseNotes: json['licenseNotes'] as String?,
    );

Map<String, dynamic> _$$InterventionImplToJson(_$InterventionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$InterventionTypeEnumMap[instance.type]!,
      'title': instance.title,
      'summary': instance.summary,
      'description': instance.description,
      'steps': instance.steps,
      'estimatedDurationSec': instance.estimatedDurationSec,
      'recommendedForStates': instance.recommendedForStates
          .map((e) => _$SystemStateEnumMap[e]!)
          .toList(),
      'recommendedForEmotions': instance.recommendedForEmotions
          .map((e) => _$EmotionTypeEnumMap[e]!)
          .toList(),
      'minIntensity': instance.minIntensity,
      'maxIntensity': instance.maxIntensity,
      'icon': instance.icon,
      'category': instance.category,
      'difficultyLevel': instance.difficultyLevel,
      'licenseTag': _$ContentLicenseTagEnumMap[instance.licenseTag]!,
      'licenseNotes': instance.licenseNotes,
    };

const _$InterventionTypeEnumMap = {
  InterventionType.regulation: 'regulation',
  InterventionType.factCheck: 'factCheck',
  InterventionType.impulsePause: 'impulsePause',
  InterventionType.ruminationStop: 'ruminationStop',
  InterventionType.communication: 'communication',
  InterventionType.overwhelmStructure: 'overwhelmStructure',
  InterventionType.selfValueCheck: 'selfValueCheck',
  InterventionType.abc3: 'abc3',
  InterventionType.rsaAbcde: 'rsaAbcde',
};

const _$SystemStateEnumMap = {
  SystemState.acuteActivation: 'acuteActivation',
  SystemState.reflectiveReady: 'reflectiveReady',
  SystemState.interpretation: 'interpretation',
  SystemState.rumination: 'rumination',
  SystemState.conflict: 'conflict',
  SystemState.selfDevaluation: 'selfDevaluation',
  SystemState.overwhelm: 'overwhelm',
  SystemState.crisis: 'crisis',
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

const _$ContentLicenseTagEnumMap = {
  ContentLicenseTag.originalInspiredNoCopy: 'original-inspired-no-copy',
  ContentLicenseTag.licenseRequired: 'license-required',
  ContentLicenseTag.licensedKohlhammer: 'licensed-kohlhammer',
  ContentLicenseTag.licensedHogrefe: 'licensed-hogrefe',
  ContentLicenseTag.licensedOup: 'licensed-oup',
  ContentLicenseTag.publicDomain: 'public-domain',
};

_$InterventionResultImpl _$$InterventionResultImplFromJson(
        Map<String, dynamic> json) =>
    _$InterventionResultImpl(
      interventionId: json['interventionId'] as String,
      title: json['title'] as String,
      type: $enumDecode(_$InterventionTypeEnumMap, json['type']),
      startedAt: DateTime.parse(json['startedAt'] as String),
      completedAt: DateTime.parse(json['completedAt'] as String),
      actualDurationSec: (json['actualDurationSec'] as num).toInt(),
      stepResponses: (json['stepResponses'] as List<dynamic>)
          .map((e) =>
              InterventionStepResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      wasCompleted: json['wasCompleted'] as bool,
      abortReason: json['abortReason'] as String?,
      userNote: json['userNote'] as String?,
    );

Map<String, dynamic> _$$InterventionResultImplToJson(
        _$InterventionResultImpl instance) =>
    <String, dynamic>{
      'interventionId': instance.interventionId,
      'title': instance.title,
      'type': _$InterventionTypeEnumMap[instance.type]!,
      'startedAt': instance.startedAt.toIso8601String(),
      'completedAt': instance.completedAt.toIso8601String(),
      'actualDurationSec': instance.actualDurationSec,
      'stepResponses': instance.stepResponses,
      'wasCompleted': instance.wasCompleted,
      'abortReason': instance.abortReason,
      'userNote': instance.userNote,
    };

_$InterventionEffectivenessImpl _$$InterventionEffectivenessImplFromJson(
        Map<String, dynamic> json) =>
    _$InterventionEffectivenessImpl(
      interventionId: json['interventionId'] as String,
      title: json['title'] as String,
      type: $enumDecode(_$InterventionTypeEnumMap, json['type']),
      usageCount: (json['usageCount'] as num).toInt(),
      avgImprovement: (json['avgImprovement'] as num).toDouble(),
      avgTensionImprovement: (json['avgTensionImprovement'] as num).toDouble(),
      avgClarityGain: (json['avgClarityGain'] as num).toDouble(),
      avgHelpfulnessRating: (json['avgHelpfulnessRating'] as num).toDouble(),
      lastUsedAt: DateTime.parse(json['lastUsedAt'] as String),
    );

Map<String, dynamic> _$$InterventionEffectivenessImplToJson(
        _$InterventionEffectivenessImpl instance) =>
    <String, dynamic>{
      'interventionId': instance.interventionId,
      'title': instance.title,
      'type': _$InterventionTypeEnumMap[instance.type]!,
      'usageCount': instance.usageCount,
      'avgImprovement': instance.avgImprovement,
      'avgTensionImprovement': instance.avgTensionImprovement,
      'avgClarityGain': instance.avgClarityGain,
      'avgHelpfulnessRating': instance.avgHelpfulnessRating,
      'lastUsedAt': instance.lastUsedAt.toIso8601String(),
    };
