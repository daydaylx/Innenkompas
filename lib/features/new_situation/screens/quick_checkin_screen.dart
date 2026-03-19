import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../app/theme/colors.dart';
import '../../../application/providers/database_provider.dart';
import '../../../application/providers/intervention_providers.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/context_types.dart';
import '../../../core/constants/emotion_types.dart';
import '../../../core/constants/impulse_types.dart';
import '../../../core/constants/system_states.dart';
import '../../../data/db/app_database.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../../shared/widgets/buttons/app_primary_button.dart';

/// Schnelles Check-in: nur Emotion + Intensität (ca. 30 Sekunden).
///
/// Der Eintrag wird direkt gespeichert und fließt in Muster- und
/// Trendanalysen ein. Nach dem Speichern kann der Nutzer optional
/// die vollständige Reflexion fortsetzen.
class QuickCheckinScreen extends ConsumerStatefulWidget {
  const QuickCheckinScreen({super.key});

  @override
  ConsumerState<QuickCheckinScreen> createState() => _QuickCheckinScreenState();
}

class _QuickCheckinScreenState extends ConsumerState<QuickCheckinScreen> {
  EmotionType? _selectedEmotion;
  int _intensity = 5;
  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppScaffold(
      title: 'Kurzcheck',
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
            // Header
            Container(
              padding: const EdgeInsets.all(AppConstants.spacingLarge),
              decoration: BoxDecoration(
                color: AppColors.surface.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
                border: Border.all(color: AppColors.border.withValues(alpha: 0.6)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Wie geht es dir gerade?',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingSmall),
                  Text(
                    'Wähle eine Emotion und schätze deine Belastung ein. Das dauert nur 30 Sekunden.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppConstants.spacingXLarge),

            // Emotion selector
            Text(
              'Wie fühlst du dich?',
              style: theme.textTheme.titleMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppConstants.spacingMedium),
            Wrap(
              spacing: AppConstants.spacingSmall,
              runSpacing: AppConstants.spacingSmall,
              children: EmotionType.values.map((emotion) {
                final isSelected = _selectedEmotion == emotion;
                return GestureDetector(
                  onTap: () => setState(() => _selectedEmotion = emotion),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.spacingMedium,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary.withValues(alpha: 0.14)
                          : AppColors.surface.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(
                          AppConstants.borderRadiusPill),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary.withValues(alpha: 0.5)
                            : AppColors.border.withValues(alpha: 0.7),
                        width: isSelected ? 1.5 : 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          emotion.emoji,
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          emotion.label,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: isSelected
                                ? AppColors.primaryDark
                                : AppColors.textPrimary,
                            fontWeight: isSelected
                                ? FontWeight.w700
                                : FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: AppConstants.spacingXLarge),

            // Intensity slider
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Belastung',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.spacingMedium,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.intensityColor(_intensity)
                        .withValues(alpha: 0.14),
                    borderRadius:
                        BorderRadius.circular(AppConstants.borderRadiusPill),
                  ),
                  child: Text(
                    '$_intensity / 10',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: AppColors.intensityColor(_intensity),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.spacingMedium),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: AppColors.intensityColor(_intensity),
                thumbColor: AppColors.intensityColor(_intensity),
                overlayColor:
                    AppColors.intensityColor(_intensity).withValues(alpha: 0.14),
                inactiveTrackColor: AppColors.border,
              ),
              child: Slider(
                value: _intensity.toDouble(),
                min: 1,
                max: 10,
                divisions: 9,
                label: '$_intensity',
                onChanged: (v) => setState(() => _intensity = v.round()),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Leicht',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
                Text(
                  'Sehr hoch',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.spacingXLarge),

            // Save button
            AppPrimaryButton(
              label: 'Einchecken',
              isLoading: _isSaving,
              isEnabled: _selectedEmotion != null && !_isSaving,
              onPressed: _selectedEmotion != null ? _save : null,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    final emotion = _selectedEmotion;
    if (emotion == null) return;

    setState(() => _isSaving = true);

    try {
      final db = ref.read(databaseProvider);

      final systemState = _intensityToSystemState(_intensity);

      await db.createSituationEntry(
        SituationEntriesCompanion.insert(
          situationDescription: '',
          context: ContextType.other.name,
          timestamp: DateTime.now(),
          intensity: _intensity,
          bodyTension: _intensity,
          primaryEmotion: emotion.name,
          automaticThought: '',
          firstImpulse: ImpulseType.freeze.name,
          systemState: systemState.name,
          isCrisis: Value(_intensity >= 9),
          isDraft: const Value(false),
        ),
      );

      // Muster-Provider invalidieren, damit die Analyse aktualisiert wird
      ref.invalidate(patternSummaryProvider);
      ref.invalidate(contextCorrelationsProvider);

      if (mounted) {
        setState(() => _isSaving = false);
        _showFollowUpDialog(emotion);
      }
    } catch (_) {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  SystemState _intensityToSystemState(int intensity) {
    if (intensity >= 9) return SystemState.crisis;
    if (intensity >= 7) return SystemState.acuteActivation;
    if (intensity >= 5) return SystemState.overwhelm;
    return SystemState.reflectiveReady;
  }

  void _showFollowUpDialog(EmotionType emotion) {
    showDialog<void>(
      context: context,
      builder: (ctx) {
        final theme = Theme.of(ctx);
        return AlertDialog(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
          ),
          title: Text(
            'Eingecheckt ${emotion.emoji}',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          content: Text(
            'Möchtest du noch etwas mehr reflektieren?',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                context.go(AppRoutes.home);
              },
              child: const Text('Nein, danke'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                ),
              ),
              onPressed: () {
                Navigator.of(ctx).pop();
                context.go(AppRoutes.newSituationEvent);
              },
              child: const Text('Ja, weiter reflektieren'),
            ),
          ],
        );
      },
    );
  }
}
