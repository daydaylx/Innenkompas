import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../app/theme/colors.dart';
import '../../../application/providers/new_situation_providers.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/fact_interpretation_results.dart';
import '../../../core/constants/new_situation_option_lists.dart';
import '../../../core/constants/system_reaction_types.dart';
import '../../../core/constants/tipping_point_awareness.dart';
import '../../../core/validators/new_situation_validators.dart';
import '../../../domain/models/situation_draft.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../../shared/widgets/buttons/app_primary_button.dart';
import '../../../shared/widgets/buttons/app_secondary_button.dart';
import '../../../shared/widgets/cards/app_card.dart';
import '../widgets/flow_progress_indicator.dart';
import '../widgets/shared/form_text_area.dart';
import '../widgets/shared/string_chip_selector.dart';

class SituationThoughtImpulseScreen extends ConsumerStatefulWidget {
  const SituationThoughtImpulseScreen({super.key});

  @override
  ConsumerState<SituationThoughtImpulseScreen> createState() =>
      _SituationThoughtImpulseScreenState();
}

class _SituationThoughtImpulseScreenState
    extends ConsumerState<SituationThoughtImpulseScreen> {
  String _thoughtFocus = '';
  String _automaticThought = '';
  FactInterpretationResult? _factInterpretation;
  SystemReactionType? _systemReaction;
  List<String> _thoughtPatterns = const [];
  List<String> _actualBehaviorTags = const [];
  String _actualBehaviorNote = '';
  TippingPointAwareness? _tippingPointAwareness;
  String _fearOrPressurePoint = '';
  String? _thoughtFocusError;
  String? _thoughtError;
  String? _behaviorError;

  @override
  void initState() {
    super.initState();
    final existingData = ref.read(thoughtImpulseDataProvider);
    if (existingData != null) {
      _thoughtFocus = existingData.thoughtFocus;
      _automaticThought = existingData.automaticThought;
      _factInterpretation = existingData.factInterpretation;
      _systemReaction = existingData.systemReaction;
      _thoughtPatterns = List<String>.from(existingData.thoughtPatterns);
      _actualBehaviorTags = List<String>.from(existingData.actualBehaviorTags);
      _actualBehaviorNote = existingData.actualBehaviorNote ?? '';
      _tippingPointAwareness = existingData.tippingPointAwareness;
      _fearOrPressurePoint = existingData.fearOrPressurePoint ?? '';
    }
  }

  bool get _isValid {
    if (_factInterpretation == null ||
        _systemReaction == null ||
        _tippingPointAwareness == null) {
      return false;
    }

    return NewSituationValidators.validateThoughtImpulseData(
      SituationThoughtImpulseData(
        thoughtFocus: _thoughtFocus,
        automaticThought: _automaticThought,
        factInterpretation: _factInterpretation!,
        systemReaction: _systemReaction!,
        thoughtPatterns: _thoughtPatterns,
        actualBehaviorTags: _actualBehaviorTags,
        actualBehaviorNote: _actualBehaviorNote.trim().isEmpty
            ? null
            : _actualBehaviorNote.trim(),
        tippingPointAwareness: _tippingPointAwareness!,
        fearOrPressurePoint: _fearOrPressurePoint.trim().isEmpty
            ? null
            : _fearOrPressurePoint.trim(),
      ),
    ).isValid;
  }

  void _handleNext() {
    if (_factInterpretation == null ||
        _systemReaction == null ||
        _tippingPointAwareness == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bitte vervollständige die Einordnung der Reaktion.'),
        ),
      );
      return;
    }

    final validation = NewSituationValidators.validateThoughtImpulseData(
      SituationThoughtImpulseData(
        thoughtFocus: _thoughtFocus,
        automaticThought: _automaticThought,
        factInterpretation: _factInterpretation!,
        systemReaction: _systemReaction!,
        thoughtPatterns: _thoughtPatterns,
        actualBehaviorTags: _actualBehaviorTags,
        actualBehaviorNote: _actualBehaviorNote.trim().isEmpty
            ? null
            : _actualBehaviorNote.trim(),
        tippingPointAwareness: _tippingPointAwareness!,
        fearOrPressurePoint: _fearOrPressurePoint.trim().isEmpty
            ? null
            : _fearOrPressurePoint.trim(),
      ),
    );

    setState(() {
      _thoughtFocusError =
          NewSituationValidators.validateThoughtFocus(_thoughtFocus).firstError;
      _thoughtError =
          NewSituationValidators.validateAutomaticThought(_automaticThought)
              .firstError;
      _behaviorError = NewSituationValidators.validateActualBehavior(
        behaviorTags: _actualBehaviorTags,
        note: _actualBehaviorNote,
      ).firstError;
    });

    if (!validation.isValid) {
      return;
    }

    ref
        .read(newSituationFlowControllerProvider.notifier)
        .updateThoughtImpulseData(
          SituationThoughtImpulseData(
            thoughtFocus: _thoughtFocus.trim(),
            automaticThought: _automaticThought.trim(),
            factInterpretation: _factInterpretation!,
            systemReaction: _systemReaction!,
            thoughtPatterns: _thoughtPatterns,
            actualBehaviorTags: _actualBehaviorTags,
            actualBehaviorNote: _actualBehaviorNote.trim().isEmpty
                ? null
                : _actualBehaviorNote.trim(),
            tippingPointAwareness: _tippingPointAwareness!,
            fearOrPressurePoint: _fearOrPressurePoint.trim().isEmpty
                ? null
                : _fearOrPressurePoint.trim(),
          ),
        );

    context.push(AppRoutes.newSituationReflection);
  }

  void _handleBack() {
    context.pop();
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
      title: 'Gedanken, Muster und Verhalten',
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
                    'Was lief gedanklich und im Verhalten ab?',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingSmall),
                  Text(
                    'Hier trennen wir Gedankenspur, erste Systemreaktion, Muster und das, was du tatsächlich gemacht hast.',
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
                  'Worin warst du gedanklich vertieft, als die Situation aufkam?',
              child: FormTextArea(
                initialValue: _thoughtFocus,
                onChanged: (value) {
                  setState(() {
                    _thoughtFocus = value;
                    _thoughtFocusError = null;
                  });
                },
                maxLength: AppConstants.maxThoughtFocusLength,
                hintText:
                    'Zum Beispiel: Ich war schon bei den nächsten Problemen oder habe innerlich etwas durchgespielt.',
                helperText: 'Kurz reicht, Hauptsache konkret.',
                errorText: _thoughtFocusError,
              ),
            ),
            _buildPromptCard(
              title: 'Was schoss dir als Erstes durch den Kopf?',
              variant: AppCardVariant.soft,
              child: FormTextArea(
                initialValue: _automaticThought,
                onChanged: (value) {
                  setState(() {
                    _automaticThought = value;
                    _thoughtError = null;
                  });
                },
                maxLength: AppConstants.maxThoughtDescriptionLength,
                maxLines: 3,
                hintText:
                    '"Das ist wieder typisch" oder "Ich bin zu blöd dafür"',
                helperText:
                    'Nimm den ersten rohen Gedanken, nicht die spätere Erklärung.',
                errorText: _thoughtError,
              ),
            ),
            AppCard(
              variant: AppCardVariant.soft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Was davon war eher Fakt, was eher Deutung?',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingSmall),
                  Wrap(
                    spacing: AppConstants.spacingSmall,
                    runSpacing: AppConstants.spacingSmall,
                    children: FactInterpretationResult.values.map((value) {
                      return ChoiceChip(
                        selected: _factInterpretation == value,
                        label: Text(value.label),
                        onSelected: (_) {
                          setState(() {
                            _factInterpretation = value;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  if (_factInterpretation != null) ...[
                    const SizedBox(height: AppConstants.spacingSmall),
                    Text(
                      _factInterpretation!.description,
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
                    'Was wolltest du in dem Moment am liebsten tun?',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingSmall),
                  Wrap(
                    spacing: AppConstants.spacingSmall,
                    runSpacing: AppConstants.spacingSmall,
                    children: SystemReactionType.values.map((value) {
                      return ChoiceChip(
                        selected: _systemReaction == value,
                        label: Text(value.label),
                        onSelected: (_) {
                          setState(() {
                            _systemReaction = value;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  if (_systemReaction != null) ...[
                    const SizedBox(height: AppConstants.spacingSmall),
                    Text(
                      _systemReaction!.description,
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
                    'In welches Gedankenmuster bist du gerutscht? Optional, max. 2',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingSmall),
                  StringChipSelector(
                    options: NewSituationOptionLists.thoughtPatterns,
                    selectedValues: _thoughtPatterns,
                    maxSelected: 2,
                    onChanged: (values) {
                      setState(() {
                        _thoughtPatterns = values;
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
                    'Was hast du tatsächlich gemacht?',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingSmall),
                  StringChipSelector(
                    options: NewSituationOptionLists.actualBehaviorOptions,
                    selectedValues: _actualBehaviorTags,
                    onChanged: (values) {
                      setState(() {
                        _actualBehaviorTags = values;
                        _behaviorError = null;
                      });
                    },
                  ),
                  const SizedBox(height: AppConstants.spacingMedium),
                  FormTextArea(
                    initialValue: _actualBehaviorNote,
                    onChanged: (value) {
                      setState(() {
                        _actualBehaviorNote = value;
                        _behaviorError = null;
                      });
                    },
                    maxLength: AppConstants.maxBehaviorDescriptionLength,
                    maxLines: 3,
                    hintText:
                        'Optional ergänzen: Was genau hast du gesagt oder getan?',
                    errorText: _behaviorError,
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
                    'Gab es einen Moment, an dem du kurz gemerkt hast, dass es kippt?',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingSmall),
                  Wrap(
                    spacing: AppConstants.spacingSmall,
                    runSpacing: AppConstants.spacingSmall,
                    children: TippingPointAwareness.values.map((value) {
                      return ChoiceChip(
                        selected: _tippingPointAwareness == value,
                        label: Text(value.label),
                        onSelected: (_) {
                          setState(() {
                            _tippingPointAwareness = value;
                          });
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            _buildPromptCard(
              title:
                  'Was hat dir in dem Moment am meisten Angst gemacht oder Druck gemacht? Optional',
              variant: AppCardVariant.soft,
              child: FormTextArea(
                initialValue: _fearOrPressurePoint,
                onChanged: (value) {
                  setState(() {
                    _fearOrPressurePoint = value;
                  });
                },
                maxLength: AppConstants.maxFearPressurePointLength,
                maxLines: 3,
                hintText:
                    'Zum Beispiel: Kontrolle zu verlieren, lächerlich zu wirken oder nicht ernst genommen zu werden.',
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
