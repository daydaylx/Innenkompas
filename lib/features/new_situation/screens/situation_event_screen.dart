import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/router.dart';
import '../../../app/theme/colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/context_types.dart';
import '../../../core/validators/new_situation_validators.dart';
import '../../../domain/models/situation_draft.dart';
import '../../../shared/widgets/buttons/app_primary_button.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../../shared/widgets/cards/app_card.dart';
import '../../../application/providers/new_situation_providers.dart';
import '../widgets/flow_progress_indicator.dart';
import '../widgets/event/situation_description_field.dart';
import '../widgets/event/context_selector.dart';
import '../widgets/event/timestamp_picker.dart';

/// Step 1 screen of the new situation flow - Event description.
class SituationEventScreen extends ConsumerStatefulWidget {
  const SituationEventScreen({super.key});

  @override
  ConsumerState<SituationEventScreen> createState() =>
      _SituationEventScreenState();
}

class _SituationEventScreenState extends ConsumerState<SituationEventScreen> {
  final _involvedPersonController = TextEditingController();
  String _description = '';
  ContextType? _selectedContext;
  DateTime _timestamp = DateTime.now();
  String? _involvedPerson;
  String? _descriptionError;

  @override
  void initState() {
    super.initState();
    // Load existing event data if available
    final existingData = ref.read(eventDataProvider);
    if (existingData != null) {
      _description = existingData.description;
      _selectedContext = existingData.context;
      _timestamp = existingData.timestamp;
      _involvedPerson = existingData.involvedPerson;
      _involvedPersonController.text = existingData.involvedPerson ?? '';
    }
  }

  @override
  void dispose() {
    _involvedPersonController.dispose();
    super.dispose();
  }

  bool get _isValid {
    final validation = NewSituationValidators.validateEventData(
      SituationEventData(
        description: _description,
        context: _selectedContext ?? ContextType.other,
        timestamp: _timestamp,
        involvedPerson: _involvedPerson,
      ),
    );
    return validation.isValid;
  }

  void _handleNext() {
    // Validate
    final descriptionValidation =
        NewSituationValidators.validateDescription(_description);
    if (!descriptionValidation.isValid) {
      setState(() {
        _descriptionError = descriptionValidation.firstError;
      });
      return;
    }

    if (_selectedContext == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bitte wähle einen Kontext aus.')),
      );
      return;
    }

    // Save event data
    final eventData = SituationEventData(
      description: _description,
      context: _selectedContext!,
      timestamp: _timestamp,
      involvedPerson: _involvedPerson?.trim().isEmpty ?? true
          ? null
          : _involvedPerson?.trim(),
    );

    ref
        .read(newSituationFlowControllerProvider.notifier)
        .updateEventData(eventData);

    // Navigate to next step
    context.push(AppRoutes.newSituationEmotion);
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
      title: 'Situation erfassen',
      backgroundVariant: AppBackgroundVariant.focus,
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: _handleCancel,
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
              currentStep: 1,
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
                    'Was ist passiert?',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingSmall),
                  Text(
                    'Beschreibe kurz die Situation. Ein ruhiger Überblick reicht aus.',
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
                    'Beschreibung',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingSmall),
                  SituationDescriptionField(
                    initialValue: _description,
                    onChanged: (value) {
                      setState(() {
                        _description = value;
                        _descriptionError = null;
                      });
                    },
                    errorText: _descriptionError,
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
                    'Kontext',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingSmall),
                  Text(
                    'In welchem Lebensbereich hat die Situation stattgefunden?',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingMedium),
                  ContextSelector(
                    selectedContext: _selectedContext,
                    onContextSelected: (context) {
                      setState(() {
                        _selectedContext = context;
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
                    'Wann?',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingSmall),
                  TimestampPicker(
                    selectedTimestamp: _timestamp,
                    onTimestampChanged: (timestamp) {
                      setState(() {
                        _timestamp = timestamp;
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
                    'Wer war dabei? (Optional)',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingSmall),
                  TextField(
                    controller: _involvedPersonController,
                    textInputAction: TextInputAction.done,
                    onChanged: (value) {
                      setState(() {
                        _involvedPerson = value;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'z.B. Kollege, Partner oder Mutter',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppConstants.spacingXLarge),
            AppPrimaryButton(
              label: 'Weiter',
              onPressed: _isValid ? _handleNext : null,
            ),
          ],
        ),
      ),
    );
  }
}
