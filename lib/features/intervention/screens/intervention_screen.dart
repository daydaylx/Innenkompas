import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:innenkompass/app/router.dart';
import 'package:innenkompass/core/constants/app_constants.dart';
import 'package:innenkompass/domain/models/intervention.dart';
import 'package:innenkompass/domain/models/intervention_library.dart';
import 'package:innenkompass/domain/models/intervention_step.dart';
import 'package:innenkompass/application/providers/intervention_providers.dart';
import 'package:innenkompass/shared/widgets/app_scaffold.dart';
import 'package:innenkompass/shared/widgets/buttons/app_primary_button.dart';
import 'package:innenkompass/shared/widgets/buttons/app_secondary_button.dart';
import 'package:innenkompass/features/intervention/widgets/intervention_step_renderer.dart';
import 'package:innenkompass/features/intervention/widgets/progress_indicator.dart';

/// Screen für die Durchführung einer Intervention
class InterventionScreen extends ConsumerStatefulWidget {
  final String? interventionId;

  const InterventionScreen({
    super.key,
    this.interventionId,
  });

  @override
  ConsumerState<InterventionScreen> createState() => _InterventionScreenState();
}

class _InterventionScreenState extends ConsumerState<InterventionScreen> {
  @override
  void initState() {
    super.initState();
    _scheduleDirectInterventionStartIfNeeded();
  }

  @override
  void didUpdateWidget(covariant InterventionScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.interventionId != widget.interventionId) {
      _scheduleDirectInterventionStartIfNeeded();
    }
  }

  void _scheduleDirectInterventionStartIfNeeded() {
    final interventionId = widget.interventionId;
    if (interventionId == null) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final flowState = ref.read(interventionFlowStateProvider);
      final shouldReuseExistingFlow =
          flowState.intervention?.id == interventionId &&
              flowState.entryId != null &&
              !flowState.isCompleted &&
              !flowState.wasAborted;
      if (shouldReuseExistingFlow) return;

      final intervention = InterventionLibrary.getById(interventionId);
      if (intervention == null) return;

      ref
          .read(interventionFlowStateProvider.notifier)
          .startIntervention(intervention);
    });
  }

  @override
  Widget build(BuildContext context) {
    final flowState = ref.watch(interventionFlowStateProvider);
    final intervention = flowState.intervention;

    if (intervention == null) {
      return AppScaffold(
        title: 'Intervention',
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.grey,
              ),
              const SizedBox(height: AppConstants.spacingMedium),
              const Text(
                'Intervention nicht gefunden',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: AppConstants.spacingLarge),
              AppSecondaryButton(
                onPressed: () => context.go(AppRoutes.home),
                label: 'Zurück zur Startseite',
              ),
            ],
          ),
        ),
      );
    }

    final currentStep = flowState.currentStep;
    final totalSteps = intervention.steps.length;
    final currentStepIndex = flowState.currentStepIndex;

    return AppScaffold(
      title: intervention.title,
      actions: [
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => _showAbortDialog(context, ref),
        ),
      ],
      body: Column(
        children: [
          // Fortschrittsanzeige
          InterventionProgressIndicator(
            currentStep: currentStepIndex + 1,
            totalSteps: totalSteps,
            intervention: intervention,
          ),

          const SizedBox(height: AppConstants.spacingMedium),

          // Inhalt des aktuellen Schritts
          Expanded(
            child: currentStep == null
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(AppConstants.spacingMedium),
                    child: InterventionStepRenderer(
                      key: ValueKey(currentStep.id),
                      step: currentStep,
                      onResponse: (response) {
                        ref
                            .read(interventionFlowStateProvider.notifier)
                            .saveStepResponse(response);
                      },
                      existingResponse: flowState.stepResponses[currentStep.id],
                    ),
                  ),
          ),

          // Navigations-Buttons
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingMedium),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  // Zurück-Button
                  if (currentStepIndex > 0)
                    Expanded(
                      child: AppSecondaryButton(
                        onPressed: () {
                          ref
                              .read(interventionFlowStateProvider.notifier)
                              .previousStep();
                        },
                        label: 'Zurück',
                      ),
                    ),

                  if (currentStepIndex > 0)
                    const SizedBox(width: AppConstants.spacingSmall),

                  // Weiter/Fertig-Button
                  Expanded(
                    flex: currentStepIndex > 0 ? 1 : 2,
                    child: AppPrimaryButton(
                      onPressed: _canProceed(flowState, currentStep)
                          ? () => _handleNext(intervention)
                          : null,
                      label: currentStepIndex < totalSteps - 1
                          ? 'Weiter'
                          : 'Fertigstellen',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Prüft, ob der Nutzer zum nächsten Schritt weitergehen kann
  bool _canProceed(InterventionFlowData flowState, InterventionStep? step) {
    if (step == null) return false;
    final response = flowState.stepResponses[step.id];
    final metadata = step.metadata ?? {};

    switch (step.type) {
      case InterventionStepType.text:
      case InterventionStepType.action:
        return true;

      case InterventionStepType.breathing:
      case InterventionStepType.timer:
        return response?.boolResponse == true;

      case InterventionStepType.reflection:
        final minItems = metadata['min_items'] as int?;
        if (minItems != null) {
          final text = response?.textResponse;
          if (text == null || text.isEmpty) return false;
          return text.split('|').where((s) => s.isNotEmpty).length >= minItems;
        }
        return (response?.textResponse?.isNotEmpty) == true;

      case InterventionStepType.selection:
        final isMulti = metadata['multi_select'] == true;
        final sel = response?.selectionResponse;
        if (isMulti) return sel != null && sel.isNotEmpty;
        return sel != null;

      case InterventionStepType.factCheck:
        return response?.textResponse != null;

      case InterventionStepType.rating:
        return response?.ratingResponse != null;
    }
  }

  /// Handle Weiter-Button
  void _handleNext(Intervention intervention) {
    final flowState = ref.read(interventionFlowStateProvider);

    if (flowState.currentStepIndex < intervention.steps.length - 1) {
      // Weiter zum nächsten Schritt
      ref.read(interventionFlowStateProvider.notifier).nextStep();
    } else {
      // Intervention abschließen
      ref.read(interventionFlowStateProvider.notifier).completeIntervention();
      // Zur Nachbewertung
      context.push(AppRoutes.postEvaluation);
    }
  }

  /// Zeigt Abbruch-Dialog
  void _showAbortDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Intervention abbrechen?'),
        content: const Text(
          'Möchtest du diese Intervention wirklich abbrechen? Deine Fortschritte gehen verloren.',
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Abbrechen'),
          ),
          TextButton(
            onPressed: () {
              ref
                  .read(interventionFlowStateProvider.notifier)
                  .abortIntervention();
              context.go(AppRoutes.home);
            },
            child: const Text(
              'Ja, abbrechen',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
