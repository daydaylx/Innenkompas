import '../../core/constants/app_constants.dart';
import '../../domain/models/situation_draft.dart';

class NewSituationValidators {
  NewSituationValidators._();

  static ValidationResult validateDescription(String value) {
    return _validateRequiredText(
      value,
      emptyMessage: 'Bitte beschreibe konkret, was passiert ist.',
      minLength: AppConstants.minSituationDescriptionLength,
      maxLength: AppConstants.maxSituationDescriptionLength,
      maxLengthMessage:
          'Die Beschreibung darf maximal ${AppConstants.maxSituationDescriptionLength} Zeichen lang sein.',
    );
  }

  static ValidationResult validatePreTriggerPreoccupation(String value) {
    return _validateRequiredText(
      value,
      emptyMessage:
          'Bitte halte fest, womit dein Kopf vorher schon beschäftigt war.',
      minLength: AppConstants.minReflectionFieldLength,
      maxLength: AppConstants.maxPreoccupationLength,
      maxLengthMessage:
          'Der Vorlauf darf maximal ${AppConstants.maxPreoccupationLength} Zeichen lang sein.',
    );
  }

  static ValidationResult validateTriggerDescription(String value) {
    return _validateRequiredText(
      value,
      emptyMessage: 'Bitte benenne den konkreten Auslöser.',
      minLength: AppConstants.minReflectionFieldLength,
      maxLength: AppConstants.maxTriggerDescriptionLength,
      maxLengthMessage:
          'Der Auslöser darf maximal ${AppConstants.maxTriggerDescriptionLength} Zeichen lang sein.',
    );
  }

  static ValidationResult validateIntensity(int value) {
    if (value < AppConstants.minIntensityRating ||
        value > AppConstants.maxIntensityRating) {
      return ValidationResult.errors([
        'Die Belastung muss zwischen ${AppConstants.minIntensityRating} und ${AppConstants.maxIntensityRating} liegen.',
      ]);
    }
    return const ValidationResult.valid();
  }

  static ValidationResult validateBodyTension(int value) {
    if (value < AppConstants.minBodyTensionRating ||
        value > AppConstants.maxBodyTensionRating) {
      return ValidationResult.errors([
        'Die körperliche Anspannung muss zwischen ${AppConstants.minBodyTensionRating} und ${AppConstants.maxBodyTensionRating} liegen.',
      ]);
    }
    return const ValidationResult.valid();
  }

  static ValidationResult validatePrimaryEmotion(dynamic emotion) {
    if (emotion == null) {
      return const ValidationResult.errors(
        ['Bitte wähle das stärkste Gefühl aus.'],
      );
    }
    return const ValidationResult.valid();
  }

  static ValidationResult validateThoughtFocus(String value) {
    return _validateRequiredText(
      value,
      emptyMessage:
          'Bitte beschreibe kurz, worin du gedanklich vertieft warst.',
      minLength: AppConstants.minReflectionFieldLength,
      maxLength: AppConstants.maxThoughtFocusLength,
      maxLengthMessage:
          'Der Gedankenfokus darf maximal ${AppConstants.maxThoughtFocusLength} Zeichen lang sein.',
    );
  }

  static ValidationResult validateAutomaticThought(String value) {
    return _validateRequiredText(
      value,
      emptyMessage: 'Bitte notiere deinen ersten automatischen Gedanken.',
      minLength: AppConstants.minReflectionFieldLength,
      maxLength: AppConstants.maxThoughtDescriptionLength,
      maxLengthMessage:
          'Der Gedanke darf maximal ${AppConstants.maxThoughtDescriptionLength} Zeichen lang sein.',
    );
  }

  static ValidationResult validateFactInterpretation(dynamic result) {
    if (result == null) {
      return const ValidationResult.errors([
        'Bitte ordne kurz ein, ob es eher Fakt oder Deutung war.',
      ]);
    }
    return const ValidationResult.valid();
  }

