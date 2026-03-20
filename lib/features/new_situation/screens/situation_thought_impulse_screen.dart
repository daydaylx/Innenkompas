import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../app/theme/colors.dart';
import '../../../application/providers/evaluation_providers.dart';
import '../../../application/providers/intervention_providers.dart';
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
import '../../../shared/widgets/loading/app_loading_indicator.dart';
import '../widgets/flow_progress_indicator.dart';
import '../widgets/shared/form_text_area.dart';
import '../widgets/shared/string_chip_selector.dart';

class SituationThoughtImpulseScreen extends ConsumerStatefulWidget {
  const SituationThoughtImpulseScreen({
    super.key,
    this.reducedCapture = false,
  });

  final bool reducedCapture;

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
    } else if (widget.reducedCapture) {
      _factInterpretation = FactInterpretationResult.mixed;
    }
  }

  bool get _isValid {
    if (_systemReaction == null || _tippingPointAwareness == null) {
      return false;
    }

    if (!widget.reducedCapture && _factInterpretation == null) {
      return false;
    }

    final thoughtValidation = widget.reducedCapture
        ? const ValidationResult.valid()
        : NewSituationValidators.validateThoughtFocus(_thoughtFocus);
    final automaticThoughtValidation =
        NewSituationValidators.validateAutomaticThought(_automaticThought);
    final behaviorValidation = NewSituationValidators.validateActualBehavior(
      behaviorTags: _actualBehaviorTags,
      note: _actualBehaviorNote,
    );

    return thoughtValidation.isValid &&
        automaticThoughtValidation.isValid &&
        behaviorValidation.isValid;
  }

  void _handleNext() async {
    if (_systemReaction == null || _tippingPointAwareness == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bitte vervollständige die Einordnung der Reaktion.'),
        ),
      );
      return;
    }

    if (!widget.reducedCapture && _factInterpretation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bitte ordne kurz ein, was eher Fakt und was Deutung war.'),
        ),
      );
      return;
    }

    final thoughtValidation = widget.reducedCapture
        ? const ValidationResult.valid()
        : NewSituationValidators.validateThoughtFocus(_thoughtFocus);
    final automaticThoughtValidation =
        NewSituationValidators.validateAutomaticThought(_automaticThought);
    final behaviorValidation = NewSituationValidators.validateActualBehavior(
      behaviorTags: _actualBehaviorTags,
      note: _actualBehaviorNote,
    );

    setState(() {
      _thoughtFocusError = thoughtValidation.firstError;
      _thoughtError = automaticThoughtValidation.firstError;
      _behaviorError = behaviorValidation.firstError;
    });

    if (!thoughtValidation.isValid ||
        !automaticThoughtValidation.isValid ||
        !behaviorValidation.isValid) {
      return;
    }

    ref
        .read(newSituationFlowControllerProvider.notifier)
        .updateThoughtImpulseData(_buildThoughtData());

    if (!widget.reducedCapture) {
      ref
          .read(newSituationFlowControllerProvider.notifier)
          .setCapturePath(NewSituationCapturePath.full);
      context.push(AppRoutes.newSituationReflection);
      return;
    }

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

  SituationThoughtImpulseData _buildThoughtData() {
    return SituationThoughtImpulseData(
      thoughtFocus: _thoughtFocus.trim(),
      automaticThought: _automaticThought.trim(),
      factInterpretation:
          _factInterpretation ?? FactInterpretationResult.mixed,
      systemReaction: _systemReaction!,
      thoughtPatterns: widget.reducedCapture ? const [] : _thoughtPatterns,
      actualBehaviorTags: _actualBehaviorTags,
      actualBehaviorNote:
          _actualBehaviorNote.trim().isEmpty ? null : _actualBehaviorNote.trim(),
      tippingPointAwareness: _tippingPointAwareness!,
      fearOrPressurePoint:
          _fearOrPressurePoint.trim().isEmpty ? null : _fearOrPressurePoint.trim(),
    );
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
    final isSaving = ref.watch(isFlowSavingProvider);

    return AppScaffold(
      title: widget.reducedCapture
          ? 'Kernspur sichern'
          : 'Gedanken und Verhalten',
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
            FlowProgressIndicator(
              currentStep: 4,
              totalSteps: widget.reducedCapture ? 4 : 5,
            ),
            const SizedBox(height: AppConstants.spacingLarge),
            AppCard(
              variant: AppCardVariant.glass,
              margin: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.reducedCapture
                        ? 'Halte nur die wichtigste Spur fest'
                        : 'Was lief gedanklich und im Verhalten ab?',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingSmall),
                  Text(
                    widget.reducedCapture
                        ? 'Nach der Stabilisierung reicht hier das Wesentliche: erster Gedanke, Reaktionsimpuls, tatsächliches Verhalten und ob du den Kipppunkt bemerkt hast.'
                        : 'Wir trennen hier bewusst Gedankenspur und Verhaltensspur, damit klarer bleibt, was innerlich lief und was dann tatsächlich nach außen ging.',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppConstants.spacingLarge),
            if (!widget.reducedCapture) ...[
              _buildSectionIntro(
                title: 'Gedankenspur',
                helper:
                    'Was war schon im Kopf, welcher Satz schoss zuerst durch und wie stark war das schon Bewertung statt Beobachtung?',
              ),
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
            ],
            _buildPromptCard(
              title: 'Was schoss dir als Erstes durch den Kopf?',
              variant: widget.reducedCapture
                  ? AppCardVariant.focus
                  : AppCardVariant.soft,
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
                    '"Das ist wieder typisch" oder "Ich werde jetzt sicher falsch verstanden."',
                helperText:
                    'Nimm den ersten rohen Gedanken, nicht die spätere Erklärung.',
                errorText: _thoughtError,
              ),
            ),
            if (!widget.reducedCapture) ...[
              _buildChoiceCard(
                title: 'Was davon war eher Fakt, was eher Deutung?',
                helper:
                    'Fakt heißt beobachtbar. Deutung heißt: deine Schlussfolgerung oder Bewertung dazu.',
                child: Wrap(
                  spacing: AppConstants.spacingSmall,
                  runSpacing: AppConstants.spacingSmall,
                  children:
                      FactInterpretationResult.values.map((value) {
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
                selectedDescription: _factInterpretation?.description,
              ),
              _buildChoiceCard(
                title: 'Optionaler Zusatz: In welches Gedankenmuster bist du gerutscht? Max. 2',
                helper:
                    'Nur wenn es sich klar anfühlt. Wenn nicht, lass es weg.',
                child: StringChipSelector(
                  options: NewSituationOptionLists.thoughtPatterns,
                  selectedValues: _thoughtPatterns,
                  maxSelected: 2,
                  onChanged: (values) {
                    setState(() {
                      _thoughtPatterns = values;
                    });
                  },
                ),
              ),
            ],
            _buildSectionIntro(
              title: 'Verhaltensspur',
              helper:
                  'Hier geht es darum, was du am liebsten getan hättest, was du dann wirklich getan hast und wann du das Kippen bemerkt hast.',
            ),
            _buildChoiceCard(
              title: 'Was wolltest du in dem Moment am liebsten tun?',
              helper:
                  'Das meint den ersten inneren Reaktionsimpuls, noch bevor du alles kontrolliert oder erklärt hast.',
              child: Wrap(
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
              selectedDescription: _systemReaction?.description,
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
                  Text(
                    'Halte fest, was nach außen sichtbar wurde. Die Chips reichen oft schon.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingMedium),
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
            _buildChoiceCard(
              title:
                  'Gab es einen Moment, an dem du kurz gemerkt hast, dass es kippt?',
              helper:
                  'Das ist die Rückschau auf den Ablauf: früh bemerkt, spät bemerkt oder erst im Nachhinein.',
              child: Wrap(
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
                  child: isSaving
                      ? const AppLoadingIndicator()
                      : AppPrimaryButton(
                          label: widget.reducedCapture ? 'Speichern' : 'Weiter',
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

  Widget _buildSectionIntro({
    required String title,
    required String helper,
  }) {
    return AppCard(
      variant: AppCardVariant.soft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppConstants.spacingSmall),
          Text(
            helper,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ],
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

  Widget _buildChoiceCard({
    required String title,
    required String helper,
    required Widget child,
    String? selectedDescription,
  }) {
    return AppCard(
      variant: AppCardVariant.soft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppConstants.spacingSmall),
          Text(
            helper,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          const SizedBox(height: AppConstants.spacingMedium),
          child,
          if (selectedDescription != null) ...[
            const SizedBox(height: AppConstants.spacingSmall),
            Text(
              selectedDescription,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ],
        ],
      ),
    );
  }
}
