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
  static const VerificationMeta _involvedEntitiesMeta =
      const VerificationMeta('involvedEntities');
  @override
  late final GeneratedColumn<String> involvedEntities = GeneratedColumn<String>(
      'involved_entities', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _preTriggerPreoccupationMeta =
      const VerificationMeta('preTriggerPreoccupation');
  @override
  late final GeneratedColumn<String> preTriggerPreoccupation =
      GeneratedColumn<String>('pre_trigger_preoccupation', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _problemTimingMeta =
      const VerificationMeta('problemTiming');
  @override
  late final GeneratedColumn<String> problemTiming = GeneratedColumn<String>(
      'problem_timing', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _triggerDescriptionMeta =
      const VerificationMeta('triggerDescription');
  @override
  late final GeneratedColumn<String> triggerDescription =
      GeneratedColumn<String>('trigger_description', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _preTriggerLoadMeta =
      const VerificationMeta('preTriggerLoad');
  @override
  late final GeneratedColumn<int> preTriggerLoad = GeneratedColumn<int>(
      'pre_trigger_load', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
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
  static const VerificationMeta _initialBodyReactionsMeta =
      const VerificationMeta('initialBodyReactions');
  @override
  late final GeneratedColumn<String> initialBodyReactions =
      GeneratedColumn<String>('initial_body_reactions', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _additionalEmotionsMeta =
      const VerificationMeta('additionalEmotions');
  @override
  late final GeneratedColumn<String> additionalEmotions =
      GeneratedColumn<String>('additional_emotions', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _thoughtFocusMeta =
      const VerificationMeta('thoughtFocus');
  @override
  late final GeneratedColumn<String> thoughtFocus = GeneratedColumn<String>(
      'thought_focus', aliasedName, true,
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
  static const VerificationMeta _factInterpretationResultMeta =
      const VerificationMeta('factInterpretationResult');
  @override
  late final GeneratedColumn<String> factInterpretationResult =
      GeneratedColumn<String>('fact_interpretation_result', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _systemReactionMeta =
      const VerificationMeta('systemReaction');
  @override
  late final GeneratedColumn<String> systemReaction = GeneratedColumn<String>(
      'system_reaction', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _thoughtPatternsMeta =
      const VerificationMeta('thoughtPatterns');
  @override
  late final GeneratedColumn<String> thoughtPatterns = GeneratedColumn<String>(
      'thought_patterns', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _actualBehaviorTagsMeta =
      const VerificationMeta('actualBehaviorTags');
  @override
  late final GeneratedColumn<String> actualBehaviorTags =
      GeneratedColumn<String>('actual_behavior_tags', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _actualBehaviorMeta =
      const VerificationMeta('actualBehavior');
  @override
  late final GeneratedColumn<String> actualBehavior = GeneratedColumn<String>(
      'actual_behavior', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _tippingPointAwarenessMeta =
      const VerificationMeta('tippingPointAwareness');
  @override
  late final GeneratedColumn<String> tippingPointAwareness =
      GeneratedColumn<String>('tipping_point_awareness', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fearOrPressurePointMeta =
      const VerificationMeta('fearOrPressurePoint');
  @override
  late final GeneratedColumn<String> fearOrPressurePoint =
      GeneratedColumn<String>('fear_or_pressure_point', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _needOrWoundedPointMeta =
      const VerificationMeta('needOrWoundedPoint');
  @override
  late final GeneratedColumn<String> needOrWoundedPoint =
      GeneratedColumn<String>('need_or_wounded_point', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _touchedThemesMeta =
      const VerificationMeta('touchedThemes');
  @override
  late final GeneratedColumn<String> touchedThemes = GeneratedColumn<String>(
      'touched_themes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _neededSupportsMeta =
      const VerificationMeta('neededSupports');
  @override
  late final GeneratedColumn<String> neededSupports = GeneratedColumn<String>(
      'needed_supports', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _realisticAlternativeMeta =
      const VerificationMeta('realisticAlternative');
  @override
  late final GeneratedColumn<String> realisticAlternative =
      GeneratedColumn<String>('realistic_alternative', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _triggerAsLastDropMeta =
      const VerificationMeta('triggerAsLastDrop');
  @override
  late final GeneratedColumn<String> triggerAsLastDrop =
      GeneratedColumn<String>('trigger_as_last_drop', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _backgroundThemeMeta =
      const VerificationMeta('backgroundTheme');
  @override
  late final GeneratedColumn<String> backgroundTheme = GeneratedColumn<String>(
      'background_theme', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _preEscalationReliefMeta =
      const VerificationMeta('preEscalationRelief');
  @override
  late final GeneratedColumn<String> preEscalationRelief =
      GeneratedColumn<String>('pre_escalation_relief', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _patternFamiliarityMeta =
      const VerificationMeta('patternFamiliarity');
  @override
  late final GeneratedColumn<String> patternFamiliarity =
      GeneratedColumn<String>('pattern_familiarity', aliasedName, true,
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
  static const VerificationMeta _evaluationHeadlineKeyMeta =
      const VerificationMeta('evaluationHeadlineKey');
  @override
  late final GeneratedColumn<String> evaluationHeadlineKey =
      GeneratedColumn<String>('evaluation_headline_key', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _evaluationMeaningKeyMeta =
      const VerificationMeta('evaluationMeaningKey');
  @override
  late final GeneratedColumn<String> evaluationMeaningKey =
      GeneratedColumn<String>('evaluation_meaning_key', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _evaluationHelpfulNowKeyMeta =
      const VerificationMeta('evaluationHelpfulNowKey');
  @override
  late final GeneratedColumn<String> evaluationHelpfulNowKey =
      GeneratedColumn<String>('evaluation_helpful_now_key', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _evaluationLearningPointKeyMeta =
      const VerificationMeta('evaluationLearningPointKey');
  @override
  late final GeneratedColumn<String> evaluationLearningPointKey =
      GeneratedColumn<String>(
          'evaluation_learning_point_key', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _evaluationStatusKeysMeta =
      const VerificationMeta('evaluationStatusKeys');
  @override
  late final GeneratedColumn<String> evaluationStatusKeys =
      GeneratedColumn<String>('evaluation_status_keys', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _suggestedTipIdsMeta =
      const VerificationMeta('suggestedTipIds');
  @override
  late final GeneratedColumn<String> suggestedTipIds = GeneratedColumn<String>(
      'suggested_tip_ids', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _suggestedNextActionKeyMeta =
      const VerificationMeta('suggestedNextActionKey');
  @override
  late final GeneratedColumn<String> suggestedNextActionKey =
      GeneratedColumn<String>('suggested_next_action_key', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _selectedNextActionKeyMeta =
      const VerificationMeta('selectedNextActionKey');
  @override
  late final GeneratedColumn<String> selectedNextActionKey =
      GeneratedColumn<String>('selected_next_action_key', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _aiEvaluationStatusMeta =
      const VerificationMeta('aiEvaluationStatus');
  @override
  late final GeneratedColumn<String> aiEvaluationStatus =
      GeneratedColumn<String>('ai_evaluation_status', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _aiEvaluationProviderMeta =
      const VerificationMeta('aiEvaluationProvider');
  @override
  late final GeneratedColumn<String> aiEvaluationProvider =
      GeneratedColumn<String>('ai_evaluation_provider', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _aiEvaluationModelMeta =
      const VerificationMeta('aiEvaluationModel');
  @override
  late final GeneratedColumn<String> aiEvaluationModel =
      GeneratedColumn<String>('ai_evaluation_model', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _aiEvaluationRequestedAtMeta =
      const VerificationMeta('aiEvaluationRequestedAt');
  @override
  late final GeneratedColumn<DateTime> aiEvaluationRequestedAt =
      GeneratedColumn<DateTime>('ai_evaluation_requested_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _aiEvaluationCompletedAtMeta =
      const VerificationMeta('aiEvaluationCompletedAt');
  @override
  late final GeneratedColumn<DateTime> aiEvaluationCompletedAt =
      GeneratedColumn<DateTime>('ai_evaluation_completed_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _aiEvaluationConsentGivenMeta =
      const VerificationMeta('aiEvaluationConsentGiven');
  @override
  late final GeneratedColumn<bool> aiEvaluationConsentGiven =
      GeneratedColumn<bool>(
          'ai_evaluation_consent_given', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("ai_evaluation_consent_given" IN (0, 1))'),
          defaultValue: const Constant(false));
  static const VerificationMeta _aiEvaluationTextMeta =
      const VerificationMeta('aiEvaluationText');
  @override
  late final GeneratedColumn<String> aiEvaluationText = GeneratedColumn<String>(
      'ai_evaluation_text', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _aiEvaluationSchemaVersionMeta =
      const VerificationMeta('aiEvaluationSchemaVersion');
  @override
  late final GeneratedColumn<int> aiEvaluationSchemaVersion =
      GeneratedColumn<int>('ai_evaluation_schema_version', aliasedName, true,
          type: DriftSqlType.int, requiredDuringInsert: false);
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
        involvedEntities,
        preTriggerPreoccupation,
        problemTiming,
        triggerDescription,
        preTriggerLoad,
        intensity,
        bodyTension,
        primaryEmotion,
        secondaryEmotion,
        bodySymptoms,
        initialBodyReactions,
        additionalEmotions,
        thoughtFocus,
        automaticThought,
        firstImpulse,
        factInterpretationResult,
        systemReaction,
        thoughtPatterns,
        actualBehaviorTags,
        actualBehavior,
        tippingPointAwareness,
        fearOrPressurePoint,
        needOrWoundedPoint,
        touchedThemes,
        neededSupports,
        realisticAlternative,
        triggerAsLastDrop,
        backgroundTheme,
        preEscalationRelief,
        patternFamiliarity,
        nextStep,
        systemState,
        isCrisis,
        evaluationHeadlineKey,
        evaluationMeaningKey,
        evaluationHelpfulNowKey,
        evaluationLearningPointKey,
        evaluationStatusKeys,
        suggestedTipIds,
        suggestedNextActionKey,
        selectedNextActionKey,
        aiEvaluationStatus,
        aiEvaluationProvider,
        aiEvaluationModel,
        aiEvaluationRequestedAt,
        aiEvaluationCompletedAt,
        aiEvaluationConsentGiven,
        aiEvaluationText,
        aiEvaluationSchemaVersion,
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
    if (data.containsKey('involved_entities')) {
      context.handle(
          _involvedEntitiesMeta,
          involvedEntities.isAcceptableOrUnknown(
              data['involved_entities']!, _involvedEntitiesMeta));
    }
    if (data.containsKey('pre_trigger_preoccupation')) {
      context.handle(
          _preTriggerPreoccupationMeta,
          preTriggerPreoccupation.isAcceptableOrUnknown(
              data['pre_trigger_preoccupation']!,
              _preTriggerPreoccupationMeta));
    }
    if (data.containsKey('problem_timing')) {
      context.handle(
          _problemTimingMeta,
          problemTiming.isAcceptableOrUnknown(
              data['problem_timing']!, _problemTimingMeta));
    }
    if (data.containsKey('trigger_description')) {
      context.handle(
          _triggerDescriptionMeta,
          triggerDescription.isAcceptableOrUnknown(
              data['trigger_description']!, _triggerDescriptionMeta));
    }
    if (data.containsKey('pre_trigger_load')) {
      context.handle(
          _preTriggerLoadMeta,
          preTriggerLoad.isAcceptableOrUnknown(
              data['pre_trigger_load']!, _preTriggerLoadMeta));
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
    if (data.containsKey('initial_body_reactions')) {
      context.handle(
          _initialBodyReactionsMeta,
          initialBodyReactions.isAcceptableOrUnknown(
              data['initial_body_reactions']!, _initialBodyReactionsMeta));
    }
    if (data.containsKey('additional_emotions')) {
      context.handle(
          _additionalEmotionsMeta,
          additionalEmotions.isAcceptableOrUnknown(
              data['additional_emotions']!, _additionalEmotionsMeta));
    }
    if (data.containsKey('thought_focus')) {
      context.handle(
          _thoughtFocusMeta,
          thoughtFocus.isAcceptableOrUnknown(
              data['thought_focus']!, _thoughtFocusMeta));
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
    if (data.containsKey('fact_interpretation_result')) {
      context.handle(
          _factInterpretationResultMeta,
          factInterpretationResult.isAcceptableOrUnknown(
              data['fact_interpretation_result']!,
              _factInterpretationResultMeta));
    }
    if (data.containsKey('system_reaction')) {
      context.handle(
          _systemReactionMeta,
          systemReaction.isAcceptableOrUnknown(
              data['system_reaction']!, _systemReactionMeta));
    }
    if (data.containsKey('thought_patterns')) {
      context.handle(
          _thoughtPatternsMeta,
          thoughtPatterns.isAcceptableOrUnknown(
              data['thought_patterns']!, _thoughtPatternsMeta));
    }
    if (data.containsKey('actual_behavior_tags')) {
      context.handle(
          _actualBehaviorTagsMeta,
          actualBehaviorTags.isAcceptableOrUnknown(
              data['actual_behavior_tags']!, _actualBehaviorTagsMeta));
    }
    if (data.containsKey('actual_behavior')) {
      context.handle(
          _actualBehaviorMeta,
          actualBehavior.isAcceptableOrUnknown(
              data['actual_behavior']!, _actualBehaviorMeta));
    }
    if (data.containsKey('tipping_point_awareness')) {
      context.handle(
          _tippingPointAwarenessMeta,
          tippingPointAwareness.isAcceptableOrUnknown(
              data['tipping_point_awareness']!, _tippingPointAwarenessMeta));
    }
    if (data.containsKey('fear_or_pressure_point')) {
      context.handle(
          _fearOrPressurePointMeta,
          fearOrPressurePoint.isAcceptableOrUnknown(
              data['fear_or_pressure_point']!, _fearOrPressurePointMeta));
    }
    if (data.containsKey('need_or_wounded_point')) {
      context.handle(
          _needOrWoundedPointMeta,
          needOrWoundedPoint.isAcceptableOrUnknown(
              data['need_or_wounded_point']!, _needOrWoundedPointMeta));
    }
    if (data.containsKey('touched_themes')) {
      context.handle(
          _touchedThemesMeta,
          touchedThemes.isAcceptableOrUnknown(
              data['touched_themes']!, _touchedThemesMeta));
    }
    if (data.containsKey('needed_supports')) {
      context.handle(
          _neededSupportsMeta,
          neededSupports.isAcceptableOrUnknown(
              data['needed_supports']!, _neededSupportsMeta));
    }
    if (data.containsKey('realistic_alternative')) {
      context.handle(
          _realisticAlternativeMeta,
          realisticAlternative.isAcceptableOrUnknown(
              data['realistic_alternative']!, _realisticAlternativeMeta));
    }
    if (data.containsKey('trigger_as_last_drop')) {
      context.handle(
          _triggerAsLastDropMeta,
          triggerAsLastDrop.isAcceptableOrUnknown(
              data['trigger_as_last_drop']!, _triggerAsLastDropMeta));
    }
    if (data.containsKey('background_theme')) {
      context.handle(
          _backgroundThemeMeta,
          backgroundTheme.isAcceptableOrUnknown(
              data['background_theme']!, _backgroundThemeMeta));
    }
    if (data.containsKey('pre_escalation_relief')) {
      context.handle(
          _preEscalationReliefMeta,
          preEscalationRelief.isAcceptableOrUnknown(
              data['pre_escalation_relief']!, _preEscalationReliefMeta));
    }
    if (data.containsKey('pattern_familiarity')) {
      context.handle(
          _patternFamiliarityMeta,
          patternFamiliarity.isAcceptableOrUnknown(
              data['pattern_familiarity']!, _patternFamiliarityMeta));
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
    if (data.containsKey('evaluation_headline_key')) {
      context.handle(
          _evaluationHeadlineKeyMeta,
          evaluationHeadlineKey.isAcceptableOrUnknown(
              data['evaluation_headline_key']!, _evaluationHeadlineKeyMeta));
    }
    if (data.containsKey('evaluation_meaning_key')) {
      context.handle(
          _evaluationMeaningKeyMeta,
          evaluationMeaningKey.isAcceptableOrUnknown(
              data['evaluation_meaning_key']!, _evaluationMeaningKeyMeta));
    }
    if (data.containsKey('evaluation_helpful_now_key')) {
      context.handle(
          _evaluationHelpfulNowKeyMeta,
          evaluationHelpfulNowKey.isAcceptableOrUnknown(
              data['evaluation_helpful_now_key']!,
              _evaluationHelpfulNowKeyMeta));
    }
    if (data.containsKey('evaluation_learning_point_key')) {
      context.handle(
          _evaluationLearningPointKeyMeta,
          evaluationLearningPointKey.isAcceptableOrUnknown(
              data['evaluation_learning_point_key']!,
              _evaluationLearningPointKeyMeta));
    }
    if (data.containsKey('evaluation_status_keys')) {
      context.handle(
          _evaluationStatusKeysMeta,
          evaluationStatusKeys.isAcceptableOrUnknown(
              data['evaluation_status_keys']!, _evaluationStatusKeysMeta));
    }
    if (data.containsKey('suggested_tip_ids')) {
      context.handle(
          _suggestedTipIdsMeta,
          suggestedTipIds.isAcceptableOrUnknown(
              data['suggested_tip_ids']!, _suggestedTipIdsMeta));
    }
    if (data.containsKey('suggested_next_action_key')) {
      context.handle(
          _suggestedNextActionKeyMeta,
          suggestedNextActionKey.isAcceptableOrUnknown(
              data['suggested_next_action_key']!, _suggestedNextActionKeyMeta));
    }
    if (data.containsKey('selected_next_action_key')) {
      context.handle(
          _selectedNextActionKeyMeta,
          selectedNextActionKey.isAcceptableOrUnknown(
              data['selected_next_action_key']!, _selectedNextActionKeyMeta));
    }
    if (data.containsKey('ai_evaluation_status')) {
      context.handle(
          _aiEvaluationStatusMeta,
          aiEvaluationStatus.isAcceptableOrUnknown(
              data['ai_evaluation_status']!, _aiEvaluationStatusMeta));
    }
    if (data.containsKey('ai_evaluation_provider')) {
      context.handle(
          _aiEvaluationProviderMeta,
          aiEvaluationProvider.isAcceptableOrUnknown(
              data['ai_evaluation_provider']!, _aiEvaluationProviderMeta));
    }
    if (data.containsKey('ai_evaluation_model')) {
      context.handle(
          _aiEvaluationModelMeta,
          aiEvaluationModel.isAcceptableOrUnknown(
              data['ai_evaluation_model']!, _aiEvaluationModelMeta));
    }
    if (data.containsKey('ai_evaluation_requested_at')) {
      context.handle(
          _aiEvaluationRequestedAtMeta,
          aiEvaluationRequestedAt.isAcceptableOrUnknown(
              data['ai_evaluation_requested_at']!,
              _aiEvaluationRequestedAtMeta));
    }
    if (data.containsKey('ai_evaluation_completed_at')) {
      context.handle(
          _aiEvaluationCompletedAtMeta,
          aiEvaluationCompletedAt.isAcceptableOrUnknown(
              data['ai_evaluation_completed_at']!,
              _aiEvaluationCompletedAtMeta));
    }
    if (data.containsKey('ai_evaluation_consent_given')) {
      context.handle(
          _aiEvaluationConsentGivenMeta,
          aiEvaluationConsentGiven.isAcceptableOrUnknown(
              data['ai_evaluation_consent_given']!,
              _aiEvaluationConsentGivenMeta));
    }
    if (data.containsKey('ai_evaluation_text')) {
      context.handle(
          _aiEvaluationTextMeta,
          aiEvaluationText.isAcceptableOrUnknown(
              data['ai_evaluation_text']!, _aiEvaluationTextMeta));
    }
    if (data.containsKey('ai_evaluation_schema_version')) {
      context.handle(
          _aiEvaluationSchemaVersionMeta,
          aiEvaluationSchemaVersion.isAcceptableOrUnknown(
              data['ai_evaluation_schema_version']!,
              _aiEvaluationSchemaVersionMeta));
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
      involvedEntities: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}involved_entities']),
      preTriggerPreoccupation: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}pre_trigger_preoccupation']),
      problemTiming: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}problem_timing']),
      triggerDescription: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}trigger_description']),
      preTriggerLoad: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}pre_trigger_load']),
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
      initialBodyReactions: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}initial_body_reactions']),
      additionalEmotions: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}additional_emotions']),
      thoughtFocus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}thought_focus']),
      automaticThought: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}automatic_thought'])!,
      firstImpulse: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}first_impulse'])!,
      factInterpretationResult: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}fact_interpretation_result']),
      systemReaction: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}system_reaction']),
      thoughtPatterns: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}thought_patterns']),
      actualBehaviorTags: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}actual_behavior_tags']),
      actualBehavior: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}actual_behavior']),
      tippingPointAwareness: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}tipping_point_awareness']),
      fearOrPressurePoint: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}fear_or_pressure_point']),
      needOrWoundedPoint: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}need_or_wounded_point']),
      touchedThemes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}touched_themes']),
      neededSupports: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}needed_supports']),
      realisticAlternative: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}realistic_alternative']),
      triggerAsLastDrop: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}trigger_as_last_drop']),
      backgroundTheme: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}background_theme']),
      preEscalationRelief: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}pre_escalation_relief']),
      patternFamiliarity: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}pattern_familiarity']),
      nextStep: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}next_step']),
      systemState: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}system_state'])!,
      isCrisis: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_crisis'])!,
      evaluationHeadlineKey: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}evaluation_headline_key']),
      evaluationMeaningKey: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}evaluation_meaning_key']),
      evaluationHelpfulNowKey: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}evaluation_helpful_now_key']),
      evaluationLearningPointKey: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}evaluation_learning_point_key']),
      evaluationStatusKeys: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}evaluation_status_keys']),
      suggestedTipIds: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}suggested_tip_ids']),
      suggestedNextActionKey: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}suggested_next_action_key']),
      selectedNextActionKey: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}selected_next_action_key']),
      aiEvaluationStatus: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}ai_evaluation_status']),
      aiEvaluationProvider: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}ai_evaluation_provider']),
      aiEvaluationModel: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}ai_evaluation_model']),
      aiEvaluationRequestedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}ai_evaluation_requested_at']),
      aiEvaluationCompletedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}ai_evaluation_completed_at']),
      aiEvaluationConsentGiven: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}ai_evaluation_consent_given'])!,
      aiEvaluationText: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}ai_evaluation_text']),
      aiEvaluationSchemaVersion: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}ai_evaluation_schema_version']),
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
  final String? involvedEntities;
  final String? preTriggerPreoccupation;
  final String? problemTiming;
  final String? triggerDescription;
  final int? preTriggerLoad;
  final int intensity;
  final int bodyTension;
  final String primaryEmotion;
  final String? secondaryEmotion;
  final String? bodySymptoms;
  final String? initialBodyReactions;
  final String? additionalEmotions;
  final String? thoughtFocus;
  final String automaticThought;
  final String firstImpulse;
  final String? factInterpretationResult;
  final String? systemReaction;
  final String? thoughtPatterns;
  final String? actualBehaviorTags;
  final String? actualBehavior;
  final String? tippingPointAwareness;
  final String? fearOrPressurePoint;
  final String? needOrWoundedPoint;
  final String? touchedThemes;
  final String? neededSupports;
  final String? realisticAlternative;
  final String? triggerAsLastDrop;
  final String? backgroundTheme;
  final String? preEscalationRelief;
  final String? patternFamiliarity;
  final String? nextStep;
  final String systemState;
  final bool isCrisis;
  final String? evaluationHeadlineKey;
  final String? evaluationMeaningKey;
  final String? evaluationHelpfulNowKey;
  final String? evaluationLearningPointKey;
  final String? evaluationStatusKeys;
  final String? suggestedTipIds;
  final String? suggestedNextActionKey;
  final String? selectedNextActionKey;
  final String? aiEvaluationStatus;
  final String? aiEvaluationProvider;
  final String? aiEvaluationModel;
  final DateTime? aiEvaluationRequestedAt;
  final DateTime? aiEvaluationCompletedAt;
  final bool aiEvaluationConsentGiven;
  final String? aiEvaluationText;
  final int? aiEvaluationSchemaVersion;
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
      this.involvedEntities,
      this.preTriggerPreoccupation,
      this.problemTiming,
      this.triggerDescription,
      this.preTriggerLoad,
      required this.intensity,
      required this.bodyTension,
      required this.primaryEmotion,
      this.secondaryEmotion,
      this.bodySymptoms,
      this.initialBodyReactions,
      this.additionalEmotions,
      this.thoughtFocus,
      required this.automaticThought,
      required this.firstImpulse,
      this.factInterpretationResult,
      this.systemReaction,
      this.thoughtPatterns,
      this.actualBehaviorTags,
      this.actualBehavior,
      this.tippingPointAwareness,
      this.fearOrPressurePoint,
      this.needOrWoundedPoint,
      this.touchedThemes,
      this.neededSupports,
      this.realisticAlternative,
      this.triggerAsLastDrop,
      this.backgroundTheme,
      this.preEscalationRelief,
      this.patternFamiliarity,
      this.nextStep,
      required this.systemState,
      required this.isCrisis,
      this.evaluationHeadlineKey,
      this.evaluationMeaningKey,
      this.evaluationHelpfulNowKey,
      this.evaluationLearningPointKey,
      this.evaluationStatusKeys,
      this.suggestedTipIds,
      this.suggestedNextActionKey,
      this.selectedNextActionKey,
      this.aiEvaluationStatus,
      this.aiEvaluationProvider,
      this.aiEvaluationModel,
      this.aiEvaluationRequestedAt,
      this.aiEvaluationCompletedAt,
      required this.aiEvaluationConsentGiven,
      this.aiEvaluationText,
      this.aiEvaluationSchemaVersion,
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
    if (!nullToAbsent || involvedEntities != null) {
      map['involved_entities'] = Variable<String>(involvedEntities);
    }
    if (!nullToAbsent || preTriggerPreoccupation != null) {
      map['pre_trigger_preoccupation'] =
          Variable<String>(preTriggerPreoccupation);
    }
    if (!nullToAbsent || problemTiming != null) {
      map['problem_timing'] = Variable<String>(problemTiming);
    }
    if (!nullToAbsent || triggerDescription != null) {
      map['trigger_description'] = Variable<String>(triggerDescription);
    }
    if (!nullToAbsent || preTriggerLoad != null) {
      map['pre_trigger_load'] = Variable<int>(preTriggerLoad);
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
    if (!nullToAbsent || initialBodyReactions != null) {
      map['initial_body_reactions'] = Variable<String>(initialBodyReactions);
    }
    if (!nullToAbsent || additionalEmotions != null) {
      map['additional_emotions'] = Variable<String>(additionalEmotions);
    }
    if (!nullToAbsent || thoughtFocus != null) {
      map['thought_focus'] = Variable<String>(thoughtFocus);
    }
    map['automatic_thought'] = Variable<String>(automaticThought);
    map['first_impulse'] = Variable<String>(firstImpulse);
    if (!nullToAbsent || factInterpretationResult != null) {
      map['fact_interpretation_result'] =
          Variable<String>(factInterpretationResult);
    }
    if (!nullToAbsent || systemReaction != null) {
      map['system_reaction'] = Variable<String>(systemReaction);
    }
    if (!nullToAbsent || thoughtPatterns != null) {
      map['thought_patterns'] = Variable<String>(thoughtPatterns);
    }
    if (!nullToAbsent || actualBehaviorTags != null) {
      map['actual_behavior_tags'] = Variable<String>(actualBehaviorTags);
    }
    if (!nullToAbsent || actualBehavior != null) {
      map['actual_behavior'] = Variable<String>(actualBehavior);
    }
    if (!nullToAbsent || tippingPointAwareness != null) {
      map['tipping_point_awareness'] = Variable<String>(tippingPointAwareness);
    }
    if (!nullToAbsent || fearOrPressurePoint != null) {
      map['fear_or_pressure_point'] = Variable<String>(fearOrPressurePoint);
    }
    if (!nullToAbsent || needOrWoundedPoint != null) {
      map['need_or_wounded_point'] = Variable<String>(needOrWoundedPoint);
    }
    if (!nullToAbsent || touchedThemes != null) {
      map['touched_themes'] = Variable<String>(touchedThemes);
    }
    if (!nullToAbsent || neededSupports != null) {
      map['needed_supports'] = Variable<String>(neededSupports);
    }
    if (!nullToAbsent || realisticAlternative != null) {
      map['realistic_alternative'] = Variable<String>(realisticAlternative);
    }
    if (!nullToAbsent || triggerAsLastDrop != null) {
      map['trigger_as_last_drop'] = Variable<String>(triggerAsLastDrop);
    }
    if (!nullToAbsent || backgroundTheme != null) {
      map['background_theme'] = Variable<String>(backgroundTheme);
    }
    if (!nullToAbsent || preEscalationRelief != null) {
      map['pre_escalation_relief'] = Variable<String>(preEscalationRelief);
    }
    if (!nullToAbsent || patternFamiliarity != null) {
      map['pattern_familiarity'] = Variable<String>(patternFamiliarity);
    }
    if (!nullToAbsent || nextStep != null) {
      map['next_step'] = Variable<String>(nextStep);
    }
    map['system_state'] = Variable<String>(systemState);
    map['is_crisis'] = Variable<bool>(isCrisis);
    if (!nullToAbsent || evaluationHeadlineKey != null) {
      map['evaluation_headline_key'] = Variable<String>(evaluationHeadlineKey);
    }
    if (!nullToAbsent || evaluationMeaningKey != null) {
      map['evaluation_meaning_key'] = Variable<String>(evaluationMeaningKey);
    }
    if (!nullToAbsent || evaluationHelpfulNowKey != null) {
      map['evaluation_helpful_now_key'] =
          Variable<String>(evaluationHelpfulNowKey);
    }
    if (!nullToAbsent || evaluationLearningPointKey != null) {
      map['evaluation_learning_point_key'] =
          Variable<String>(evaluationLearningPointKey);
    }
    if (!nullToAbsent || evaluationStatusKeys != null) {
      map['evaluation_status_keys'] = Variable<String>(evaluationStatusKeys);
    }
    if (!nullToAbsent || suggestedTipIds != null) {
      map['suggested_tip_ids'] = Variable<String>(suggestedTipIds);
    }
    if (!nullToAbsent || suggestedNextActionKey != null) {
      map['suggested_next_action_key'] =
          Variable<String>(suggestedNextActionKey);
    }
    if (!nullToAbsent || selectedNextActionKey != null) {
      map['selected_next_action_key'] = Variable<String>(selectedNextActionKey);
    }
    if (!nullToAbsent || aiEvaluationStatus != null) {
      map['ai_evaluation_status'] = Variable<String>(aiEvaluationStatus);
    }
    if (!nullToAbsent || aiEvaluationProvider != null) {
      map['ai_evaluation_provider'] = Variable<String>(aiEvaluationProvider);
    }
    if (!nullToAbsent || aiEvaluationModel != null) {
      map['ai_evaluation_model'] = Variable<String>(aiEvaluationModel);
    }
    if (!nullToAbsent || aiEvaluationRequestedAt != null) {
      map['ai_evaluation_requested_at'] =
          Variable<DateTime>(aiEvaluationRequestedAt);
    }
    if (!nullToAbsent || aiEvaluationCompletedAt != null) {
      map['ai_evaluation_completed_at'] =
          Variable<DateTime>(aiEvaluationCompletedAt);
    }
    map['ai_evaluation_consent_given'] =
        Variable<bool>(aiEvaluationConsentGiven);
    if (!nullToAbsent || aiEvaluationText != null) {
      map['ai_evaluation_text'] = Variable<String>(aiEvaluationText);
    }
    if (!nullToAbsent || aiEvaluationSchemaVersion != null) {
      map['ai_evaluation_schema_version'] =
          Variable<int>(aiEvaluationSchemaVersion);
    }
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
      involvedEntities: involvedEntities == null && nullToAbsent
          ? const Value.absent()
          : Value(involvedEntities),
      preTriggerPreoccupation: preTriggerPreoccupation == null && nullToAbsent
          ? const Value.absent()
          : Value(preTriggerPreoccupation),
      problemTiming: problemTiming == null && nullToAbsent
          ? const Value.absent()
          : Value(problemTiming),
      triggerDescription: triggerDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(triggerDescription),
      preTriggerLoad: preTriggerLoad == null && nullToAbsent
          ? const Value.absent()
          : Value(preTriggerLoad),
      intensity: Value(intensity),
      bodyTension: Value(bodyTension),
      primaryEmotion: Value(primaryEmotion),
      secondaryEmotion: secondaryEmotion == null && nullToAbsent
          ? const Value.absent()
          : Value(secondaryEmotion),
      bodySymptoms: bodySymptoms == null && nullToAbsent
          ? const Value.absent()
          : Value(bodySymptoms),
      initialBodyReactions: initialBodyReactions == null && nullToAbsent
          ? const Value.absent()
          : Value(initialBodyReactions),
      additionalEmotions: additionalEmotions == null && nullToAbsent
          ? const Value.absent()
          : Value(additionalEmotions),
      thoughtFocus: thoughtFocus == null && nullToAbsent
          ? const Value.absent()
          : Value(thoughtFocus),
      automaticThought: Value(automaticThought),
      firstImpulse: Value(firstImpulse),
      factInterpretationResult: factInterpretationResult == null && nullToAbsent
          ? const Value.absent()
          : Value(factInterpretationResult),
      systemReaction: systemReaction == null && nullToAbsent
          ? const Value.absent()
          : Value(systemReaction),
      thoughtPatterns: thoughtPatterns == null && nullToAbsent
          ? const Value.absent()
          : Value(thoughtPatterns),
      actualBehaviorTags: actualBehaviorTags == null && nullToAbsent
          ? const Value.absent()
          : Value(actualBehaviorTags),
      actualBehavior: actualBehavior == null && nullToAbsent
          ? const Value.absent()
          : Value(actualBehavior),
      tippingPointAwareness: tippingPointAwareness == null && nullToAbsent
          ? const Value.absent()
          : Value(tippingPointAwareness),
      fearOrPressurePoint: fearOrPressurePoint == null && nullToAbsent
          ? const Value.absent()
          : Value(fearOrPressurePoint),
      needOrWoundedPoint: needOrWoundedPoint == null && nullToAbsent
          ? const Value.absent()
          : Value(needOrWoundedPoint),
      touchedThemes: touchedThemes == null && nullToAbsent
          ? const Value.absent()
          : Value(touchedThemes),
      neededSupports: neededSupports == null && nullToAbsent
          ? const Value.absent()
          : Value(neededSupports),
      realisticAlternative: realisticAlternative == null && nullToAbsent
          ? const Value.absent()
          : Value(realisticAlternative),
      triggerAsLastDrop: triggerAsLastDrop == null && nullToAbsent
          ? const Value.absent()
          : Value(triggerAsLastDrop),
      backgroundTheme: backgroundTheme == null && nullToAbsent
          ? const Value.absent()
          : Value(backgroundTheme),
      preEscalationRelief: preEscalationRelief == null && nullToAbsent
          ? const Value.absent()
          : Value(preEscalationRelief),
      patternFamiliarity: patternFamiliarity == null && nullToAbsent
          ? const Value.absent()
          : Value(patternFamiliarity),
      nextStep: nextStep == null && nullToAbsent
          ? const Value.absent()
          : Value(nextStep),
      systemState: Value(systemState),
      isCrisis: Value(isCrisis),
      evaluationHeadlineKey: evaluationHeadlineKey == null && nullToAbsent
          ? const Value.absent()
          : Value(evaluationHeadlineKey),
      evaluationMeaningKey: evaluationMeaningKey == null && nullToAbsent
          ? const Value.absent()
          : Value(evaluationMeaningKey),
      evaluationHelpfulNowKey: evaluationHelpfulNowKey == null && nullToAbsent
          ? const Value.absent()
          : Value(evaluationHelpfulNowKey),
      evaluationLearningPointKey:
          evaluationLearningPointKey == null && nullToAbsent
              ? const Value.absent()
              : Value(evaluationLearningPointKey),
      evaluationStatusKeys: evaluationStatusKeys == null && nullToAbsent
          ? const Value.absent()
          : Value(evaluationStatusKeys),
      suggestedTipIds: suggestedTipIds == null && nullToAbsent
          ? const Value.absent()
          : Value(suggestedTipIds),
      suggestedNextActionKey: suggestedNextActionKey == null && nullToAbsent
          ? const Value.absent()
          : Value(suggestedNextActionKey),
      selectedNextActionKey: selectedNextActionKey == null && nullToAbsent
          ? const Value.absent()
          : Value(selectedNextActionKey),
      aiEvaluationStatus: aiEvaluationStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(aiEvaluationStatus),
      aiEvaluationProvider: aiEvaluationProvider == null && nullToAbsent
          ? const Value.absent()
          : Value(aiEvaluationProvider),
      aiEvaluationModel: aiEvaluationModel == null && nullToAbsent
          ? const Value.absent()
          : Value(aiEvaluationModel),
      aiEvaluationRequestedAt: aiEvaluationRequestedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(aiEvaluationRequestedAt),
      aiEvaluationCompletedAt: aiEvaluationCompletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(aiEvaluationCompletedAt),
      aiEvaluationConsentGiven: Value(aiEvaluationConsentGiven),
      aiEvaluationText: aiEvaluationText == null && nullToAbsent
          ? const Value.absent()
          : Value(aiEvaluationText),
      aiEvaluationSchemaVersion:
          aiEvaluationSchemaVersion == null && nullToAbsent
              ? const Value.absent()
              : Value(aiEvaluationSchemaVersion),
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
      involvedEntities: serializer.fromJson<String?>(json['involvedEntities']),
      preTriggerPreoccupation:
          serializer.fromJson<String?>(json['preTriggerPreoccupation']),
      problemTiming: serializer.fromJson<String?>(json['problemTiming']),
      triggerDescription:
          serializer.fromJson<String?>(json['triggerDescription']),
      preTriggerLoad: serializer.fromJson<int?>(json['preTriggerLoad']),
      intensity: serializer.fromJson<int>(json['intensity']),
      bodyTension: serializer.fromJson<int>(json['bodyTension']),
      primaryEmotion: serializer.fromJson<String>(json['primaryEmotion']),
      secondaryEmotion: serializer.fromJson<String?>(json['secondaryEmotion']),
      bodySymptoms: serializer.fromJson<String?>(json['bodySymptoms']),
      initialBodyReactions:
          serializer.fromJson<String?>(json['initialBodyReactions']),
      additionalEmotions:
          serializer.fromJson<String?>(json['additionalEmotions']),
      thoughtFocus: serializer.fromJson<String?>(json['thoughtFocus']),
      automaticThought: serializer.fromJson<String>(json['automaticThought']),
      firstImpulse: serializer.fromJson<String>(json['firstImpulse']),
      factInterpretationResult:
          serializer.fromJson<String?>(json['factInterpretationResult']),
      systemReaction: serializer.fromJson<String?>(json['systemReaction']),
      thoughtPatterns: serializer.fromJson<String?>(json['thoughtPatterns']),
      actualBehaviorTags:
          serializer.fromJson<String?>(json['actualBehaviorTags']),
      actualBehavior: serializer.fromJson<String?>(json['actualBehavior']),
      tippingPointAwareness:
          serializer.fromJson<String?>(json['tippingPointAwareness']),
      fearOrPressurePoint:
          serializer.fromJson<String?>(json['fearOrPressurePoint']),
      needOrWoundedPoint:
          serializer.fromJson<String?>(json['needOrWoundedPoint']),
      touchedThemes: serializer.fromJson<String?>(json['touchedThemes']),
      neededSupports: serializer.fromJson<String?>(json['neededSupports']),
      realisticAlternative:
          serializer.fromJson<String?>(json['realisticAlternative']),
      triggerAsLastDrop:
          serializer.fromJson<String?>(json['triggerAsLastDrop']),
      backgroundTheme: serializer.fromJson<String?>(json['backgroundTheme']),
      preEscalationRelief:
          serializer.fromJson<String?>(json['preEscalationRelief']),
      patternFamiliarity:
          serializer.fromJson<String?>(json['patternFamiliarity']),
      nextStep: serializer.fromJson<String?>(json['nextStep']),
      systemState: serializer.fromJson<String>(json['systemState']),
      isCrisis: serializer.fromJson<bool>(json['isCrisis']),
      evaluationHeadlineKey:
          serializer.fromJson<String?>(json['evaluationHeadlineKey']),
      evaluationMeaningKey:
          serializer.fromJson<String?>(json['evaluationMeaningKey']),
      evaluationHelpfulNowKey:
          serializer.fromJson<String?>(json['evaluationHelpfulNowKey']),
      evaluationLearningPointKey:
          serializer.fromJson<String?>(json['evaluationLearningPointKey']),
      evaluationStatusKeys:
          serializer.fromJson<String?>(json['evaluationStatusKeys']),
      suggestedTipIds: serializer.fromJson<String?>(json['suggestedTipIds']),
      suggestedNextActionKey:
          serializer.fromJson<String?>(json['suggestedNextActionKey']),
      selectedNextActionKey:
          serializer.fromJson<String?>(json['selectedNextActionKey']),
      aiEvaluationStatus:
          serializer.fromJson<String?>(json['aiEvaluationStatus']),
      aiEvaluationProvider:
          serializer.fromJson<String?>(json['aiEvaluationProvider']),
      aiEvaluationModel:
          serializer.fromJson<String?>(json['aiEvaluationModel']),
      aiEvaluationRequestedAt:
          serializer.fromJson<DateTime?>(json['aiEvaluationRequestedAt']),
      aiEvaluationCompletedAt:
          serializer.fromJson<DateTime?>(json['aiEvaluationCompletedAt']),
      aiEvaluationConsentGiven:
          serializer.fromJson<bool>(json['aiEvaluationConsentGiven']),
      aiEvaluationText: serializer.fromJson<String?>(json['aiEvaluationText']),
      aiEvaluationSchemaVersion:
          serializer.fromJson<int?>(json['aiEvaluationSchemaVersion']),
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
      'involvedEntities': serializer.toJson<String?>(involvedEntities),
      'preTriggerPreoccupation':
          serializer.toJson<String?>(preTriggerPreoccupation),
      'problemTiming': serializer.toJson<String?>(problemTiming),
      'triggerDescription': serializer.toJson<String?>(triggerDescription),
      'preTriggerLoad': serializer.toJson<int?>(preTriggerLoad),
      'intensity': serializer.toJson<int>(intensity),
      'bodyTension': serializer.toJson<int>(bodyTension),
      'primaryEmotion': serializer.toJson<String>(primaryEmotion),
      'secondaryEmotion': serializer.toJson<String?>(secondaryEmotion),
      'bodySymptoms': serializer.toJson<String?>(bodySymptoms),
      'initialBodyReactions': serializer.toJson<String?>(initialBodyReactions),
      'additionalEmotions': serializer.toJson<String?>(additionalEmotions),
      'thoughtFocus': serializer.toJson<String?>(thoughtFocus),
      'automaticThought': serializer.toJson<String>(automaticThought),
      'firstImpulse': serializer.toJson<String>(firstImpulse),
      'factInterpretationResult':
          serializer.toJson<String?>(factInterpretationResult),
      'systemReaction': serializer.toJson<String?>(systemReaction),
      'thoughtPatterns': serializer.toJson<String?>(thoughtPatterns),
      'actualBehaviorTags': serializer.toJson<String?>(actualBehaviorTags),
      'actualBehavior': serializer.toJson<String?>(actualBehavior),
      'tippingPointAwareness':
          serializer.toJson<String?>(tippingPointAwareness),
      'fearOrPressurePoint': serializer.toJson<String?>(fearOrPressurePoint),
      'needOrWoundedPoint': serializer.toJson<String?>(needOrWoundedPoint),
      'touchedThemes': serializer.toJson<String?>(touchedThemes),
      'neededSupports': serializer.toJson<String?>(neededSupports),
      'realisticAlternative': serializer.toJson<String?>(realisticAlternative),
      'triggerAsLastDrop': serializer.toJson<String?>(triggerAsLastDrop),
      'backgroundTheme': serializer.toJson<String?>(backgroundTheme),
      'preEscalationRelief': serializer.toJson<String?>(preEscalationRelief),
      'patternFamiliarity': serializer.toJson<String?>(patternFamiliarity),
      'nextStep': serializer.toJson<String?>(nextStep),
      'systemState': serializer.toJson<String>(systemState),
      'isCrisis': serializer.toJson<bool>(isCrisis),
      'evaluationHeadlineKey':
          serializer.toJson<String?>(evaluationHeadlineKey),
      'evaluationMeaningKey': serializer.toJson<String?>(evaluationMeaningKey),
      'evaluationHelpfulNowKey':
          serializer.toJson<String?>(evaluationHelpfulNowKey),
      'evaluationLearningPointKey':
          serializer.toJson<String?>(evaluationLearningPointKey),
      'evaluationStatusKeys': serializer.toJson<String?>(evaluationStatusKeys),
      'suggestedTipIds': serializer.toJson<String?>(suggestedTipIds),
      'suggestedNextActionKey':
          serializer.toJson<String?>(suggestedNextActionKey),
      'selectedNextActionKey':
          serializer.toJson<String?>(selectedNextActionKey),
      'aiEvaluationStatus': serializer.toJson<String?>(aiEvaluationStatus),
      'aiEvaluationProvider': serializer.toJson<String?>(aiEvaluationProvider),
      'aiEvaluationModel': serializer.toJson<String?>(aiEvaluationModel),
      'aiEvaluationRequestedAt':
          serializer.toJson<DateTime?>(aiEvaluationRequestedAt),
      'aiEvaluationCompletedAt':
          serializer.toJson<DateTime?>(aiEvaluationCompletedAt),
      'aiEvaluationConsentGiven':
          serializer.toJson<bool>(aiEvaluationConsentGiven),
      'aiEvaluationText': serializer.toJson<String?>(aiEvaluationText),
      'aiEvaluationSchemaVersion':
          serializer.toJson<int?>(aiEvaluationSchemaVersion),
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
          Value<String?> involvedEntities = const Value.absent(),
          Value<String?> preTriggerPreoccupation = const Value.absent(),
          Value<String?> problemTiming = const Value.absent(),
          Value<String?> triggerDescription = const Value.absent(),
          Value<int?> preTriggerLoad = const Value.absent(),
          int? intensity,
          int? bodyTension,
          String? primaryEmotion,
          Value<String?> secondaryEmotion = const Value.absent(),
          Value<String?> bodySymptoms = const Value.absent(),
          Value<String?> initialBodyReactions = const Value.absent(),
          Value<String?> additionalEmotions = const Value.absent(),
          Value<String?> thoughtFocus = const Value.absent(),
          String? automaticThought,
          String? firstImpulse,
          Value<String?> factInterpretationResult = const Value.absent(),
          Value<String?> systemReaction = const Value.absent(),
          Value<String?> thoughtPatterns = const Value.absent(),
          Value<String?> actualBehaviorTags = const Value.absent(),
          Value<String?> actualBehavior = const Value.absent(),
          Value<String?> tippingPointAwareness = const Value.absent(),
          Value<String?> fearOrPressurePoint = const Value.absent(),
          Value<String?> needOrWoundedPoint = const Value.absent(),
          Value<String?> touchedThemes = const Value.absent(),
          Value<String?> neededSupports = const Value.absent(),
          Value<String?> realisticAlternative = const Value.absent(),
          Value<String?> triggerAsLastDrop = const Value.absent(),
          Value<String?> backgroundTheme = const Value.absent(),
          Value<String?> preEscalationRelief = const Value.absent(),
          Value<String?> patternFamiliarity = const Value.absent(),
          Value<String?> nextStep = const Value.absent(),
          String? systemState,
          bool? isCrisis,
          Value<String?> evaluationHeadlineKey = const Value.absent(),
          Value<String?> evaluationMeaningKey = const Value.absent(),
          Value<String?> evaluationHelpfulNowKey = const Value.absent(),
          Value<String?> evaluationLearningPointKey = const Value.absent(),
          Value<String?> evaluationStatusKeys = const Value.absent(),
          Value<String?> suggestedTipIds = const Value.absent(),
          Value<String?> suggestedNextActionKey = const Value.absent(),
          Value<String?> selectedNextActionKey = const Value.absent(),
          Value<String?> aiEvaluationStatus = const Value.absent(),
          Value<String?> aiEvaluationProvider = const Value.absent(),
          Value<String?> aiEvaluationModel = const Value.absent(),
          Value<DateTime?> aiEvaluationRequestedAt = const Value.absent(),
          Value<DateTime?> aiEvaluationCompletedAt = const Value.absent(),
          bool? aiEvaluationConsentGiven,
          Value<String?> aiEvaluationText = const Value.absent(),
          Value<int?> aiEvaluationSchemaVersion = const Value.absent(),
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
        involvedEntities: involvedEntities.present
            ? involvedEntities.value
            : this.involvedEntities,
        preTriggerPreoccupation: preTriggerPreoccupation.present
            ? preTriggerPreoccupation.value
            : this.preTriggerPreoccupation,
        problemTiming:
            problemTiming.present ? problemTiming.value : this.problemTiming,
        triggerDescription: triggerDescription.present
            ? triggerDescription.value
            : this.triggerDescription,
        preTriggerLoad:
            preTriggerLoad.present ? preTriggerLoad.value : this.preTriggerLoad,
        intensity: intensity ?? this.intensity,
        bodyTension: bodyTension ?? this.bodyTension,
        primaryEmotion: primaryEmotion ?? this.primaryEmotion,
        secondaryEmotion: secondaryEmotion.present
            ? secondaryEmotion.value
            : this.secondaryEmotion,
        bodySymptoms:
            bodySymptoms.present ? bodySymptoms.value : this.bodySymptoms,
        initialBodyReactions: initialBodyReactions.present
            ? initialBodyReactions.value
            : this.initialBodyReactions,
        additionalEmotions: additionalEmotions.present
            ? additionalEmotions.value
            : this.additionalEmotions,
        thoughtFocus:
            thoughtFocus.present ? thoughtFocus.value : this.thoughtFocus,
        automaticThought: automaticThought ?? this.automaticThought,
        firstImpulse: firstImpulse ?? this.firstImpulse,
        factInterpretationResult: factInterpretationResult.present
            ? factInterpretationResult.value
            : this.factInterpretationResult,
        systemReaction:
            systemReaction.present ? systemReaction.value : this.systemReaction,
        thoughtPatterns: thoughtPatterns.present
            ? thoughtPatterns.value
            : this.thoughtPatterns,
        actualBehaviorTags: actualBehaviorTags.present
            ? actualBehaviorTags.value
            : this.actualBehaviorTags,
        actualBehavior:
            actualBehavior.present ? actualBehavior.value : this.actualBehavior,
        tippingPointAwareness: tippingPointAwareness.present
            ? tippingPointAwareness.value
            : this.tippingPointAwareness,
        fearOrPressurePoint: fearOrPressurePoint.present
            ? fearOrPressurePoint.value
            : this.fearOrPressurePoint,
        needOrWoundedPoint: needOrWoundedPoint.present
            ? needOrWoundedPoint.value
            : this.needOrWoundedPoint,
        touchedThemes:
            touchedThemes.present ? touchedThemes.value : this.touchedThemes,
        neededSupports:
            neededSupports.present ? neededSupports.value : this.neededSupports,
        realisticAlternative: realisticAlternative.present
            ? realisticAlternative.value
            : this.realisticAlternative,
        triggerAsLastDrop: triggerAsLastDrop.present
            ? triggerAsLastDrop.value
            : this.triggerAsLastDrop,
        backgroundTheme: backgroundTheme.present
            ? backgroundTheme.value
            : this.backgroundTheme,
        preEscalationRelief: preEscalationRelief.present
            ? preEscalationRelief.value
            : this.preEscalationRelief,
        patternFamiliarity: patternFamiliarity.present
            ? patternFamiliarity.value
            : this.patternFamiliarity,
        nextStep: nextStep.present ? nextStep.value : this.nextStep,
        systemState: systemState ?? this.systemState,
        isCrisis: isCrisis ?? this.isCrisis,
        evaluationHeadlineKey: evaluationHeadlineKey.present
            ? evaluationHeadlineKey.value
            : this.evaluationHeadlineKey,
        evaluationMeaningKey: evaluationMeaningKey.present
            ? evaluationMeaningKey.value
            : this.evaluationMeaningKey,
        evaluationHelpfulNowKey: evaluationHelpfulNowKey.present
            ? evaluationHelpfulNowKey.value
            : this.evaluationHelpfulNowKey,
        evaluationLearningPointKey: evaluationLearningPointKey.present
            ? evaluationLearningPointKey.value
            : this.evaluationLearningPointKey,
        evaluationStatusKeys: evaluationStatusKeys.present
            ? evaluationStatusKeys.value
            : this.evaluationStatusKeys,
        suggestedTipIds: suggestedTipIds.present
            ? suggestedTipIds.value
            : this.suggestedTipIds,
        suggestedNextActionKey: suggestedNextActionKey.present
            ? suggestedNextActionKey.value
            : this.suggestedNextActionKey,
        selectedNextActionKey: selectedNextActionKey.present
            ? selectedNextActionKey.value
            : this.selectedNextActionKey,
        aiEvaluationStatus: aiEvaluationStatus.present
            ? aiEvaluationStatus.value
            : this.aiEvaluationStatus,
        aiEvaluationProvider: aiEvaluationProvider.present
            ? aiEvaluationProvider.value
            : this.aiEvaluationProvider,
        aiEvaluationModel: aiEvaluationModel.present
            ? aiEvaluationModel.value
            : this.aiEvaluationModel,
        aiEvaluationRequestedAt: aiEvaluationRequestedAt.present
            ? aiEvaluationRequestedAt.value
            : this.aiEvaluationRequestedAt,
        aiEvaluationCompletedAt: aiEvaluationCompletedAt.present
            ? aiEvaluationCompletedAt.value
            : this.aiEvaluationCompletedAt,
        aiEvaluationConsentGiven:
            aiEvaluationConsentGiven ?? this.aiEvaluationConsentGiven,
        aiEvaluationText: aiEvaluationText.present
            ? aiEvaluationText.value
            : this.aiEvaluationText,
        aiEvaluationSchemaVersion: aiEvaluationSchemaVersion.present
            ? aiEvaluationSchemaVersion.value
            : this.aiEvaluationSchemaVersion,
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
      involvedEntities: data.involvedEntities.present
          ? data.involvedEntities.value
          : this.involvedEntities,
      preTriggerPreoccupation: data.preTriggerPreoccupation.present
          ? data.preTriggerPreoccupation.value
          : this.preTriggerPreoccupation,
      problemTiming: data.problemTiming.present
          ? data.problemTiming.value
          : this.problemTiming,
      triggerDescription: data.triggerDescription.present
          ? data.triggerDescription.value
          : this.triggerDescription,
      preTriggerLoad: data.preTriggerLoad.present
          ? data.preTriggerLoad.value
          : this.preTriggerLoad,
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
      initialBodyReactions: data.initialBodyReactions.present
          ? data.initialBodyReactions.value
          : this.initialBodyReactions,
      additionalEmotions: data.additionalEmotions.present
          ? data.additionalEmotions.value
          : this.additionalEmotions,
      thoughtFocus: data.thoughtFocus.present
          ? data.thoughtFocus.value
          : this.thoughtFocus,
      automaticThought: data.automaticThought.present
          ? data.automaticThought.value
          : this.automaticThought,
      firstImpulse: data.firstImpulse.present
          ? data.firstImpulse.value
          : this.firstImpulse,
      factInterpretationResult: data.factInterpretationResult.present
          ? data.factInterpretationResult.value
          : this.factInterpretationResult,
      systemReaction: data.systemReaction.present
          ? data.systemReaction.value
          : this.systemReaction,
      thoughtPatterns: data.thoughtPatterns.present
          ? data.thoughtPatterns.value
          : this.thoughtPatterns,
      actualBehaviorTags: data.actualBehaviorTags.present
          ? data.actualBehaviorTags.value
          : this.actualBehaviorTags,
      actualBehavior: data.actualBehavior.present
          ? data.actualBehavior.value
          : this.actualBehavior,
      tippingPointAwareness: data.tippingPointAwareness.present
          ? data.tippingPointAwareness.value
          : this.tippingPointAwareness,
      fearOrPressurePoint: data.fearOrPressurePoint.present
          ? data.fearOrPressurePoint.value
          : this.fearOrPressurePoint,
      needOrWoundedPoint: data.needOrWoundedPoint.present
          ? data.needOrWoundedPoint.value
          : this.needOrWoundedPoint,
      touchedThemes: data.touchedThemes.present
          ? data.touchedThemes.value
          : this.touchedThemes,
      neededSupports: data.neededSupports.present
          ? data.neededSupports.value
          : this.neededSupports,
      realisticAlternative: data.realisticAlternative.present
          ? data.realisticAlternative.value
          : this.realisticAlternative,
      triggerAsLastDrop: data.triggerAsLastDrop.present
          ? data.triggerAsLastDrop.value
          : this.triggerAsLastDrop,
      backgroundTheme: data.backgroundTheme.present
          ? data.backgroundTheme.value
          : this.backgroundTheme,
      preEscalationRelief: data.preEscalationRelief.present
          ? data.preEscalationRelief.value
          : this.preEscalationRelief,
      patternFamiliarity: data.patternFamiliarity.present
          ? data.patternFamiliarity.value
          : this.patternFamiliarity,
      nextStep: data.nextStep.present ? data.nextStep.value : this.nextStep,
      systemState:
          data.systemState.present ? data.systemState.value : this.systemState,
      isCrisis: data.isCrisis.present ? data.isCrisis.value : this.isCrisis,
      evaluationHeadlineKey: data.evaluationHeadlineKey.present
          ? data.evaluationHeadlineKey.value
          : this.evaluationHeadlineKey,
      evaluationMeaningKey: data.evaluationMeaningKey.present
          ? data.evaluationMeaningKey.value
          : this.evaluationMeaningKey,
      evaluationHelpfulNowKey: data.evaluationHelpfulNowKey.present
          ? data.evaluationHelpfulNowKey.value
          : this.evaluationHelpfulNowKey,
      evaluationLearningPointKey: data.evaluationLearningPointKey.present
          ? data.evaluationLearningPointKey.value
          : this.evaluationLearningPointKey,
      evaluationStatusKeys: data.evaluationStatusKeys.present
          ? data.evaluationStatusKeys.value
          : this.evaluationStatusKeys,
      suggestedTipIds: data.suggestedTipIds.present
          ? data.suggestedTipIds.value
          : this.suggestedTipIds,
      suggestedNextActionKey: data.suggestedNextActionKey.present
          ? data.suggestedNextActionKey.value
          : this.suggestedNextActionKey,
      selectedNextActionKey: data.selectedNextActionKey.present
          ? data.selectedNextActionKey.value
          : this.selectedNextActionKey,
      aiEvaluationStatus: data.aiEvaluationStatus.present
          ? data.aiEvaluationStatus.value
          : this.aiEvaluationStatus,
      aiEvaluationProvider: data.aiEvaluationProvider.present
          ? data.aiEvaluationProvider.value
          : this.aiEvaluationProvider,
      aiEvaluationModel: data.aiEvaluationModel.present
          ? data.aiEvaluationModel.value
          : this.aiEvaluationModel,
      aiEvaluationRequestedAt: data.aiEvaluationRequestedAt.present
          ? data.aiEvaluationRequestedAt.value
          : this.aiEvaluationRequestedAt,
      aiEvaluationCompletedAt: data.aiEvaluationCompletedAt.present
          ? data.aiEvaluationCompletedAt.value
          : this.aiEvaluationCompletedAt,
      aiEvaluationConsentGiven: data.aiEvaluationConsentGiven.present
          ? data.aiEvaluationConsentGiven.value
          : this.aiEvaluationConsentGiven,
      aiEvaluationText: data.aiEvaluationText.present
          ? data.aiEvaluationText.value
          : this.aiEvaluationText,
      aiEvaluationSchemaVersion: data.aiEvaluationSchemaVersion.present
          ? data.aiEvaluationSchemaVersion.value
          : this.aiEvaluationSchemaVersion,
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
          ..write('involvedEntities: $involvedEntities, ')
          ..write('preTriggerPreoccupation: $preTriggerPreoccupation, ')
          ..write('problemTiming: $problemTiming, ')
          ..write('triggerDescription: $triggerDescription, ')
          ..write('preTriggerLoad: $preTriggerLoad, ')
          ..write('intensity: $intensity, ')
          ..write('bodyTension: $bodyTension, ')
          ..write('primaryEmotion: $primaryEmotion, ')
          ..write('secondaryEmotion: $secondaryEmotion, ')
          ..write('bodySymptoms: $bodySymptoms, ')
          ..write('initialBodyReactions: $initialBodyReactions, ')
          ..write('additionalEmotions: $additionalEmotions, ')
          ..write('thoughtFocus: $thoughtFocus, ')
          ..write('automaticThought: $automaticThought, ')
          ..write('firstImpulse: $firstImpulse, ')
          ..write('factInterpretationResult: $factInterpretationResult, ')
          ..write('systemReaction: $systemReaction, ')
          ..write('thoughtPatterns: $thoughtPatterns, ')
          ..write('actualBehaviorTags: $actualBehaviorTags, ')
          ..write('actualBehavior: $actualBehavior, ')
          ..write('tippingPointAwareness: $tippingPointAwareness, ')
          ..write('fearOrPressurePoint: $fearOrPressurePoint, ')
          ..write('needOrWoundedPoint: $needOrWoundedPoint, ')
          ..write('touchedThemes: $touchedThemes, ')
          ..write('neededSupports: $neededSupports, ')
          ..write('realisticAlternative: $realisticAlternative, ')
          ..write('triggerAsLastDrop: $triggerAsLastDrop, ')
          ..write('backgroundTheme: $backgroundTheme, ')
          ..write('preEscalationRelief: $preEscalationRelief, ')
          ..write('patternFamiliarity: $patternFamiliarity, ')
          ..write('nextStep: $nextStep, ')
          ..write('systemState: $systemState, ')
          ..write('isCrisis: $isCrisis, ')
          ..write('evaluationHeadlineKey: $evaluationHeadlineKey, ')
          ..write('evaluationMeaningKey: $evaluationMeaningKey, ')
          ..write('evaluationHelpfulNowKey: $evaluationHelpfulNowKey, ')
          ..write('evaluationLearningPointKey: $evaluationLearningPointKey, ')
          ..write('evaluationStatusKeys: $evaluationStatusKeys, ')
          ..write('suggestedTipIds: $suggestedTipIds, ')
          ..write('suggestedNextActionKey: $suggestedNextActionKey, ')
          ..write('selectedNextActionKey: $selectedNextActionKey, ')
          ..write('aiEvaluationStatus: $aiEvaluationStatus, ')
          ..write('aiEvaluationProvider: $aiEvaluationProvider, ')
          ..write('aiEvaluationModel: $aiEvaluationModel, ')
          ..write('aiEvaluationRequestedAt: $aiEvaluationRequestedAt, ')
          ..write('aiEvaluationCompletedAt: $aiEvaluationCompletedAt, ')
          ..write('aiEvaluationConsentGiven: $aiEvaluationConsentGiven, ')
          ..write('aiEvaluationText: $aiEvaluationText, ')
          ..write('aiEvaluationSchemaVersion: $aiEvaluationSchemaVersion, ')
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
        involvedEntities,
        preTriggerPreoccupation,
        problemTiming,
        triggerDescription,
        preTriggerLoad,
        intensity,
        bodyTension,
        primaryEmotion,
        secondaryEmotion,
        bodySymptoms,
        initialBodyReactions,
        additionalEmotions,
        thoughtFocus,
        automaticThought,
        firstImpulse,
        factInterpretationResult,
        systemReaction,
        thoughtPatterns,
        actualBehaviorTags,
        actualBehavior,
        tippingPointAwareness,
        fearOrPressurePoint,
        needOrWoundedPoint,
        touchedThemes,
        neededSupports,
        realisticAlternative,
        triggerAsLastDrop,
        backgroundTheme,
        preEscalationRelief,
        patternFamiliarity,
        nextStep,
        systemState,
        isCrisis,
        evaluationHeadlineKey,
        evaluationMeaningKey,
        evaluationHelpfulNowKey,
        evaluationLearningPointKey,
        evaluationStatusKeys,
        suggestedTipIds,
        suggestedNextActionKey,
        selectedNextActionKey,
        aiEvaluationStatus,
        aiEvaluationProvider,
        aiEvaluationModel,
        aiEvaluationRequestedAt,
        aiEvaluationCompletedAt,
        aiEvaluationConsentGiven,
        aiEvaluationText,
        aiEvaluationSchemaVersion,
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
          other.involvedEntities == this.involvedEntities &&
          other.preTriggerPreoccupation == this.preTriggerPreoccupation &&
          other.problemTiming == this.problemTiming &&
          other.triggerDescription == this.triggerDescription &&
          other.preTriggerLoad == this.preTriggerLoad &&
          other.intensity == this.intensity &&
          other.bodyTension == this.bodyTension &&
          other.primaryEmotion == this.primaryEmotion &&
          other.secondaryEmotion == this.secondaryEmotion &&
          other.bodySymptoms == this.bodySymptoms &&
          other.initialBodyReactions == this.initialBodyReactions &&
          other.additionalEmotions == this.additionalEmotions &&
          other.thoughtFocus == this.thoughtFocus &&
          other.automaticThought == this.automaticThought &&
          other.firstImpulse == this.firstImpulse &&
          other.factInterpretationResult == this.factInterpretationResult &&
          other.systemReaction == this.systemReaction &&
          other.thoughtPatterns == this.thoughtPatterns &&
          other.actualBehaviorTags == this.actualBehaviorTags &&
          other.actualBehavior == this.actualBehavior &&
          other.tippingPointAwareness == this.tippingPointAwareness &&
          other.fearOrPressurePoint == this.fearOrPressurePoint &&
          other.needOrWoundedPoint == this.needOrWoundedPoint &&
          other.touchedThemes == this.touchedThemes &&
          other.neededSupports == this.neededSupports &&
          other.realisticAlternative == this.realisticAlternative &&
          other.triggerAsLastDrop == this.triggerAsLastDrop &&
          other.backgroundTheme == this.backgroundTheme &&
          other.preEscalationRelief == this.preEscalationRelief &&
          other.patternFamiliarity == this.patternFamiliarity &&
          other.nextStep == this.nextStep &&
          other.systemState == this.systemState &&
          other.isCrisis == this.isCrisis &&
          other.evaluationHeadlineKey == this.evaluationHeadlineKey &&
          other.evaluationMeaningKey == this.evaluationMeaningKey &&
          other.evaluationHelpfulNowKey == this.evaluationHelpfulNowKey &&
          other.evaluationLearningPointKey == this.evaluationLearningPointKey &&
          other.evaluationStatusKeys == this.evaluationStatusKeys &&
          other.suggestedTipIds == this.suggestedTipIds &&
          other.suggestedNextActionKey == this.suggestedNextActionKey &&
          other.selectedNextActionKey == this.selectedNextActionKey &&
          other.aiEvaluationStatus == this.aiEvaluationStatus &&
          other.aiEvaluationProvider == this.aiEvaluationProvider &&
          other.aiEvaluationModel == this.aiEvaluationModel &&
          other.aiEvaluationRequestedAt == this.aiEvaluationRequestedAt &&
          other.aiEvaluationCompletedAt == this.aiEvaluationCompletedAt &&
          other.aiEvaluationConsentGiven == this.aiEvaluationConsentGiven &&
          other.aiEvaluationText == this.aiEvaluationText &&
          other.aiEvaluationSchemaVersion == this.aiEvaluationSchemaVersion &&
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
  final Value<String?> involvedEntities;
  final Value<String?> preTriggerPreoccupation;
  final Value<String?> problemTiming;
  final Value<String?> triggerDescription;
  final Value<int?> preTriggerLoad;
  final Value<int> intensity;
  final Value<int> bodyTension;
  final Value<String> primaryEmotion;
  final Value<String?> secondaryEmotion;
  final Value<String?> bodySymptoms;
  final Value<String?> initialBodyReactions;
  final Value<String?> additionalEmotions;
  final Value<String?> thoughtFocus;
  final Value<String> automaticThought;
  final Value<String> firstImpulse;
  final Value<String?> factInterpretationResult;
  final Value<String?> systemReaction;
  final Value<String?> thoughtPatterns;
  final Value<String?> actualBehaviorTags;
  final Value<String?> actualBehavior;
  final Value<String?> tippingPointAwareness;
  final Value<String?> fearOrPressurePoint;
  final Value<String?> needOrWoundedPoint;
  final Value<String?> touchedThemes;
  final Value<String?> neededSupports;
  final Value<String?> realisticAlternative;
  final Value<String?> triggerAsLastDrop;
  final Value<String?> backgroundTheme;
  final Value<String?> preEscalationRelief;
  final Value<String?> patternFamiliarity;
  final Value<String?> nextStep;
  final Value<String> systemState;
  final Value<bool> isCrisis;
  final Value<String?> evaluationHeadlineKey;
  final Value<String?> evaluationMeaningKey;
  final Value<String?> evaluationHelpfulNowKey;
  final Value<String?> evaluationLearningPointKey;
  final Value<String?> evaluationStatusKeys;
  final Value<String?> suggestedTipIds;
  final Value<String?> suggestedNextActionKey;
  final Value<String?> selectedNextActionKey;
  final Value<String?> aiEvaluationStatus;
  final Value<String?> aiEvaluationProvider;
  final Value<String?> aiEvaluationModel;
  final Value<DateTime?> aiEvaluationRequestedAt;
  final Value<DateTime?> aiEvaluationCompletedAt;
  final Value<bool> aiEvaluationConsentGiven;
  final Value<String?> aiEvaluationText;
  final Value<int?> aiEvaluationSchemaVersion;
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
    this.involvedEntities = const Value.absent(),
    this.preTriggerPreoccupation = const Value.absent(),
    this.problemTiming = const Value.absent(),
    this.triggerDescription = const Value.absent(),
    this.preTriggerLoad = const Value.absent(),
    this.intensity = const Value.absent(),
    this.bodyTension = const Value.absent(),
    this.primaryEmotion = const Value.absent(),
    this.secondaryEmotion = const Value.absent(),
    this.bodySymptoms = const Value.absent(),
    this.initialBodyReactions = const Value.absent(),
    this.additionalEmotions = const Value.absent(),
    this.thoughtFocus = const Value.absent(),
    this.automaticThought = const Value.absent(),
    this.firstImpulse = const Value.absent(),
    this.factInterpretationResult = const Value.absent(),
    this.systemReaction = const Value.absent(),
    this.thoughtPatterns = const Value.absent(),
    this.actualBehaviorTags = const Value.absent(),
    this.actualBehavior = const Value.absent(),
    this.tippingPointAwareness = const Value.absent(),
    this.fearOrPressurePoint = const Value.absent(),
    this.needOrWoundedPoint = const Value.absent(),
    this.touchedThemes = const Value.absent(),
    this.neededSupports = const Value.absent(),
    this.realisticAlternative = const Value.absent(),
    this.triggerAsLastDrop = const Value.absent(),
    this.backgroundTheme = const Value.absent(),
    this.preEscalationRelief = const Value.absent(),
    this.patternFamiliarity = const Value.absent(),
    this.nextStep = const Value.absent(),
    this.systemState = const Value.absent(),
    this.isCrisis = const Value.absent(),
    this.evaluationHeadlineKey = const Value.absent(),
    this.evaluationMeaningKey = const Value.absent(),
    this.evaluationHelpfulNowKey = const Value.absent(),
    this.evaluationLearningPointKey = const Value.absent(),
    this.evaluationStatusKeys = const Value.absent(),
    this.suggestedTipIds = const Value.absent(),
    this.suggestedNextActionKey = const Value.absent(),
    this.selectedNextActionKey = const Value.absent(),
    this.aiEvaluationStatus = const Value.absent(),
    this.aiEvaluationProvider = const Value.absent(),
    this.aiEvaluationModel = const Value.absent(),
    this.aiEvaluationRequestedAt = const Value.absent(),
    this.aiEvaluationCompletedAt = const Value.absent(),
    this.aiEvaluationConsentGiven = const Value.absent(),
    this.aiEvaluationText = const Value.absent(),
    this.aiEvaluationSchemaVersion = const Value.absent(),
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
    this.involvedEntities = const Value.absent(),
    this.preTriggerPreoccupation = const Value.absent(),
    this.problemTiming = const Value.absent(),
    this.triggerDescription = const Value.absent(),
    this.preTriggerLoad = const Value.absent(),
    required int intensity,
    required int bodyTension,
    required String primaryEmotion,
    this.secondaryEmotion = const Value.absent(),
    this.bodySymptoms = const Value.absent(),
    this.initialBodyReactions = const Value.absent(),
    this.additionalEmotions = const Value.absent(),
    this.thoughtFocus = const Value.absent(),
    required String automaticThought,
    required String firstImpulse,
    this.factInterpretationResult = const Value.absent(),
    this.systemReaction = const Value.absent(),
    this.thoughtPatterns = const Value.absent(),
    this.actualBehaviorTags = const Value.absent(),
    this.actualBehavior = const Value.absent(),
    this.tippingPointAwareness = const Value.absent(),
    this.fearOrPressurePoint = const Value.absent(),
    this.needOrWoundedPoint = const Value.absent(),
    this.touchedThemes = const Value.absent(),
    this.neededSupports = const Value.absent(),
    this.realisticAlternative = const Value.absent(),
    this.triggerAsLastDrop = const Value.absent(),
    this.backgroundTheme = const Value.absent(),
    this.preEscalationRelief = const Value.absent(),
    this.patternFamiliarity = const Value.absent(),
    this.nextStep = const Value.absent(),
    required String systemState,
    this.isCrisis = const Value.absent(),
    this.evaluationHeadlineKey = const Value.absent(),
    this.evaluationMeaningKey = const Value.absent(),
    this.evaluationHelpfulNowKey = const Value.absent(),
    this.evaluationLearningPointKey = const Value.absent(),
    this.evaluationStatusKeys = const Value.absent(),
    this.suggestedTipIds = const Value.absent(),
    this.suggestedNextActionKey = const Value.absent(),
    this.selectedNextActionKey = const Value.absent(),
    this.aiEvaluationStatus = const Value.absent(),
    this.aiEvaluationProvider = const Value.absent(),
    this.aiEvaluationModel = const Value.absent(),
    this.aiEvaluationRequestedAt = const Value.absent(),
    this.aiEvaluationCompletedAt = const Value.absent(),
    this.aiEvaluationConsentGiven = const Value.absent(),
    this.aiEvaluationText = const Value.absent(),
    this.aiEvaluationSchemaVersion = const Value.absent(),
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
    Expression<String>? involvedEntities,
    Expression<String>? preTriggerPreoccupation,
    Expression<String>? problemTiming,
    Expression<String>? triggerDescription,
    Expression<int>? preTriggerLoad,
    Expression<int>? intensity,
    Expression<int>? bodyTension,
    Expression<String>? primaryEmotion,
    Expression<String>? secondaryEmotion,
    Expression<String>? bodySymptoms,
    Expression<String>? initialBodyReactions,
    Expression<String>? additionalEmotions,
    Expression<String>? thoughtFocus,
    Expression<String>? automaticThought,
    Expression<String>? firstImpulse,
    Expression<String>? factInterpretationResult,
    Expression<String>? systemReaction,
    Expression<String>? thoughtPatterns,
    Expression<String>? actualBehaviorTags,
    Expression<String>? actualBehavior,
    Expression<String>? tippingPointAwareness,
    Expression<String>? fearOrPressurePoint,
    Expression<String>? needOrWoundedPoint,
    Expression<String>? touchedThemes,
    Expression<String>? neededSupports,
    Expression<String>? realisticAlternative,
    Expression<String>? triggerAsLastDrop,
    Expression<String>? backgroundTheme,
    Expression<String>? preEscalationRelief,
    Expression<String>? patternFamiliarity,
    Expression<String>? nextStep,
    Expression<String>? systemState,
    Expression<bool>? isCrisis,
    Expression<String>? evaluationHeadlineKey,
    Expression<String>? evaluationMeaningKey,
    Expression<String>? evaluationHelpfulNowKey,
    Expression<String>? evaluationLearningPointKey,
    Expression<String>? evaluationStatusKeys,
    Expression<String>? suggestedTipIds,
    Expression<String>? suggestedNextActionKey,
    Expression<String>? selectedNextActionKey,
    Expression<String>? aiEvaluationStatus,
    Expression<String>? aiEvaluationProvider,
    Expression<String>? aiEvaluationModel,
    Expression<DateTime>? aiEvaluationRequestedAt,
    Expression<DateTime>? aiEvaluationCompletedAt,
    Expression<bool>? aiEvaluationConsentGiven,
    Expression<String>? aiEvaluationText,
    Expression<int>? aiEvaluationSchemaVersion,
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
      if (involvedEntities != null) 'involved_entities': involvedEntities,
      if (preTriggerPreoccupation != null)
        'pre_trigger_preoccupation': preTriggerPreoccupation,
      if (problemTiming != null) 'problem_timing': problemTiming,
      if (triggerDescription != null) 'trigger_description': triggerDescription,
      if (preTriggerLoad != null) 'pre_trigger_load': preTriggerLoad,
      if (intensity != null) 'intensity': intensity,
      if (bodyTension != null) 'body_tension': bodyTension,
      if (primaryEmotion != null) 'primary_emotion': primaryEmotion,
      if (secondaryEmotion != null) 'secondary_emotion': secondaryEmotion,
      if (bodySymptoms != null) 'body_symptoms': bodySymptoms,
      if (initialBodyReactions != null)
        'initial_body_reactions': initialBodyReactions,
      if (additionalEmotions != null) 'additional_emotions': additionalEmotions,
      if (thoughtFocus != null) 'thought_focus': thoughtFocus,
      if (automaticThought != null) 'automatic_thought': automaticThought,
      if (firstImpulse != null) 'first_impulse': firstImpulse,
      if (factInterpretationResult != null)
        'fact_interpretation_result': factInterpretationResult,
      if (systemReaction != null) 'system_reaction': systemReaction,
      if (thoughtPatterns != null) 'thought_patterns': thoughtPatterns,
      if (actualBehaviorTags != null)
        'actual_behavior_tags': actualBehaviorTags,
      if (actualBehavior != null) 'actual_behavior': actualBehavior,
      if (tippingPointAwareness != null)
        'tipping_point_awareness': tippingPointAwareness,
      if (fearOrPressurePoint != null)
        'fear_or_pressure_point': fearOrPressurePoint,
      if (needOrWoundedPoint != null)
        'need_or_wounded_point': needOrWoundedPoint,
      if (touchedThemes != null) 'touched_themes': touchedThemes,
      if (neededSupports != null) 'needed_supports': neededSupports,
      if (realisticAlternative != null)
        'realistic_alternative': realisticAlternative,
      if (triggerAsLastDrop != null) 'trigger_as_last_drop': triggerAsLastDrop,
      if (backgroundTheme != null) 'background_theme': backgroundTheme,
      if (preEscalationRelief != null)
        'pre_escalation_relief': preEscalationRelief,
      if (patternFamiliarity != null) 'pattern_familiarity': patternFamiliarity,
      if (nextStep != null) 'next_step': nextStep,
      if (systemState != null) 'system_state': systemState,
      if (isCrisis != null) 'is_crisis': isCrisis,
      if (evaluationHeadlineKey != null)
        'evaluation_headline_key': evaluationHeadlineKey,
      if (evaluationMeaningKey != null)
        'evaluation_meaning_key': evaluationMeaningKey,
      if (evaluationHelpfulNowKey != null)
        'evaluation_helpful_now_key': evaluationHelpfulNowKey,
      if (evaluationLearningPointKey != null)
        'evaluation_learning_point_key': evaluationLearningPointKey,
      if (evaluationStatusKeys != null)
        'evaluation_status_keys': evaluationStatusKeys,
      if (suggestedTipIds != null) 'suggested_tip_ids': suggestedTipIds,
      if (suggestedNextActionKey != null)
        'suggested_next_action_key': suggestedNextActionKey,
      if (selectedNextActionKey != null)
        'selected_next_action_key': selectedNextActionKey,
      if (aiEvaluationStatus != null)
        'ai_evaluation_status': aiEvaluationStatus,
      if (aiEvaluationProvider != null)
        'ai_evaluation_provider': aiEvaluationProvider,
      if (aiEvaluationModel != null) 'ai_evaluation_model': aiEvaluationModel,
      if (aiEvaluationRequestedAt != null)
        'ai_evaluation_requested_at': aiEvaluationRequestedAt,
      if (aiEvaluationCompletedAt != null)
        'ai_evaluation_completed_at': aiEvaluationCompletedAt,
      if (aiEvaluationConsentGiven != null)
        'ai_evaluation_consent_given': aiEvaluationConsentGiven,
      if (aiEvaluationText != null) 'ai_evaluation_text': aiEvaluationText,
      if (aiEvaluationSchemaVersion != null)
        'ai_evaluation_schema_version': aiEvaluationSchemaVersion,
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
      Value<String?>? involvedEntities,
      Value<String?>? preTriggerPreoccupation,
      Value<String?>? problemTiming,
      Value<String?>? triggerDescription,
      Value<int?>? preTriggerLoad,
      Value<int>? intensity,
      Value<int>? bodyTension,
      Value<String>? primaryEmotion,
      Value<String?>? secondaryEmotion,
      Value<String?>? bodySymptoms,
      Value<String?>? initialBodyReactions,
      Value<String?>? additionalEmotions,
      Value<String?>? thoughtFocus,
      Value<String>? automaticThought,
      Value<String>? firstImpulse,
      Value<String?>? factInterpretationResult,
      Value<String?>? systemReaction,
      Value<String?>? thoughtPatterns,
      Value<String?>? actualBehaviorTags,
      Value<String?>? actualBehavior,
      Value<String?>? tippingPointAwareness,
      Value<String?>? fearOrPressurePoint,
      Value<String?>? needOrWoundedPoint,
      Value<String?>? touchedThemes,
      Value<String?>? neededSupports,
      Value<String?>? realisticAlternative,
      Value<String?>? triggerAsLastDrop,
      Value<String?>? backgroundTheme,
      Value<String?>? preEscalationRelief,
      Value<String?>? patternFamiliarity,
      Value<String?>? nextStep,
      Value<String>? systemState,
      Value<bool>? isCrisis,
      Value<String?>? evaluationHeadlineKey,
      Value<String?>? evaluationMeaningKey,
      Value<String?>? evaluationHelpfulNowKey,
      Value<String?>? evaluationLearningPointKey,
      Value<String?>? evaluationStatusKeys,
      Value<String?>? suggestedTipIds,
      Value<String?>? suggestedNextActionKey,
      Value<String?>? selectedNextActionKey,
      Value<String?>? aiEvaluationStatus,
      Value<String?>? aiEvaluationProvider,
      Value<String?>? aiEvaluationModel,
      Value<DateTime?>? aiEvaluationRequestedAt,
      Value<DateTime?>? aiEvaluationCompletedAt,
      Value<bool>? aiEvaluationConsentGiven,
      Value<String?>? aiEvaluationText,
      Value<int?>? aiEvaluationSchemaVersion,
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
      involvedEntities: involvedEntities ?? this.involvedEntities,
      preTriggerPreoccupation:
          preTriggerPreoccupation ?? this.preTriggerPreoccupation,
      problemTiming: problemTiming ?? this.problemTiming,
      triggerDescription: triggerDescription ?? this.triggerDescription,
      preTriggerLoad: preTriggerLoad ?? this.preTriggerLoad,
      intensity: intensity ?? this.intensity,
      bodyTension: bodyTension ?? this.bodyTension,
      primaryEmotion: primaryEmotion ?? this.primaryEmotion,
      secondaryEmotion: secondaryEmotion ?? this.secondaryEmotion,
      bodySymptoms: bodySymptoms ?? this.bodySymptoms,
      initialBodyReactions: initialBodyReactions ?? this.initialBodyReactions,
      additionalEmotions: additionalEmotions ?? this.additionalEmotions,
      thoughtFocus: thoughtFocus ?? this.thoughtFocus,
      automaticThought: automaticThought ?? this.automaticThought,
      firstImpulse: firstImpulse ?? this.firstImpulse,
      factInterpretationResult:
          factInterpretationResult ?? this.factInterpretationResult,
      systemReaction: systemReaction ?? this.systemReaction,
      thoughtPatterns: thoughtPatterns ?? this.thoughtPatterns,
      actualBehaviorTags: actualBehaviorTags ?? this.actualBehaviorTags,
      actualBehavior: actualBehavior ?? this.actualBehavior,
      tippingPointAwareness:
          tippingPointAwareness ?? this.tippingPointAwareness,
      fearOrPressurePoint: fearOrPressurePoint ?? this.fearOrPressurePoint,
      needOrWoundedPoint: needOrWoundedPoint ?? this.needOrWoundedPoint,
      touchedThemes: touchedThemes ?? this.touchedThemes,
      neededSupports: neededSupports ?? this.neededSupports,
      realisticAlternative: realisticAlternative ?? this.realisticAlternative,
      triggerAsLastDrop: triggerAsLastDrop ?? this.triggerAsLastDrop,
      backgroundTheme: backgroundTheme ?? this.backgroundTheme,
      preEscalationRelief: preEscalationRelief ?? this.preEscalationRelief,
      patternFamiliarity: patternFamiliarity ?? this.patternFamiliarity,
      nextStep: nextStep ?? this.nextStep,
      systemState: systemState ?? this.systemState,
      isCrisis: isCrisis ?? this.isCrisis,
      evaluationHeadlineKey:
          evaluationHeadlineKey ?? this.evaluationHeadlineKey,
      evaluationMeaningKey: evaluationMeaningKey ?? this.evaluationMeaningKey,
      evaluationHelpfulNowKey:
          evaluationHelpfulNowKey ?? this.evaluationHelpfulNowKey,
      evaluationLearningPointKey:
          evaluationLearningPointKey ?? this.evaluationLearningPointKey,
      evaluationStatusKeys: evaluationStatusKeys ?? this.evaluationStatusKeys,
      suggestedTipIds: suggestedTipIds ?? this.suggestedTipIds,
      suggestedNextActionKey:
          suggestedNextActionKey ?? this.suggestedNextActionKey,
      selectedNextActionKey:
          selectedNextActionKey ?? this.selectedNextActionKey,
      aiEvaluationStatus: aiEvaluationStatus ?? this.aiEvaluationStatus,
      aiEvaluationProvider: aiEvaluationProvider ?? this.aiEvaluationProvider,
      aiEvaluationModel: aiEvaluationModel ?? this.aiEvaluationModel,
      aiEvaluationRequestedAt:
          aiEvaluationRequestedAt ?? this.aiEvaluationRequestedAt,
      aiEvaluationCompletedAt:
          aiEvaluationCompletedAt ?? this.aiEvaluationCompletedAt,
      aiEvaluationConsentGiven:
          aiEvaluationConsentGiven ?? this.aiEvaluationConsentGiven,
      aiEvaluationText: aiEvaluationText ?? this.aiEvaluationText,
      aiEvaluationSchemaVersion:
          aiEvaluationSchemaVersion ?? this.aiEvaluationSchemaVersion,
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
    if (involvedEntities.present) {
      map['involved_entities'] = Variable<String>(involvedEntities.value);
    }
    if (preTriggerPreoccupation.present) {
      map['pre_trigger_preoccupation'] =
          Variable<String>(preTriggerPreoccupation.value);
    }
    if (problemTiming.present) {
      map['problem_timing'] = Variable<String>(problemTiming.value);
    }
    if (triggerDescription.present) {
      map['trigger_description'] = Variable<String>(triggerDescription.value);
    }
    if (preTriggerLoad.present) {
      map['pre_trigger_load'] = Variable<int>(preTriggerLoad.value);
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
    if (initialBodyReactions.present) {
      map['initial_body_reactions'] =
          Variable<String>(initialBodyReactions.value);
    }
    if (additionalEmotions.present) {
      map['additional_emotions'] = Variable<String>(additionalEmotions.value);
    }
    if (thoughtFocus.present) {
      map['thought_focus'] = Variable<String>(thoughtFocus.value);
    }
    if (automaticThought.present) {
      map['automatic_thought'] = Variable<String>(automaticThought.value);
    }
    if (firstImpulse.present) {
      map['first_impulse'] = Variable<String>(firstImpulse.value);
    }
    if (factInterpretationResult.present) {
      map['fact_interpretation_result'] =
          Variable<String>(factInterpretationResult.value);
    }
    if (systemReaction.present) {
      map['system_reaction'] = Variable<String>(systemReaction.value);
    }
    if (thoughtPatterns.present) {
      map['thought_patterns'] = Variable<String>(thoughtPatterns.value);
    }
    if (actualBehaviorTags.present) {
      map['actual_behavior_tags'] = Variable<String>(actualBehaviorTags.value);
    }
    if (actualBehavior.present) {
      map['actual_behavior'] = Variable<String>(actualBehavior.value);
    }
    if (tippingPointAwareness.present) {
      map['tipping_point_awareness'] =
          Variable<String>(tippingPointAwareness.value);
    }
    if (fearOrPressurePoint.present) {
      map['fear_or_pressure_point'] =
          Variable<String>(fearOrPressurePoint.value);
    }
    if (needOrWoundedPoint.present) {
      map['need_or_wounded_point'] = Variable<String>(needOrWoundedPoint.value);
    }
    if (touchedThemes.present) {
      map['touched_themes'] = Variable<String>(touchedThemes.value);
    }
    if (neededSupports.present) {
      map['needed_supports'] = Variable<String>(neededSupports.value);
    }
    if (realisticAlternative.present) {
      map['realistic_alternative'] =
          Variable<String>(realisticAlternative.value);
    }
    if (triggerAsLastDrop.present) {
      map['trigger_as_last_drop'] = Variable<String>(triggerAsLastDrop.value);
    }
    if (backgroundTheme.present) {
      map['background_theme'] = Variable<String>(backgroundTheme.value);
    }
    if (preEscalationRelief.present) {
      map['pre_escalation_relief'] =
          Variable<String>(preEscalationRelief.value);
    }
    if (patternFamiliarity.present) {
      map['pattern_familiarity'] = Variable<String>(patternFamiliarity.value);
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
    if (evaluationHeadlineKey.present) {
      map['evaluation_headline_key'] =
          Variable<String>(evaluationHeadlineKey.value);
    }
    if (evaluationMeaningKey.present) {
      map['evaluation_meaning_key'] =
          Variable<String>(evaluationMeaningKey.value);
    }
    if (evaluationHelpfulNowKey.present) {
      map['evaluation_helpful_now_key'] =
          Variable<String>(evaluationHelpfulNowKey.value);
    }
    if (evaluationLearningPointKey.present) {
      map['evaluation_learning_point_key'] =
          Variable<String>(evaluationLearningPointKey.value);
    }
    if (evaluationStatusKeys.present) {
      map['evaluation_status_keys'] =
          Variable<String>(evaluationStatusKeys.value);
    }
    if (suggestedTipIds.present) {
      map['suggested_tip_ids'] = Variable<String>(suggestedTipIds.value);
    }
    if (suggestedNextActionKey.present) {
      map['suggested_next_action_key'] =
          Variable<String>(suggestedNextActionKey.value);
    }
    if (selectedNextActionKey.present) {
      map['selected_next_action_key'] =
          Variable<String>(selectedNextActionKey.value);
    }
    if (aiEvaluationStatus.present) {
      map['ai_evaluation_status'] = Variable<String>(aiEvaluationStatus.value);
    }
    if (aiEvaluationProvider.present) {
      map['ai_evaluation_provider'] =
          Variable<String>(aiEvaluationProvider.value);
    }
    if (aiEvaluationModel.present) {
      map['ai_evaluation_model'] = Variable<String>(aiEvaluationModel.value);
    }
    if (aiEvaluationRequestedAt.present) {
      map['ai_evaluation_requested_at'] =
          Variable<DateTime>(aiEvaluationRequestedAt.value);
    }
    if (aiEvaluationCompletedAt.present) {
      map['ai_evaluation_completed_at'] =
          Variable<DateTime>(aiEvaluationCompletedAt.value);
    }
    if (aiEvaluationConsentGiven.present) {
      map['ai_evaluation_consent_given'] =
          Variable<bool>(aiEvaluationConsentGiven.value);
    }
    if (aiEvaluationText.present) {
      map['ai_evaluation_text'] = Variable<String>(aiEvaluationText.value);
    }
    if (aiEvaluationSchemaVersion.present) {
      map['ai_evaluation_schema_version'] =
          Variable<int>(aiEvaluationSchemaVersion.value);
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
          ..write('involvedEntities: $involvedEntities, ')
          ..write('preTriggerPreoccupation: $preTriggerPreoccupation, ')
          ..write('problemTiming: $problemTiming, ')
          ..write('triggerDescription: $triggerDescription, ')
          ..write('preTriggerLoad: $preTriggerLoad, ')
          ..write('intensity: $intensity, ')
          ..write('bodyTension: $bodyTension, ')
          ..write('primaryEmotion: $primaryEmotion, ')
          ..write('secondaryEmotion: $secondaryEmotion, ')
          ..write('bodySymptoms: $bodySymptoms, ')
          ..write('initialBodyReactions: $initialBodyReactions, ')
          ..write('additionalEmotions: $additionalEmotions, ')
          ..write('thoughtFocus: $thoughtFocus, ')
          ..write('automaticThought: $automaticThought, ')
          ..write('firstImpulse: $firstImpulse, ')
          ..write('factInterpretationResult: $factInterpretationResult, ')
          ..write('systemReaction: $systemReaction, ')
          ..write('thoughtPatterns: $thoughtPatterns, ')
          ..write('actualBehaviorTags: $actualBehaviorTags, ')
          ..write('actualBehavior: $actualBehavior, ')
          ..write('tippingPointAwareness: $tippingPointAwareness, ')
          ..write('fearOrPressurePoint: $fearOrPressurePoint, ')
          ..write('needOrWoundedPoint: $needOrWoundedPoint, ')
          ..write('touchedThemes: $touchedThemes, ')
          ..write('neededSupports: $neededSupports, ')
          ..write('realisticAlternative: $realisticAlternative, ')
          ..write('triggerAsLastDrop: $triggerAsLastDrop, ')
          ..write('backgroundTheme: $backgroundTheme, ')
          ..write('preEscalationRelief: $preEscalationRelief, ')
          ..write('patternFamiliarity: $patternFamiliarity, ')
          ..write('nextStep: $nextStep, ')
          ..write('systemState: $systemState, ')
          ..write('isCrisis: $isCrisis, ')
          ..write('evaluationHeadlineKey: $evaluationHeadlineKey, ')
          ..write('evaluationMeaningKey: $evaluationMeaningKey, ')
          ..write('evaluationHelpfulNowKey: $evaluationHelpfulNowKey, ')
          ..write('evaluationLearningPointKey: $evaluationLearningPointKey, ')
          ..write('evaluationStatusKeys: $evaluationStatusKeys, ')
          ..write('suggestedTipIds: $suggestedTipIds, ')
          ..write('suggestedNextActionKey: $suggestedNextActionKey, ')
          ..write('selectedNextActionKey: $selectedNextActionKey, ')
          ..write('aiEvaluationStatus: $aiEvaluationStatus, ')
          ..write('aiEvaluationProvider: $aiEvaluationProvider, ')
          ..write('aiEvaluationModel: $aiEvaluationModel, ')
          ..write('aiEvaluationRequestedAt: $aiEvaluationRequestedAt, ')
          ..write('aiEvaluationCompletedAt: $aiEvaluationCompletedAt, ')
          ..write('aiEvaluationConsentGiven: $aiEvaluationConsentGiven, ')
          ..write('aiEvaluationText: $aiEvaluationText, ')
          ..write('aiEvaluationSchemaVersion: $aiEvaluationSchemaVersion, ')
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
  Value<String?> involvedEntities,
  Value<String?> preTriggerPreoccupation,
  Value<String?> problemTiming,
  Value<String?> triggerDescription,
  Value<int?> preTriggerLoad,
  required int intensity,
  required int bodyTension,
  required String primaryEmotion,
  Value<String?> secondaryEmotion,
  Value<String?> bodySymptoms,
  Value<String?> initialBodyReactions,
  Value<String?> additionalEmotions,
  Value<String?> thoughtFocus,
  required String automaticThought,
  required String firstImpulse,
  Value<String?> factInterpretationResult,
  Value<String?> systemReaction,
  Value<String?> thoughtPatterns,
  Value<String?> actualBehaviorTags,
  Value<String?> actualBehavior,
  Value<String?> tippingPointAwareness,
  Value<String?> fearOrPressurePoint,
  Value<String?> needOrWoundedPoint,
  Value<String?> touchedThemes,
  Value<String?> neededSupports,
  Value<String?> realisticAlternative,
  Value<String?> triggerAsLastDrop,
  Value<String?> backgroundTheme,
  Value<String?> preEscalationRelief,
  Value<String?> patternFamiliarity,
  Value<String?> nextStep,
  required String systemState,
  Value<bool> isCrisis,
  Value<String?> evaluationHeadlineKey,
  Value<String?> evaluationMeaningKey,
  Value<String?> evaluationHelpfulNowKey,
  Value<String?> evaluationLearningPointKey,
  Value<String?> evaluationStatusKeys,
  Value<String?> suggestedTipIds,
  Value<String?> suggestedNextActionKey,
  Value<String?> selectedNextActionKey,
  Value<String?> aiEvaluationStatus,
  Value<String?> aiEvaluationProvider,
  Value<String?> aiEvaluationModel,
  Value<DateTime?> aiEvaluationRequestedAt,
  Value<DateTime?> aiEvaluationCompletedAt,
  Value<bool> aiEvaluationConsentGiven,
  Value<String?> aiEvaluationText,
  Value<int?> aiEvaluationSchemaVersion,
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
  Value<String?> involvedEntities,
  Value<String?> preTriggerPreoccupation,
  Value<String?> problemTiming,
  Value<String?> triggerDescription,
  Value<int?> preTriggerLoad,
  Value<int> intensity,
  Value<int> bodyTension,
  Value<String> primaryEmotion,
  Value<String?> secondaryEmotion,
  Value<String?> bodySymptoms,
  Value<String?> initialBodyReactions,
  Value<String?> additionalEmotions,
  Value<String?> thoughtFocus,
  Value<String> automaticThought,
  Value<String> firstImpulse,
  Value<String?> factInterpretationResult,
  Value<String?> systemReaction,
  Value<String?> thoughtPatterns,
  Value<String?> actualBehaviorTags,
  Value<String?> actualBehavior,
  Value<String?> tippingPointAwareness,
  Value<String?> fearOrPressurePoint,
  Value<String?> needOrWoundedPoint,
  Value<String?> touchedThemes,
  Value<String?> neededSupports,
  Value<String?> realisticAlternative,
  Value<String?> triggerAsLastDrop,
  Value<String?> backgroundTheme,
  Value<String?> preEscalationRelief,
  Value<String?> patternFamiliarity,
  Value<String?> nextStep,
  Value<String> systemState,
  Value<bool> isCrisis,
  Value<String?> evaluationHeadlineKey,
  Value<String?> evaluationMeaningKey,
  Value<String?> evaluationHelpfulNowKey,
  Value<String?> evaluationLearningPointKey,
  Value<String?> evaluationStatusKeys,
  Value<String?> suggestedTipIds,
  Value<String?> suggestedNextActionKey,
  Value<String?> selectedNextActionKey,
  Value<String?> aiEvaluationStatus,
  Value<String?> aiEvaluationProvider,
  Value<String?> aiEvaluationModel,
  Value<DateTime?> aiEvaluationRequestedAt,
  Value<DateTime?> aiEvaluationCompletedAt,
  Value<bool> aiEvaluationConsentGiven,
  Value<String?> aiEvaluationText,
  Value<int?> aiEvaluationSchemaVersion,
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

  ColumnFilters<String> get involvedEntities => $composableBuilder(
      column: $table.involvedEntities,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get preTriggerPreoccupation => $composableBuilder(
      column: $table.preTriggerPreoccupation,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get problemTiming => $composableBuilder(
      column: $table.problemTiming, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get triggerDescription => $composableBuilder(
      column: $table.triggerDescription,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get preTriggerLoad => $composableBuilder(
      column: $table.preTriggerLoad,
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

  ColumnFilters<String> get initialBodyReactions => $composableBuilder(
      column: $table.initialBodyReactions,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get additionalEmotions => $composableBuilder(
      column: $table.additionalEmotions,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get thoughtFocus => $composableBuilder(
      column: $table.thoughtFocus, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get automaticThought => $composableBuilder(
      column: $table.automaticThought,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get firstImpulse => $composableBuilder(
      column: $table.firstImpulse, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get factInterpretationResult => $composableBuilder(
      column: $table.factInterpretationResult,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get systemReaction => $composableBuilder(
      column: $table.systemReaction,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get thoughtPatterns => $composableBuilder(
      column: $table.thoughtPatterns,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get actualBehaviorTags => $composableBuilder(
      column: $table.actualBehaviorTags,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get actualBehavior => $composableBuilder(
      column: $table.actualBehavior,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tippingPointAwareness => $composableBuilder(
      column: $table.tippingPointAwareness,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fearOrPressurePoint => $composableBuilder(
      column: $table.fearOrPressurePoint,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get needOrWoundedPoint => $composableBuilder(
      column: $table.needOrWoundedPoint,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get touchedThemes => $composableBuilder(
      column: $table.touchedThemes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get neededSupports => $composableBuilder(
      column: $table.neededSupports,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get realisticAlternative => $composableBuilder(
      column: $table.realisticAlternative,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get triggerAsLastDrop => $composableBuilder(
      column: $table.triggerAsLastDrop,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get backgroundTheme => $composableBuilder(
      column: $table.backgroundTheme,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get preEscalationRelief => $composableBuilder(
      column: $table.preEscalationRelief,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get patternFamiliarity => $composableBuilder(
      column: $table.patternFamiliarity,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nextStep => $composableBuilder(
      column: $table.nextStep, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get systemState => $composableBuilder(
      column: $table.systemState, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isCrisis => $composableBuilder(
      column: $table.isCrisis, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get evaluationHeadlineKey => $composableBuilder(
      column: $table.evaluationHeadlineKey,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get evaluationMeaningKey => $composableBuilder(
      column: $table.evaluationMeaningKey,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get evaluationHelpfulNowKey => $composableBuilder(
      column: $table.evaluationHelpfulNowKey,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get evaluationLearningPointKey => $composableBuilder(
      column: $table.evaluationLearningPointKey,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get evaluationStatusKeys => $composableBuilder(
      column: $table.evaluationStatusKeys,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get suggestedTipIds => $composableBuilder(
      column: $table.suggestedTipIds,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get suggestedNextActionKey => $composableBuilder(
      column: $table.suggestedNextActionKey,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get selectedNextActionKey => $composableBuilder(
      column: $table.selectedNextActionKey,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get aiEvaluationStatus => $composableBuilder(
      column: $table.aiEvaluationStatus,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get aiEvaluationProvider => $composableBuilder(
      column: $table.aiEvaluationProvider,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get aiEvaluationModel => $composableBuilder(
      column: $table.aiEvaluationModel,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get aiEvaluationRequestedAt => $composableBuilder(
      column: $table.aiEvaluationRequestedAt,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get aiEvaluationCompletedAt => $composableBuilder(
      column: $table.aiEvaluationCompletedAt,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get aiEvaluationConsentGiven => $composableBuilder(
      column: $table.aiEvaluationConsentGiven,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get aiEvaluationText => $composableBuilder(
      column: $table.aiEvaluationText,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get aiEvaluationSchemaVersion => $composableBuilder(
      column: $table.aiEvaluationSchemaVersion,
      builder: (column) => ColumnFilters(column));

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

  ColumnOrderings<String> get involvedEntities => $composableBuilder(
      column: $table.involvedEntities,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get preTriggerPreoccupation => $composableBuilder(
      column: $table.preTriggerPreoccupation,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get problemTiming => $composableBuilder(
      column: $table.problemTiming,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get triggerDescription => $composableBuilder(
      column: $table.triggerDescription,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get preTriggerLoad => $composableBuilder(
      column: $table.preTriggerLoad,
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

  ColumnOrderings<String> get initialBodyReactions => $composableBuilder(
      column: $table.initialBodyReactions,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get additionalEmotions => $composableBuilder(
      column: $table.additionalEmotions,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get thoughtFocus => $composableBuilder(
      column: $table.thoughtFocus,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get automaticThought => $composableBuilder(
      column: $table.automaticThought,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get firstImpulse => $composableBuilder(
      column: $table.firstImpulse,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get factInterpretationResult => $composableBuilder(
      column: $table.factInterpretationResult,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get systemReaction => $composableBuilder(
      column: $table.systemReaction,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get thoughtPatterns => $composableBuilder(
      column: $table.thoughtPatterns,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get actualBehaviorTags => $composableBuilder(
      column: $table.actualBehaviorTags,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get actualBehavior => $composableBuilder(
      column: $table.actualBehavior,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tippingPointAwareness => $composableBuilder(
      column: $table.tippingPointAwareness,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fearOrPressurePoint => $composableBuilder(
      column: $table.fearOrPressurePoint,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get needOrWoundedPoint => $composableBuilder(
      column: $table.needOrWoundedPoint,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get touchedThemes => $composableBuilder(
      column: $table.touchedThemes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get neededSupports => $composableBuilder(
      column: $table.neededSupports,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get realisticAlternative => $composableBuilder(
      column: $table.realisticAlternative,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get triggerAsLastDrop => $composableBuilder(
      column: $table.triggerAsLastDrop,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get backgroundTheme => $composableBuilder(
      column: $table.backgroundTheme,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get preEscalationRelief => $composableBuilder(
      column: $table.preEscalationRelief,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get patternFamiliarity => $composableBuilder(
      column: $table.patternFamiliarity,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nextStep => $composableBuilder(
      column: $table.nextStep, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get systemState => $composableBuilder(
      column: $table.systemState, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isCrisis => $composableBuilder(
      column: $table.isCrisis, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get evaluationHeadlineKey => $composableBuilder(
      column: $table.evaluationHeadlineKey,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get evaluationMeaningKey => $composableBuilder(
      column: $table.evaluationMeaningKey,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get evaluationHelpfulNowKey => $composableBuilder(
      column: $table.evaluationHelpfulNowKey,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get evaluationLearningPointKey => $composableBuilder(
      column: $table.evaluationLearningPointKey,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get evaluationStatusKeys => $composableBuilder(
      column: $table.evaluationStatusKeys,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get suggestedTipIds => $composableBuilder(
      column: $table.suggestedTipIds,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get suggestedNextActionKey => $composableBuilder(
      column: $table.suggestedNextActionKey,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get selectedNextActionKey => $composableBuilder(
      column: $table.selectedNextActionKey,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get aiEvaluationStatus => $composableBuilder(
      column: $table.aiEvaluationStatus,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get aiEvaluationProvider => $composableBuilder(
      column: $table.aiEvaluationProvider,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get aiEvaluationModel => $composableBuilder(
      column: $table.aiEvaluationModel,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get aiEvaluationRequestedAt => $composableBuilder(
      column: $table.aiEvaluationRequestedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get aiEvaluationCompletedAt => $composableBuilder(
      column: $table.aiEvaluationCompletedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get aiEvaluationConsentGiven => $composableBuilder(
      column: $table.aiEvaluationConsentGiven,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get aiEvaluationText => $composableBuilder(
      column: $table.aiEvaluationText,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get aiEvaluationSchemaVersion => $composableBuilder(
      column: $table.aiEvaluationSchemaVersion,
      builder: (column) => ColumnOrderings(column));

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

  GeneratedColumn<String> get involvedEntities => $composableBuilder(
      column: $table.involvedEntities, builder: (column) => column);

  GeneratedColumn<String> get preTriggerPreoccupation => $composableBuilder(
      column: $table.preTriggerPreoccupation, builder: (column) => column);

  GeneratedColumn<String> get problemTiming => $composableBuilder(
      column: $table.problemTiming, builder: (column) => column);

  GeneratedColumn<String> get triggerDescription => $composableBuilder(
      column: $table.triggerDescription, builder: (column) => column);

  GeneratedColumn<int> get preTriggerLoad => $composableBuilder(
      column: $table.preTriggerLoad, builder: (column) => column);

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

  GeneratedColumn<String> get initialBodyReactions => $composableBuilder(
      column: $table.initialBodyReactions, builder: (column) => column);

  GeneratedColumn<String> get additionalEmotions => $composableBuilder(
      column: $table.additionalEmotions, builder: (column) => column);

  GeneratedColumn<String> get thoughtFocus => $composableBuilder(
      column: $table.thoughtFocus, builder: (column) => column);

  GeneratedColumn<String> get automaticThought => $composableBuilder(
      column: $table.automaticThought, builder: (column) => column);

  GeneratedColumn<String> get firstImpulse => $composableBuilder(
      column: $table.firstImpulse, builder: (column) => column);

  GeneratedColumn<String> get factInterpretationResult => $composableBuilder(
      column: $table.factInterpretationResult, builder: (column) => column);

  GeneratedColumn<String> get systemReaction => $composableBuilder(
      column: $table.systemReaction, builder: (column) => column);

  GeneratedColumn<String> get thoughtPatterns => $composableBuilder(
      column: $table.thoughtPatterns, builder: (column) => column);

  GeneratedColumn<String> get actualBehaviorTags => $composableBuilder(
      column: $table.actualBehaviorTags, builder: (column) => column);

  GeneratedColumn<String> get actualBehavior => $composableBuilder(
      column: $table.actualBehavior, builder: (column) => column);

  GeneratedColumn<String> get tippingPointAwareness => $composableBuilder(
      column: $table.tippingPointAwareness, builder: (column) => column);

  GeneratedColumn<String> get fearOrPressurePoint => $composableBuilder(
      column: $table.fearOrPressurePoint, builder: (column) => column);

  GeneratedColumn<String> get needOrWoundedPoint => $composableBuilder(
      column: $table.needOrWoundedPoint, builder: (column) => column);

  GeneratedColumn<String> get touchedThemes => $composableBuilder(
      column: $table.touchedThemes, builder: (column) => column);

  GeneratedColumn<String> get neededSupports => $composableBuilder(
      column: $table.neededSupports, builder: (column) => column);

  GeneratedColumn<String> get realisticAlternative => $composableBuilder(
      column: $table.realisticAlternative, builder: (column) => column);

  GeneratedColumn<String> get triggerAsLastDrop => $composableBuilder(
      column: $table.triggerAsLastDrop, builder: (column) => column);

  GeneratedColumn<String> get backgroundTheme => $composableBuilder(
      column: $table.backgroundTheme, builder: (column) => column);

  GeneratedColumn<String> get preEscalationRelief => $composableBuilder(
      column: $table.preEscalationRelief, builder: (column) => column);

  GeneratedColumn<String> get patternFamiliarity => $composableBuilder(
      column: $table.patternFamiliarity, builder: (column) => column);

  GeneratedColumn<String> get nextStep =>
      $composableBuilder(column: $table.nextStep, builder: (column) => column);

  GeneratedColumn<String> get systemState => $composableBuilder(
      column: $table.systemState, builder: (column) => column);

  GeneratedColumn<bool> get isCrisis =>
      $composableBuilder(column: $table.isCrisis, builder: (column) => column);

  GeneratedColumn<String> get evaluationHeadlineKey => $composableBuilder(
      column: $table.evaluationHeadlineKey, builder: (column) => column);

  GeneratedColumn<String> get evaluationMeaningKey => $composableBuilder(
      column: $table.evaluationMeaningKey, builder: (column) => column);

  GeneratedColumn<String> get evaluationHelpfulNowKey => $composableBuilder(
      column: $table.evaluationHelpfulNowKey, builder: (column) => column);

  GeneratedColumn<String> get evaluationLearningPointKey => $composableBuilder(
      column: $table.evaluationLearningPointKey, builder: (column) => column);

  GeneratedColumn<String> get evaluationStatusKeys => $composableBuilder(
      column: $table.evaluationStatusKeys, builder: (column) => column);

  GeneratedColumn<String> get suggestedTipIds => $composableBuilder(
      column: $table.suggestedTipIds, builder: (column) => column);

  GeneratedColumn<String> get suggestedNextActionKey => $composableBuilder(
      column: $table.suggestedNextActionKey, builder: (column) => column);

  GeneratedColumn<String> get selectedNextActionKey => $composableBuilder(
      column: $table.selectedNextActionKey, builder: (column) => column);

  GeneratedColumn<String> get aiEvaluationStatus => $composableBuilder(
      column: $table.aiEvaluationStatus, builder: (column) => column);

  GeneratedColumn<String> get aiEvaluationProvider => $composableBuilder(
      column: $table.aiEvaluationProvider, builder: (column) => column);

  GeneratedColumn<String> get aiEvaluationModel => $composableBuilder(
      column: $table.aiEvaluationModel, builder: (column) => column);

  GeneratedColumn<DateTime> get aiEvaluationRequestedAt => $composableBuilder(
      column: $table.aiEvaluationRequestedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get aiEvaluationCompletedAt => $composableBuilder(
      column: $table.aiEvaluationCompletedAt, builder: (column) => column);

  GeneratedColumn<bool> get aiEvaluationConsentGiven => $composableBuilder(
      column: $table.aiEvaluationConsentGiven, builder: (column) => column);

  GeneratedColumn<String> get aiEvaluationText => $composableBuilder(
      column: $table.aiEvaluationText, builder: (column) => column);

  GeneratedColumn<int> get aiEvaluationSchemaVersion => $composableBuilder(
      column: $table.aiEvaluationSchemaVersion, builder: (column) => column);

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
            Value<String?> involvedEntities = const Value.absent(),
            Value<String?> preTriggerPreoccupation = const Value.absent(),
            Value<String?> problemTiming = const Value.absent(),
            Value<String?> triggerDescription = const Value.absent(),
            Value<int?> preTriggerLoad = const Value.absent(),
            Value<int> intensity = const Value.absent(),
            Value<int> bodyTension = const Value.absent(),
            Value<String> primaryEmotion = const Value.absent(),
            Value<String?> secondaryEmotion = const Value.absent(),
            Value<String?> bodySymptoms = const Value.absent(),
            Value<String?> initialBodyReactions = const Value.absent(),
            Value<String?> additionalEmotions = const Value.absent(),
            Value<String?> thoughtFocus = const Value.absent(),
            Value<String> automaticThought = const Value.absent(),
            Value<String> firstImpulse = const Value.absent(),
            Value<String?> factInterpretationResult = const Value.absent(),
            Value<String?> systemReaction = const Value.absent(),
            Value<String?> thoughtPatterns = const Value.absent(),
            Value<String?> actualBehaviorTags = const Value.absent(),
            Value<String?> actualBehavior = const Value.absent(),
            Value<String?> tippingPointAwareness = const Value.absent(),
            Value<String?> fearOrPressurePoint = const Value.absent(),
            Value<String?> needOrWoundedPoint = const Value.absent(),
            Value<String?> touchedThemes = const Value.absent(),
            Value<String?> neededSupports = const Value.absent(),
            Value<String?> realisticAlternative = const Value.absent(),
            Value<String?> triggerAsLastDrop = const Value.absent(),
            Value<String?> backgroundTheme = const Value.absent(),
            Value<String?> preEscalationRelief = const Value.absent(),
            Value<String?> patternFamiliarity = const Value.absent(),
            Value<String?> nextStep = const Value.absent(),
            Value<String> systemState = const Value.absent(),
            Value<bool> isCrisis = const Value.absent(),
            Value<String?> evaluationHeadlineKey = const Value.absent(),
            Value<String?> evaluationMeaningKey = const Value.absent(),
            Value<String?> evaluationHelpfulNowKey = const Value.absent(),
            Value<String?> evaluationLearningPointKey = const Value.absent(),
            Value<String?> evaluationStatusKeys = const Value.absent(),
            Value<String?> suggestedTipIds = const Value.absent(),
            Value<String?> suggestedNextActionKey = const Value.absent(),
            Value<String?> selectedNextActionKey = const Value.absent(),
            Value<String?> aiEvaluationStatus = const Value.absent(),
            Value<String?> aiEvaluationProvider = const Value.absent(),
            Value<String?> aiEvaluationModel = const Value.absent(),
            Value<DateTime?> aiEvaluationRequestedAt = const Value.absent(),
            Value<DateTime?> aiEvaluationCompletedAt = const Value.absent(),
            Value<bool> aiEvaluationConsentGiven = const Value.absent(),
            Value<String?> aiEvaluationText = const Value.absent(),
            Value<int?> aiEvaluationSchemaVersion = const Value.absent(),
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
            involvedEntities: involvedEntities,
            preTriggerPreoccupation: preTriggerPreoccupation,
            problemTiming: problemTiming,
            triggerDescription: triggerDescription,
            preTriggerLoad: preTriggerLoad,
            intensity: intensity,
            bodyTension: bodyTension,
            primaryEmotion: primaryEmotion,
            secondaryEmotion: secondaryEmotion,
            bodySymptoms: bodySymptoms,
            initialBodyReactions: initialBodyReactions,
            additionalEmotions: additionalEmotions,
            thoughtFocus: thoughtFocus,
            automaticThought: automaticThought,
            firstImpulse: firstImpulse,
            factInterpretationResult: factInterpretationResult,
            systemReaction: systemReaction,
            thoughtPatterns: thoughtPatterns,
            actualBehaviorTags: actualBehaviorTags,
            actualBehavior: actualBehavior,
            tippingPointAwareness: tippingPointAwareness,
            fearOrPressurePoint: fearOrPressurePoint,
            needOrWoundedPoint: needOrWoundedPoint,
            touchedThemes: touchedThemes,
            neededSupports: neededSupports,
            realisticAlternative: realisticAlternative,
            triggerAsLastDrop: triggerAsLastDrop,
            backgroundTheme: backgroundTheme,
            preEscalationRelief: preEscalationRelief,
            patternFamiliarity: patternFamiliarity,
            nextStep: nextStep,
            systemState: systemState,
            isCrisis: isCrisis,
            evaluationHeadlineKey: evaluationHeadlineKey,
            evaluationMeaningKey: evaluationMeaningKey,
            evaluationHelpfulNowKey: evaluationHelpfulNowKey,
            evaluationLearningPointKey: evaluationLearningPointKey,
            evaluationStatusKeys: evaluationStatusKeys,
            suggestedTipIds: suggestedTipIds,
            suggestedNextActionKey: suggestedNextActionKey,
            selectedNextActionKey: selectedNextActionKey,
            aiEvaluationStatus: aiEvaluationStatus,
            aiEvaluationProvider: aiEvaluationProvider,
            aiEvaluationModel: aiEvaluationModel,
            aiEvaluationRequestedAt: aiEvaluationRequestedAt,
            aiEvaluationCompletedAt: aiEvaluationCompletedAt,
            aiEvaluationConsentGiven: aiEvaluationConsentGiven,
            aiEvaluationText: aiEvaluationText,
            aiEvaluationSchemaVersion: aiEvaluationSchemaVersion,
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
            Value<String?> involvedEntities = const Value.absent(),
            Value<String?> preTriggerPreoccupation = const Value.absent(),
            Value<String?> problemTiming = const Value.absent(),
            Value<String?> triggerDescription = const Value.absent(),
            Value<int?> preTriggerLoad = const Value.absent(),
            required int intensity,
            required int bodyTension,
            required String primaryEmotion,
            Value<String?> secondaryEmotion = const Value.absent(),
            Value<String?> bodySymptoms = const Value.absent(),
            Value<String?> initialBodyReactions = const Value.absent(),
            Value<String?> additionalEmotions = const Value.absent(),
            Value<String?> thoughtFocus = const Value.absent(),
            required String automaticThought,
            required String firstImpulse,
            Value<String?> factInterpretationResult = const Value.absent(),
            Value<String?> systemReaction = const Value.absent(),
            Value<String?> thoughtPatterns = const Value.absent(),
            Value<String?> actualBehaviorTags = const Value.absent(),
            Value<String?> actualBehavior = const Value.absent(),
            Value<String?> tippingPointAwareness = const Value.absent(),
            Value<String?> fearOrPressurePoint = const Value.absent(),
            Value<String?> needOrWoundedPoint = const Value.absent(),
            Value<String?> touchedThemes = const Value.absent(),
            Value<String?> neededSupports = const Value.absent(),
            Value<String?> realisticAlternative = const Value.absent(),
            Value<String?> triggerAsLastDrop = const Value.absent(),
            Value<String?> backgroundTheme = const Value.absent(),
            Value<String?> preEscalationRelief = const Value.absent(),
            Value<String?> patternFamiliarity = const Value.absent(),
            Value<String?> nextStep = const Value.absent(),
            required String systemState,
            Value<bool> isCrisis = const Value.absent(),
            Value<String?> evaluationHeadlineKey = const Value.absent(),
            Value<String?> evaluationMeaningKey = const Value.absent(),
            Value<String?> evaluationHelpfulNowKey = const Value.absent(),
            Value<String?> evaluationLearningPointKey = const Value.absent(),
            Value<String?> evaluationStatusKeys = const Value.absent(),
            Value<String?> suggestedTipIds = const Value.absent(),
            Value<String?> suggestedNextActionKey = const Value.absent(),
            Value<String?> selectedNextActionKey = const Value.absent(),
            Value<String?> aiEvaluationStatus = const Value.absent(),
            Value<String?> aiEvaluationProvider = const Value.absent(),
            Value<String?> aiEvaluationModel = const Value.absent(),
            Value<DateTime?> aiEvaluationRequestedAt = const Value.absent(),
            Value<DateTime?> aiEvaluationCompletedAt = const Value.absent(),
            Value<bool> aiEvaluationConsentGiven = const Value.absent(),
            Value<String?> aiEvaluationText = const Value.absent(),
            Value<int?> aiEvaluationSchemaVersion = const Value.absent(),
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
            involvedEntities: involvedEntities,
            preTriggerPreoccupation: preTriggerPreoccupation,
            problemTiming: problemTiming,
            triggerDescription: triggerDescription,
            preTriggerLoad: preTriggerLoad,
            intensity: intensity,
            bodyTension: bodyTension,
            primaryEmotion: primaryEmotion,
            secondaryEmotion: secondaryEmotion,
            bodySymptoms: bodySymptoms,
            initialBodyReactions: initialBodyReactions,
            additionalEmotions: additionalEmotions,
            thoughtFocus: thoughtFocus,
            automaticThought: automaticThought,
            firstImpulse: firstImpulse,
            factInterpretationResult: factInterpretationResult,
            systemReaction: systemReaction,
            thoughtPatterns: thoughtPatterns,
            actualBehaviorTags: actualBehaviorTags,
            actualBehavior: actualBehavior,
            tippingPointAwareness: tippingPointAwareness,
            fearOrPressurePoint: fearOrPressurePoint,
            needOrWoundedPoint: needOrWoundedPoint,
            touchedThemes: touchedThemes,
            neededSupports: neededSupports,
            realisticAlternative: realisticAlternative,
            triggerAsLastDrop: triggerAsLastDrop,
            backgroundTheme: backgroundTheme,
            preEscalationRelief: preEscalationRelief,
            patternFamiliarity: patternFamiliarity,
            nextStep: nextStep,
            systemState: systemState,
            isCrisis: isCrisis,
            evaluationHeadlineKey: evaluationHeadlineKey,
            evaluationMeaningKey: evaluationMeaningKey,
            evaluationHelpfulNowKey: evaluationHelpfulNowKey,
            evaluationLearningPointKey: evaluationLearningPointKey,
            evaluationStatusKeys: evaluationStatusKeys,
            suggestedTipIds: suggestedTipIds,
            suggestedNextActionKey: suggestedNextActionKey,
            selectedNextActionKey: selectedNextActionKey,
            aiEvaluationStatus: aiEvaluationStatus,
            aiEvaluationProvider: aiEvaluationProvider,
            aiEvaluationModel: aiEvaluationModel,
            aiEvaluationRequestedAt: aiEvaluationRequestedAt,
            aiEvaluationCompletedAt: aiEvaluationCompletedAt,
            aiEvaluationConsentGiven: aiEvaluationConsentGiven,
            aiEvaluationText: aiEvaluationText,
            aiEvaluationSchemaVersion: aiEvaluationSchemaVersion,
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
