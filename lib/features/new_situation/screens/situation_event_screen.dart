import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../app/theme/colors.dart';
import '../../../application/providers/new_situation_providers.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/context_types.dart';
import '../../../core/validators/new_situation_validators.dart';
import '../../../domain/models/situation_draft.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../../shared/widgets/buttons/app_primary_button.dart';
import '../../../shared/widgets/cards/app_card.dart';
import '../widgets/event/context_selector.dart';
import '../widgets/event/timestamp_picker.dart';
import '../widgets/flow_progress_indicator.dart';
import '../widgets/shared/form_text_area.dart';

class SituationEventScreen extends ConsumerStatefulWidget {
  const SituationEventScreen({super.key});

  @override
  ConsumerState<SituationEventScreen> createState() =>
      _SituationEventScreenState();
}

class _SituationEventScreenState extends ConsumerState<SituationEventScreen> {
  String _description = '';
  ContextType? _selectedContext;
  DateTime _timestamp = DateTime.now();
  String _involvedEntities = '';
  String? _descriptionError;

  @override
  void initState() {
    super.initState();
    final contextData = ref.read(eventContextDataProvider);
    final eventData = ref.read(eventDataProvider);
    final existingData = contextData ??
        (eventData == null
            ? null
            : SituationEventContextData(
                description: eventData.description,
                context: eventData.context,
                timestamp: eventData.timestamp,
                involvedEntities: eventData.involvedEntities,
              ));
    if (existingData != null) {
      _description = existingData.description;
      _selectedContext = existingData.context;
      _timestamp = existingData.timestamp;
      _involvedEntities = existingData.involvedEntities ?? '';
    }
  }

  bool get _isValid {
    if (_selectedContext == null) {
      return false;
    }

    return NewSituationValidators.validateEventContextData(
      SituationEventContextData(
        description: _description,
        context: _selectedContext!,
        timestamp: _timestamp,
        involvedEntities:
            _involvedEntities.trim().isEmpty ? null : _involvedEntities.trim(),
      ),
    ).isValid;
  }

  void _handleNext() {
    final descriptionValidation =
        NewSituationValidators.validateDescription(_description);

    setState(() {
      _descriptionError = descriptionValidation.firstError;
    });

    if (!descriptionValidation.isValid) {
      return;
    }

    if (_selectedContext == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bitte wähle einen Lebensbereich aus.')),
      );
      return;
    }

    ref.read(newSituationFlowControllerProvider.notifier).updateEventContextData(
          SituationEventContextData(
            description: _description.trim(),
            context: _selectedContext!,
            timestamp: _timestamp,
            involvedEntities: _involvedEntities.trim().isEmpty
                ? null
                : _involvedEntities.trim(),
          ),
        );

    context.push(AppRoutes.newSituationPrelude);
  }

  void _handleCancel() {
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
            child: const Text(
              'Verwerfen',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppScaffold(
      title: 'Situation und Kontext',
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
                    'Worum ging die Situation insgesamt?',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingSmall),
                  Text(
                    'Hier reicht der grobe Rahmen: Was ist passiert, in welchem Bereich und wann ungefähr?',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppConstants.spacingLarge),
            _buildPromptCard(
              title: 'Was ist konkret passiert?',
              child: FormTextArea(
                initialValue: _description,
                onChanged: (value) {
                  setState(() {
                    _description = value;
                    _descriptionError = null;
                  });
                },
                maxLength: AppConstants.maxSituationDescriptionLength,
                hintText:
                    'Zum Beispiel: Das Gespräch im Meeting wurde plötzlich scharf.',
                helperText:
                    'Beschreibe die Situation als Ganzes, noch nicht nur den Kippmoment.',
                errorText: _descriptionError,
              ),
            ),
            _buildPromptCard(
              title: 'Wer oder was war beteiligt? Optional',
              variant: AppCardVariant.soft,
              child: FormTextArea(
                initialValue: _involvedEntities,
                onChanged: (value) {
                  setState(() {
                    _involvedEntities = value;
                  });
                },
                maxLength: AppConstants.maxNeedDescriptionLength,
                maxLines: 2,
                hintText:
                    'Zum Beispiel: Partner, Kollegin, Kind, Chat, Termin, Haushalt.',
              ),
            ),
            AppCard(
              variant: AppCardVariant.soft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Lebensbereich',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingSmall),
                  Text(
                    'In welchem Bereich lag die Situation vor allem?',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingMedium),
                  ContextSelector(
                    selectedContext: _selectedContext,
                    onContextSelected: (value) {
                      setState(() {
                        _selectedContext = value;
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
                    'Wann war das?',
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
