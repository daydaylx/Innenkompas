import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../app/theme/colors.dart';
import '../../../application/providers/new_situation_providers.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/emotion_types.dart';
import '../../../core/validators/new_situation_validators.dart';
import '../../../domain/models/situation_draft.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../../shared/widgets/buttons/app_primary_button.dart';
import '../../../shared/widgets/buttons/app_secondary_button.dart';
import '../../../shared/widgets/cards/app_card.dart';
import '../widgets/emotion/body_symptoms_selector.dart';
import '../widgets/emotion/emotion_selector.dart';
import '../widgets/emotion/intensity_slider.dart';
import '../widgets/flow_progress_indicator.dart';

class SituationEmotionScreen extends ConsumerStatefulWidget {
  const SituationEmotionScreen({super.key});

  @override
  ConsumerState<SituationEmotionScreen> createState() =>
      _SituationEmotionScreenState();
}

class _SituationEmotionScreenState
    extends ConsumerState<SituationEmotionScreen> {
  int _intensity = 0;
  int _bodyTension = 0;
  EmotionType? _primaryEmotion;
  List<EmotionType> _additionalEmotions = const [];
  List<String> _initialBodyReactions = const [];

  @override
  void initState() {
    super.initState();
    final existingData = ref.read(emotionDataProvider);
    if (existingData != null) {
      _intensity = existingData.intensity;
      _bodyTension = existingData.bodyTension;
      _primaryEmotion = existingData.primaryEmotion;
      _additionalEmotions =
          List<EmotionType>.from(existingData.additionalEmotions);
      _initialBodyReactions =
          List<String>.from(existingData.initialBodyReactions);
    }
  }

  bool get _isValid {
    if (_primaryEmotion == null) return false;
    return NewSituationValidators.validateEmotionData(
      SituationEmotionData(
        intensity: _intensity,
        bodyTension: _bodyTension,
        primaryEmotion: _primaryEmotion!,
        additionalEmotions: _additionalEmotions,
        initialBodyReactions: _initialBodyReactions,
      ),
    ).isValid;
  }

  void _handleNext() {
    if (_primaryEmotion == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bitte wähle das stärkste Gefühl aus.')),
      );
      return;
    }

    ref.read(newSituationFlowControllerProvider.notifier).updateEmotionData(
          SituationEmotionData(
            intensity: _intensity,
            bodyTension: _bodyTension,
            primaryEmotion: _primaryEmotion!,
            additionalEmotions: _additionalEmotions,
            initialBodyReactions: _initialBodyReactions,
          ),
        );

    if (_intensity >= 8 || _bodyTension >= 7) {
      _showHighIntensityDialog();
    } else {
      ref
          .read(newSituationFlowControllerProvider.notifier)
          .setCapturePath(NewSituationCapturePath.full);
      context.push(AppRoutes.newSituationThoughtImpulse);
    }
  }

  void _showHighIntensityDialog() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Dein System ist gerade sehr aktiviert'),
        content: const Text(
          'Bei hoher Aktivierung fällt Reflexion oft schwerer. '
          'Möchtest du dich erst kurz stabilisieren und danach nur die wichtigsten Punkte sichern? '
          'Die ausführlichere Einordnung kann später folgen.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              ref
                  .read(newSituationFlowControllerProvider.notifier)
                  .setCapturePath(NewSituationCapturePath.full);
              context.push(AppRoutes.newSituationThoughtImpulse);
            },
            child: const Text('Weiter erfassen'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              ref
                  .read(newSituationFlowControllerProvider.notifier)
                  .setCapturePath(NewSituationCapturePath.reduced);
              context.push(
                AppRoutes.intervention,
                extra: {
                  'interventionId': 'regulation_4_6_breathing',
                  'completionRoute':
                      AppRoutes.newSituationThoughtImpulseReduced,
                },
              );
            },
            child: const Text('Erst stabilisieren'),
          ),
        ],
      ),
    );
  }

  void _handleBack() {
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppScaffold(
      title: 'Körper und Gefühle',
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
              currentStep: 3,
              totalSteps: 5,
            ),
            const SizedBox(height: AppConstants.spacingLarge),
            AppCard(
              variant: AppCardVariant.glass,
              margin: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Wie stark war die Reaktion in Körper und Gefühlen?',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingSmall),
                  Text(
                    'Benenn zuerst das stärkste Gefühl und schätze dann Intensität und Körperspannung grob ein.',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppConstants.spacingLarge),
            AppCard(
              variant: AppCardVariant.soft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Gefühle',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingSmall),
                  EmotionSelector(
                    primaryEmotion: _primaryEmotion,
                    additionalEmotions: _additionalEmotions,
                    onPrimaryChanged: (emotion) {
                      setState(() {
                        _primaryEmotion = emotion;
                        _additionalEmotions = _additionalEmotions
                            .where((value) => value != emotion)
                            .toList(growable: false);
                      });
                    },
                    onAdditionalChanged: (emotions) {
                      setState(() {
                        _additionalEmotions = emotions;
                      });
                    },
                  ),
                ],
              ),
            ),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Was ist im Körper zuerst hochgegangen?',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingSmall),
                  Text(
                    'Mehr als drei Auswahlpunkte machen die Rückschau meist unklarer als hilfreicher.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingMedium),
                  BodySymptomsSelector(
                    selectedSymptoms: _initialBodyReactions,
                    onSymptomsChanged: (values) {
                      setState(() {
                        _initialBodyReactions = values;
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