  static ValidationResult validateSystemReaction(dynamic reaction) {
    if (reaction == null) {
      return const ValidationResult.errors([
        'Bitte wähle, wie dein System zuerst reagiert hat.',
      ]);
    }
    return const ValidationResult.valid();
  }

  static ValidationResult validateActualBehavior({
    required List<String> behaviorTags,
    required String? note,
  }) {
    final trimmedNote = note?.trim() ?? '';
    if (behaviorTags.isEmpty && trimmedNote.isEmpty) {
      return const ValidationResult.errors([
        'Bitte halte fest, was du tatsächlich gemacht hast.',
      ]);
    }
    if (trimmedNote.length > AppConstants.maxBehaviorDescriptionLength) {
      return ValidationResult.errors([
        'Die Verhaltensnotiz darf maximal ${AppConstants.maxBehaviorDescriptionLength} Zeichen lang sein.',
      ]);
    }
    return const ValidationResult.valid();
  }

  static ValidationResult validateRealisticAlternative(String value) {
    return _validateRequiredText(
      value,
      emptyMessage:
          'Bitte formuliere einen realistischen anderen Schritt für den Moment.',
      minLength: AppConstants.minReflectionFieldLength,
      maxLength: AppConstants.maxAlternativeStepLength,
      maxLengthMessage:
          'Die Alternative darf maximal ${AppConstants.maxAlternativeStepLength} Zeichen lang sein.',
    );
  }

  static ValidationResult validateBackgroundTheme(String value) {
    return _validateRequiredText(
      value,
      emptyMessage:
          'Bitte benenne kurz, was wahrscheinlich das eigentliche Thema dahinter war.',
      minLength: AppConstants.minReflectionFieldLength,
      maxLength: AppConstants.maxBackgroundThemeLength,
      maxLengthMessage:
          'Das Hintergrundthema darf maximal ${AppConstants.maxBackgroundThemeLength} Zeichen lang sein.',
    );
  }

  static ValidationResult validateNextStep(String value) {
    return _validateRequiredText(
      value,
      emptyMessage:
          'Bitte formuliere den kleinsten sinnvollen nächsten Schritt.',
      minLength: AppConstants.minReflectionFieldLength,
      maxLength: AppConstants.maxNextStepLength,
      maxLengthMessage:
          'Der nächste Schritt darf maximal ${AppConstants.maxNextStepLength} Zeichen lang sein.',
    );
  }

  static ValidationResult validateEventData(SituationEventData data) {
    final errors = <String>[];

    final descriptionResult = validateDescription(data.description);
    if (!descriptionResult.isValid) {
      errors.addAll(descriptionResult.errorMessages);
    }

    final preoccupationResult =
        validatePreTriggerPreoccupation(data.preTriggerPreoccupation);
    if (!preoccupationResult.isValid) {
      errors.addAll(preoccupationResult.errorMessages);
    }

    final triggerResult = validateTriggerDescription(data.trigger);
    if (!triggerResult.isValid) {
      errors.addAll(triggerResult.errorMessages);
    }

    return errors.isEmpty
        ? const ValidationResult.valid()
        : ValidationResult.errors(errors);
  }

  static ValidationResult validateEmotionData(SituationEmotionData data) {
    final errors = <String>[];

    final preTriggerLoadResult = validateIntensity(data.preTriggerLoad);
    if (!preTriggerLoadResult.isValid) {
      errors.addAll(preTriggerLoadResult.errorMessages);
    }

    final intensityResult = validateIntensity(data.intensity);
    if (!intensityResult.isValid) {
      errors.addAll(intensityResult.errorMessages);
    }

    final tensionResult = validateBodyTension(data.bodyTension);
    if (!tensionResult.isValid) {
      errors.addAll(tensionResult.errorMessages);
    }

    final emotionResult = validatePrimaryEmotion(data.primaryEmotion);
    if (!emotionResult.isValid) {
      errors.addAll(emotionResult.errorMessages);
    }

    if (data.initialBodyReactions.length > 3) {
      errors.add('Bitte wähle höchstens drei Körperreaktionen aus.');
    }

    if (data.additionalEmotions.length > 2) {
      errors.add('Bitte wähle höchstens zwei zusätzliche Gefühle aus.');
    }

    return errors.isEmpty
        ? const ValidationResult.valid()
        : ValidationResult.errors(errors);
  }

