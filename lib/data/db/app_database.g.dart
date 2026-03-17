// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SituationEntriesTable extends SituationEntries
    with TableInfo<$SituationEntriesTable, SituationEntryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SituationEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _situationDescriptionMeta =
      const VerificationMeta('situationDescription');
  @override
  late final GeneratedColumn<String> situationDescription =
      GeneratedColumn<String>('situation_description', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contextMeta =
      const VerificationMeta('context');
  @override
  late final GeneratedColumn<String> context = GeneratedColumn<String>(
      'context', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _involvedPersonMeta =
      const VerificationMeta('involvedPerson');
  @override
  late final GeneratedColumn<String> involvedPerson = GeneratedColumn<String>(
      'involved_person', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _intensityMeta =
      const VerificationMeta('intensity');
  @override
  late final GeneratedColumn<int> intensity = GeneratedColumn<int>(
      'intensity', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _bodyTensionMeta =
      const VerificationMeta('bodyTension');
  @override
  late final GeneratedColumn<int> bodyTension = GeneratedColumn<int>(
      'body_tension', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _primaryEmotionMeta =
      const VerificationMeta('primaryEmotion');
  @override
  late final GeneratedColumn<String> primaryEmotion = GeneratedColumn<String>(
      'primary_emotion', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _secondaryEmotionMeta =
      const VerificationMeta('secondaryEmotion');
  @override
  late final GeneratedColumn<String> secondaryEmotion = GeneratedColumn<String>(
      'secondary_emotion', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _bodySymptomsMeta =
      const VerificationMeta('bodySymptoms');
  @override
  late final GeneratedColumn<String> bodySymptoms = GeneratedColumn<String>(
      'body_symptoms', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _automaticThoughtMeta =
      const VerificationMeta('automaticThought');
  @override
  late final GeneratedColumn<String> automaticThought = GeneratedColumn<String>(
      'automatic_thought', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _firstImpulseMeta =
      const VerificationMeta('firstImpulse');
  @override
  late final GeneratedColumn<String> firstImpulse = GeneratedColumn<String>(
      'first_impulse', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _actualBehaviorMeta =
      const VerificationMeta('actualBehavior');
  @override
  late final GeneratedColumn<String> actualBehavior = GeneratedColumn<String>(
      'actual_behavior', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _needOrWoundedPointMeta =
      const VerificationMeta('needOrWoundedPoint');
  @override
  late final GeneratedColumn<String> needOrWoundedPoint =
      GeneratedColumn<String>('need_or_wounded_point', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nextStepMeta =
      const VerificationMeta('nextStep');
  @override
  late final GeneratedColumn<String> nextStep = GeneratedColumn<String>(
      'next_step', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _systemStateMeta =
      const VerificationMeta('systemState');
  @override
  late final GeneratedColumn<String> systemState = GeneratedColumn<String>(
      'system_state', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isCrisisMeta =
      const VerificationMeta('isCrisis');
  @override
  late final GeneratedColumn<bool> isCrisis = GeneratedColumn<bool>(
      'is_crisis', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_crisis" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _interventionTypeMeta =
      const VerificationMeta('interventionType');
  @override
  late final GeneratedColumn<String> interventionType = GeneratedColumn<String>(
      'intervention_type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _interventionIdMeta =
      const VerificationMeta('interventionId');
  @override
  late final GeneratedColumn<String> interventionId = GeneratedColumn<String>(
      'intervention_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _interventionCompletedMeta =
      const VerificationMeta('interventionCompleted');
  @override
  late final GeneratedColumn<bool> interventionCompleted =
      GeneratedColumn<bool>('intervention_completed', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("intervention_completed" IN (0, 1))'),
          defaultValue: const Constant(false));
  static const VerificationMeta _interventionDurationSecMeta =
      const VerificationMeta('interventionDurationSec');
  @override
  late final GeneratedColumn<int> interventionDurationSec =
      GeneratedColumn<int>('intervention_duration_sec', aliasedName, true,
          type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _postIntensityMeta =
      const VerificationMeta('postIntensity');
  @override
  late final GeneratedColumn<int> postIntensity = GeneratedColumn<int>(
      'post_intensity', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _postBodyTensionMeta =
      const VerificationMeta('postBodyTension');
  @override
  late final GeneratedColumn<int> postBodyTension = GeneratedColumn<int>(
      'post_body_tension', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _postClarityMeta =
      const VerificationMeta('postClarity');
  @override
  late final GeneratedColumn<int> postClarity = GeneratedColumn<int>(
      'post_clarity', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _helpfulnessRatingMeta =
      const VerificationMeta('helpfulnessRating');
  @override
  late final GeneratedColumn<int> helpfulnessRating = GeneratedColumn<int>(
      'helpfulness_rating', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _postNoteMeta =
      const VerificationMeta('postNote');
  @override
  late final GeneratedColumn<String> postNote = GeneratedColumn<String>(
      'post_note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _isDraftMeta =
      const VerificationMeta('isDraft');
  @override
  late final GeneratedColumn<bool> isDraft = GeneratedColumn<bool>(
      'is_draft', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_draft" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        situationDescription,
        context,
        timestamp,
        involvedPerson,
        intensity,
        bodyTension,
        primaryEmotion,
        secondaryEmotion,
        bodySymptoms,
        automaticThought,
        firstImpulse,
        actualBehavior,
        needOrWoundedPoint,
        nextStep,
        systemState,
        isCrisis,
        interventionType,
        interventionId,
        interventionCompleted,
        interventionDurationSec,
        postIntensity,
        postBodyTension,
        postClarity,
        helpfulnessRating,
        postNote,
        createdAt,
        updatedAt,
        isDraft
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'situation_entries';
  @override
  VerificationContext validateIntegrity(Insertable<SituationEntryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('situation_description')) {
      context.handle(
          _situationDescriptionMeta,
          situationDescription.isAcceptableOrUnknown(
              data['situation_description']!, _situationDescriptionMeta));
    } else if (isInserting) {
      context.missing(_situationDescriptionMeta);
    }
    if (data.containsKey('context')) {
      context.handle(_contextMeta,
          this.context.isAcceptableOrUnknown(data['context']!, _contextMeta));
    } else if (isInserting) {
      context.missing(_contextMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('involved_person')) {
      context.handle(
          _involvedPersonMeta,
          involvedPerson.isAcceptableOrUnknown(
              data['involved_person']!, _involvedPersonMeta));
    }
    if (data.containsKey('intensity')) {
      context.handle(_intensityMeta,
          intensity.isAcceptableOrUnknown(data['intensity']!, _intensityMeta));
    } else if (isInserting) {
      context.missing(_intensityMeta);
    }
    if (data.containsKey('body_tension')) {
      context.handle(
          _bodyTensionMeta,
          bodyTension.isAcceptableOrUnknown(
              data['body_tension']!, _bodyTensionMeta));
    } else if (isInserting) {
      context.missing(_bodyTensionMeta);
    }
    if (data.containsKey('primary_emotion')) {
      context.handle(
          _primaryEmotionMeta,
          primaryEmotion.isAcceptableOrUnknown(
              data['primary_emotion']!, _primaryEmotionMeta));
    } else if (isInserting) {
      context.missing(_primaryEmotionMeta);
    }
    if (data.containsKey('secondary_emotion')) {
      context.handle(
          _secondaryEmotionMeta,
          secondaryEmotion.isAcceptableOrUnknown(
              data['secondary_emotion']!, _secondaryEmotionMeta));
    }
    if (data.containsKey('body_symptoms')) {
      context.handle(
          _bodySymptomsMeta,
          bodySymptoms.isAcceptableOrUnknown(
              data['body_symptoms']!, _bodySymptomsMeta));
    }
    if (data.containsKey('automatic_thought')) {
      context.handle(
          _automaticThoughtMeta,
          automaticThought.isAcceptableOrUnknown(
              data['automatic_thought']!, _automaticThoughtMeta));
    } else if (isInserting) {
      context.missing(_automaticThoughtMeta);
    }
    if (data.containsKey('first_impulse')) {
      context.handle(
          _firstImpulseMeta,
          firstImpulse.isAcceptableOrUnknown(
              data['first_impulse']!, _firstImpulseMeta));
    } else if (isInserting) {
      context.missing(_firstImpulseMeta);
    }
    if (data.containsKey('actual_behavior')) {
      context.handle(
          _actualBehaviorMeta,
          actualBehavior.isAcceptableOrUnknown(
              data['actual_behavior']!, _actualBehaviorMeta));
    }
    if (data.containsKey('need_or_wounded_point')) {
      context.handle(
          _needOrWoundedPointMeta,
          needOrWoundedPoint.isAcceptableOrUnknown(
              data['need_or_wounded_point']!, _needOrWoundedPointMeta));
    }
    if (data.containsKey('next_step')) {
      context.handle(_nextStepMeta,
          nextStep.isAcceptableOrUnknown(data['next_step']!, _nextStepMeta));
    }
    if (data.containsKey('system_state')) {
      context.handle(
          _systemStateMeta,
          systemState.isAcceptableOrUnknown(
              data['system_state']!, _systemStateMeta));
    } else if (isInserting) {
      context.missing(_systemStateMeta);
    }
    if (data.containsKey('is_crisis')) {
      context.handle(_isCrisisMeta,
          isCrisis.isAcceptableOrUnknown(data['is_crisis']!, _isCrisisMeta));
    }
    if (data.containsKey('intervention_type')) {
      context.handle(
          _interventionTypeMeta,
          interventionType.isAcceptableOrUnknown(
              data['intervention_type']!, _interventionTypeMeta));
    }
    if (data.containsKey('intervention_id')) {
      context.handle(
          _interventionIdMeta,
          interventionId.isAcceptableOrUnknown(
              data['intervention_id']!, _interventionIdMeta));
    }
    if (data.containsKey('intervention_completed')) {
      context.handle(
          _interventionCompletedMeta,
          interventionCompleted.isAcceptableOrUnknown(
              data['intervention_completed']!, _interventionCompletedMeta));
    }
    if (data.containsKey('intervention_duration_sec')) {
      context.handle(
          _interventionDurationSecMeta,
          interventionDurationSec.isAcceptableOrUnknown(
              data['intervention_duration_sec']!,
              _interventionDurationSecMeta));
    }
    if (data.containsKey('post_intensity')) {
      context.handle(
          _postIntensityMeta,
          postIntensity.isAcceptableOrUnknown(
              data['post_intensity']!, _postIntensityMeta));
    }
    if (data.containsKey('post_body_tension')) {
      context.handle(
          _postBodyTensionMeta,
          postBodyTension.isAcceptableOrUnknown(
              data['post_body_tension']!, _postBodyTensionMeta));
    }
    if (data.containsKey('post_clarity')) {
      context.handle(
          _postClarityMeta,
          postClarity.isAcceptableOrUnknown(
              data['post_clarity']!, _postClarityMeta));
    }
    if (data.containsKey('helpfulness_rating')) {
      context.handle(
          _helpfulnessRatingMeta,
          helpfulnessRating.isAcceptableOrUnknown(
              data['helpfulness_rating']!, _helpfulnessRatingMeta));
    }
    if (data.containsKey('post_note')) {
      context.handle(_postNoteMeta,
          postNote.isAcceptableOrUnknown(data['post_note']!, _postNoteMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('is_draft')) {
      context.handle(_isDraftMeta,
          isDraft.isAcceptableOrUnknown(data['is_draft']!, _isDraftMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SituationEntryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SituationEntryData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      situationDescription: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}situation_description'])!,
      context: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}context'])!,
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timestamp'])!,
      involvedPerson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}involved_person']),
      intensity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}intensity'])!,
      bodyTension: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}body_tension'])!,
      primaryEmotion: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}primary_emotion'])!,
      secondaryEmotion: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}secondary_emotion']),
      bodySymptoms: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}body_symptoms']),
      automaticThought: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}automatic_thought'])!,
      firstImpulse: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}first_impulse'])!,
      actualBehavior: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}actual_behavior']),
      needOrWoundedPoint: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}need_or_wounded_point']),
      nextStep: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}next_step']),
      systemState: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}system_state'])!,
      isCrisis: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_crisis'])!,
      interventionType: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}intervention_type']),
      interventionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}intervention_id']),
      interventionCompleted: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}intervention_completed'])!,
      interventionDurationSec: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}intervention_duration_sec']),
      postIntensity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}post_intensity']),
      postBodyTension: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}post_body_tension']),
      postClarity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}post_clarity']),
      helpfulnessRating: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}helpfulness_rating']),
      postNote: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}post_note']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      isDraft: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_draft'])!,
    );
  }

  @override
  $SituationEntriesTable createAlias(String alias) {
    return $SituationEntriesTable(attachedDatabase, alias);
  }
}

class SituationEntryData extends DataClass
    implements Insertable<SituationEntryData> {
  final int id;
  final String situationDescription;
  final String context;
  final DateTime timestamp;
  final String? involvedPerson;
  final int intensity;
  final int bodyTension;
  final String primaryEmotion;
  final String? secondaryEmotion;
  final String? bodySymptoms;
  final String automaticThought;
  final String firstImpulse;
  final String? actualBehavior;
  final String? needOrWoundedPoint;
  final String? nextStep;
  final String systemState;
  final bool isCrisis;
  final String? interventionType;
  final String? interventionId;
  final bool interventionCompleted;
  final int? interventionDurationSec;
  final int? postIntensity;
  final int? postBodyTension;
  final int? postClarity;
  final int? helpfulnessRating;
  final String? postNote;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isDraft;
  const SituationEntryData(
      {required this.id,
      required this.situationDescription,
      required this.context,
      required this.timestamp,
      this.involvedPerson,
      required this.intensity,
      required this.bodyTension,
      required this.primaryEmotion,
      this.secondaryEmotion,
      this.bodySymptoms,
      required this.automaticThought,
      required this.firstImpulse,
      this.actualBehavior,
      this.needOrWoundedPoint,
      this.nextStep,
      required this.systemState,
      required this.isCrisis,
      this.interventionType,
      this.interventionId,
      required this.interventionCompleted,
      this.interventionDurationSec,
      this.postIntensity,
      this.postBodyTension,
      this.postClarity,
      this.helpfulnessRating,
      this.postNote,
      required this.createdAt,
      required this.updatedAt,
      required this.isDraft});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['situation_description'] = Variable<String>(situationDescription);
    map['context'] = Variable<String>(context);
    map['timestamp'] = Variable<DateTime>(timestamp);
    if (!nullToAbsent || involvedPerson != null) {
      map['involved_person'] = Variable<String>(involvedPerson);
    }
    map['intensity'] = Variable<int>(intensity);
    map['body_tension'] = Variable<int>(bodyTension);
    map['primary_emotion'] = Variable<String>(primaryEmotion);
    if (!nullToAbsent || secondaryEmotion != null) {
      map['secondary_emotion'] = Variable<String>(secondaryEmotion);
    }
    if (!nullToAbsent || bodySymptoms != null) {
      map['body_symptoms'] = Variable<String>(bodySymptoms);
    }
    map['automatic_thought'] = Variable<String>(automaticThought);
    map['first_impulse'] = Variable<String>(firstImpulse);
    if (!nullToAbsent || actualBehavior != null) {
      map['actual_behavior'] = Variable<String>(actualBehavior);
    }
    if (!nullToAbsent || needOrWoundedPoint != null) {
      map['need_or_wounded_point'] = Variable<String>(needOrWoundedPoint);
    }
    if (!nullToAbsent || nextStep != null) {
      map['next_step'] = Variable<String>(nextStep);
    }
    map['system_state'] = Variable<String>(systemState);
    map['is_crisis'] = Variable<bool>(isCrisis);
    if (!nullToAbsent || interventionType != null) {
      map['intervention_type'] = Variable<String>(interventionType);
    }
    if (!nullToAbsent || interventionId != null) {
      map['intervention_id'] = Variable<String>(interventionId);
    }
    map['intervention_completed'] = Variable<bool>(interventionCompleted);
    if (!nullToAbsent || interventionDurationSec != null) {
      map['intervention_duration_sec'] = Variable<int>(interventionDurationSec);
    }
    if (!nullToAbsent || postIntensity != null) {
      map['post_intensity'] = Variable<int>(postIntensity);
    }
    if (!nullToAbsent || postBodyTension != null) {
      map['post_body_tension'] = Variable<int>(postBodyTension);
    }
    if (!nullToAbsent || postClarity != null) {
      map['post_clarity'] = Variable<int>(postClarity);
    }
    if (!nullToAbsent || helpfulnessRating != null) {
      map['helpfulness_rating'] = Variable<int>(helpfulnessRating);
    }
    if (!nullToAbsent || postNote != null) {
      map['post_note'] = Variable<String>(postNote);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_draft'] = Variable<bool>(isDraft);
    return map;
  }

  SituationEntriesCompanion toCompanion(bool nullToAbsent) {
    return SituationEntriesCompanion(
      id: Value(id),
      situationDescription: Value(situationDescription),
      context: Value(context),
      timestamp: Value(timestamp),
      involvedPerson: involvedPerson == null && nullToAbsent
          ? const Value.absent()
          : Value(involvedPerson),
      intensity: Value(intensity),
      bodyTension: Value(bodyTension),
      primaryEmotion: Value(primaryEmotion),
      secondaryEmotion: secondaryEmotion == null && nullToAbsent
          ? const Value.absent()
          : Value(secondaryEmotion),
      bodySymptoms: bodySymptoms == null && nullToAbsent
          ? const Value.absent()
          : Value(bodySymptoms),
      automaticThought: Value(automaticThought),
      firstImpulse: Value(firstImpulse),
      actualBehavior: actualBehavior == null && nullToAbsent
          ? const Value.absent()
          : Value(actualBehavior),
      needOrWoundedPoint: needOrWoundedPoint == null && nullToAbsent
          ? const Value.absent()
          : Value(needOrWoundedPoint),
      nextStep: nextStep == null && nullToAbsent
          ? const Value.absent()
          : Value(nextStep),
      systemState: Value(systemState),
      isCrisis: Value(isCrisis),
      interventionType: interventionType == null && nullToAbsent
          ? const Value.absent()
          : Value(interventionType),
      interventionId: interventionId == null && nullToAbsent
          ? const Value.absent()
          : Value(interventionId),
      interventionCompleted: Value(interventionCompleted),
      interventionDurationSec: interventionDurationSec == null && nullToAbsent
          ? const Value.absent()
          : Value(interventionDurationSec),
      postIntensity: postIntensity == null && nullToAbsent
          ? const Value.absent()
          : Value(postIntensity),
      postBodyTension: postBodyTension == null && nullToAbsent
          ? const Value.absent()
          : Value(postBodyTension),
      postClarity: postClarity == null && nullToAbsent
          ? const Value.absent()
          : Value(postClarity),
      helpfulnessRating: helpfulnessRating == null && nullToAbsent
          ? const Value.absent()
          : Value(helpfulnessRating),
      postNote: postNote == null && nullToAbsent
          ? const Value.absent()
          : Value(postNote),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      isDraft: Value(isDraft),
    );
  }

  factory SituationEntryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SituationEntryData(
      id: serializer.fromJson<int>(json['id']),
      situationDescription:
          serializer.fromJson<String>(json['situationDescription']),
      context: serializer.fromJson<String>(json['context']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      involvedPerson: serializer.fromJson<String?>(json['involvedPerson']),
      intensity: serializer.fromJson<int>(json['intensity']),
      bodyTension: serializer.fromJson<int>(json['bodyTension']),
      primaryEmotion: serializer.fromJson<String>(json['primaryEmotion']),
      secondaryEmotion: serializer.fromJson<String?>(json['secondaryEmotion']),
      bodySymptoms: serializer.fromJson<String?>(json['bodySymptoms']),
      automaticThought: serializer.fromJson<String>(json['automaticThought']),
      firstImpulse: serializer.fromJson<String>(json['firstImpulse']),
      actualBehavior: serializer.fromJson<String?>(json['actualBehavior']),
      needOrWoundedPoint:
          serializer.fromJson<String?>(json['needOrWoundedPoint']),
      nextStep: serializer.fromJson<String?>(json['nextStep']),
      systemState: serializer.fromJson<String>(json['systemState']),
      isCrisis: serializer.fromJson<bool>(json['isCrisis']),
      interventionType: serializer.fromJson<String?>(json['interventionType']),
      interventionId: serializer.fromJson<String?>(json['interventionId']),
      interventionCompleted:
          serializer.fromJson<bool>(json['interventionCompleted']),
      interventionDurationSec:
          serializer.fromJson<int?>(json['interventionDurationSec']),
      postIntensity: serializer.fromJson<int?>(json['postIntensity']),
      postBodyTension: serializer.fromJson<int?>(json['postBodyTension']),
      postClarity: serializer.fromJson<int?>(json['postClarity']),
      helpfulnessRating: serializer.fromJson<int?>(json['helpfulnessRating']),
      postNote: serializer.fromJson<String?>(json['postNote']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isDraft: serializer.fromJson<bool>(json['isDraft']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'situationDescription': serializer.toJson<String>(situationDescription),
      'context': serializer.toJson<String>(context),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'involvedPerson': serializer.toJson<String?>(involvedPerson),
      'intensity': serializer.toJson<int>(intensity),
      'bodyTension': serializer.toJson<int>(bodyTension),
      'primaryEmotion': serializer.toJson<String>(primaryEmotion),
      'secondaryEmotion': serializer.toJson<String?>(secondaryEmotion),
      'bodySymptoms': serializer.toJson<String?>(bodySymptoms),
      'automaticThought': serializer.toJson<String>(automaticThought),
      'firstImpulse': serializer.toJson<String>(firstImpulse),
      'actualBehavior': serializer.toJson<String?>(actualBehavior),
      'needOrWoundedPoint': serializer.toJson<String?>(needOrWoundedPoint),
      'nextStep': serializer.toJson<String?>(nextStep),
      'systemState': serializer.toJson<String>(systemState),
      'isCrisis': serializer.toJson<bool>(isCrisis),
      'interventionType': serializer.toJson<String?>(interventionType),
      'interventionId': serializer.toJson<String?>(interventionId),
      'interventionCompleted': serializer.toJson<bool>(interventionCompleted),
      'interventionDurationSec':
          serializer.toJson<int?>(interventionDurationSec),
      'postIntensity': serializer.toJson<int?>(postIntensity),
      'postBodyTension': serializer.toJson<int?>(postBodyTension),
      'postClarity': serializer.toJson<int?>(postClarity),
      'helpfulnessRating': serializer.toJson<int?>(helpfulnessRating),
      'postNote': serializer.toJson<String?>(postNote),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isDraft': serializer.toJson<bool>(isDraft),
    };
  }

  SituationEntryData copyWith(
          {int? id,
          String? situationDescription,
          String? context,
          DateTime? timestamp,
          Value<String?> involvedPerson = const Value.absent(),
          int? intensity,
          int? bodyTension,
          String? primaryEmotion,
          Value<String?> secondaryEmotion = const Value.absent(),
          Value<String?> bodySymptoms = const Value.absent(),
          String? automaticThought,
          String? firstImpulse,
          Value<String?> actualBehavior = const Value.absent(),
          Value<String?> needOrWoundedPoint = const Value.absent(),
          Value<String?> nextStep = const Value.absent(),
          String? systemState,
          bool? isCrisis,
          Value<String?> interventionType = const Value.absent(),
          Value<String?> interventionId = const Value.absent(),
          bool? interventionCompleted,
          Value<int?> interventionDurationSec = const Value.absent(),
          Value<int?> postIntensity = const Value.absent(),
          Value<int?> postBodyTension = const Value.absent(),
          Value<int?> postClarity = const Value.absent(),
          Value<int?> helpfulnessRating = const Value.absent(),
          Value<String?> postNote = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt,
          bool? isDraft}) =>
      SituationEntryData(
        id: id ?? this.id,
        situationDescription: situationDescription ?? this.situationDescription,
        context: context ?? this.context,
        timestamp: timestamp ?? this.timestamp,
        involvedPerson:
            involvedPerson.present ? involvedPerson.value : this.involvedPerson,
        intensity: intensity ?? this.intensity,
        bodyTension: bodyTension ?? this.bodyTension,
        primaryEmotion: primaryEmotion ?? this.primaryEmotion,
        secondaryEmotion: secondaryEmotion.present
            ? secondaryEmotion.value
            : this.secondaryEmotion,
        bodySymptoms:
            bodySymptoms.present ? bodySymptoms.value : this.bodySymptoms,
        automaticThought: automaticThought ?? this.automaticThought,
        firstImpulse: firstImpulse ?? this.firstImpulse,
        actualBehavior:
            actualBehavior.present ? actualBehavior.value : this.actualBehavior,
        needOrWoundedPoint: needOrWoundedPoint.present
            ? needOrWoundedPoint.value
            : this.needOrWoundedPoint,
        nextStep: nextStep.present ? nextStep.value : this.nextStep,
        systemState: systemState ?? this.systemState,
        isCrisis: isCrisis ?? this.isCrisis,
        interventionType: interventionType.present
            ? interventionType.value
            : this.interventionType,
        interventionId:
            interventionId.present ? interventionId.value : this.interventionId,
        interventionCompleted:
            interventionCompleted ?? this.interventionCompleted,
        interventionDurationSec: interventionDurationSec.present
            ? interventionDurationSec.value
            : this.interventionDurationSec,
        postIntensity:
            postIntensity.present ? postIntensity.value : this.postIntensity,
        postBodyTension: postBodyTension.present
            ? postBodyTension.value
            : this.postBodyTension,
        postClarity: postClarity.present ? postClarity.value : this.postClarity,
        helpfulnessRating: helpfulnessRating.present
            ? helpfulnessRating.value
            : this.helpfulnessRating,
        postNote: postNote.present ? postNote.value : this.postNote,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        isDraft: isDraft ?? this.isDraft,
      );
  SituationEntryData copyWithCompanion(SituationEntriesCompanion data) {
    return SituationEntryData(
      id: data.id.present ? data.id.value : this.id,
      situationDescription: data.situationDescription.present
          ? data.situationDescription.value
          : this.situationDescription,
      context: data.context.present ? data.context.value : this.context,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      involvedPerson: data.involvedPerson.present
          ? data.involvedPerson.value
          : this.involvedPerson,
      intensity: data.intensity.present ? data.intensity.value : this.intensity,
      bodyTension:
          data.bodyTension.present ? data.bodyTension.value : this.bodyTension,
      primaryEmotion: data.primaryEmotion.present
          ? data.primaryEmotion.value
          : this.primaryEmotion,
      secondaryEmotion: data.secondaryEmotion.present
          ? data.secondaryEmotion.value
          : this.secondaryEmotion,
      bodySymptoms: data.bodySymptoms.present
          ? data.bodySymptoms.value
          : this.bodySymptoms,
      automaticThought: data.automaticThought.present
          ? data.automaticThought.value
          : this.automaticThought,
      firstImpulse: data.firstImpulse.present
          ? data.firstImpulse.value
          : this.firstImpulse,
      actualBehavior: data.actualBehavior.present
          ? data.actualBehavior.value
          : this.actualBehavior,
      needOrWoundedPoint: data.needOrWoundedPoint.present
          ? data.needOrWoundedPoint.value
          : this.needOrWoundedPoint,
      nextStep: data.nextStep.present ? data.nextStep.value : this.nextStep,
      systemState:
          data.systemState.present ? data.systemState.value : this.systemState,
      isCrisis: data.isCrisis.present ? data.isCrisis.value : this.isCrisis,
      interventionType: data.interventionType.present
          ? data.interventionType.value
          : this.interventionType,
      interventionId: data.interventionId.present
          ? data.interventionId.value
          : this.interventionId,
      interventionCompleted: data.interventionCompleted.present
          ? data.interventionCompleted.value
          : this.interventionCompleted,
      interventionDurationSec: data.interventionDurationSec.present
          ? data.interventionDurationSec.value
          : this.interventionDurationSec,
      postIntensity: data.postIntensity.present
          ? data.postIntensity.value
          : this.postIntensity,
      postBodyTension: data.postBodyTension.present
          ? data.postBodyTension.value
          : this.postBodyTension,
      postClarity:
          data.postClarity.present ? data.postClarity.value : this.postClarity,
      helpfulnessRating: data.helpfulnessRating.present
          ? data.helpfulnessRating.value
          : this.helpfulnessRating,
      postNote: data.postNote.present ? data.postNote.value : this.postNote,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isDraft: data.isDraft.present ? data.isDraft.value : this.isDraft,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SituationEntryData(')
          ..write('id: $id, ')
          ..write('situationDescription: $situationDescription, ')
          ..write('context: $context, ')
          ..write('timestamp: $timestamp, ')
          ..write('involvedPerson: $involvedPerson, ')
          ..write('intensity: $intensity, ')
          ..write('bodyTension: $bodyTension, ')
          ..write('primaryEmotion: $primaryEmotion, ')
          ..write('secondaryEmotion: $secondaryEmotion, ')
          ..write('bodySymptoms: $bodySymptoms, ')
          ..write('automaticThought: $automaticThought, ')
          ..write('firstImpulse: $firstImpulse, ')
          ..write('actualBehavior: $actualBehavior, ')
          ..write('needOrWoundedPoint: $needOrWoundedPoint, ')
          ..write('nextStep: $nextStep, ')
          ..write('systemState: $systemState, ')
          ..write('isCrisis: $isCrisis, ')
          ..write('interventionType: $interventionType, ')
          ..write('interventionId: $interventionId, ')
          ..write('interventionCompleted: $interventionCompleted, ')
          ..write('interventionDurationSec: $interventionDurationSec, ')
          ..write('postIntensity: $postIntensity, ')
          ..write('postBodyTension: $postBodyTension, ')
          ..write('postClarity: $postClarity, ')
          ..write('helpfulnessRating: $helpfulnessRating, ')
          ..write('postNote: $postNote, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDraft: $isDraft')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        situationDescription,
        context,
        timestamp,
        involvedPerson,
        intensity,
        bodyTension,
        primaryEmotion,
        secondaryEmotion,
        bodySymptoms,
        automaticThought,
        firstImpulse,
        actualBehavior,
        needOrWoundedPoint,
        nextStep,
        systemState,
        isCrisis,
        interventionType,
        interventionId,
        interventionCompleted,
        interventionDurationSec,
        postIntensity,
        postBodyTension,
        postClarity,
        helpfulnessRating,
        postNote,
        createdAt,
        updatedAt,
        isDraft
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SituationEntryData &&
          other.id == this.id &&
          other.situationDescription == this.situationDescription &&
          other.context == this.context &&
          other.timestamp == this.timestamp &&
          other.involvedPerson == this.involvedPerson &&
          other.intensity == this.intensity &&
          other.bodyTension == this.bodyTension &&
          other.primaryEmotion == this.primaryEmotion &&
          other.secondaryEmotion == this.secondaryEmotion &&
          other.bodySymptoms == this.bodySymptoms &&
          other.automaticThought == this.automaticThought &&
          other.firstImpulse == this.firstImpulse &&
          other.actualBehavior == this.actualBehavior &&
          other.needOrWoundedPoint == this.needOrWoundedPoint &&
          other.nextStep == this.nextStep &&
          other.systemState == this.systemState &&
          other.isCrisis == this.isCrisis &&
          other.interventionType == this.interventionType &&
          other.interventionId == this.interventionId &&
          other.interventionCompleted == this.interventionCompleted &&
          other.interventionDurationSec == this.interventionDurationSec &&
          other.postIntensity == this.postIntensity &&
          other.postBodyTension == this.postBodyTension &&
          other.postClarity == this.postClarity &&
          other.helpfulnessRating == this.helpfulnessRating &&
          other.postNote == this.postNote &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isDraft == this.isDraft);
}

class SituationEntriesCompanion extends UpdateCompanion<SituationEntryData> {
  final Value<int> id;
  final Value<String> situationDescription;
  final Value<String> context;
  final Value<DateTime> timestamp;
  final Value<String?> involvedPerson;
  final Value<int> intensity;
  final Value<int> bodyTension;
  final Value<String> primaryEmotion;
  final Value<String?> secondaryEmotion;
  final Value<String?> bodySymptoms;
  final Value<String> automaticThought;
  final Value<String> firstImpulse;
  final Value<String?> actualBehavior;
  final Value<String?> needOrWoundedPoint;
  final Value<String?> nextStep;
  final Value<String> systemState;
  final Value<bool> isCrisis;
  final Value<String?> interventionType;
  final Value<String?> interventionId;
  final Value<bool> interventionCompleted;
  final Value<int?> interventionDurationSec;
  final Value<int?> postIntensity;
  final Value<int?> postBodyTension;
  final Value<int?> postClarity;
  final Value<int?> helpfulnessRating;
  final Value<String?> postNote;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> isDraft;
  const SituationEntriesCompanion({
    this.id = const Value.absent(),
    this.situationDescription = const Value.absent(),
    this.context = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.involvedPerson = const Value.absent(),
    this.intensity = const Value.absent(),
    this.bodyTension = const Value.absent(),
    this.primaryEmotion = const Value.absent(),
    this.secondaryEmotion = const Value.absent(),
    this.bodySymptoms = const Value.absent(),
    this.automaticThought = const Value.absent(),
    this.firstImpulse = const Value.absent(),
    this.actualBehavior = const Value.absent(),
    this.needOrWoundedPoint = const Value.absent(),
    this.nextStep = const Value.absent(),
    this.systemState = const Value.absent(),
    this.isCrisis = const Value.absent(),
    this.interventionType = const Value.absent(),
    this.interventionId = const Value.absent(),
    this.interventionCompleted = const Value.absent(),
    this.interventionDurationSec = const Value.absent(),
    this.postIntensity = const Value.absent(),
    this.postBodyTension = const Value.absent(),
    this.postClarity = const Value.absent(),
    this.helpfulnessRating = const Value.absent(),
    this.postNote = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDraft = const Value.absent(),
  });
  SituationEntriesCompanion.insert({
    this.id = const Value.absent(),
    required String situationDescription,
    required String context,
    required DateTime timestamp,
    this.involvedPerson = const Value.absent(),
    required int intensity,
    required int bodyTension,
    required String primaryEmotion,
    this.secondaryEmotion = const Value.absent(),
    this.bodySymptoms = const Value.absent(),
    required String automaticThought,
    required String firstImpulse,
    this.actualBehavior = const Value.absent(),
    this.needOrWoundedPoint = const Value.absent(),
    this.nextStep = const Value.absent(),
    required String systemState,
    this.isCrisis = const Value.absent(),
    this.interventionType = const Value.absent(),
    this.interventionId = const Value.absent(),
    this.interventionCompleted = const Value.absent(),
    this.interventionDurationSec = const Value.absent(),
    this.postIntensity = const Value.absent(),
    this.postBodyTension = const Value.absent(),
    this.postClarity = const Value.absent(),
    this.helpfulnessRating = const Value.absent(),
    this.postNote = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDraft = const Value.absent(),
  })  : situationDescription = Value(situationDescription),
        context = Value(context),
        timestamp = Value(timestamp),
        intensity = Value(intensity),
        bodyTension = Value(bodyTension),
        primaryEmotion = Value(primaryEmotion),
        automaticThought = Value(automaticThought),
        firstImpulse = Value(firstImpulse),
        systemState = Value(systemState);
  static Insertable<SituationEntryData> custom({
    Expression<int>? id,
    Expression<String>? situationDescription,
    Expression<String>? context,
    Expression<DateTime>? timestamp,
    Expression<String>? involvedPerson,
    Expression<int>? intensity,
    Expression<int>? bodyTension,
    Expression<String>? primaryEmotion,
    Expression<String>? secondaryEmotion,
    Expression<String>? bodySymptoms,
    Expression<String>? automaticThought,
    Expression<String>? firstImpulse,
    Expression<String>? actualBehavior,
    Expression<String>? needOrWoundedPoint,
    Expression<String>? nextStep,
    Expression<String>? systemState,
    Expression<bool>? isCrisis,
    Expression<String>? interventionType,
    Expression<String>? interventionId,
    Expression<bool>? interventionCompleted,
    Expression<int>? interventionDurationSec,
    Expression<int>? postIntensity,
    Expression<int>? postBodyTension,
    Expression<int>? postClarity,
    Expression<int>? helpfulnessRating,
    Expression<String>? postNote,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isDraft,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (situationDescription != null)
        'situation_description': situationDescription,
      if (context != null) 'context': context,
      if (timestamp != null) 'timestamp': timestamp,
      if (involvedPerson != null) 'involved_person': involvedPerson,
      if (intensity != null) 'intensity': intensity,
      if (bodyTension != null) 'body_tension': bodyTension,
      if (primaryEmotion != null) 'primary_emotion': primaryEmotion,
      if (secondaryEmotion != null) 'secondary_emotion': secondaryEmotion,
      if (bodySymptoms != null) 'body_symptoms': bodySymptoms,
      if (automaticThought != null) 'automatic_thought': automaticThought,
      if (firstImpulse != null) 'first_impulse': firstImpulse,
      if (actualBehavior != null) 'actual_behavior': actualBehavior,
      if (needOrWoundedPoint != null)
        'need_or_wounded_point': needOrWoundedPoint,
      if (nextStep != null) 'next_step': nextStep,
      if (systemState != null) 'system_state': systemState,
      if (isCrisis != null) 'is_crisis': isCrisis,
      if (interventionType != null) 'intervention_type': interventionType,
      if (interventionId != null) 'intervention_id': interventionId,
      if (interventionCompleted != null)
        'intervention_completed': interventionCompleted,
      if (interventionDurationSec != null)
        'intervention_duration_sec': interventionDurationSec,
      if (postIntensity != null) 'post_intensity': postIntensity,
      if (postBodyTension != null) 'post_body_tension': postBodyTension,
      if (postClarity != null) 'post_clarity': postClarity,
      if (helpfulnessRating != null) 'helpfulness_rating': helpfulnessRating,
      if (postNote != null) 'post_note': postNote,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isDraft != null) 'is_draft': isDraft,
    });
  }

  SituationEntriesCompanion copyWith(
      {Value<int>? id,
      Value<String>? situationDescription,
      Value<String>? context,
      Value<DateTime>? timestamp,
      Value<String?>? involvedPerson,
      Value<int>? intensity,
      Value<int>? bodyTension,
      Value<String>? primaryEmotion,
      Value<String?>? secondaryEmotion,
      Value<String?>? bodySymptoms,
      Value<String>? automaticThought,
      Value<String>? firstImpulse,
      Value<String?>? actualBehavior,
      Value<String?>? needOrWoundedPoint,
      Value<String?>? nextStep,
      Value<String>? systemState,
      Value<bool>? isCrisis,
      Value<String?>? interventionType,
      Value<String?>? interventionId,
      Value<bool>? interventionCompleted,
      Value<int?>? interventionDurationSec,
      Value<int?>? postIntensity,
      Value<int?>? postBodyTension,
      Value<int?>? postClarity,
      Value<int?>? helpfulnessRating,
      Value<String?>? postNote,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<bool>? isDraft}) {
    return SituationEntriesCompanion(
      id: id ?? this.id,
      situationDescription: situationDescription ?? this.situationDescription,
      context: context ?? this.context,
      timestamp: timestamp ?? this.timestamp,
      involvedPerson: involvedPerson ?? this.involvedPerson,
      intensity: intensity ?? this.intensity,
      bodyTension: bodyTension ?? this.bodyTension,
      primaryEmotion: primaryEmotion ?? this.primaryEmotion,
      secondaryEmotion: secondaryEmotion ?? this.secondaryEmotion,
      bodySymptoms: bodySymptoms ?? this.bodySymptoms,
      automaticThought: automaticThought ?? this.automaticThought,
      firstImpulse: firstImpulse ?? this.firstImpulse,
      actualBehavior: actualBehavior ?? this.actualBehavior,
      needOrWoundedPoint: needOrWoundedPoint ?? this.needOrWoundedPoint,
      nextStep: nextStep ?? this.nextStep,
      systemState: systemState ?? this.systemState,
      isCrisis: isCrisis ?? this.isCrisis,
      interventionType: interventionType ?? this.interventionType,
      interventionId: interventionId ?? this.interventionId,
      interventionCompleted:
          interventionCompleted ?? this.interventionCompleted,
      interventionDurationSec:
          interventionDurationSec ?? this.interventionDurationSec,
      postIntensity: postIntensity ?? this.postIntensity,
      postBodyTension: postBodyTension ?? this.postBodyTension,
      postClarity: postClarity ?? this.postClarity,
      helpfulnessRating: helpfulnessRating ?? this.helpfulnessRating,
      postNote: postNote ?? this.postNote,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isDraft: isDraft ?? this.isDraft,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (situationDescription.present) {
      map['situation_description'] =
          Variable<String>(situationDescription.value);
    }
    if (context.present) {
      map['context'] = Variable<String>(context.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (involvedPerson.present) {
      map['involved_person'] = Variable<String>(involvedPerson.value);
    }
    if (intensity.present) {
      map['intensity'] = Variable<int>(intensity.value);
    }
    if (bodyTension.present) {
      map['body_tension'] = Variable<int>(bodyTension.value);
    }
    if (primaryEmotion.present) {
      map['primary_emotion'] = Variable<String>(primaryEmotion.value);
    }
    if (secondaryEmotion.present) {
      map['secondary_emotion'] = Variable<String>(secondaryEmotion.value);
    }
    if (bodySymptoms.present) {
      map['body_symptoms'] = Variable<String>(bodySymptoms.value);
    }
    if (automaticThought.present) {
      map['automatic_thought'] = Variable<String>(automaticThought.value);
    }
    if (firstImpulse.present) {
      map['first_impulse'] = Variable<String>(firstImpulse.value);
    }
    if (actualBehavior.present) {
      map['actual_behavior'] = Variable<String>(actualBehavior.value);
    }
    if (needOrWoundedPoint.present) {
      map['need_or_wounded_point'] = Variable<String>(needOrWoundedPoint.value);
    }
    if (nextStep.present) {
      map['next_step'] = Variable<String>(nextStep.value);
    }
    if (systemState.present) {
      map['system_state'] = Variable<String>(systemState.value);
    }
    if (isCrisis.present) {
      map['is_crisis'] = Variable<bool>(isCrisis.value);
    }
    if (interventionType.present) {
      map['intervention_type'] = Variable<String>(interventionType.value);
    }
    if (interventionId.present) {
      map['intervention_id'] = Variable<String>(interventionId.value);
    }
    if (interventionCompleted.present) {
      map['intervention_completed'] =
          Variable<bool>(interventionCompleted.value);
    }
    if (interventionDurationSec.present) {
      map['intervention_duration_sec'] =
          Variable<int>(interventionDurationSec.value);
    }
    if (postIntensity.present) {
      map['post_intensity'] = Variable<int>(postIntensity.value);
    }
    if (postBodyTension.present) {
      map['post_body_tension'] = Variable<int>(postBodyTension.value);
    }
    if (postClarity.present) {
      map['post_clarity'] = Variable<int>(postClarity.value);
    }
    if (helpfulnessRating.present) {
      map['helpfulness_rating'] = Variable<int>(helpfulnessRating.value);
    }
    if (postNote.present) {
      map['post_note'] = Variable<String>(postNote.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isDraft.present) {
      map['is_draft'] = Variable<bool>(isDraft.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SituationEntriesCompanion(')
          ..write('id: $id, ')
          ..write('situationDescription: $situationDescription, ')
          ..write('context: $context, ')
          ..write('timestamp: $timestamp, ')
          ..write('involvedPerson: $involvedPerson, ')
          ..write('intensity: $intensity, ')
          ..write('bodyTension: $bodyTension, ')
          ..write('primaryEmotion: $primaryEmotion, ')
          ..write('secondaryEmotion: $secondaryEmotion, ')
          ..write('bodySymptoms: $bodySymptoms, ')
          ..write('automaticThought: $automaticThought, ')
          ..write('firstImpulse: $firstImpulse, ')
          ..write('actualBehavior: $actualBehavior, ')
          ..write('needOrWoundedPoint: $needOrWoundedPoint, ')
          ..write('nextStep: $nextStep, ')
          ..write('systemState: $systemState, ')
          ..write('isCrisis: $isCrisis, ')
          ..write('interventionType: $interventionType, ')
          ..write('interventionId: $interventionId, ')
          ..write('interventionCompleted: $interventionCompleted, ')
          ..write('interventionDurationSec: $interventionDurationSec, ')
          ..write('postIntensity: $postIntensity, ')
          ..write('postBodyTension: $postBodyTension, ')
          ..write('postClarity: $postClarity, ')
          ..write('helpfulnessRating: $helpfulnessRating, ')
          ..write('postNote: $postNote, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDraft: $isDraft')
          ..write(')'))
        .toString();
  }
}

class $UserSettingsTable extends UserSettings
    with TableInfo<$UserSettingsTable, UserSettingsData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _onboardingCompletedMeta =
      const VerificationMeta('onboardingCompleted');
  @override
  late final GeneratedColumn<bool> onboardingCompleted = GeneratedColumn<bool>(
      'onboarding_completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("onboarding_completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isFirstLaunchMeta =
      const VerificationMeta('isFirstLaunch');
  @override
  late final GeneratedColumn<bool> isFirstLaunch = GeneratedColumn<bool>(
      'is_first_launch', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_first_launch" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _localeMeta = const VerificationMeta('locale');
  @override
  late final GeneratedColumn<String> locale = GeneratedColumn<String>(
      'locale', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('de'));
  static const VerificationMeta _notificationsEnabledMeta =
      const VerificationMeta('notificationsEnabled');
  @override
  late final GeneratedColumn<bool> notificationsEnabled = GeneratedColumn<bool>(
      'notifications_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("notifications_enabled" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _notificationTimesMeta =
      const VerificationMeta('notificationTimes');
  @override
  late final GeneratedColumn<String> notificationTimes =
      GeneratedColumn<String>('notification_times', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _discreteNotificationsMeta =
      const VerificationMeta('discreteNotifications');
  @override
  late final GeneratedColumn<bool> discreteNotifications =
      GeneratedColumn<bool>('discrete_notifications', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("discrete_notifications" IN (0, 1))'),
          defaultValue: const Constant(true));
  static const VerificationMeta _appLockEnabledMeta =
      const VerificationMeta('appLockEnabled');
  @override
  late final GeneratedColumn<bool> appLockEnabled = GeneratedColumn<bool>(
      'app_lock_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("app_lock_enabled" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _appLockTypeMeta =
      const VerificationMeta('appLockType');
  @override
  late final GeneratedColumn<String> appLockType = GeneratedColumn<String>(
      'app_lock_type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _themeModeMeta =
      const VerificationMeta('themeMode');
  @override
  late final GeneratedColumn<String> themeMode = GeneratedColumn<String>(
      'theme_mode', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('system'));
  static const VerificationMeta _emergencyContactsMeta =
      const VerificationMeta('emergencyContacts');
  @override
  late final GeneratedColumn<String> emergencyContacts =
      GeneratedColumn<String>('emergency_contacts', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _analyticsEnabledMeta =
      const VerificationMeta('analyticsEnabled');
  @override
  late final GeneratedColumn<bool> analyticsEnabled = GeneratedColumn<bool>(
      'analytics_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("analytics_enabled" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _lastBackupAtMeta =
      const VerificationMeta('lastBackupAt');
  @override
  late final GeneratedColumn<DateTime> lastBackupAt = GeneratedColumn<DateTime>(
      'last_backup_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _lastDataCleanupAtMeta =
      const VerificationMeta('lastDataCleanupAt');
  @override
  late final GeneratedColumn<DateTime> lastDataCleanupAt =
      GeneratedColumn<DateTime>('last_data_cleanup_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        onboardingCompleted,
        isFirstLaunch,
        locale,
        notificationsEnabled,
        notificationTimes,
        discreteNotifications,
        appLockEnabled,
        appLockType,
        themeMode,
        emergencyContacts,
        analyticsEnabled,
        lastBackupAt,
        lastDataCleanupAt,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_settings';
  @override
  VerificationContext validateIntegrity(Insertable<UserSettingsData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('onboarding_completed')) {
      context.handle(
          _onboardingCompletedMeta,
          onboardingCompleted.isAcceptableOrUnknown(
              data['onboarding_completed']!, _onboardingCompletedMeta));
    }
    if (data.containsKey('is_first_launch')) {
      context.handle(
          _isFirstLaunchMeta,
          isFirstLaunch.isAcceptableOrUnknown(
              data['is_first_launch']!, _isFirstLaunchMeta));
    }
    if (data.containsKey('locale')) {
      context.handle(_localeMeta,
          locale.isAcceptableOrUnknown(data['locale']!, _localeMeta));
    }
    if (data.containsKey('notifications_enabled')) {
      context.handle(
          _notificationsEnabledMeta,
          notificationsEnabled.isAcceptableOrUnknown(
              data['notifications_enabled']!, _notificationsEnabledMeta));
    }
    if (data.containsKey('notification_times')) {
      context.handle(
          _notificationTimesMeta,
          notificationTimes.isAcceptableOrUnknown(
              data['notification_times']!, _notificationTimesMeta));
    }
    if (data.containsKey('discrete_notifications')) {
      context.handle(
          _discreteNotificationsMeta,
          discreteNotifications.isAcceptableOrUnknown(
              data['discrete_notifications']!, _discreteNotificationsMeta));
    }
    if (data.containsKey('app_lock_enabled')) {
      context.handle(
          _appLockEnabledMeta,
          appLockEnabled.isAcceptableOrUnknown(
              data['app_lock_enabled']!, _appLockEnabledMeta));
    }
    if (data.containsKey('app_lock_type')) {
      context.handle(
          _appLockTypeMeta,
          appLockType.isAcceptableOrUnknown(
              data['app_lock_type']!, _appLockTypeMeta));
    }
    if (data.containsKey('theme_mode')) {
      context.handle(_themeModeMeta,
          themeMode.isAcceptableOrUnknown(data['theme_mode']!, _themeModeMeta));
    }
    if (data.containsKey('emergency_contacts')) {
      context.handle(
          _emergencyContactsMeta,
          emergencyContacts.isAcceptableOrUnknown(
              data['emergency_contacts']!, _emergencyContactsMeta));
    }
    if (data.containsKey('analytics_enabled')) {
      context.handle(
          _analyticsEnabledMeta,
          analyticsEnabled.isAcceptableOrUnknown(
              data['analytics_enabled']!, _analyticsEnabledMeta));
    }
    if (data.containsKey('last_backup_at')) {
      context.handle(
          _lastBackupAtMeta,
          lastBackupAt.isAcceptableOrUnknown(
              data['last_backup_at']!, _lastBackupAtMeta));
    }
    if (data.containsKey('last_data_cleanup_at')) {
      context.handle(
          _lastDataCleanupAtMeta,
          lastDataCleanupAt.isAcceptableOrUnknown(
              data['last_data_cleanup_at']!, _lastDataCleanupAtMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserSettingsData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserSettingsData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      onboardingCompleted: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}onboarding_completed'])!,
      isFirstLaunch: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_first_launch'])!,
      locale: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}locale'])!,
      notificationsEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}notifications_enabled'])!,
      notificationTimes: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}notification_times']),
      discreteNotifications: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}discrete_notifications'])!,
      appLockEnabled: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}app_lock_enabled'])!,
      appLockType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}app_lock_type']),
      themeMode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}theme_mode'])!,
      emergencyContacts: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}emergency_contacts']),
      analyticsEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}analytics_enabled'])!,
      lastBackupAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_backup_at']),
      lastDataCleanupAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}last_data_cleanup_at']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $UserSettingsTable createAlias(String alias) {
    return $UserSettingsTable(attachedDatabase, alias);
  }
}

class UserSettingsData extends DataClass
    implements Insertable<UserSettingsData> {
  final int id;
  final bool onboardingCompleted;
  final bool isFirstLaunch;
  final String locale;
  final bool notificationsEnabled;
  final String? notificationTimes;
  final bool discreteNotifications;
  final bool appLockEnabled;
  final String? appLockType;
  final String themeMode;
  final String? emergencyContacts;
  final bool analyticsEnabled;
  final DateTime? lastBackupAt;
  final DateTime? lastDataCleanupAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const UserSettingsData(
      {required this.id,
      required this.onboardingCompleted,
      required this.isFirstLaunch,
      required this.locale,
      required this.notificationsEnabled,
      this.notificationTimes,
      required this.discreteNotifications,
      required this.appLockEnabled,
      this.appLockType,
      required this.themeMode,
      this.emergencyContacts,
      required this.analyticsEnabled,
      this.lastBackupAt,
      this.lastDataCleanupAt,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['onboarding_completed'] = Variable<bool>(onboardingCompleted);
    map['is_first_launch'] = Variable<bool>(isFirstLaunch);
    map['locale'] = Variable<String>(locale);
    map['notifications_enabled'] = Variable<bool>(notificationsEnabled);
    if (!nullToAbsent || notificationTimes != null) {
      map['notification_times'] = Variable<String>(notificationTimes);
    }
    map['discrete_notifications'] = Variable<bool>(discreteNotifications);
    map['app_lock_enabled'] = Variable<bool>(appLockEnabled);
    if (!nullToAbsent || appLockType != null) {
      map['app_lock_type'] = Variable<String>(appLockType);
    }
    map['theme_mode'] = Variable<String>(themeMode);
    if (!nullToAbsent || emergencyContacts != null) {
      map['emergency_contacts'] = Variable<String>(emergencyContacts);
    }
    map['analytics_enabled'] = Variable<bool>(analyticsEnabled);
    if (!nullToAbsent || lastBackupAt != null) {
      map['last_backup_at'] = Variable<DateTime>(lastBackupAt);
    }
    if (!nullToAbsent || lastDataCleanupAt != null) {
      map['last_data_cleanup_at'] = Variable<DateTime>(lastDataCleanupAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserSettingsCompanion toCompanion(bool nullToAbsent) {
    return UserSettingsCompanion(
      id: Value(id),
      onboardingCompleted: Value(onboardingCompleted),
      isFirstLaunch: Value(isFirstLaunch),
      locale: Value(locale),
      notificationsEnabled: Value(notificationsEnabled),
      notificationTimes: notificationTimes == null && nullToAbsent
          ? const Value.absent()
          : Value(notificationTimes),
      discreteNotifications: Value(discreteNotifications),
      appLockEnabled: Value(appLockEnabled),
      appLockType: appLockType == null && nullToAbsent
          ? const Value.absent()
          : Value(appLockType),
      themeMode: Value(themeMode),
      emergencyContacts: emergencyContacts == null && nullToAbsent
          ? const Value.absent()
          : Value(emergencyContacts),
      analyticsEnabled: Value(analyticsEnabled),
      lastBackupAt: lastBackupAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastBackupAt),
      lastDataCleanupAt: lastDataCleanupAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastDataCleanupAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserSettingsData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserSettingsData(
      id: serializer.fromJson<int>(json['id']),
      onboardingCompleted:
          serializer.fromJson<bool>(json['onboardingCompleted']),
      isFirstLaunch: serializer.fromJson<bool>(json['isFirstLaunch']),
      locale: serializer.fromJson<String>(json['locale']),
      notificationsEnabled:
          serializer.fromJson<bool>(json['notificationsEnabled']),
      notificationTimes:
          serializer.fromJson<String?>(json['notificationTimes']),
      discreteNotifications:
          serializer.fromJson<bool>(json['discreteNotifications']),
      appLockEnabled: serializer.fromJson<bool>(json['appLockEnabled']),
      appLockType: serializer.fromJson<String?>(json['appLockType']),
      themeMode: serializer.fromJson<String>(json['themeMode']),
      emergencyContacts:
          serializer.fromJson<String?>(json['emergencyContacts']),
      analyticsEnabled: serializer.fromJson<bool>(json['analyticsEnabled']),
      lastBackupAt: serializer.fromJson<DateTime?>(json['lastBackupAt']),
      lastDataCleanupAt:
          serializer.fromJson<DateTime?>(json['lastDataCleanupAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'onboardingCompleted': serializer.toJson<bool>(onboardingCompleted),
      'isFirstLaunch': serializer.toJson<bool>(isFirstLaunch),
      'locale': serializer.toJson<String>(locale),
      'notificationsEnabled': serializer.toJson<bool>(notificationsEnabled),
      'notificationTimes': serializer.toJson<String?>(notificationTimes),
      'discreteNotifications': serializer.toJson<bool>(discreteNotifications),
      'appLockEnabled': serializer.toJson<bool>(appLockEnabled),
      'appLockType': serializer.toJson<String?>(appLockType),
      'themeMode': serializer.toJson<String>(themeMode),
      'emergencyContacts': serializer.toJson<String?>(emergencyContacts),
      'analyticsEnabled': serializer.toJson<bool>(analyticsEnabled),
      'lastBackupAt': serializer.toJson<DateTime?>(lastBackupAt),
      'lastDataCleanupAt': serializer.toJson<DateTime?>(lastDataCleanupAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserSettingsData copyWith(
          {int? id,
          bool? onboardingCompleted,
          bool? isFirstLaunch,
          String? locale,
          bool? notificationsEnabled,
          Value<String?> notificationTimes = const Value.absent(),
          bool? discreteNotifications,
          bool? appLockEnabled,
          Value<String?> appLockType = const Value.absent(),
          String? themeMode,
          Value<String?> emergencyContacts = const Value.absent(),
          bool? analyticsEnabled,
          Value<DateTime?> lastBackupAt = const Value.absent(),
          Value<DateTime?> lastDataCleanupAt = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      UserSettingsData(
        id: id ?? this.id,
        onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
        isFirstLaunch: isFirstLaunch ?? this.isFirstLaunch,
        locale: locale ?? this.locale,
        notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
        notificationTimes: notificationTimes.present
            ? notificationTimes.value
            : this.notificationTimes,
        discreteNotifications:
            discreteNotifications ?? this.discreteNotifications,
        appLockEnabled: appLockEnabled ?? this.appLockEnabled,
        appLockType: appLockType.present ? appLockType.value : this.appLockType,
        themeMode: themeMode ?? this.themeMode,
        emergencyContacts: emergencyContacts.present
            ? emergencyContacts.value
            : this.emergencyContacts,
        analyticsEnabled: analyticsEnabled ?? this.analyticsEnabled,
        lastBackupAt:
            lastBackupAt.present ? lastBackupAt.value : this.lastBackupAt,
        lastDataCleanupAt: lastDataCleanupAt.present
            ? lastDataCleanupAt.value
            : this.lastDataCleanupAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  UserSettingsData copyWithCompanion(UserSettingsCompanion data) {
    return UserSettingsData(
      id: data.id.present ? data.id.value : this.id,
      onboardingCompleted: data.onboardingCompleted.present
          ? data.onboardingCompleted.value
          : this.onboardingCompleted,
      isFirstLaunch: data.isFirstLaunch.present
          ? data.isFirstLaunch.value
          : this.isFirstLaunch,
      locale: data.locale.present ? data.locale.value : this.locale,
      notificationsEnabled: data.notificationsEnabled.present
          ? data.notificationsEnabled.value
          : this.notificationsEnabled,
      notificationTimes: data.notificationTimes.present
          ? data.notificationTimes.value
          : this.notificationTimes,
      discreteNotifications: data.discreteNotifications.present
          ? data.discreteNotifications.value
          : this.discreteNotifications,
      appLockEnabled: data.appLockEnabled.present
          ? data.appLockEnabled.value
          : this.appLockEnabled,
      appLockType:
          data.appLockType.present ? data.appLockType.value : this.appLockType,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      emergencyContacts: data.emergencyContacts.present
          ? data.emergencyContacts.value
          : this.emergencyContacts,
      analyticsEnabled: data.analyticsEnabled.present
          ? data.analyticsEnabled.value
          : this.analyticsEnabled,
      lastBackupAt: data.lastBackupAt.present
          ? data.lastBackupAt.value
          : this.lastBackupAt,
      lastDataCleanupAt: data.lastDataCleanupAt.present
          ? data.lastDataCleanupAt.value
          : this.lastDataCleanupAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserSettingsData(')
          ..write('id: $id, ')
          ..write('onboardingCompleted: $onboardingCompleted, ')
          ..write('isFirstLaunch: $isFirstLaunch, ')
          ..write('locale: $locale, ')
          ..write('notificationsEnabled: $notificationsEnabled, ')
          ..write('notificationTimes: $notificationTimes, ')
          ..write('discreteNotifications: $discreteNotifications, ')
          ..write('appLockEnabled: $appLockEnabled, ')
          ..write('appLockType: $appLockType, ')
          ..write('themeMode: $themeMode, ')
          ..write('emergencyContacts: $emergencyContacts, ')
          ..write('analyticsEnabled: $analyticsEnabled, ')
          ..write('lastBackupAt: $lastBackupAt, ')
          ..write('lastDataCleanupAt: $lastDataCleanupAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      onboardingCompleted,
      isFirstLaunch,
      locale,
      notificationsEnabled,
      notificationTimes,
      discreteNotifications,
      appLockEnabled,
      appLockType,
      themeMode,
      emergencyContacts,
      analyticsEnabled,
      lastBackupAt,
      lastDataCleanupAt,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserSettingsData &&
          other.id == this.id &&
          other.onboardingCompleted == this.onboardingCompleted &&
          other.isFirstLaunch == this.isFirstLaunch &&
          other.locale == this.locale &&
          other.notificationsEnabled == this.notificationsEnabled &&
          other.notificationTimes == this.notificationTimes &&
          other.discreteNotifications == this.discreteNotifications &&
          other.appLockEnabled == this.appLockEnabled &&
          other.appLockType == this.appLockType &&
          other.themeMode == this.themeMode &&
          other.emergencyContacts == this.emergencyContacts &&
          other.analyticsEnabled == this.analyticsEnabled &&
          other.lastBackupAt == this.lastBackupAt &&
          other.lastDataCleanupAt == this.lastDataCleanupAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UserSettingsCompanion extends UpdateCompanion<UserSettingsData> {
  final Value<int> id;
  final Value<bool> onboardingCompleted;
  final Value<bool> isFirstLaunch;
  final Value<String> locale;
  final Value<bool> notificationsEnabled;
  final Value<String?> notificationTimes;
  final Value<bool> discreteNotifications;
  final Value<bool> appLockEnabled;
  final Value<String?> appLockType;
  final Value<String> themeMode;
  final Value<String?> emergencyContacts;
  final Value<bool> analyticsEnabled;
  final Value<DateTime?> lastBackupAt;
  final Value<DateTime?> lastDataCleanupAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const UserSettingsCompanion({
    this.id = const Value.absent(),
    this.onboardingCompleted = const Value.absent(),
    this.isFirstLaunch = const Value.absent(),
    this.locale = const Value.absent(),
    this.notificationsEnabled = const Value.absent(),
    this.notificationTimes = const Value.absent(),
    this.discreteNotifications = const Value.absent(),
    this.appLockEnabled = const Value.absent(),
    this.appLockType = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.emergencyContacts = const Value.absent(),
    this.analyticsEnabled = const Value.absent(),
    this.lastBackupAt = const Value.absent(),
    this.lastDataCleanupAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UserSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.onboardingCompleted = const Value.absent(),
    this.isFirstLaunch = const Value.absent(),
    this.locale = const Value.absent(),
    this.notificationsEnabled = const Value.absent(),
    this.notificationTimes = const Value.absent(),
    this.discreteNotifications = const Value.absent(),
    this.appLockEnabled = const Value.absent(),
    this.appLockType = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.emergencyContacts = const Value.absent(),
    this.analyticsEnabled = const Value.absent(),
    this.lastBackupAt = const Value.absent(),
    this.lastDataCleanupAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  static Insertable<UserSettingsData> custom({
    Expression<int>? id,
    Expression<bool>? onboardingCompleted,
    Expression<bool>? isFirstLaunch,
    Expression<String>? locale,
    Expression<bool>? notificationsEnabled,
    Expression<String>? notificationTimes,
    Expression<bool>? discreteNotifications,
    Expression<bool>? appLockEnabled,
    Expression<String>? appLockType,
    Expression<String>? themeMode,
    Expression<String>? emergencyContacts,
    Expression<bool>? analyticsEnabled,
    Expression<DateTime>? lastBackupAt,
    Expression<DateTime>? lastDataCleanupAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (onboardingCompleted != null)
        'onboarding_completed': onboardingCompleted,
      if (isFirstLaunch != null) 'is_first_launch': isFirstLaunch,
      if (locale != null) 'locale': locale,
      if (notificationsEnabled != null)
        'notifications_enabled': notificationsEnabled,
      if (notificationTimes != null) 'notification_times': notificationTimes,
      if (discreteNotifications != null)
        'discrete_notifications': discreteNotifications,
      if (appLockEnabled != null) 'app_lock_enabled': appLockEnabled,
      if (appLockType != null) 'app_lock_type': appLockType,
      if (themeMode != null) 'theme_mode': themeMode,
      if (emergencyContacts != null) 'emergency_contacts': emergencyContacts,
      if (analyticsEnabled != null) 'analytics_enabled': analyticsEnabled,
      if (lastBackupAt != null) 'last_backup_at': lastBackupAt,
      if (lastDataCleanupAt != null) 'last_data_cleanup_at': lastDataCleanupAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UserSettingsCompanion copyWith(
      {Value<int>? id,
      Value<bool>? onboardingCompleted,
      Value<bool>? isFirstLaunch,
      Value<String>? locale,
      Value<bool>? notificationsEnabled,
      Value<String?>? notificationTimes,
      Value<bool>? discreteNotifications,
      Value<bool>? appLockEnabled,
      Value<String?>? appLockType,
      Value<String>? themeMode,
      Value<String?>? emergencyContacts,
      Value<bool>? analyticsEnabled,
      Value<DateTime?>? lastBackupAt,
      Value<DateTime?>? lastDataCleanupAt,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return UserSettingsCompanion(
      id: id ?? this.id,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      isFirstLaunch: isFirstLaunch ?? this.isFirstLaunch,
      locale: locale ?? this.locale,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      notificationTimes: notificationTimes ?? this.notificationTimes,
      discreteNotifications:
          discreteNotifications ?? this.discreteNotifications,
      appLockEnabled: appLockEnabled ?? this.appLockEnabled,
      appLockType: appLockType ?? this.appLockType,
      themeMode: themeMode ?? this.themeMode,
      emergencyContacts: emergencyContacts ?? this.emergencyContacts,
      analyticsEnabled: analyticsEnabled ?? this.analyticsEnabled,
      lastBackupAt: lastBackupAt ?? this.lastBackupAt,
      lastDataCleanupAt: lastDataCleanupAt ?? this.lastDataCleanupAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (onboardingCompleted.present) {
      map['onboarding_completed'] = Variable<bool>(onboardingCompleted.value);
    }
    if (isFirstLaunch.present) {
      map['is_first_launch'] = Variable<bool>(isFirstLaunch.value);
    }
    if (locale.present) {
      map['locale'] = Variable<String>(locale.value);
    }
    if (notificationsEnabled.present) {
      map['notifications_enabled'] = Variable<bool>(notificationsEnabled.value);
    }
    if (notificationTimes.present) {
      map['notification_times'] = Variable<String>(notificationTimes.value);
    }
    if (discreteNotifications.present) {
      map['discrete_notifications'] =
          Variable<bool>(discreteNotifications.value);
    }
    if (appLockEnabled.present) {
      map['app_lock_enabled'] = Variable<bool>(appLockEnabled.value);
    }
    if (appLockType.present) {
      map['app_lock_type'] = Variable<String>(appLockType.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(themeMode.value);
    }
    if (emergencyContacts.present) {
      map['emergency_contacts'] = Variable<String>(emergencyContacts.value);
    }
    if (analyticsEnabled.present) {
      map['analytics_enabled'] = Variable<bool>(analyticsEnabled.value);
    }
    if (lastBackupAt.present) {
      map['last_backup_at'] = Variable<DateTime>(lastBackupAt.value);
    }
    if (lastDataCleanupAt.present) {
      map['last_data_cleanup_at'] = Variable<DateTime>(lastDataCleanupAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserSettingsCompanion(')
          ..write('id: $id, ')
          ..write('onboardingCompleted: $onboardingCompleted, ')
          ..write('isFirstLaunch: $isFirstLaunch, ')
          ..write('locale: $locale, ')
          ..write('notificationsEnabled: $notificationsEnabled, ')
          ..write('notificationTimes: $notificationTimes, ')
          ..write('discreteNotifications: $discreteNotifications, ')
          ..write('appLockEnabled: $appLockEnabled, ')
          ..write('appLockType: $appLockType, ')
          ..write('themeMode: $themeMode, ')
          ..write('emergencyContacts: $emergencyContacts, ')
          ..write('analyticsEnabled: $analyticsEnabled, ')
          ..write('lastBackupAt: $lastBackupAt, ')
          ..write('lastDataCleanupAt: $lastDataCleanupAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $CrisisPlanTable extends CrisisPlan
    with TableInfo<$CrisisPlanTable, CrisisPlanData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CrisisPlanTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _warningSignsMeta =
      const VerificationMeta('warningSigns');
  @override
  late final GeneratedColumn<String> warningSigns = GeneratedColumn<String>(
      'warning_signs', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _copingStrategiesMeta =
      const VerificationMeta('copingStrategies');
  @override
  late final GeneratedColumn<String> copingStrategies = GeneratedColumn<String>(
      'coping_strategies', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _socialSupportMeta =
      const VerificationMeta('socialSupport');
  @override
  late final GeneratedColumn<String> socialSupport = GeneratedColumn<String>(
      'social_support', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _safeEnvironmentMeta =
      const VerificationMeta('safeEnvironment');
  @override
  late final GeneratedColumn<String> safeEnvironment = GeneratedColumn<String>(
      'safe_environment', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _professionalResourcesMeta =
      const VerificationMeta('professionalResources');
  @override
  late final GeneratedColumn<String> professionalResources =
      GeneratedColumn<String>('professional_resources', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _emergencyContactsMeta =
      const VerificationMeta('emergencyContacts');
  @override
  late final GeneratedColumn<String> emergencyContacts =
      GeneratedColumn<String>('emergency_contacts', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _localResourcesMeta =
      const VerificationMeta('localResources');
  @override
  late final GeneratedColumn<String> localResources = GeneratedColumn<String>(
      'local_resources', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _personalMotivationMeta =
      const VerificationMeta('personalMotivation');
  @override
  late final GeneratedColumn<String> personalMotivation =
      GeneratedColumn<String>('personal_motivation', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        warningSigns,
        copingStrategies,
        socialSupport,
        safeEnvironment,
        professionalResources,
        emergencyContacts,
        localResources,
        personalMotivation,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'crisis_plan';
  @override
  VerificationContext validateIntegrity(Insertable<CrisisPlanData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('warning_signs')) {
      context.handle(
          _warningSignsMeta,
          warningSigns.isAcceptableOrUnknown(
              data['warning_signs']!, _warningSignsMeta));
    }
    if (data.containsKey('coping_strategies')) {
      context.handle(
          _copingStrategiesMeta,
          copingStrategies.isAcceptableOrUnknown(
              data['coping_strategies']!, _copingStrategiesMeta));
    }
    if (data.containsKey('social_support')) {
      context.handle(
          _socialSupportMeta,
          socialSupport.isAcceptableOrUnknown(
              data['social_support']!, _socialSupportMeta));
    }
    if (data.containsKey('safe_environment')) {
      context.handle(
          _safeEnvironmentMeta,
          safeEnvironment.isAcceptableOrUnknown(
              data['safe_environment']!, _safeEnvironmentMeta));
    }
    if (data.containsKey('professional_resources')) {
      context.handle(
          _professionalResourcesMeta,
          professionalResources.isAcceptableOrUnknown(
              data['professional_resources']!, _professionalResourcesMeta));
    }
    if (data.containsKey('emergency_contacts')) {
      context.handle(
          _emergencyContactsMeta,
          emergencyContacts.isAcceptableOrUnknown(
              data['emergency_contacts']!, _emergencyContactsMeta));
    }
    if (data.containsKey('local_resources')) {
      context.handle(
          _localResourcesMeta,
          localResources.isAcceptableOrUnknown(
              data['local_resources']!, _localResourcesMeta));
    }
    if (data.containsKey('personal_motivation')) {
      context.handle(
          _personalMotivationMeta,
          personalMotivation.isAcceptableOrUnknown(
              data['personal_motivation']!, _personalMotivationMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CrisisPlanData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CrisisPlanData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      warningSigns: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}warning_signs']),
      copingStrategies: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}coping_strategies']),
      socialSupport: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}social_support']),
      safeEnvironment: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}safe_environment']),
      professionalResources: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}professional_resources']),
      emergencyContacts: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}emergency_contacts']),
      localResources: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}local_resources']),
      personalMotivation: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}personal_motivation']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $CrisisPlanTable createAlias(String alias) {
    return $CrisisPlanTable(attachedDatabase, alias);
  }
}

class CrisisPlanData extends DataClass implements Insertable<CrisisPlanData> {
  final int id;
  final String? warningSigns;
  final String? copingStrategies;
  final String? socialSupport;
  final String? safeEnvironment;
  final String? professionalResources;
  final String? emergencyContacts;
  final String? localResources;
  final String? personalMotivation;
  final DateTime createdAt;
  final DateTime updatedAt;
  const CrisisPlanData(
      {required this.id,
      this.warningSigns,
      this.copingStrategies,
      this.socialSupport,
      this.safeEnvironment,
      this.professionalResources,
      this.emergencyContacts,
      this.localResources,
      this.personalMotivation,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || warningSigns != null) {
      map['warning_signs'] = Variable<String>(warningSigns);
    }
    if (!nullToAbsent || copingStrategies != null) {
      map['coping_strategies'] = Variable<String>(copingStrategies);
    }
    if (!nullToAbsent || socialSupport != null) {
      map['social_support'] = Variable<String>(socialSupport);
    }
    if (!nullToAbsent || safeEnvironment != null) {
      map['safe_environment'] = Variable<String>(safeEnvironment);
    }
    if (!nullToAbsent || professionalResources != null) {
      map['professional_resources'] = Variable<String>(professionalResources);
    }
    if (!nullToAbsent || emergencyContacts != null) {
      map['emergency_contacts'] = Variable<String>(emergencyContacts);
    }
    if (!nullToAbsent || localResources != null) {
      map['local_resources'] = Variable<String>(localResources);
    }
    if (!nullToAbsent || personalMotivation != null) {
      map['personal_motivation'] = Variable<String>(personalMotivation);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CrisisPlanCompanion toCompanion(bool nullToAbsent) {
    return CrisisPlanCompanion(
      id: Value(id),
      warningSigns: warningSigns == null && nullToAbsent
          ? const Value.absent()
          : Value(warningSigns),
      copingStrategies: copingStrategies == null && nullToAbsent
          ? const Value.absent()
          : Value(copingStrategies),
      socialSupport: socialSupport == null && nullToAbsent
          ? const Value.absent()
          : Value(socialSupport),
      safeEnvironment: safeEnvironment == null && nullToAbsent
          ? const Value.absent()
          : Value(safeEnvironment),
      professionalResources: professionalResources == null && nullToAbsent
          ? const Value.absent()
          : Value(professionalResources),
      emergencyContacts: emergencyContacts == null && nullToAbsent
          ? const Value.absent()
          : Value(emergencyContacts),
      localResources: localResources == null && nullToAbsent
          ? const Value.absent()
          : Value(localResources),
      personalMotivation: personalMotivation == null && nullToAbsent
          ? const Value.absent()
          : Value(personalMotivation),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CrisisPlanData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CrisisPlanData(
      id: serializer.fromJson<int>(json['id']),
      warningSigns: serializer.fromJson<String?>(json['warningSigns']),
      copingStrategies: serializer.fromJson<String?>(json['copingStrategies']),
      socialSupport: serializer.fromJson<String?>(json['socialSupport']),
      safeEnvironment: serializer.fromJson<String?>(json['safeEnvironment']),
      professionalResources:
          serializer.fromJson<String?>(json['professionalResources']),
      emergencyContacts:
          serializer.fromJson<String?>(json['emergencyContacts']),
      localResources: serializer.fromJson<String?>(json['localResources']),
      personalMotivation:
          serializer.fromJson<String?>(json['personalMotivation']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'warningSigns': serializer.toJson<String?>(warningSigns),
      'copingStrategies': serializer.toJson<String?>(copingStrategies),
      'socialSupport': serializer.toJson<String?>(socialSupport),
      'safeEnvironment': serializer.toJson<String?>(safeEnvironment),
      'professionalResources':
          serializer.toJson<String?>(professionalResources),
      'emergencyContacts': serializer.toJson<String?>(emergencyContacts),
      'localResources': serializer.toJson<String?>(localResources),
      'personalMotivation': serializer.toJson<String?>(personalMotivation),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CrisisPlanData copyWith(
          {int? id,
          Value<String?> warningSigns = const Value.absent(),
          Value<String?> copingStrategies = const Value.absent(),
          Value<String?> socialSupport = const Value.absent(),
          Value<String?> safeEnvironment = const Value.absent(),
          Value<String?> professionalResources = const Value.absent(),
          Value<String?> emergencyContacts = const Value.absent(),
          Value<String?> localResources = const Value.absent(),
          Value<String?> personalMotivation = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      CrisisPlanData(
        id: id ?? this.id,
        warningSigns:
            warningSigns.present ? warningSigns.value : this.warningSigns,
        copingStrategies: copingStrategies.present
            ? copingStrategies.value
            : this.copingStrategies,
        socialSupport:
            socialSupport.present ? socialSupport.value : this.socialSupport,
        safeEnvironment: safeEnvironment.present
            ? safeEnvironment.value
            : this.safeEnvironment,
        professionalResources: professionalResources.present
            ? professionalResources.value
            : this.professionalResources,
        emergencyContacts: emergencyContacts.present
            ? emergencyContacts.value
            : this.emergencyContacts,
        localResources:
            localResources.present ? localResources.value : this.localResources,
        personalMotivation: personalMotivation.present
            ? personalMotivation.value
            : this.personalMotivation,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  CrisisPlanData copyWithCompanion(CrisisPlanCompanion data) {
    return CrisisPlanData(
      id: data.id.present ? data.id.value : this.id,
      warningSigns: data.warningSigns.present
          ? data.warningSigns.value
          : this.warningSigns,
      copingStrategies: data.copingStrategies.present
          ? data.copingStrategies.value
          : this.copingStrategies,
      socialSupport: data.socialSupport.present
          ? data.socialSupport.value
          : this.socialSupport,
      safeEnvironment: data.safeEnvironment.present
          ? data.safeEnvironment.value
          : this.safeEnvironment,
      professionalResources: data.professionalResources.present
          ? data.professionalResources.value
          : this.professionalResources,
      emergencyContacts: data.emergencyContacts.present
          ? data.emergencyContacts.value
          : this.emergencyContacts,
      localResources: data.localResources.present
          ? data.localResources.value
          : this.localResources,
      personalMotivation: data.personalMotivation.present
          ? data.personalMotivation.value
          : this.personalMotivation,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CrisisPlanData(')
          ..write('id: $id, ')
          ..write('warningSigns: $warningSigns, ')
          ..write('copingStrategies: $copingStrategies, ')
          ..write('socialSupport: $socialSupport, ')
          ..write('safeEnvironment: $safeEnvironment, ')
          ..write('professionalResources: $professionalResources, ')
          ..write('emergencyContacts: $emergencyContacts, ')
          ..write('localResources: $localResources, ')
          ..write('personalMotivation: $personalMotivation, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      warningSigns,
      copingStrategies,
      socialSupport,
      safeEnvironment,
      professionalResources,
      emergencyContacts,
      localResources,
      personalMotivation,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CrisisPlanData &&
          other.id == this.id &&
          other.warningSigns == this.warningSigns &&
          other.copingStrategies == this.copingStrategies &&
          other.socialSupport == this.socialSupport &&
          other.safeEnvironment == this.safeEnvironment &&
          other.professionalResources == this.professionalResources &&
          other.emergencyContacts == this.emergencyContacts &&
          other.localResources == this.localResources &&
          other.personalMotivation == this.personalMotivation &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CrisisPlanCompanion extends UpdateCompanion<CrisisPlanData> {
  final Value<int> id;
  final Value<String?> warningSigns;
  final Value<String?> copingStrategies;
  final Value<String?> socialSupport;
  final Value<String?> safeEnvironment;
  final Value<String?> professionalResources;
  final Value<String?> emergencyContacts;
  final Value<String?> localResources;
  final Value<String?> personalMotivation;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const CrisisPlanCompanion({
    this.id = const Value.absent(),
    this.warningSigns = const Value.absent(),
    this.copingStrategies = const Value.absent(),
    this.socialSupport = const Value.absent(),
    this.safeEnvironment = const Value.absent(),
    this.professionalResources = const Value.absent(),
    this.emergencyContacts = const Value.absent(),
    this.localResources = const Value.absent(),
    this.personalMotivation = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CrisisPlanCompanion.insert({
    this.id = const Value.absent(),
    this.warningSigns = const Value.absent(),
    this.copingStrategies = const Value.absent(),
    this.socialSupport = const Value.absent(),
    this.safeEnvironment = const Value.absent(),
    this.professionalResources = const Value.absent(),
    this.emergencyContacts = const Value.absent(),
    this.localResources = const Value.absent(),
    this.personalMotivation = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  static Insertable<CrisisPlanData> custom({
    Expression<int>? id,
    Expression<String>? warningSigns,
    Expression<String>? copingStrategies,
    Expression<String>? socialSupport,
    Expression<String>? safeEnvironment,
    Expression<String>? professionalResources,
    Expression<String>? emergencyContacts,
    Expression<String>? localResources,
    Expression<String>? personalMotivation,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (warningSigns != null) 'warning_signs': warningSigns,
      if (copingStrategies != null) 'coping_strategies': copingStrategies,
      if (socialSupport != null) 'social_support': socialSupport,
      if (safeEnvironment != null) 'safe_environment': safeEnvironment,
      if (professionalResources != null)
        'professional_resources': professionalResources,
      if (emergencyContacts != null) 'emergency_contacts': emergencyContacts,
      if (localResources != null) 'local_resources': localResources,
      if (personalMotivation != null) 'personal_motivation': personalMotivation,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CrisisPlanCompanion copyWith(
      {Value<int>? id,
      Value<String?>? warningSigns,
      Value<String?>? copingStrategies,
      Value<String?>? socialSupport,
      Value<String?>? safeEnvironment,
      Value<String?>? professionalResources,
      Value<String?>? emergencyContacts,
      Value<String?>? localResources,
      Value<String?>? personalMotivation,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return CrisisPlanCompanion(
      id: id ?? this.id,
      warningSigns: warningSigns ?? this.warningSigns,
      copingStrategies: copingStrategies ?? this.copingStrategies,
      socialSupport: socialSupport ?? this.socialSupport,
      safeEnvironment: safeEnvironment ?? this.safeEnvironment,
      professionalResources:
          professionalResources ?? this.professionalResources,
      emergencyContacts: emergencyContacts ?? this.emergencyContacts,
      localResources: localResources ?? this.localResources,
      personalMotivation: personalMotivation ?? this.personalMotivation,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (warningSigns.present) {
      map['warning_signs'] = Variable<String>(warningSigns.value);
    }
    if (copingStrategies.present) {
      map['coping_strategies'] = Variable<String>(copingStrategies.value);
    }
    if (socialSupport.present) {
      map['social_support'] = Variable<String>(socialSupport.value);
    }
    if (safeEnvironment.present) {
      map['safe_environment'] = Variable<String>(safeEnvironment.value);
    }
    if (professionalResources.present) {
      map['professional_resources'] =
          Variable<String>(professionalResources.value);
    }
    if (emergencyContacts.present) {
      map['emergency_contacts'] = Variable<String>(emergencyContacts.value);
    }
    if (localResources.present) {
      map['local_resources'] = Variable<String>(localResources.value);
    }
    if (personalMotivation.present) {
      map['personal_motivation'] = Variable<String>(personalMotivation.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CrisisPlanCompanion(')
          ..write('id: $id, ')
          ..write('warningSigns: $warningSigns, ')
          ..write('copingStrategies: $copingStrategies, ')
          ..write('socialSupport: $socialSupport, ')
          ..write('safeEnvironment: $safeEnvironment, ')
          ..write('professionalResources: $professionalResources, ')
          ..write('emergencyContacts: $emergencyContacts, ')
          ..write('localResources: $localResources, ')
          ..write('personalMotivation: $personalMotivation, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SituationEntriesTable situationEntries =
      $SituationEntriesTable(this);
  late final $UserSettingsTable userSettings = $UserSettingsTable(this);
  late final $CrisisPlanTable crisisPlan = $CrisisPlanTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [situationEntries, userSettings, crisisPlan];
}

typedef $$SituationEntriesTableCreateCompanionBuilder
    = SituationEntriesCompanion Function({
  Value<int> id,
  required String situationDescription,
  required String context,
  required DateTime timestamp,
  Value<String?> involvedPerson,
  required int intensity,
  required int bodyTension,
  required String primaryEmotion,
  Value<String?> secondaryEmotion,
  Value<String?> bodySymptoms,
  required String automaticThought,
  required String firstImpulse,
  Value<String?> actualBehavior,
  Value<String?> needOrWoundedPoint,
  Value<String?> nextStep,
  required String systemState,
  Value<bool> isCrisis,
  Value<String?> interventionType,
  Value<String?> interventionId,
  Value<bool> interventionCompleted,
  Value<int?> interventionDurationSec,
  Value<int?> postIntensity,
  Value<int?> postBodyTension,
  Value<int?> postClarity,
  Value<int?> helpfulnessRating,
  Value<String?> postNote,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<bool> isDraft,
});
typedef $$SituationEntriesTableUpdateCompanionBuilder
    = SituationEntriesCompanion Function({
  Value<int> id,
  Value<String> situationDescription,
  Value<String> context,
  Value<DateTime> timestamp,
  Value<String?> involvedPerson,
  Value<int> intensity,
  Value<int> bodyTension,
  Value<String> primaryEmotion,
  Value<String?> secondaryEmotion,
  Value<String?> bodySymptoms,
  Value<String> automaticThought,
  Value<String> firstImpulse,
  Value<String?> actualBehavior,
  Value<String?> needOrWoundedPoint,
  Value<String?> nextStep,
  Value<String> systemState,
  Value<bool> isCrisis,
  Value<String?> interventionType,
  Value<String?> interventionId,
  Value<bool> interventionCompleted,
  Value<int?> interventionDurationSec,
  Value<int?> postIntensity,
  Value<int?> postBodyTension,
  Value<int?> postClarity,
  Value<int?> helpfulnessRating,
  Value<String?> postNote,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<bool> isDraft,
});

class $$SituationEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $SituationEntriesTable> {
  $$SituationEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get situationDescription => $composableBuilder(
      column: $table.situationDescription,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get context => $composableBuilder(
      column: $table.context, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get involvedPerson => $composableBuilder(
      column: $table.involvedPerson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get intensity => $composableBuilder(
      column: $table.intensity, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get bodyTension => $composableBuilder(
      column: $table.bodyTension, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get primaryEmotion => $composableBuilder(
      column: $table.primaryEmotion,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get secondaryEmotion => $composableBuilder(
      column: $table.secondaryEmotion,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get bodySymptoms => $composableBuilder(
      column: $table.bodySymptoms, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get automaticThought => $composableBuilder(
      column: $table.automaticThought,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get firstImpulse => $composableBuilder(
      column: $table.firstImpulse, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get actualBehavior => $composableBuilder(
      column: $table.actualBehavior,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get needOrWoundedPoint => $composableBuilder(
      column: $table.needOrWoundedPoint,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nextStep => $composableBuilder(
      column: $table.nextStep, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get systemState => $composableBuilder(
      column: $table.systemState, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isCrisis => $composableBuilder(
      column: $table.isCrisis, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get interventionType => $composableBuilder(
      column: $table.interventionType,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get interventionId => $composableBuilder(
      column: $table.interventionId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get interventionCompleted => $composableBuilder(
      column: $table.interventionCompleted,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get interventionDurationSec => $composableBuilder(
      column: $table.interventionDurationSec,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get postIntensity => $composableBuilder(
      column: $table.postIntensity, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get postBodyTension => $composableBuilder(
      column: $table.postBodyTension,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get postClarity => $composableBuilder(
      column: $table.postClarity, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get helpfulnessRating => $composableBuilder(
      column: $table.helpfulnessRating,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get postNote => $composableBuilder(
      column: $table.postNote, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDraft => $composableBuilder(
      column: $table.isDraft, builder: (column) => ColumnFilters(column));
}

class $$SituationEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $SituationEntriesTable> {
  $$SituationEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get situationDescription => $composableBuilder(
      column: $table.situationDescription,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get context => $composableBuilder(
      column: $table.context, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get involvedPerson => $composableBuilder(
      column: $table.involvedPerson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get intensity => $composableBuilder(
      column: $table.intensity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get bodyTension => $composableBuilder(
      column: $table.bodyTension, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get primaryEmotion => $composableBuilder(
      column: $table.primaryEmotion,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get secondaryEmotion => $composableBuilder(
      column: $table.secondaryEmotion,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get bodySymptoms => $composableBuilder(
      column: $table.bodySymptoms,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get automaticThought => $composableBuilder(
      column: $table.automaticThought,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get firstImpulse => $composableBuilder(
      column: $table.firstImpulse,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get actualBehavior => $composableBuilder(
      column: $table.actualBehavior,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get needOrWoundedPoint => $composableBuilder(
      column: $table.needOrWoundedPoint,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nextStep => $composableBuilder(
      column: $table.nextStep, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get systemState => $composableBuilder(
      column: $table.systemState, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isCrisis => $composableBuilder(
      column: $table.isCrisis, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get interventionType => $composableBuilder(
      column: $table.interventionType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get interventionId => $composableBuilder(
      column: $table.interventionId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get interventionCompleted => $composableBuilder(
      column: $table.interventionCompleted,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get interventionDurationSec => $composableBuilder(
      column: $table.interventionDurationSec,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get postIntensity => $composableBuilder(
      column: $table.postIntensity,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get postBodyTension => $composableBuilder(
      column: $table.postBodyTension,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get postClarity => $composableBuilder(
      column: $table.postClarity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get helpfulnessRating => $composableBuilder(
      column: $table.helpfulnessRating,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get postNote => $composableBuilder(
      column: $table.postNote, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDraft => $composableBuilder(
      column: $table.isDraft, builder: (column) => ColumnOrderings(column));
}

class $$SituationEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SituationEntriesTable> {
  $$SituationEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get situationDescription => $composableBuilder(
      column: $table.situationDescription, builder: (column) => column);

  GeneratedColumn<String> get context =>
      $composableBuilder(column: $table.context, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get involvedPerson => $composableBuilder(
      column: $table.involvedPerson, builder: (column) => column);

  GeneratedColumn<int> get intensity =>
      $composableBuilder(column: $table.intensity, builder: (column) => column);

  GeneratedColumn<int> get bodyTension => $composableBuilder(
      column: $table.bodyTension, builder: (column) => column);

  GeneratedColumn<String> get primaryEmotion => $composableBuilder(
      column: $table.primaryEmotion, builder: (column) => column);

  GeneratedColumn<String> get secondaryEmotion => $composableBuilder(
      column: $table.secondaryEmotion, builder: (column) => column);

  GeneratedColumn<String> get bodySymptoms => $composableBuilder(
      column: $table.bodySymptoms, builder: (column) => column);

  GeneratedColumn<String> get automaticThought => $composableBuilder(
      column: $table.automaticThought, builder: (column) => column);

  GeneratedColumn<String> get firstImpulse => $composableBuilder(
      column: $table.firstImpulse, builder: (column) => column);

  GeneratedColumn<String> get actualBehavior => $composableBuilder(
      column: $table.actualBehavior, builder: (column) => column);

  GeneratedColumn<String> get needOrWoundedPoint => $composableBuilder(
      column: $table.needOrWoundedPoint, builder: (column) => column);

  GeneratedColumn<String> get nextStep =>
      $composableBuilder(column: $table.nextStep, builder: (column) => column);

  GeneratedColumn<String> get systemState => $composableBuilder(
      column: $table.systemState, builder: (column) => column);

  GeneratedColumn<bool> get isCrisis =>
      $composableBuilder(column: $table.isCrisis, builder: (column) => column);

  GeneratedColumn<String> get interventionType => $composableBuilder(
      column: $table.interventionType, builder: (column) => column);

  GeneratedColumn<String> get interventionId => $composableBuilder(
      column: $table.interventionId, builder: (column) => column);

  GeneratedColumn<bool> get interventionCompleted => $composableBuilder(
      column: $table.interventionCompleted, builder: (column) => column);

  GeneratedColumn<int> get interventionDurationSec => $composableBuilder(
      column: $table.interventionDurationSec, builder: (column) => column);

  GeneratedColumn<int> get postIntensity => $composableBuilder(
      column: $table.postIntensity, builder: (column) => column);

  GeneratedColumn<int> get postBodyTension => $composableBuilder(
      column: $table.postBodyTension, builder: (column) => column);

  GeneratedColumn<int> get postClarity => $composableBuilder(
      column: $table.postClarity, builder: (column) => column);

  GeneratedColumn<int> get helpfulnessRating => $composableBuilder(
      column: $table.helpfulnessRating, builder: (column) => column);

  GeneratedColumn<String> get postNote =>
      $composableBuilder(column: $table.postNote, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDraft =>
      $composableBuilder(column: $table.isDraft, builder: (column) => column);
}

class $$SituationEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SituationEntriesTable,
    SituationEntryData,
    $$SituationEntriesTableFilterComposer,
    $$SituationEntriesTableOrderingComposer,
    $$SituationEntriesTableAnnotationComposer,
    $$SituationEntriesTableCreateCompanionBuilder,
    $$SituationEntriesTableUpdateCompanionBuilder,
    (
      SituationEntryData,
      BaseReferences<_$AppDatabase, $SituationEntriesTable, SituationEntryData>
    ),
    SituationEntryData,
    PrefetchHooks Function()> {
  $$SituationEntriesTableTableManager(
      _$AppDatabase db, $SituationEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SituationEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SituationEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SituationEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> situationDescription = const Value.absent(),
            Value<String> context = const Value.absent(),
            Value<DateTime> timestamp = const Value.absent(),
            Value<String?> involvedPerson = const Value.absent(),
            Value<int> intensity = const Value.absent(),
            Value<int> bodyTension = const Value.absent(),
            Value<String> primaryEmotion = const Value.absent(),
            Value<String?> secondaryEmotion = const Value.absent(),
            Value<String?> bodySymptoms = const Value.absent(),
            Value<String> automaticThought = const Value.absent(),
            Value<String> firstImpulse = const Value.absent(),
            Value<String?> actualBehavior = const Value.absent(),
            Value<String?> needOrWoundedPoint = const Value.absent(),
            Value<String?> nextStep = const Value.absent(),
            Value<String> systemState = const Value.absent(),
            Value<bool> isCrisis = const Value.absent(),
            Value<String?> interventionType = const Value.absent(),
            Value<String?> interventionId = const Value.absent(),
            Value<bool> interventionCompleted = const Value.absent(),
            Value<int?> interventionDurationSec = const Value.absent(),
            Value<int?> postIntensity = const Value.absent(),
            Value<int?> postBodyTension = const Value.absent(),
            Value<int?> postClarity = const Value.absent(),
            Value<int?> helpfulnessRating = const Value.absent(),
            Value<String?> postNote = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<bool> isDraft = const Value.absent(),
          }) =>
              SituationEntriesCompanion(
            id: id,
            situationDescription: situationDescription,
            context: context,
            timestamp: timestamp,
            involvedPerson: involvedPerson,
            intensity: intensity,
            bodyTension: bodyTension,
            primaryEmotion: primaryEmotion,
            secondaryEmotion: secondaryEmotion,
            bodySymptoms: bodySymptoms,
            automaticThought: automaticThought,
            firstImpulse: firstImpulse,
            actualBehavior: actualBehavior,
            needOrWoundedPoint: needOrWoundedPoint,
            nextStep: nextStep,
            systemState: systemState,
            isCrisis: isCrisis,
            interventionType: interventionType,
            interventionId: interventionId,
            interventionCompleted: interventionCompleted,
            interventionDurationSec: interventionDurationSec,
            postIntensity: postIntensity,
            postBodyTension: postBodyTension,
            postClarity: postClarity,
            helpfulnessRating: helpfulnessRating,
            postNote: postNote,
            createdAt: createdAt,
            updatedAt: updatedAt,
            isDraft: isDraft,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String situationDescription,
            required String context,
            required DateTime timestamp,
            Value<String?> involvedPerson = const Value.absent(),
            required int intensity,
            required int bodyTension,
            required String primaryEmotion,
            Value<String?> secondaryEmotion = const Value.absent(),
            Value<String?> bodySymptoms = const Value.absent(),
            required String automaticThought,
            required String firstImpulse,
            Value<String?> actualBehavior = const Value.absent(),
            Value<String?> needOrWoundedPoint = const Value.absent(),
            Value<String?> nextStep = const Value.absent(),
            required String systemState,
            Value<bool> isCrisis = const Value.absent(),
            Value<String?> interventionType = const Value.absent(),
            Value<String?> interventionId = const Value.absent(),
            Value<bool> interventionCompleted = const Value.absent(),
            Value<int?> interventionDurationSec = const Value.absent(),
            Value<int?> postIntensity = const Value.absent(),
            Value<int?> postBodyTension = const Value.absent(),
            Value<int?> postClarity = const Value.absent(),
            Value<int?> helpfulnessRating = const Value.absent(),
            Value<String?> postNote = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<bool> isDraft = const Value.absent(),
          }) =>
              SituationEntriesCompanion.insert(
            id: id,
            situationDescription: situationDescription,
            context: context,
            timestamp: timestamp,
            involvedPerson: involvedPerson,
            intensity: intensity,
            bodyTension: bodyTension,
            primaryEmotion: primaryEmotion,
            secondaryEmotion: secondaryEmotion,
            bodySymptoms: bodySymptoms,
            automaticThought: automaticThought,
            firstImpulse: firstImpulse,
            actualBehavior: actualBehavior,
            needOrWoundedPoint: needOrWoundedPoint,
            nextStep: nextStep,
            systemState: systemState,
            isCrisis: isCrisis,
            interventionType: interventionType,
            interventionId: interventionId,
            interventionCompleted: interventionCompleted,
            interventionDurationSec: interventionDurationSec,
            postIntensity: postIntensity,
            postBodyTension: postBodyTension,
            postClarity: postClarity,
            helpfulnessRating: helpfulnessRating,
            postNote: postNote,
            createdAt: createdAt,
            updatedAt: updatedAt,
            isDraft: isDraft,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SituationEntriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SituationEntriesTable,
    SituationEntryData,
    $$SituationEntriesTableFilterComposer,
    $$SituationEntriesTableOrderingComposer,
    $$SituationEntriesTableAnnotationComposer,
    $$SituationEntriesTableCreateCompanionBuilder,
    $$SituationEntriesTableUpdateCompanionBuilder,
    (
      SituationEntryData,
      BaseReferences<_$AppDatabase, $SituationEntriesTable, SituationEntryData>
    ),
    SituationEntryData,
    PrefetchHooks Function()>;
typedef $$UserSettingsTableCreateCompanionBuilder = UserSettingsCompanion
    Function({
  Value<int> id,
  Value<bool> onboardingCompleted,
  Value<bool> isFirstLaunch,
  Value<String> locale,
  Value<bool> notificationsEnabled,
  Value<String?> notificationTimes,
  Value<bool> discreteNotifications,
  Value<bool> appLockEnabled,
  Value<String?> appLockType,
  Value<String> themeMode,
  Value<String?> emergencyContacts,
  Value<bool> analyticsEnabled,
  Value<DateTime?> lastBackupAt,
  Value<DateTime?> lastDataCleanupAt,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$UserSettingsTableUpdateCompanionBuilder = UserSettingsCompanion
    Function({
  Value<int> id,
  Value<bool> onboardingCompleted,
  Value<bool> isFirstLaunch,
  Value<String> locale,
  Value<bool> notificationsEnabled,
  Value<String?> notificationTimes,
  Value<bool> discreteNotifications,
  Value<bool> appLockEnabled,
  Value<String?> appLockType,
  Value<String> themeMode,
  Value<String?> emergencyContacts,
  Value<bool> analyticsEnabled,
  Value<DateTime?> lastBackupAt,
  Value<DateTime?> lastDataCleanupAt,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$UserSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $UserSettingsTable> {
  $$UserSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get onboardingCompleted => $composableBuilder(
      column: $table.onboardingCompleted,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isFirstLaunch => $composableBuilder(
      column: $table.isFirstLaunch, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get locale => $composableBuilder(
      column: $table.locale, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get notificationsEnabled => $composableBuilder(
      column: $table.notificationsEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notificationTimes => $composableBuilder(
      column: $table.notificationTimes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get discreteNotifications => $composableBuilder(
      column: $table.discreteNotifications,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get appLockEnabled => $composableBuilder(
      column: $table.appLockEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get appLockType => $composableBuilder(
      column: $table.appLockType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get themeMode => $composableBuilder(
      column: $table.themeMode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get emergencyContacts => $composableBuilder(
      column: $table.emergencyContacts,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get analyticsEnabled => $composableBuilder(
      column: $table.analyticsEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastBackupAt => $composableBuilder(
      column: $table.lastBackupAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastDataCleanupAt => $composableBuilder(
      column: $table.lastDataCleanupAt,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$UserSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $UserSettingsTable> {
  $$UserSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get onboardingCompleted => $composableBuilder(
      column: $table.onboardingCompleted,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isFirstLaunch => $composableBuilder(
      column: $table.isFirstLaunch,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get locale => $composableBuilder(
      column: $table.locale, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get notificationsEnabled => $composableBuilder(
      column: $table.notificationsEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notificationTimes => $composableBuilder(
      column: $table.notificationTimes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get discreteNotifications => $composableBuilder(
      column: $table.discreteNotifications,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get appLockEnabled => $composableBuilder(
      column: $table.appLockEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get appLockType => $composableBuilder(
      column: $table.appLockType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get themeMode => $composableBuilder(
      column: $table.themeMode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get emergencyContacts => $composableBuilder(
      column: $table.emergencyContacts,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get analyticsEnabled => $composableBuilder(
      column: $table.analyticsEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastBackupAt => $composableBuilder(
      column: $table.lastBackupAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastDataCleanupAt => $composableBuilder(
      column: $table.lastDataCleanupAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$UserSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserSettingsTable> {
  $$UserSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get onboardingCompleted => $composableBuilder(
      column: $table.onboardingCompleted, builder: (column) => column);

  GeneratedColumn<bool> get isFirstLaunch => $composableBuilder(
      column: $table.isFirstLaunch, builder: (column) => column);

  GeneratedColumn<String> get locale =>
      $composableBuilder(column: $table.locale, builder: (column) => column);

  GeneratedColumn<bool> get notificationsEnabled => $composableBuilder(
      column: $table.notificationsEnabled, builder: (column) => column);

  GeneratedColumn<String> get notificationTimes => $composableBuilder(
      column: $table.notificationTimes, builder: (column) => column);

  GeneratedColumn<bool> get discreteNotifications => $composableBuilder(
      column: $table.discreteNotifications, builder: (column) => column);

  GeneratedColumn<bool> get appLockEnabled => $composableBuilder(
      column: $table.appLockEnabled, builder: (column) => column);

  GeneratedColumn<String> get appLockType => $composableBuilder(
      column: $table.appLockType, builder: (column) => column);

  GeneratedColumn<String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumn<String> get emergencyContacts => $composableBuilder(
      column: $table.emergencyContacts, builder: (column) => column);

  GeneratedColumn<bool> get analyticsEnabled => $composableBuilder(
      column: $table.analyticsEnabled, builder: (column) => column);

  GeneratedColumn<DateTime> get lastBackupAt => $composableBuilder(
      column: $table.lastBackupAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastDataCleanupAt => $composableBuilder(
      column: $table.lastDataCleanupAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$UserSettingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserSettingsTable,
    UserSettingsData,
    $$UserSettingsTableFilterComposer,
    $$UserSettingsTableOrderingComposer,
    $$UserSettingsTableAnnotationComposer,
    $$UserSettingsTableCreateCompanionBuilder,
    $$UserSettingsTableUpdateCompanionBuilder,
    (
      UserSettingsData,
      BaseReferences<_$AppDatabase, $UserSettingsTable, UserSettingsData>
    ),
    UserSettingsData,
    PrefetchHooks Function()> {
  $$UserSettingsTableTableManager(_$AppDatabase db, $UserSettingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<bool> onboardingCompleted = const Value.absent(),
            Value<bool> isFirstLaunch = const Value.absent(),
            Value<String> locale = const Value.absent(),
            Value<bool> notificationsEnabled = const Value.absent(),
            Value<String?> notificationTimes = const Value.absent(),
            Value<bool> discreteNotifications = const Value.absent(),
            Value<bool> appLockEnabled = const Value.absent(),
            Value<String?> appLockType = const Value.absent(),
            Value<String> themeMode = const Value.absent(),
            Value<String?> emergencyContacts = const Value.absent(),
            Value<bool> analyticsEnabled = const Value.absent(),
            Value<DateTime?> lastBackupAt = const Value.absent(),
            Value<DateTime?> lastDataCleanupAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              UserSettingsCompanion(
            id: id,
            onboardingCompleted: onboardingCompleted,
            isFirstLaunch: isFirstLaunch,
            locale: locale,
            notificationsEnabled: notificationsEnabled,
            notificationTimes: notificationTimes,
            discreteNotifications: discreteNotifications,
            appLockEnabled: appLockEnabled,
            appLockType: appLockType,
            themeMode: themeMode,
            emergencyContacts: emergencyContacts,
            analyticsEnabled: analyticsEnabled,
            lastBackupAt: lastBackupAt,
            lastDataCleanupAt: lastDataCleanupAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<bool> onboardingCompleted = const Value.absent(),
            Value<bool> isFirstLaunch = const Value.absent(),
            Value<String> locale = const Value.absent(),
            Value<bool> notificationsEnabled = const Value.absent(),
            Value<String?> notificationTimes = const Value.absent(),
            Value<bool> discreteNotifications = const Value.absent(),
            Value<bool> appLockEnabled = const Value.absent(),
            Value<String?> appLockType = const Value.absent(),
            Value<String> themeMode = const Value.absent(),
            Value<String?> emergencyContacts = const Value.absent(),
            Value<bool> analyticsEnabled = const Value.absent(),
            Value<DateTime?> lastBackupAt = const Value.absent(),
            Value<DateTime?> lastDataCleanupAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              UserSettingsCompanion.insert(
            id: id,
            onboardingCompleted: onboardingCompleted,
            isFirstLaunch: isFirstLaunch,
            locale: locale,
            notificationsEnabled: notificationsEnabled,
            notificationTimes: notificationTimes,
            discreteNotifications: discreteNotifications,
            appLockEnabled: appLockEnabled,
            appLockType: appLockType,
            themeMode: themeMode,
            emergencyContacts: emergencyContacts,
            analyticsEnabled: analyticsEnabled,
            lastBackupAt: lastBackupAt,
            lastDataCleanupAt: lastDataCleanupAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UserSettingsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UserSettingsTable,
    UserSettingsData,
    $$UserSettingsTableFilterComposer,
    $$UserSettingsTableOrderingComposer,
    $$UserSettingsTableAnnotationComposer,
    $$UserSettingsTableCreateCompanionBuilder,
    $$UserSettingsTableUpdateCompanionBuilder,
    (
      UserSettingsData,
      BaseReferences<_$AppDatabase, $UserSettingsTable, UserSettingsData>
    ),
    UserSettingsData,
    PrefetchHooks Function()>;
typedef $$CrisisPlanTableCreateCompanionBuilder = CrisisPlanCompanion Function({
  Value<int> id,
  Value<String?> warningSigns,
  Value<String?> copingStrategies,
  Value<String?> socialSupport,
  Value<String?> safeEnvironment,
  Value<String?> professionalResources,
  Value<String?> emergencyContacts,
  Value<String?> localResources,
  Value<String?> personalMotivation,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$CrisisPlanTableUpdateCompanionBuilder = CrisisPlanCompanion Function({
  Value<int> id,
  Value<String?> warningSigns,
  Value<String?> copingStrategies,
  Value<String?> socialSupport,
  Value<String?> safeEnvironment,
  Value<String?> professionalResources,
  Value<String?> emergencyContacts,
  Value<String?> localResources,
  Value<String?> personalMotivation,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$CrisisPlanTableFilterComposer
    extends Composer<_$AppDatabase, $CrisisPlanTable> {
  $$CrisisPlanTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get warningSigns => $composableBuilder(
      column: $table.warningSigns, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get copingStrategies => $composableBuilder(
      column: $table.copingStrategies,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get socialSupport => $composableBuilder(
      column: $table.socialSupport, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get safeEnvironment => $composableBuilder(
      column: $table.safeEnvironment,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get professionalResources => $composableBuilder(
      column: $table.professionalResources,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get emergencyContacts => $composableBuilder(
      column: $table.emergencyContacts,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get localResources => $composableBuilder(
      column: $table.localResources,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get personalMotivation => $composableBuilder(
      column: $table.personalMotivation,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$CrisisPlanTableOrderingComposer
    extends Composer<_$AppDatabase, $CrisisPlanTable> {
  $$CrisisPlanTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get warningSigns => $composableBuilder(
      column: $table.warningSigns,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get copingStrategies => $composableBuilder(
      column: $table.copingStrategies,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get socialSupport => $composableBuilder(
      column: $table.socialSupport,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get safeEnvironment => $composableBuilder(
      column: $table.safeEnvironment,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get professionalResources => $composableBuilder(
      column: $table.professionalResources,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get emergencyContacts => $composableBuilder(
      column: $table.emergencyContacts,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get localResources => $composableBuilder(
      column: $table.localResources,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get personalMotivation => $composableBuilder(
      column: $table.personalMotivation,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$CrisisPlanTableAnnotationComposer
    extends Composer<_$AppDatabase, $CrisisPlanTable> {
  $$CrisisPlanTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get warningSigns => $composableBuilder(
      column: $table.warningSigns, builder: (column) => column);

  GeneratedColumn<String> get copingStrategies => $composableBuilder(
      column: $table.copingStrategies, builder: (column) => column);

  GeneratedColumn<String> get socialSupport => $composableBuilder(
      column: $table.socialSupport, builder: (column) => column);

  GeneratedColumn<String> get safeEnvironment => $composableBuilder(
      column: $table.safeEnvironment, builder: (column) => column);

  GeneratedColumn<String> get professionalResources => $composableBuilder(
      column: $table.professionalResources, builder: (column) => column);

  GeneratedColumn<String> get emergencyContacts => $composableBuilder(
      column: $table.emergencyContacts, builder: (column) => column);

  GeneratedColumn<String> get localResources => $composableBuilder(
      column: $table.localResources, builder: (column) => column);

  GeneratedColumn<String> get personalMotivation => $composableBuilder(
      column: $table.personalMotivation, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CrisisPlanTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CrisisPlanTable,
    CrisisPlanData,
    $$CrisisPlanTableFilterComposer,
    $$CrisisPlanTableOrderingComposer,
    $$CrisisPlanTableAnnotationComposer,
    $$CrisisPlanTableCreateCompanionBuilder,
    $$CrisisPlanTableUpdateCompanionBuilder,
    (
      CrisisPlanData,
      BaseReferences<_$AppDatabase, $CrisisPlanTable, CrisisPlanData>
    ),
    CrisisPlanData,
    PrefetchHooks Function()> {
  $$CrisisPlanTableTableManager(_$AppDatabase db, $CrisisPlanTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CrisisPlanTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CrisisPlanTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CrisisPlanTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> warningSigns = const Value.absent(),
            Value<String?> copingStrategies = const Value.absent(),
            Value<String?> socialSupport = const Value.absent(),
            Value<String?> safeEnvironment = const Value.absent(),
            Value<String?> professionalResources = const Value.absent(),
            Value<String?> emergencyContacts = const Value.absent(),
            Value<String?> localResources = const Value.absent(),
            Value<String?> personalMotivation = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              CrisisPlanCompanion(
            id: id,
            warningSigns: warningSigns,
            copingStrategies: copingStrategies,
            socialSupport: socialSupport,
            safeEnvironment: safeEnvironment,
            professionalResources: professionalResources,
            emergencyContacts: emergencyContacts,
            localResources: localResources,
            personalMotivation: personalMotivation,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> warningSigns = const Value.absent(),
            Value<String?> copingStrategies = const Value.absent(),
            Value<String?> socialSupport = const Value.absent(),
            Value<String?> safeEnvironment = const Value.absent(),
            Value<String?> professionalResources = const Value.absent(),
            Value<String?> emergencyContacts = const Value.absent(),
            Value<String?> localResources = const Value.absent(),
            Value<String?> personalMotivation = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              CrisisPlanCompanion.insert(
            id: id,
            warningSigns: warningSigns,
            copingStrategies: copingStrategies,
            socialSupport: socialSupport,
            safeEnvironment: safeEnvironment,
            professionalResources: professionalResources,
            emergencyContacts: emergencyContacts,
            localResources: localResources,
            personalMotivation: personalMotivation,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CrisisPlanTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CrisisPlanTable,
    CrisisPlanData,
    $$CrisisPlanTableFilterComposer,
    $$CrisisPlanTableOrderingComposer,
    $$CrisisPlanTableAnnotationComposer,
    $$CrisisPlanTableCreateCompanionBuilder,
    $$CrisisPlanTableUpdateCompanionBuilder,
    (
      CrisisPlanData,
      BaseReferences<_$AppDatabase, $CrisisPlanTable, CrisisPlanData>
    ),
    CrisisPlanData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SituationEntriesTableTableManager get situationEntries =>
      $$SituationEntriesTableTableManager(_db, _db.situationEntries);
  $$UserSettingsTableTableManager get userSettings =>
      $$UserSettingsTableTableManager(_db, _db.userSettings);
  $$CrisisPlanTableTableManager get crisisPlan =>
      $$CrisisPlanTableTableManager(_db, _db.crisisPlan);
}
