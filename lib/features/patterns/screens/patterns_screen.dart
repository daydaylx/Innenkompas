import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:innenkompass/core/constants/app_constants.dart';
import 'package:innenkompass/core/constants/emotion_types.dart';
import 'package:innenkompass/core/constants/context_types.dart';
import 'package:innenkompass/core/constants/system_states.dart';
import 'package:innenkompass/domain/models/pattern_summary.dart';
import 'package:innenkompass/application/providers/intervention_providers.dart';
import 'package:innenkompass/shared/widgets/app_scaffold.dart';
import 'package:innenkompass/features/patterns/widgets/pattern_card.dart';
import 'package:innenkompass/features/patterns/widgets/emotion_bar_chart.dart';
import 'package:innenkompass/features/patterns/widgets/trend_chart.dart';

part 'patterns_screen.g.dart';

/// Screen für Muster- und Trend-Analysen
class PatternsScreen extends ConsumerWidget {
  const PatternsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patternAsync = ref.watch(patternSummaryProvider);

    return AppScaffold(
      title: 'Muster & Trends',
      body: patternAsync.when(
        data: (pattern) {
          if (pattern.totalEntries == 0) {
            return _buildEmptyState(context);
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.spacingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Übersicht
                _buildOverviewCards(context, pattern),

                const SizedBox(height: AppConstants.spacingLarge),

                // Emotions-Statistik
                _buildSectionHeader(context, 'Häufigste Emotionen'),
                EmotionBarChart(
                  emotionFrequency: pattern.emotionFrequency,
                  totalEntries: pattern.totalEntries,
                ),

                const SizedBox(height: AppConstants.spacingLarge),

                // Kontext-Analyse
                _buildSectionHeader(context, 'Kontexte'),
                _buildContextCards(context, pattern),

                const SizedBox(height: AppConstants.spacingLarge),

                // Systemzustände
                _buildSectionHeader(context, 'Systemzustände'),
                _buildSystemStateCards(context, pattern),

                const SizedBox(height: AppConstants.spacingLarge),

                // Trend-Diagramm
                _buildSectionHeader(context, 'Belastungs-Trend'),
                TrendChart(
                  dataPoints: pattern.intensityTrend,
                  secondaryDataPoints: pattern.tensionTrend,
                ),

                const SizedBox(height: AppConstants.spacingLarge),

                // Effektivste Interventionen
                if (pattern.mostEffectiveInterventions.isNotEmpty) ...[
                  _buildSectionHeader(context, 'Hilfreichste Interventionen'),
                  _buildInterventionCards(context, pattern),
                ],

                const SizedBox(height: AppConstants.spacingLarge),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.grey),
              const SizedBox(height: AppConstants.spacingMedium),
              Text(
                'Fehler beim Laden: $error',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.insights,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: AppConstants.spacingMedium),
          Text(
            'Noch nicht genug Einträge',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: AppConstants.spacingSmall),
          Text(
            'Muster und Trends erscheinen hier,\nsobald du mehrere Einträge hast.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[500],
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildOverviewCards(BuildContext context, PatternSummary pattern) {
    return Row(
      children: [
        Expanded(
          child: PatternCard(
            title: 'Einträge',
            value: '${pattern.totalEntries}',
            icon: Icons.book,
            color: Colors.blue,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: PatternCard(
            title: 'Ø Belastung',
            value: pattern.avgIntensity.toStringAsFixed(1),
            icon: Icons.show_chart,
            color: Colors.orange,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: PatternCard(
            title: 'Verbesserung',
            value: pattern.avgImprovement > 0
                ? '+${pattern.avgImprovement.toStringAsFixed(1)}'
                : pattern.avgImprovement.toStringAsFixed(1),
            icon: Icons.trending_up,
            color: pattern.avgImprovement > 0 ? Colors.green : Colors.red,
          ),
        ),
      ],
    );
  }

  Widget _buildContextCards(BuildContext context, PatternSummary pattern) {
    final sortedContexts = pattern.contextFrequency.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: sortedContexts.take(5).map((entry) {
        final percentage = (entry.value / pattern.totalEntries * 100).toInt();
        return Container(
          width: 100,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                _getContextEmoji(entry.key),
                style: const TextStyle(fontSize: 32),
              ),
              const SizedBox(height: 4),
              Text(
                _getContextLabel(entry.key),
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                '$percentage%',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSystemStateCards(BuildContext context, PatternSummary pattern) {
    final sortedStates = pattern.systemStateFrequency.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: sortedStates.map((entry) {
        final percentage = (entry.value / pattern.totalEntries * 100).toInt();
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: _getStateColor(entry.key).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _getStateColor(entry.key).withOpacity(0.3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _getStateIcon(entry.key),
                color: _getStateColor(entry.key),
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                _getStateLabel(entry.key),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(width: 8),
              Text(
                '$percentage%',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: _getStateColor(entry.key),
                    ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildInterventionCards(BuildContext context, PatternSummary pattern) {
    return Column(
      children: pattern.mostEffectiveInterventions.take(3).map((effectiveness) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  Icons.self_improvement,
                  color: Colors.purple,
                  size: 32,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        effectiveness.title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${effectiveness.usageCount}x verwendet',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '+${effectiveness.avgImprovement.toStringAsFixed(1)}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: effectiveness.avgImprovement > 0
                                ? Colors.green
                                : Colors.red,
                          ),
                    ),
                    Text(
                      'Verbesserung',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  String _getContextLabel(ContextType context) {
    final labels = {
      ContextType.work: 'Arbeit',
      ContextType.family: 'Familie',
      ContextType.partnership: 'Partnerschaft',
      ContextType.friends: 'Freunde',
      ContextType.finances: 'Finanzen',
      ContextType.health: 'Gesundheit',
      ContextType.leisure: 'Freizeit',
      ContextType.other: 'Sonstiges',
      ContextType.unknown: 'Unbekannt',
    };
    return labels[context] ?? context.name;
  }

  String _getContextEmoji(ContextType context) {
    final emojis = {
      ContextType.work: '💼',
      ContextType.family: '👨‍👩‍👧‍👦',
      ContextType.partnership: '❤️',
      ContextType.friends: '👥',
      ContextType.finances: '💰',
      ContextType.health: '🏥',
      ContextType.leisure: '🎮',
      ContextType.other: '📌',
      ContextType.unknown: '❓',
    };
    return emojis[context] ?? '❓';
  }

  String _getStateLabel(SystemState state) {
    final labels = {
      SystemState.acuteActivation: 'Akute Aktivierung',
      SystemState.reflectiveReady: 'Reflexionsbereit',
      SystemState.rumination: 'Grübelmodus',
      SystemState.conflict: 'Konflikt',
      SystemState.selfDevaluation: 'Selbstabwertung',
      SystemState.overwhelm: 'Überforderung',
      SystemState.crisis: 'Krise',
    };
    return labels[state] ?? state.name;
  }

  Color _getStateColor(SystemState state) {
    final colors = {
      SystemState.acuteActivation: Colors.red,
      SystemState.reflectiveReady: Colors.green,
      SystemState.rumination: Colors.orange,
      SystemState.conflict: Colors.red[700]!,
      SystemState.selfDevaluation: Colors.purple,
      SystemState.overwhelm: Colors.deepOrange,
      SystemState.crisis: Colors.red[900]!,
    };
    return colors[state] ?? Colors.grey;
  }

  IconData _getStateIcon(SystemState state) {
    final icons = {
      SystemState.acuteActivation: Icons.flash_on,
      SystemState.reflectiveReady: Icons.psychology,
      SystemState.rumination: Icons.loop,
      SystemState.conflict: Icons.handshake,
      SystemState.selfDevaluation: Icons.sentiment_very_dissatisfied,
      SystemState.overwhelm: Icons.overflow,
      SystemState.crisis: Icons.warning,
    };
    return icons[state] ?? Icons.help_outline;
  }
}
