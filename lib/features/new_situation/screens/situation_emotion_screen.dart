import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/router.dart';
import '../../../app/theme/colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/emotion_types.dart';
import '../../../core/validators/new_situation_validators.dart';
import '../../../domain/models/situation_draft.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../../shared/widgets/buttons/app_primary_button.dart';
import '../../../shared/widgets/buttons/app_secondary_button.dart';
import '../../../shared/widgets/cards/app_card.dart';
import '../../../application/providers/new_situation_providers.dart';
import '../widgets/flow_progress_indicator.dart';
import '../widgets/emotion/intensity_slider.dart';
import '../widgets/emotion/emotion_selector.dart';
import '../widgets/emotion/body_symptoms_selector.dart';

/// Step 2 screen of the new situation flow - Emotions and intensity.
class SituationEmotionScreen extends ConsumerStatefulWidget {
  const SituationEmotionScreen({super.key});

  @override
  ConsumerState<SituationEmotionScreen> createState() =>
      _SituationEmotionScreenState();
}

class _SituationEmotionScreenState
    extends ConsumerState<SituationEmotionScreen> {
  int _intensity = 5;
  int _bodyTension = 5;
  EmotionType? _primaryEmotion;
  EmotionType? _secondaryEmotion;
  List<String> _bodySymptoms = [];

  @override
  void initState() {
    super.initState();
    // Load existing emotion data if available
    final existingData = ref.read(emotionDataProvider);
    if (existingData != null) {
      _intensity = existingData.intensity;
      _bodyTension = existingData.bodyTension;
      _primaryEmotion = existingData.primaryEmotion;
      _secondaryEmotion = existingData.secondaryEmotion;
      _bodySymptoms = List.from(existingData.bodySymptoms);
    }
  }

  bool get _isValid {
    if (_primaryEmotion == null) return false;
    final intensityValidation =
        NewSituationValidators.validateIntensity(_intensity);
    final tensionValidation =
        NewSituationValidators.validateBodyTension(_bodyTension);
    return intensityValidation.isValid && tensionValidation.isValid;
  }

  void _handleNext() {
    if (_primaryEmotion == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bitte wähle eine Emotion aus.')),
      );
      return;
    }

    // Save emotion data
    final emotionData = SituationEmotionData(
      intensity: _intensity,
      bodyTension: _bodyTension,
      primaryEmotion: _primaryEmotion!,
      secondaryEmotion: _secondaryEmotion,
      bodySymptoms: _bodySymptoms,
    );

    ref
        .read(newSituationFlowControllerProvider.notifier)
        .updateEmotionData(emotionData);

    // Navigate to next step
    context.push(AppRoutes.newSituationThoughtImpulse);
  }

  void _handleBack() {
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppScaffold(
      title: 'Emotionen erfassen',
      backgroundVariant: AppBackgroundVariant.focus,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: _handleBack,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppConstants.spacingMedium,
          AppConstants.spacingSmall,
          AppConstants.spacingMedium,
          AppConstants.spacingXLarge,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const FlowProgressIndicator(
              currentStep: 2,
              totalSteps: 4,
            ),
            const SizedBox(height: AppConstants.spacingLarge),
            AppCard(
              variant: AppCardVariant.glass,
              margin: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Wie hast du dich gefühlt?',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingSmall),
                  Text(
                    'Wähle in Ruhe die Emotionen und Signale aus, die gerade am besten passen.',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppConstants.spacingLarge),
            AppCard(
              child: IntensitySlider(
                intensity: _intensity,
                bodyTension: _bodyTension,
                onIntensityChanged: (value) {
                  setState(() {
                    _intensity = value;
                  });
                },
                onBodyTensionChanged: (value) {
                  setState(() {
                    _bodyTension = value;
                  });
                },
              ),
            ),
            AppCard(
              variant: AppCardVariant.soft,
              child: EmotionSelector(
                primaryEmotion: _primaryEmotion,
                secondaryEmotion: _secondaryEmotion,
                onPrimaryChanged: (emotion) {
                  setState(() {
                    _primaryEmotion = emotion;
                    if (_secondaryEmotion == emotion) {
                      _secondaryEmotion = null;
                    }
                  });
                },
                onSecondaryChanged: (emotion) {
                  setState(() {
                    _secondaryEmotion = emotion;
                  });
                },
              ),
            ),
            AppCard(
              variant: AppCardVariant.soft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Körperzeichen (Optional)',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingSmall),
                  Text(
                    'Welche körperlichen Signale hast du gespürt? Mehrere sind möglich.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingMedium),
                  BodySymptomsSelector(
                    selectedSymptoms: _bodySymptoms,
                    onSymptomsChanged: (symptoms) {
                      setState(() {
                        _bodySymptoms = symptoms;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppConstants.spacingXLarge),
            Row(
              children: [
                Expanded(
                  child: AppSecondaryButton(
                    label: 'Zurück',
                    onPressed: _handleBack,
                  ),
                ),
                const SizedBox(width: AppConstants.spacingMedium),
                Expanded(
                  child: AppPrimaryButton(
                    label: 'Weiter',
                    onPressed: _isValid ? _handleNext : null,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