  static ValidationResult validateThoughtImpulseData(
    SituationThoughtImpulseData data,
  ) {
    final errors = <String>[];

    final thoughtFocusResult = validateThoughtFocus(data.thoughtFocus);
    if (!thoughtFocusResult.isValid) {
      errors.addAll(thoughtFocusResult.errorMessages);
    }

    final thoughtResult = validateAutomaticThought(data.automaticThought);
    if (!thoughtResult.isValid) {
      errors.addAll(thoughtResult.errorMessages);
    }

    final factResult = validateFactInterpretation(data.factInterpretation);
    if (!factResult.isValid) {
      errors.addAll(factResult.errorMessages);
    }

    final reactionResult = validateSystemReaction(data.systemReaction);
    if (!reactionResult.isValid) {
      errors.addAll(reactionResult.errorMessages);
    }

    final behaviorResult = validateActualBehavior(
      behaviorTags: data.actualBehaviorTags,
      note: data.actualBehaviorNote,
    );
    if (!behaviorResult.isValid) {
      errors.addAll(behaviorResult.errorMessages);
    }

    if (data.thoughtPatterns.length > 2) {
      errors.add('Bitte wähle höchstens zwei Gedankenmuster aus.');
    }

    if (data.fearOrPressurePoint != null &&
        data.fearOrPressurePoint!.trim().length >
            AppConstants.maxFearPressurePointLength) {
      errors.add(
        'Die Zusatznotiz zu Angst oder Druck darf maximal ${AppConstants.maxFearPressurePointLength} Zeichen lang sein.',
      );
    }

    return errors.isEmpty
        ? const ValidationResult.valid()
        : ValidationResult.errors(errors);
  }

  static ValidationResult validateReflectionData(SituationReflectionData data) {
    final errors = <String>[];

    if (data.touchedThemes.isEmpty) {
      errors.add('Bitte wähle aus, was in dir getroffen wurde.');
    }
    if (data.touchedThemes.length > 2) {
      errors.add('Bitte wähle höchstens zwei getroffene Themen aus.');
    }

    if (data.neededSupports.isEmpty) {
      errors.add('Bitte wähle aus, was du in dem Moment gebraucht hättest.');
    }
    if (data.neededSupports.length > 2) {
      errors.add('Bitte wähle höchstens zwei benötigte Dinge aus.');
    }

    final alternativeResult =
        validateRealisticAlternative(data.realisticAlternative);
    if (!alternativeResult.isValid) {
      errors.addAll(alternativeResult.errorMessages);
    }

    final backgroundThemeResult = validateBackgroundTheme(data.backgroundTheme);
    if (!backgroundThemeResult.isValid) {
      errors.addAll(backgroundThemeResult.errorMessages);
    }

    final nextStepResult = validateNextStep(data.nextStep);
    if (!nextStepResult.isValid) {
      errors.addAll(nextStepResult.errorMessages);
    }

    if (data.preEscalationRelief != null &&
        data.preEscalationRelief!.trim().length >
            AppConstants.maxPreEscalationReliefLength) {
      errors.add(
        'Die Zusatznotiz zur Entschärfung darf maximal ${AppConstants.maxPreEscalationReliefLength} Zeichen lang sein.',
      );
    }

    return errors.isEmpty
        ? const ValidationResult.valid()
        : ValidationResult.errors(errors);
  }

  static ValidationResult _validateRequiredText(
    String value, {
    required String emptyMessage,
    required int minLength,
    required int maxLength,
    required String maxLengthMessage,
  }) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      return ValidationResult.errors([emptyMessage]);
    }
    if (trimmed.length < minLength) {
      return ValidationResult.errors([
        'Bitte antworte etwas konkreter.',
      ]);
    }
    if (trimmed.length > maxLength) {
      return ValidationResult.errors([maxLengthMessage]);
    }
    return const ValidationResult.valid();
  }
}
