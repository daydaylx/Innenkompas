import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/router.dart';
import '../../../app/theme/colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/impulse_types.dart';
import '../../../core/validators/new_situation_validators.dart';
import '../../../domain/models/situation_draft.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../../shared/widgets/buttons/app_primary_button.dart';
import '../../../shared/widgets/buttons/app_secondary_button.dart';
import '../../../shared/widgets/cards/app_card.dart';
import '../../../application/providers/new_situation_providers.dart';
import '../widgets/flow_progress_indicator.dart';
import '../widgets/thought_impulse/automatic_thought_field.dart';
import '../widgets/thought_impulse/impulse_selector.dart';

/// Step 3 screen of the new situation flow - Thoughts and impulses.
class SituationThoughtImpulseScreen extends ConsumerStatefulWidget {
  const SituationThoughtImpulseScreen({super.key});

  @override
  ConsumerState<SituationThoughtImpulseScreen> createState() =>
      _SituationThoughtImpulseScreenState();
}

class _SituationThoughtImpulseScreenState
    extends ConsumerState<SituationThoughtImpulseScreen> {
  final _behaviorController = TextEditingController();
  String _automaticThought = '';
  ImpulseType? _firstImpulse;
  String _actualBehavior = '';
  String? _thoughtError;
  String? _impulseError;

  @override
  void initState() {
    super.initState();
    // Load existing data if available
    final existingData = ref.read(thoughtImpulseDataProvider);
    if (existingData != null) {
      _automaticThought = existingData.automaticThought;
      _firstImpulse = existingData.firstImpulse;
      _actualBehavior = existingData.actualBehavior ?? '';
      _behaviorController.text = _actualBehavior;
    }
  }

  @override
  void dispose() {
    _behaviorController.dispose();
    super.dispose();
  }

  bool get _isValid {
    final thoughtValidation =
        NewSituationValidators.validateAutomaticThought(_automaticThought);
    final impulseValidation =
        NewSituationValidators.validateImpulseSelection(_firstImpulse);
    return thoughtValidation.isValid && impulseValidation.isValid;
  }

  void _handleSave() {
    // Validate
    final thoughtValidation =
        NewSituationValidators.validateAutomaticThought(_automaticThought);
    if (!thoughtValidation.isValid) {
      setState(() {
        _thoughtError = thoughtValidation.firstError;
      });
      return;
    }

    if (_firstImpulse == null) {
      setState(() {
        _impulseError = 'Bitte wähle einen Impuls aus.';
      });
      return;
    }

    // Validate actual behavior (optional)
    final behaviorValidation =
        NewSituationValidators.validateActualBehavior(_actualBehavior);
    if (!behaviorValidation.isValid) {
      setState(() {
        // Show behavior validation error
        _actualBehavior = _actualBehavior.substring(
            0, AppConstants.maxBehaviorDescriptionLength);
      });
    }

    // Save thought and impulse data
    final thoughtData = SituationThoughtImpulseData(
      automaticThought: _automaticThought.trim(),
      firstImpulse: _firstImpulse!,
      actualBehavior:
          _actualBehavior.trim().isEmpty ? null : _actualBehavior.trim(),
    );

    ref
        .read(newSituationFlowControllerProvider.notifier)
        .updateThoughtImpulseData(thoughtData);

    context.push(AppRoutes.newSituationReflection);
  }

  void _handleBack() {
    context.pop();
  }

  void _handleCancel() {
    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eingabe verwerfen?'),
        content: const Text(
          'Möchtest du die Erfassung wirklich abbrechen? Alle eingegebenen Daten gehen verloren.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Weiter erfassen'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(newSituationFlowControllerProvider.notifier).reset();
              context.go(AppRoutes.home);
            },
            child: const Text('Verwerfen',
                style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppScaffold(
      title: 'Gedanken und Impulse',
      backgroundVariant: AppBackgroundVariant.focus,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: _handleBack,
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: _handleCancel,
        ),
      ],
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
                    'Was hast du gedacht?',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingSmall),
                  Text(
                    'Halte fest, was in dir direkt ablief. Es geht um Klarheit, nicht um perfekte Formulierungen.',
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
                    'Automatischer Gedanke',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingSmall),
                  AutomaticThoughtField(
                    initialValue: _automaticThought,
                    onChanged: (value) {
                      setState(() {
                        _automaticThought = value;
                        _thoughtError = null;
                      });
                    },
                    errorText: _thoughtError,
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
                    'Erster Impuls',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingSmall),
                  Text(
                    'Was war dein erster automatischer Impuls?',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingMedium),
                  ImpulseSelector(
                    selectedImpulse: _firstImpulse,
                    onImpulseSelected: (impulse) {
                      setState(() {
                        _firstImpulse = impulse;
                        _impulseError = null;
                      });
                    },
                    errorText: _impulseError,
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
                    'Was hast du tatsächlich getan? (Optional)',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingSmall),
                  TextField(
                    controller: _behaviorController,
                    maxLines: 3,
                    maxLength: AppConstants.maxBehaviorDescriptionLength,
                    textInputAction: TextInputAction.done,
                    onChanged: (value) {
                      setState(() {
                        _actualBehavior = value;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Beschreibe optional, wie du reagiert hast.',
                    ),
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
                    onPressed: _isValid ? _handleSave : null,
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
