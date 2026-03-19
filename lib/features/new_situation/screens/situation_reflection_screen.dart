import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../app/theme/colors.dart';
import '../../../application/providers/evaluation_providers.dart';
import '../../../application/providers/intervention_providers.dart';
import '../../../application/providers/new_situation_providers.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/validators/new_situation_validators.dart';
import '../../../domain/models/situation_draft.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../../shared/widgets/buttons/app_primary_button.dart';
import '../../../shared/widgets/buttons/app_secondary_button.dart';
import '../../../shared/widgets/cards/app_card.dart';
import '../../../shared/widgets/loading/app_loading_indicator.dart';
import '../widgets/flow_progress_indicator.dart';

/// Step 4 screen of the new situation flow - reflection and next step.
class SituationReflectionScreen extends ConsumerStatefulWidget {
  const SituationReflectionScreen({super.key});

  @override
  ConsumerState<SituationReflectionScreen> createState() =>
      _SituationReflectionScreenState();
}

class _SituationReflectionScreenState
    extends ConsumerState<SituationReflectionScreen> {
  final _needController = TextEditingController();
  final _nextStepController = TextEditingController();
  String _needOrWoundedPoint = '';
  String _nextStep = '';
  String? _needError;
  String? _nextStepError;

  @override
  void initState() {
    super.initState();
    final existingData = ref.read(reflectionDataProvider);
    if (existingData != null) {
      _needOrWoundedPoint = existingData.needOrWoundedPoint;
      _nextStep = existingData.nextStep;
      _needController.text = _needOrWoundedPoint;
      _nextStepController.text = _nextStep;
    }
  }

  @override
  void dispose() {
    _needController.dispose();
    _nextStepController.dispose();
    super.dispose();
  }

  bool get _isValid {
    final reflection = SituationReflectionData(
      needOrWoundedPoint: _needOrWoundedPoint,
      nextStep: _nextStep,
    );
    return NewSituationValidators.validateReflectionData(reflection).isValid;
  }

  Future<void> _handleSave() async {
    final needValidation =
        NewSituationValidators.validateNeedOrWoundedPoint(_needOrWoundedPoint);
    final nextStepValidation =
        NewSituationValidators.validateNextStep(_nextStep);

    if (!needValidation.isValid || !nextStepValidation.isValid) {
      setState(() {
        _needError = needValidation.firstError;
        _nextStepError = nextStepValidation.firstError;
      });
      return;
    }

    ref.read(newSituationFlowControllerProvider.notifier).updateReflectionData(
          SituationReflectionData(
            needOrWoundedPoint: _needOrWoundedPoint.trim(),
            nextStep: _nextStep.trim(),
          ),
        );

    final savedId =
        await ref.read(newSituationFlowControllerProvider.notifier).saveEntry();

    if (!mounted) return;

    if (savedId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Fehler beim Speichern. Bitte versuche es erneut.'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    ref.invalidate(patternSummaryProvider);
    ref.invalidate(contextCorrelationsProvider);
    ref.invalidate(trendSlopeProvider);
    ref.invalidate(burnoutRiskProvider);
    ref.invalidate(narrativeInsightsProvider);

    context.go(
      AppRoutes.entryEvaluation.replaceFirst(':id', '$savedId'),
    );
  }

  void _handleBack() {
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isSaving = ref.watch(isFlowSavingProvider);

    return AppScaffold(
      title: 'Einordnen und weitergehen',
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
              currentStep: 4,
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
                    'Was ist darin gerade besonders berührt?',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingSmall),
                  Text(
                    'Halte fest, was in dir Schutz, Klärung oder Zuwendung braucht und welcher kleine nächste Schritt dir jetzt gut tun würde.',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppConstants.spacingLarge),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Bedürfnis oder verletzter Punkt',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingSmall),
                  TextField(
                    controller: _needController,
                    maxLines: 4,
                    maxLength: AppConstants.maxNeedDescriptionLength,
                    decoration: InputDecoration(
                      hintText:
                          'z.B. Ich brauche gerade Sicherheit, Klarheit oder ein Gefühl von Gesehenwerden.',
                      errorText: _needError,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _needOrWoundedPoint = value;
                        _needError = null;
                      });
                    },
                  ),
                ],
              ),
            ),
            AppCard(
              variant: AppCardVariant.soft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Nächster kleiner Schritt',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingSmall),
                  TextField(
                    controller: _nextStepController,
                    maxLines: 3,
                    maxLength: AppConstants.maxNextStepLength,
                    decoration: InputDecoration(
                      hintText:
                          'z.B. Erst drei Minuten atmen, dann eine Nachricht entwerfen statt sofort zu reagieren.',
                      errorText: _nextStepError,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _nextStep = value;
                        _nextStepError = null;
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
                    onPressed: _handleBack,
                    label: 'Zurück',
                  ),
                ),
                const SizedBox(width: AppConstants.spacingMedium),
                Expanded(
                  child: isSaving
                      ? const AppLoadingIndicator()
                      : AppPrimaryButton(
                          onPressed: _isValid ? _handleSave : null,
                          label: 'Speichern',
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
