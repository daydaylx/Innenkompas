import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:innenkompass/app/router.dart';
import 'package:innenkompass/app/theme/colors.dart';
import 'package:innenkompass/application/providers/intervention_providers.dart';
import 'package:innenkompass/core/constants/app_constants.dart';
import 'package:innenkompass/core/constants/context_types.dart';
import 'package:innenkompass/core/constants/emotion_types.dart';
import 'package:innenkompass/core/constants/system_states.dart';
import 'package:innenkompass/domain/models/pattern_summary.dart';
import 'package:innenkompass/features/patterns/widgets/emotion_bar_chart.dart';
import 'package:innenkompass/features/patterns/widgets/pattern_card.dart';
import 'package:innenkompass/shared/widgets/app_scaffold.dart';
import 'package:innenkompass/shared/widgets/charts/charts.dart';
import 'package:innenkompass/shared/widgets/navigation/app_main_navigation.dart';

/// Screen fuer Muster- und Trend-Analysen.
class PatternsScreen extends ConsumerWidget {
  const PatternsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patternAsync = ref.watch(patternSummaryProvider);

    return AppScaffold(
      title: 'Muster',
      actions: [
        IconButton(
          icon: const Icon(Icons.add_circle_outline),
          onPressed: () => context.go(AppRoutes.newSituationEvent),
          tooltip: 'Neue Situation',
        ),
      ],
      bottomNavigationBar: const AppMainNavigationBar(
        currentRoute: AppRoutes.patterns,
      ),
      body: patternAsync.when(
        data: (pattern) {
          if (pattern.totalEntries == 0) {
            return _buildEmptyState(context);
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              AppConstants.spacingMedium,
              AppConstants.spacingSmall,
              AppConstants.spacingMedium,
              AppConstants.spacingXLarge,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSummaryPanel(context, pattern),
                const SizedBox(height: AppConstants.spacingLarge),
                _buildOverviewCards(context, pattern),
                const SizedBox(height: AppConstants.spacingXLarge),
                _buildSectionHeader(
                  context,
                  title: 'Haeufigste Emotionen',
                  subtitle:
                      'Die wichtigsten Gefuehle der letzten Eintraege in einer ruhigen Uebersicht.',
                ),
                EmotionBarChart(
                  emotionFrequency: pattern.emotionFrequency,
                  totalEntries: pattern.totalEntries,
                ),
                const SizedBox(height: AppConstants.spacingXLarge),
                _buildSectionHeader(
                  context,
                  title: 'Kontexte',
                  subtitle:
                      'Wo Belastung haeufig auftaucht, damit der Verlauf besser einordenbar wird.',
                ),
                _buildContextCards(context, pattern),
                const SizedBox(height: AppConstants.spacingXLarge),
                _buildSectionHeader(
                  context,
                  title: 'Systemzustaende',
                  subtitle:
                      'Wiederkehrende innere Muster auf einen Blick, ohne Analytics-Optik.',
                ),
                _buildSystemStateCards(context, pattern),
                const SizedBox(height: AppConstants.spacingXLarge),
                _buildSectionHeader(
                  context,
                  title: 'Belastungsverlauf',
                  subtitle:
                      'Ein ruhiger Trend ueber die Zeit. Belastung und Anspannung koennen einzeln ein- und ausgeblendet werden.',
                ),
                IntensityTrendChart(
                  intensityTrend: pattern.intensityTrend,
                  tensionTrend: pattern.tensionTrend,
                ),
                const SizedBox(height: AppConstants.spacingXLarge),
                _buildSectionHeader(
                  context,
                  title: 'Emotions-Verteilung',
                  subtitle:
                      'Welche Gefuehle besonders oft vorkommen und wie sie sich zueinander verhalten.',
                ),
                EmotionDistributionChart(
                  emotionFrequency: pattern.emotionFrequency,
                  totalEntries: pattern.totalEntries,
                ),
                const SizedBox(height: AppConstants.spacingXLarge),
                _buildSectionHeader(
                  context,
                  title: 'Wochentags-Muster',
                  subtitle:
                      'Wann Belastung im Wochenverlauf haeufiger auftaucht und wo die Spitzen liegen.',
                ),
                WeekdayPatternChart(
                  timePatterns: pattern.timePatterns,
                ),
                if (pattern.mostEffectiveInterventions.isNotEmpty) ...[
                  const SizedBox(height: AppConstants.spacingXLarge),
                  _buildSectionHeader(
                    context,
                    title: 'Hilfreichste Interventionen',
                    subtitle:
                        'Welche Schritte zuletzt am ehesten Entlastung gebracht haben.',
                  ),
                  InterventionEffectivenessCard(
                    interventions: pattern.mostEffectiveInterventions,
                  ),
                ],
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => _buildErrorState(context, error),
      ),
    );
  }

  Widget _buildSummaryPanel(BuildContext context, PatternSummary pattern) {
    final theme = Theme.of(context);
    final dominantEmotion = pattern.emotionFrequency.entries.isEmpty
        ? null
        : (pattern.emotionFrequency.entries.toList()
              ..sort((a, b) => b.value.compareTo(a.value)))
            .first;
    final dominantContext = pattern.contextFrequency.entries.isEmpty
        ? null
        : (pattern.contextFrequency.entries.toList()
              ..sort((a, b) => b.value.compareTo(a.value)))
            .first;

    final headline = dominantEmotion == null
        ? 'Dein Verlauf beginnt, Konturen zu bekommen.'
        : 'Der Verlauf zeigt aktuell vor allem ${_getEmotionLabel(dominantEmotion.key).toLowerCase()}.';

    final improvementText = pattern.avgImprovement > 0
        ? 'Im Schnitt fuehren deine Interventionen zu einer Entlastung von ${pattern.avgImprovement.toStringAsFixed(1)} Punkten.'
        : 'Die Entlastung ist noch wechselhaft. Der Blick auf Situationen und Muster hilft beim Nachjustieren.';

    final contextText = dominantContext == null
        ? 'Mit weiteren Eintraegen werden Kontexte und Wiederholungen besser sichtbar.'
        : 'Besonders oft taucht der Bereich ${_getContextLabel(dominantContext.key)} auf.';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.spacingLarge),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withValues(alpha: 0.14),
            AppColors.secondary.withValues(alpha: 0.14),
            AppColors.surface.withValues(alpha: 0.92),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.border.withValues(alpha: 0.6),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.surface.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.auto_graph_rounded,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: AppConstants.spacingMedium),
              Expanded(
                child: Text(
                  'Ruhige Einblicke statt Dashboard',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMedium),
          Text(
            headline,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppConstants.spacingSmall),
          Text(
            '$contextText $improvementText',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCards(BuildContext context, PatternSummary pattern) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth =
            (constraints.maxWidth - AppConstants.spacingSmall * 2) / 3;

        return Wrap(
          spacing: AppConstants.spacingSmall,
          runSpacing: AppConstants.spacingSmall,
          children: [
            SizedBox(
              width: cardWidth,
              child: PatternCard(
                title: 'Eintraege',
                value: '${pattern.totalEntries}',
                subtitle: 'Reflexionen gesamt',
                icon: Icons.auto_stories_outlined,
                color: AppColors.primary,
              ),
            ),
            SizedBox(
              width: cardWidth,
              child: PatternCard(
                title: 'Belastung',
                value: pattern.avgIntensity.toStringAsFixed(1),
                subtitle: 'Durchschnitt pro Eintrag',
                icon: Icons.tune_rounded,
                color: AppColors.warning,
              ),
            ),
            SizedBox(
              width: cardWidth,
              child: PatternCard(
                title: 'Entlastung',
                value: pattern.avgImprovement > 0
                    ? '+${pattern.avgImprovement.toStringAsFixed(1)}'
                    : pattern.avgImprovement.toStringAsFixed(1),
                subtitle: 'nach Hilfe-Schritten',
                icon: Icons.trending_up_rounded,
                color: pattern.avgImprovement >= 0
                    ? AppColors.success
                    : AppColors.error,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSectionHeader(
    BuildContext context, {
    required String title,
    String? subtitle,
  }) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.spacingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildContextCards(BuildContext context, PatternSummary pattern) {
    final theme = Theme.of(context);
    final sortedContexts = pattern.contextFrequency.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Wrap(
      spacing: AppConstants.spacingSmall,
      runSpacing: AppConstants.spacingSmall,
      children: sortedContexts.take(6).map((entry) {
        final percentage = (entry.value / pattern.totalEntries * 100).toInt();
        return Container(
          width: 156,
          padding: const EdgeInsets.all(AppConstants.spacingMedium),
          decoration: BoxDecoration(
            color: AppColors.surface.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.border.withValues(alpha: 0.7),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _getContextEmoji(entry.key),
                style: const TextStyle(fontSize: 28),
              ),
              const SizedBox(height: AppConstants.spacingSmall),
              Text(
                _getContextLabel(entry.key),
                style: theme.textTheme.titleSmall?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '$percentage % der Eintraege',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSystemStateCards(BuildContext context, PatternSummary pattern) {
    final theme = Theme.of(context);
    final sortedStates = pattern.systemStateFrequency.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Wrap(
      spacing: AppConstants.spacingSmall,
      runSpacing: AppConstants.spacingSmall,
      children: sortedStates.map((entry) {
        final stateColor = _getStateColor(entry.key);
        final percentage = (entry.value / pattern.totalEntries * 100).toInt();

        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spacingMedium,
            vertical: 14,
          ),
          decoration: BoxDecoration(
            color: stateColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: stateColor.withValues(alpha: 0.25),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _getStateIcon(entry.key),
                size: 18,
                color: stateColor,
              ),
              const SizedBox(width: AppConstants.spacingSmall),
              Text(
                _getStateLabel(entry.key),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: AppConstants.spacingSmall),
              Text(
                '$percentage %',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: stateColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingXLarge),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppConstants.spacingXLarge),
          decoration: BoxDecoration(
            color: AppColors.surface.withValues(alpha: 0.94),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: AppColors.border.withValues(alpha: 0.7)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(
                  Icons.insights_outlined,
                  size: 36,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: AppConstants.spacingLarge),
              Text(
                'Noch nicht genug Eintraege',
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppConstants.spacingSmall),
              Text(
                'Sobald mehrere Situationen gespeichert sind, zeigt dir dieser Bereich ruhige Einblicke in Muster, Belastung und hilfreiche Schritte.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, Object error) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingXLarge),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppConstants.spacingXLarge),
          decoration: BoxDecoration(
            color: AppColors.surface.withValues(alpha: 0.94),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: AppColors.error.withValues(alpha: 0.22)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline,
                size: 40,
                color: AppColors.error,
              ),
              const SizedBox(height: AppConstants.spacingMedium),
              Text(
                'Muster konnten gerade nicht geladen werden.',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppConstants.spacingSmall),
              Text(
                '$error',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getEmotionLabel(EmotionType emotion) {
    return emotion.label;
  }

  String _getContextLabel(ContextType context) {
    return context.label;
  }

  String _getContextEmoji(ContextType context) {
    return context.emoji;
  }

  String _getStateLabel(SystemState state) {
    switch (state) {
      case SystemState.acuteActivation:
        return 'Akute Aktivierung';
      case SystemState.reflectiveReady:
        return 'Reflexionsbereit';
      case SystemState.rumination:
        return 'Gruebelmodus';
      case SystemState.conflict:
        return 'Konflikt';
      case SystemState.selfDevaluation:
        return 'Selbstabwertung';
      case SystemState.overwhelm:
        return 'Ueberforderung';
      case SystemState.crisis:
        return 'Krise';
    }
  }

  Color _getStateColor(SystemState state) {
    switch (state) {
      case SystemState.acuteActivation:
        return AppColors.warning;
      case SystemState.reflectiveReady:
        return AppColors.success;
      case SystemState.rumination:
        return AppColors.secondary;
      case SystemState.conflict:
        return AppColors.primary;
      case SystemState.selfDevaluation:
        return AppColors.secondaryDark;
      case SystemState.overwhelm:
        return AppColors.errorLight;
      case SystemState.crisis:
        return AppColors.error;
    }
  }

  IconData _getStateIcon(SystemState state) {
    switch (state) {
      case SystemState.acuteActivation:
        return Icons.flash_on_rounded;
      case SystemState.reflectiveReady:
        return Icons.self_improvement_rounded;
      case SystemState.rumination:
        return Icons.loop_rounded;
      case SystemState.conflict:
        return Icons.sync_problem_rounded;
      case SystemState.selfDevaluation:
        return Icons.cloudy_snowing;
      case SystemState.overwhelm:
        return Icons.waves_rounded;
      case SystemState.crisis:
        return Icons.warning_amber_rounded;
    }
  }
}
