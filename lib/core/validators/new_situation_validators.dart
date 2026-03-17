import '../../core/constants/app_constants.dart';
import '../../domain/models/situation_draft.dart';

/// Validators for the new situation flow.
///
/// Provides validation methods for each step of the flow.
class NewSituationValidators {
  // Private constructor to prevent instantiation
  NewSituationValidators._();

  /// Validate situation description
  static ValidationResult validateDescription(String value) {
    if (value.isEmpty) {
      return const ValidationResult.errors(
          ['Bitte beschreibe, was passiert ist.']);
    }

    if (value.trim().length < AppConstants.minSituationDescriptionLength) {
      return ValidationResult.errors([
        'Die Beschreibung muss mindestens ${AppConstants.minSituationDescriptionLength} Zeichen lang sein.',
      ]);
    }

    if (value.trim().length > AppConstants.maxSituationDescriptionLength) {
      return ValidationResult.errors([
        'Die Beschreibung darf maximal ${AppConstants.maxSituationDescriptionLength} Zeichen lang sein.',
      ]);
    }

    return const ValidationResult.valid();
  }

  /// Validate intensity rating
  static ValidationResult validateIntensity(int value) {
    if (value < AppConstants.minIntensityRating ||
        value > AppConstants.maxIntensityRating) {
      return ValidationResult.errors([
        'Die Intensität muss zwischen ${AppConstants.minIntensityRating} und ${AppConstants.maxIntensityRating} liegen.',
      ]);
    }

    return const ValidationResult.valid();
  }

  /// Validate body tension rating
  static ValidationResult validateBodyTension(int value) {
    if (value < AppConstants.minBodyTensionRating ||
        value > AppConstants.maxBodyTensionRating) {
      return ValidationResult.errors([
        'Die Körperanspannung muss zwischen ${AppConstants.minBodyTensionRating} und ${AppConstants.maxBodyTensionRating} liegen.',
      ]);
    }

    return const ValidationResult.valid();
  }

  /// Validate primary emotion selection
  static ValidationResult validatePrimaryEmotion(dynamic emotion) {
    if (emotion == null) {
      return const ValidationResult.errors(['Bitte wähle eine Emotion aus.']);
    }

    return const ValidationResult.valid();
  }

  /// Validate automatic thought
  static ValidationResult validateAutomaticThought(String value) {
    if (value.trim().isEmpty) {
      return const ValidationResult.errors([
        'Bitte beschreibe deinen Gedanken.',
      ]);
    }

    if (value.trim().length > AppConstants.maxThoughtDescriptionLength) {
      return ValidationResult.errors([
        'Der Gedanke darf maximal ${AppConstants.maxThoughtDescriptionLength} Zeichen lang sein.',
      ]);
    }

    return const ValidationResult.valid();
  }

  /// Validate impulse selection
  static ValidationResult validateImpulseSelection(dynamic impulse) {
    if (impulse == null) {
      return const ValidationResult.errors(['Bitte wähle einen Impuls aus.']);
    }

    return const ValidationResult.valid();
  }

  /// Validate actual behavior (optional)
  static ValidationResult validateActualBehavior(String? value) {
    if (value != null &&
        value.trim().isNotEmpty &&
        value.trim().length > AppConstants.maxBehaviorDescriptionLength) {
      return ValidationResult.errors([
        'Die Beschreibung darf maximal ${AppConstants.maxBehaviorDescriptionLength} Zeichen lang sein.',
      ]);
    }

    return const ValidationResult.valid();
  }

  /// Validate need or wounded point reflection.
  static ValidationResult validateNeedOrWoundedPoint(String value) {
    if (value.trim().isEmpty) {
      return const ValidationResult.errors([
        'Bitte beschreibe kurz, was in dir berührt oder gebraucht wurde.',
      ]);
    }

    if (value.trim().length < AppConstants.minReflectionFieldLength) {
      return ValidationResult.errors([
        'Die Beschreibung muss mindestens ${AppConstants.minReflectionFieldLength} Zeichen lang sein.',
      ]);
    }

    if (value.trim().length > AppConstants.maxNeedDescriptionLength) {
      return ValidationResult.errors([
        'Die Beschreibung darf maximal ${AppConstants.maxNeedDescriptionLength} Zeichen lang sein.',
      ]);
    }

    return const ValidationResult.valid();
  }

  /// Validate a concrete next step.
  static ValidationResult validateNextStep(String value) {
    if (value.trim().isEmpty) {
      return const ValidationResult.errors([
        'Bitte formuliere einen nächsten sinnvollen Schritt.',
      ]);
    }

    if (value.trim().length < AppConstants.minReflectionFieldLength) {
      return ValidationResult.errors([
        'Der nächste Schritt muss mindestens ${AppConstants.minReflectionFieldLength} Zeichen lang sein.',
      ]);
    }

    if (value.trim().length > AppConstants.maxNextStepLength) {
      return ValidationResult.errors([
        'Der nächste Schritt darf maximal ${AppConstants.maxNextStepLength} Zeichen lang sein.',
      ]);
    }

    return const ValidationResult.valid();
  }

  /// Validate event data (Step 1)
  static ValidationResult validateEventData(SituationEventData data) {
    final errors = <String>[];
    final descriptionResult = validateDescription(data.description);

    if (!descriptionResult.isValid) {
      errors.addAll(descriptionResult.errorMessages);
    }

    return errors.isEmpty
        ? const ValidationResult.valid()
        : ValidationResult.errors(errors);
  }

  /// Validate emotion data (Step 2)
  static ValidationResult validateEmotionData(SituationEmotionData data) {
    final errors = <String>[];

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

    return errors.isEmpty
        ? const ValidationResult.valid()
        : ValidationResult.errors(errors);
  }

  /// Validate thought and impulse data (Step 3)
  static ValidationResult validateThoughtImpulseData(
      SituationThoughtImpulseData data) {
    final errors = <String>[];

    final thoughtResult = validateAutomaticThought(data.automaticThought);
    if (!thoughtResult.isValid) {
      errors.addAll(thoughtResult.errorMessages);
    }

    final impulseResult = validateImpulseSelection(data.firstImpulse);
    if (!impulseResult.isValid) {
      errors.addAll(impulseResult.errorMessages);
    }

    final behaviorResult = validateActualBehavior(data.actualBehavior);
    if (!behaviorResult.isValid) {
      errors.addAll(behaviorResult.errorMessages);
    }

    return errors.isEmpty
        ? const ValidationResult.valid()
        : ValidationResult.errors(errors);
  }

  /// Validate reflection data (Step 4)
  static ValidationResult validateReflectionData(SituationReflectionData data) {
    final errors = <String>[];

    final needResult = validateNeedOrWoundedPoint(data.needOrWoundedPoint);
    if (!needResult.isValid) {
      errors.addAll(needResult.errorMessages);
    }

    final nextStepResult = validateNextStep(data.nextStep);
    if (!nextStepResult.isValid) {
      errors.addAll(nextStepResult.errorMessages);
    }

    return errors.isEmpty
        ? const ValidationResult.valid()
        : ValidationResult.errors(errors);
  }
}
