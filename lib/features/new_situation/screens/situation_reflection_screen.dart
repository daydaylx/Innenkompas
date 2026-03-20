import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../app/theme/colors.dart';
import '../../../application/providers/evaluation_providers.dart';
import '../../../application/providers/intervention_providers.dart';
import '../../../application/providers/new_situation_providers.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/new_situation_option_lists.dart';
import '../../../core/constants/trigger_as_last_drop.dart';
import '../../../core/validators/new_situation_validators.dart';
import '../../../domain/models/situation_draft.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../../shared/widgets/buttons/app_primary_button.dart';
import '../../../shared/widgets/buttons/app_secondary_button.dart';
import '../../../shared/widgets/cards/app_card.dart';
import '../../../shared/widgets/loading/app_loading_indicator.dart';
import '../widgets/flow_progress_indicator.dart';
import '../widgets/shared/form_text_area.dart';
import '../widgets/shared/string_chip_selector.dart';

class SituationReflectionScreen extends ConsumerStatefulWidget {
  const SituationReflectionScreen({super.key});

  @override
  ConsumerState<SituationReflectionScreen> createState() =>
      _SituationReflectionScreenState();
}

class _SituationReflectionScreenState
    extends ConsumerState<SituationReflectionScreen> {
  List<String> _touchedThemes = const [];
  List<String> _neededSupports = const [];
  TriggerAsLastDrop? _triggerAsLastDrop;
  String _nextStep = '';
  String? _touchedThemesError;
  String? _neededSupportsError;

  @override
  void initState() {
    super.initState();
    final existingData = ref.read(reflectionDataProvider);
    if (existingData != null) {
      _touchedThemes = List<String>.from(existingData.touchedThemes);
      _neededSupports = List<String>.from(existingData.neededSupports);
      _triggerAsLastDrop = existingData.triggerAsLastDrop;
      _nextStep = existingData.nextStep ?? '';
    }
  }

  void _handleSave() async {
    if (_triggerAsLastDrop == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Bitte ordne kurz ein, ob der Auslöser eher der letzte Tropfen war.',
          ),
        ),
      );
      return;
    }

    final validation = NewSituationValidators.validateReflectionData(
      SituationReflectionData(
        touchedThemes: _touchedThemes,
        neededSupports: _neededSupports,
        triggerAsLastDrop: _triggerAsLastDrop!,
        nextStep: _nextStep.trim().isEmpty ? null : _nextStep.trim(),
      ),
    );

    setState(() {
      _touchedThemesError = _touchedThemes.isEmpty
          ? 'Bitte wähle, was in dir getroffen wurde.'
          : null;
      _neededSupportsError = _neededSupports.isEmpty
          ? 'Bitte wähle, was du gebraucht hättest.'
          : null;
    });

    if (!validation.isValid) {
      return;
    }

    ref.read(newSituationFlowControllerProvider.notifier).updateReflectionData(
          SituationReflectionData(
            touchedThemes: _touchedThemes,
            neededSupports: _neededSupports,
            triggerAsLastDrop: _triggerAsLastDrop!,
            nextStep: _nextStep.trim().isEmpty ? null : _nextStep.trim(),
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
    final thoughtData = ref.watch(thoughtImpulseDataProvider);

    return AppScaffold(
      title: 'Kurz einordnen',
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
              currentStep: 5,
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
                    'Was war hier getroffen und was hilft als nächster Schritt?',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingSmall),
                  Text(
                    'Zum Abschluss reicht eine knappe Einordnung. Alles, was mehr Abstand braucht, kann später in der Nachreflexion folgen.',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppConstants.spacingLarge),
            if (thoughtData != null)
              AppCard(
                variant: AppCardVariant.soft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Was hast du stattdessen gemacht?',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppConstants.spacingSmall),
                    Text(
                      [
                        if (thoughtData.actualBehaviorTags.isNotEmpty)
                          thoughtData.actualBehaviorTags.join(', '),
                        if ((thoughtData.actualBehaviorNote ?? '').isNotEmpty)
                          thoughtData.actualBehaviorNote!,
                      ].join(' | '),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
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
                    'War die Kleinigkeit wahrscheinlich nur der Trigger für etwas Größeres?',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingSmall),
                  Text(
                    'Gemeint ist: War der konkrete Auslöser eher der letzte Tropfen auf schon bestehendem Druck?',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingMedium),
                  Wrap(
                    spacing: AppConstants.spacingSmall,
                    runSpacing: AppConstants.spacingSmall,
                    children: TriggerAsLastDrop.values.map((value) {
                      return ChoiceChip(
                        selected: _triggerAsLastDrop == value,
                        label: Text(value.label),
                        onSelected: (_) {
                          setState(() {
                            _triggerAsLastDrop = value;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  if (_triggerAsLastDrop != null) ...[
                    const SizedBox(height: AppConstants.spacingSmall),
                    Text(
                      _triggerAsLastDrop!.description,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            AppCard(
              variant: AppCardVariant.soft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Was wurde in dir getroffen? Max. 2',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (_touchedThemesError != null) ...[
                    const SizedBox(height: AppConstants.spacingSmall),
                    Text(
                      _touchedThemesError!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.error,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                  const SizedBox(height: AppConstants.spacingSmall),
                  StringChipSelector(
                    options: NewSituationOptionLists.touchedThemes,
                    selectedValues: _touchedThemes,
                    maxSelected: 2,
                    onChanged: (values) {
                      setState(() {
                        _touchedThemes = values;
                        _touchedThemesError = null;
                      });
                    },
                  ),
                  const SizedBox(height: AppConstants.spacingLarge),
                  Text(
                    'Was hättest du in dem Moment eigentlich gebraucht? Max. 2',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (_neededSupportsError != null) ...[
                    const SizedBox(height: AppConstants.spacingSmall),
                    Text(
                      _neededSupportsError!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.error,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                  const SizedBox(height: AppConstants.spacingSmall),
                  StringChipSelector(
                    options: NewSituationOptionLists.neededSupports,
                    selectedValues: _neededSupports,
                    maxSelected: 2,
                    onChanged: (values) {
                      setState(() {
                        _neededSupports = values;
                        _neededSupportsError = null;
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
                    'Was ist der kleinste sinnvolle nächste Schritt? Empfohlen',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingSmall),
                  Text(
                    'Wenn dir gerade nichts Konkretes einfällt, lass es leer und geh erst in die Auswertung.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingMedium),
                  StringChipSelector(
                    options: NewSituationOptionLists.nextStepOptions,
                    selectedValues: const [],
                    maxSelected: 1,
                    onChanged: (values) {
                      if (values.isEmpty) return;
                      final selection = values.first;
                      setState(() {
                        _nextStep =
                            _nextStep.isEmpty ? selection : '$_nextStep, $selection';
                      });
                    },
                  ),
                  const SizedBox(height: AppConstants.spacingMedium),
                  FormTextArea(
                    initialValue: _nextStep,
                    onChanged: (value) {
                      setState(() {
                        _nextStep = value;
                      });
                    },
                    maxLength: AppConstants.maxNextStepLength,
                    maxLines: 3,
                    hintText:
                        'Zum Beispiel: Erst runterkommen, dann das Thema heute Abend sachlich notieren.',
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
                          onPressed: _handleSave,
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
