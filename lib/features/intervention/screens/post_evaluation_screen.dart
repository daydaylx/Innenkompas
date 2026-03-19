import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:innenkompass/app/router.dart';
import 'package:innenkompass/application/providers/evaluation_providers.dart';
import 'package:innenkompass/core/constants/app_constants.dart';
import 'package:innenkompass/domain/models/intervention.dart';
import 'package:innenkompass/application/providers/intervention_providers.dart';
import 'package:innenkompass/application/providers/database_provider.dart';
import 'package:innenkompass/application/providers/new_situation_providers.dart';
import 'package:innenkompass/shared/widgets/app_scaffold.dart';
import 'package:innenkompass/shared/widgets/buttons/app_primary_button.dart';
import 'package:innenkompass/shared/widgets/buttons/app_secondary_button.dart';
import 'package:innenkompass/app/theme/colors.dart';

/// Screen für die Nachbewertung nach einer Intervention
class PostEvaluationScreen extends ConsumerStatefulWidget {
  const PostEvaluationScreen({super.key});

  @override
  ConsumerState<PostEvaluationScreen> createState() =>
      _PostEvaluationScreenState();
}

class _PostEvaluationScreenState extends ConsumerState<PostEvaluationScreen> {
  final _noteController = TextEditingController();
  int _postIntensity = 5;
  int _postBodyTension = 5;
  int _postClarity = 5;
  int _helpfulnessRating = 7;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(postEvaluationStateProvider.notifier)
          .updatePostIntensity(_postIntensity);
      ref
          .read(postEvaluationStateProvider.notifier)
          .updatePostBodyTension(_postBodyTension);
      ref
          .read(postEvaluationStateProvider.notifier)
          .updatePostClarity(_postClarity);
      ref
          .read(postEvaluationStateProvider.notifier)
          .updateHelpfulnessRating(_helpfulnessRating);
    });
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final evalState = ref.watch(postEvaluationStateProvider);
    final flowState = ref.watch(interventionFlowStateProvider);
    final intervention = flowState.intervention;
    final isComplete = evalState.postIntensity != null &&
        evalState.postBodyTension != null &&
        evalState.postClarity != null &&
        evalState.helpfulnessRating != null;

    if (intervention == null || !flowState.isCompleted) {
      return AppScaffold(
        title: 'Nachbewertung',
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: AppConstants.spacingMedium),
              Text(
                flowState.wasAborted
                    ? 'Intervention abgebrochen'
                    : 'Intervention wird geladen...',
              ),
            ],
          ),
        ),
      );
    }

    return AppScaffold(
      title: 'Wie fühlst du dich jetzt?',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.spacingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Erfolgsmeldung
            Card(
              color: AppColors.success.withValues(alpha: 0.1),
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.spacingMedium),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: AppColors.success,
                    ),
                    const SizedBox(width: AppConstants.spacingSmall),
                    const Expanded(
                      child: Text(
                        'Gut gemacht! Du hast die Intervention abgeschlossen.',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppConstants.spacingLarge),

            // Belastung jetzt
            const Text(
              'Wie stark belastet fühlst du dich jetzt?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Slider(
              value: _postIntensity.toDouble(),
              min: 1,
              max: 10,
              divisions: 9,
              label: _postIntensity.toString(),
              onChanged: (value) {
                setState(() {
                  _postIntensity = value.toInt();
                  ref
                      .read(postEvaluationStateProvider.notifier)
                      .updatePostIntensity(value.toInt());
                });
              },
            ),

            const SizedBox(height: AppConstants.spacingLarge),

            // Körperanspannung jetzt
            const Text(
              'Wie angespannt ist dein Körper jetzt?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Slider(
              value: _postBodyTension.toDouble(),
              min: 1,
              max: 10,
              divisions: 9,
              label: _postBodyTension.toString(),
              onChanged: (value) {
                setState(() {
                  _postBodyTension = value.toInt();
                  ref
                      .read(postEvaluationStateProvider.notifier)
                      .updatePostBodyTension(value.toInt());
                });
              },
            ),

            const SizedBox(height: AppConstants.spacingLarge),

            // Klarheit jetzt
            const Text(
              'Wie klar siehst du die Situation jetzt?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Slider(
              value: _postClarity.toDouble(),
              min: 1,
              max: 10,
              divisions: 9,
              label: _postClarity.toString(),
              onChanged: (value) {
                setState(() {
                  _postClarity = value.toInt();
                  ref
                      .read(postEvaluationStateProvider.notifier)
                      .updatePostClarity(value.toInt());
                });
              },
            ),

            const SizedBox(height: AppConstants.spacingLarge),

            // Hilfreichkeit
            const Text(
              'Hat dir die Intervention geholfen?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: AppConstants.spacingSmall),
            Card(
              child: Column(
                children: [
                  Slider(
                    value: _helpfulnessRating.toDouble(),
                    min: 1,
                    max: 10,
                    divisions: 9,
                    label: _helpfulnessRating.toString(),
                    onChanged: (value) {
                      setState(() {
                        _helpfulnessRating = value.toInt();
                        ref
                            .read(postEvaluationStateProvider.notifier)
                            .updateHelpfulnessRating(value.toInt());
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.spacingLarge,
                      vertical: AppConstants.spacingSmall,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Gar nicht', style: TextStyle(fontSize: 12)),
                        Text('Sehr hilfreich', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppConstants.spacingLarge),

            // Optionale Notiz
            const Text(
              'Möchtest du noch etwas notieren? (Optional)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: AppConstants.spacingSmall),
            TextField(
              controller: _noteController,
              maxLines: 4,
              maxLength: 500,
              decoration: const InputDecoration(
                hintText:
                    'Was hast du bemerkt? Was könnte dir in Zukunft helfen?',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                ref
                    .read(postEvaluationStateProvider.notifier)
                    .updateUserNote(value.isEmpty ? null : value);
              },
            ),

            const SizedBox(height: AppConstants.spacingLarge),

            // Speichern-Button
            AppPrimaryButton(
              onPressed: isComplete
                  ? () => _saveEvaluation(intervention, flowState)
                  : null,
              label: 'Speichern und abschließen',
              isLoading: false,
            ),

            const SizedBox(height: AppConstants.spacingSmall),

            // Ohne Speichern verlassen
            AppSecondaryButton(
              onPressed: () => context.go(AppRoutes.home),
              label: 'Ohne Speichern verlassen',
            ),
          ],
        ),
      ),
    );
  }

  /// Speichert die Nachbewertung
  Future<void> _saveEvaluation(
    Intervention intervention,
    InterventionFlowData flowState,
  ) async {
    final db = ref.read(databaseProvider);
    final evalState = ref.read(postEvaluationStateProvider);

    // Entry-ID aus dem Flow holen
    final entryId = flowState.entryId;
    if (entryId == null) {
      // Keine Entry-ID verfügbar - zur Startseite navigieren
      if (mounted) {
        context.go(AppRoutes.home);
      }
      return;
    }

    // Dauer der Intervention berechnen
    final actualDuration = flowState.actualDurationSec ?? 0;

    try {
      // Post-Evaluation-Daten in der Datenbank speichern
      await db.updatePostEvaluation(
        entryId: entryId,
        postIntensity: evalState.postIntensity!,
        postBodyTension: evalState.postBodyTension!,
        postClarity: evalState.postClarity!,
        helpfulnessRating: evalState.helpfulnessRating!,
        userNote: evalState.userNote,
        completedAt: DateTime.now(),
        actualDuration: actualDuration,
      );

      // Intervention-Flow zurücksetzen
      ref.read(interventionFlowStateProvider.notifier).reset();

      // Post-Evaluation-State zurücksetzen
      ref.read(postEvaluationStateProvider.notifier).reset();

      // NewSituationFlow zurücksetzen
      ref.read(newSituationFlowControllerProvider.notifier).reset();

      ref.invalidate(patternSummaryProvider);
      ref.invalidate(contextCorrelationsProvider);
      ref.invalidate(trendSlopeProvider);
      ref.invalidate(burnoutRiskProvider);
      ref.invalidate(narrativeInsightsProvider);

      // Zum HomeScreen navigieren
      if (mounted) {
        context.go(AppRoutes.home);
      }
    } catch (e) {
      // Fehlerbehandlung
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Fehler beim Speichern der Nachbewertung'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
