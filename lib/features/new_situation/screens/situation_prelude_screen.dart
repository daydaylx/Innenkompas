import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../app/theme/colors.dart';
import '../../../application/providers/new_situation_providers.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/validators/new_situation_validators.dart';
import '../../../domain/models/situation_draft.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../../shared/widgets/buttons/app_primary_button.dart';
import '../../../shared/widgets/buttons/app_secondary_button.dart';
import '../../../shared/widgets/cards/app_card.dart';
import '../widgets/flow_progress_indicator.dart';
import '../widgets/shared/form_text_area.dart';

class SituationPreludeScreen extends ConsumerStatefulWidget {
  const SituationPreludeScreen({super.key});

  @override
  ConsumerState<SituationPreludeScreen> createState() =>
      _SituationPreludeScreenState();
}

class _SituationPreludeScreenState
    extends ConsumerState<SituationPreludeScreen> {
  String _preTriggerPreoccupation = '';
  String _trigger = '';
  int _preTriggerLoad = 0;
  String? _preoccupationError;
  String? _triggerError;

  @override
  void initState() {
    super.initState();
    final existingData = ref.read(eventDataProvider);
    if (existingData != null) {
      _preTriggerPreoccupation = existingData.preTriggerPreoccupation;
      _trigger = existingData.trigger;
      _preTriggerLoad = existingData.preTriggerLoad;
    }
  }

  bool get _isValid {
    final contextData = ref.read(eventContextDataProvider);
    if (contextData == null) {
      return false;
    }

    return NewSituationValidators.validateEventData(
      SituationEventData(
        description: contextData.description,
        preTriggerPreoccupation: _preTriggerPreoccupation,
        trigger: _trigger,
        preTriggerLoad: _preTriggerLoad,
        context: contextData.context,
        timestamp: contextData.timestamp,
        involvedEntities: contextData.involvedEntities,
      ),
    ).isValid;
  }

  void _handleNext() {
    final contextData = ref.read(eventContextDataProvider);
    if (contextData == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bitte erfasse zuerst die Situation und den Kontext.'),
        ),
      );
      context.go(AppRoutes.newSituationEvent);
      return;
    }

    final preoccupationValidation =
        NewSituationValidators.validatePreTriggerPreoccupation(
      _preTriggerPreoccupation,
    );
    final triggerValidation =
        NewSituationValidators.validateTriggerDescription(_trigger);

    setState(() {
      _preoccupationError = preoccupationValidation.firstError;
      _triggerError = triggerValidation.firstError;
    });

    if (!preoccupationValidation.isValid || !triggerValidation.isValid) {
      return;
    }

    ref.read(newSituationFlowControllerProvider.notifier).updateEventData(
          SituationEventData(
            description: contextData.description,
            preTriggerPreoccupation: _preTriggerPreoccupation.trim(),
            trigger: _trigger.trim(),
            preTriggerLoad: _preTriggerLoad,
            context: contextData.context,
            timestamp: contextData.timestamp,
            involvedEntities: contextData.involvedEntities,
          ),
        );

    context.push(AppRoutes.newSituationEmotion);
  }

  void _handleBack() {
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppScaffold(
      title: 'Vorlauf und Auslöser',
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
                    'Was war schon vorher da und was war der Kippmoment?',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingSmall),
                  Text(
                    'Hier trennen wir Vorlauf, konkreten Auslöser und Vorbelastung, damit später klarer bleibt, was schon vorher im System war.',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppConstants.spacingLarge),
            _buildPromptCard(
              title:
                  'Womit war dein Kopf schon beschäftigt, bevor die Situation gekippt ist?',
              child: FormTextArea(
                initialValue: _preTriggerPreoccupation,
                onChanged: (value) {
                  setState(() {
                    _preTriggerPreoccupation = value;
                    _preoccupationError = null;
                  });
                },
                maxLength: AppConstants.maxPreoccupationLength,
                hintText:
                    'Zum Beispiel: Ich war schon erschöpft, habe innerlich Druck gemacht oder hing noch an einem anderen Thema.',
                helperText: 'Ein kurzer Satz oder Stichworte reichen.',
                errorText: _preoccupationError,
              ),
            ),
            _buildPromptCard(
              title: 'Was war der konkrete Auslöser?',
              variant: AppCardVariant.soft,
              child: FormTextArea(
                initialValue: _trigger,
                onChanged: (value) {
                  setState(() {
                    _trigger = value;
                    _triggerError = null;
                  });
                },
                maxLength: AppConstants.maxTriggerDescriptionLength,
                hintText:
                    'Zum Beispiel: Ein bestimmter Satz, Blick, eine Nachricht oder ein kleiner Fehler.',
                helperText:
                    'Das ist der konkrete Moment, der die Situation kippen ließ.',
                errorText: _triggerError,
              ),
            ),
            AppCard(
              variant: AppCardVariant.soft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Wie voll war dein Tank schon davor?',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingSmall),
                  Text(
                    '0 heißt kaum belastet, 10 heißt schon vor dem Auslöser maximal voll.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingMedium),
                  _LoadScaleSelector(
                    value: _preTriggerLoad,
                    onChanged: (value) {
                      setState(() {
                        _preTriggerLoad = value;
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

  Widget _buildPromptCard({
    required String title,
    required Widget child,
    AppCardVariant variant = AppCardVariant.focus,
  }) {
    return AppCard(
      variant: variant,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppConstants.spacingSmall),
          child,
        ],
      ),
    );
  }
}

class _LoadScaleSelector extends StatelessWidget {
  const _LoadScaleSelector({
    required this.value,
    required this.onChanged,
  });

  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tone = AppColors.intensityColor(value == 0 ? 1 : value);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: tone.withValues(alpha: 0.14),
              borderRadius:
                  BorderRadius.circular(AppConstants.borderRadiusPill),
            ),
            child: Text(
              '$value / 10',
              style: theme.textTheme.labelMedium?.copyWith(
                color: tone,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppConstants.spacingMedium),
        Wrap(
          spacing: AppConstants.spacingSmall,
          runSpacing: AppConstants.spacingSmall,
          children: List.generate(AppConstants.maxIntensityRating + 1, (index) {
            final isSelected = value == index;
            final color = AppColors.intensityColor(index == 0 ? 1 : index);

            return InkWell(
              onTap: () => onChanged(index),
              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              child: AnimatedContainer(
                duration: const Duration(
                  milliseconds: AppConstants.animationDurationFast,
                ),
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isSelected
                      ? color.withValues(alpha: 0.18)
                      : AppColors.surfaceStrong.withValues(alpha: 0.88),
                  borderRadius:
                      BorderRadius.circular(AppConstants.borderRadius),
                  border: Border.all(
                    color: isSelected ? color : AppColors.borderLight,
                    width: isSelected ? 1.5 : 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    '$index',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: isSelected ? color : AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: AppConstants.spacingSmall),
        Row(
          children: [
            Text(
              '0 kaum',
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
            const Spacer(),
            Text(
              '10 sehr voll',
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
