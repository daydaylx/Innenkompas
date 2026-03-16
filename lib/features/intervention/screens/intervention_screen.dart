import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
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

part 'intervention_screen.g.dart';

/// Screen für die Durchführung einer Intervention
class InterventionScreen extends ConsumerStatefulWidget {
  final String interventionId;

  const InterventionScreen({
    super.key,
    required this.interventionId,
  });

  @override
  ConsumerState<InterventionScreen> createState() => _InterventionScreenState();
}

class _InterventionScreenState extends ConsumerState<InterventionScreen> {
  @override
  void initState() {
    super.initState();
    // Intervention starten
    final intervention = InterventionLibrary.getById(widget.interventionId);
    if (intervention != null) {
      ref.read(interventionFlowStateProvider.notifier).startIntervention(intervention);
    }
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
                text: 'Zurück zur Startseite',
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
          ),

          // Navigations-Buttons
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingMedium),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
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
                        text: 'Zurück',
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
                      text: currentStepIndex < totalSteps - 1
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

    // Prüfen, ob dieser Schritt eine Antwort hat
    if (!flowState.stepResponses.containsKey(step.id)) {
      // Bei manchen Step-Typen ist keine Antwort erforderlich
      return step.type == InterventionStepType.text ||
          step.type == InterventionStepType.action;
    }

    return true;
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
              ref.read(interventionFlowStateProvider.notifier).abortIntervention();
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

/// Provider für die Intervention-ID aus dem Routing
@riverpod
String currentInterventionId(CurrentInterventionIdRef ref) {
  throw UnimplementedError('Use GoRouterState parameter');
}
