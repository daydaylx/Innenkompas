import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:innenkompass/app/router.dart';
import 'package:innenkompass/application/providers/database_provider.dart';
import 'package:innenkompass/application/providers/evaluation_providers.dart';
import 'package:innenkompass/application/providers/intervention_providers.dart';
import 'package:innenkompass/application/providers/new_situation_providers.dart';
import 'package:innenkompass/core/constants/app_constants.dart';
import 'package:innenkompass/core/constants/intervention_types.dart';
import 'package:innenkompass/domain/models/intervention_library.dart';
import 'package:innenkompass/domain/services/pattern_analyzer.dart';
import 'package:innenkompass/shared/widgets/app_scaffold.dart';
import 'package:innenkompass/shared/widgets/buttons/app_primary_button.dart';
import 'package:innenkompass/shared/widgets/buttons/app_secondary_button.dart';

/// Zeigt die Sofort-Auswertung für einen gespeicherten Eintrag.
class EntryEvaluationScreen extends ConsumerStatefulWidget {
  const EntryEvaluationScreen({
    super.key,
    required this.entryId,
  });

  final int entryId;

  @override
  ConsumerState<EntryEvaluationScreen> createState() =>
      _EntryEvaluationScreenState();
}

class _EntryEvaluationScreenState extends ConsumerState<EntryEvaluationScreen> {
  String? _selectedActionKey;
  bool _isSavingAction = false;

  @override
  Widget build(BuildContext context) {
    final entryAsync = ref.watch(evaluationEntryProvider(widget.entryId));
    final contentAsync = ref.watch(evaluationContentProvider);

    return AppScaffold(
      title: 'Deine Auswertung',
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: _finishWithoutIntervention,
      ),
      body: entryAsync.when(
        data: (entry) {
          if (entry == null) {
            return const Center(
              child: Text('Eintrag nicht gefunden.'),
            );
          }

          return contentAsync.when(
            data: (content) {
              final tipIds = _decodeTipIds(entry.suggestedTipIds);
              final nextActionOptions = [
                entry.suggestedNextActionKey,
                entry.selectedNextActionKey,
              ]
                  .whereType<String>()
                  .followedBy(
                    PatternAnalyzer.nextActionFallbacks(
                      suggestedNextActionKey: entry.suggestedNextActionKey,
                      systemStateName: entry.systemState,
                    ),
                  )
                  .toSet()
                  .take(3)
                  .toList(growable: false);

              final selectedActionKey = _selectedActionKey ??
                  entry.selectedNextActionKey ??
                  entry.suggestedNextActionKey;

              final hasIntervention = entry.interventionType != null;

              return SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  AppConstants.spacingMedium,
                  AppConstants.spacingSmall,
                  AppConstants.spacingMedium,
                  AppConstants.spacingXLarge,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _InfoCard(
                      title: 'Was auffällt',
                      icon: Icons.visibility_outlined,
                      body: content.headlineFor(
                        entry.evaluationHeadlineKey ?? 'reflective_ready',
                      ),
                    ),
                    const SizedBox(height: AppConstants.spacingMedium),
                    _InfoCard(
                      title: 'Was das bedeuten könnte',
                      icon: Icons.psychology_alt_outlined,
                      body: content.meaningFor(
                        entry.evaluationMeaningKey ??
                            'reflective_ready_accessible',
                      ),
                    ),
                    const SizedBox(height: AppConstants.spacingMedium),
                    _InfoCard(
                      title: 'Was jetzt hilfreich sein kann',
                      icon: Icons.self_improvement_outlined,
                      body: content.nextActionFor(
                        entry.suggestedNextActionKey ?? 'choose_one_step',
                      ),
                    ),
                    const SizedBox(height: AppConstants.spacingLarge),
                    _SectionCard(
                      title: 'Praktische Tipps',
                      child: Column(
                        children: tipIds
                            .map((tipId) => _TipRow(
                                  text: content.tipFor(tipId),
                                ))
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: AppConstants.spacingMedium),
                    _SectionCard(
                      title: 'Nächster Schritt',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if ((entry.nextStep ?? '').isNotEmpty) ...[
                            Text(
                              'Dein notierter Schritt',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 4),
                            Text(entry.nextStep!),
                            const SizedBox(height: AppConstants.spacingMedium),
                          ],
                          ...nextActionOptions.map(
                            (actionKey) => RadioListTile<String>(
                              value: actionKey,
                              groupValue: selectedActionKey,
                              onChanged: (value) {
                                if (value == null) return;
                                setState(() {
                                  _selectedActionKey = value;
                                });
                              },
                              title: Text(content.nextActionFor(actionKey)),
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppConstants.spacingLarge),
                    if (hasIntervention)
                      AppPrimaryButton(
                        onPressed: _isSavingAction
                            ? null
                            : () => _startIntervention(
                                  selectedActionKey,
                                  entry.interventionType!,
                                ),
                        label: 'Passende Übung starten',
                        isLoading: _isSavingAction,
                      ),
                    if (hasIntervention)
                      const SizedBox(height: AppConstants.spacingSmall),
                    AppSecondaryButton(
                      onPressed: _isSavingAction
                          ? null
                          : _finishWithoutIntervention,
                      label: hasIntervention ? 'Für jetzt abschließen' : 'Fertig',
                    ),
                  ],
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(
              child: Text('Fehler beim Laden der Auswertung: $error'),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Fehler beim Laden des Eintrags: $error'),
        ),
      ),
    );
  }

  Future<void> _persistSelectedAction(String? actionKey) async {
    if (actionKey == null) {
      return;
    }

    setState(() {
      _isSavingAction = true;
    });
    try {
      final db = ref.read(databaseProvider);
      await db.updateSelectedNextAction(
        entryId: widget.entryId,
        selectedNextActionKey: actionKey,
      );
      ref.invalidate(evaluationEntryProvider(widget.entryId));
      ref.invalidate(narrativeInsightsProvider);
    } finally {
      if (mounted) {
        setState(() {
          _isSavingAction = false;
        });
      }
    }
  }

  Future<void> _startIntervention(
    String? actionKey,
    String interventionTypeRaw,
  ) async {
    await _persistSelectedAction(actionKey);
    if (!mounted) return;

    final interventionType = InterventionType.values
        .where((type) => type.name == interventionTypeRaw)
        .firstOrNull;
    if (interventionType == null) {
      await _finishWithoutIntervention();
      return;
    }

    final intervention =
        InterventionLibrary.getByType(interventionType).firstOrNull;
    if (intervention == null) {
      await _finishWithoutIntervention();
      return;
    }

    ref
        .read(interventionFlowStateProvider.notifier)
        .startIntervention(intervention, entryId: widget.entryId);
    context.push(AppRoutes.intervention);
  }

  Future<void> _finishWithoutIntervention() async {
    final actionKey = _selectedActionKey;
    await _persistSelectedAction(actionKey);
    ref.read(newSituationFlowControllerProvider.notifier).reset();
    if (!mounted) return;
    context.go(AppRoutes.home);
  }

  List<String> _decodeTipIds(String? raw) {
    if (raw == null || raw.isEmpty) {
      return const [];
    }

    try {
      final decoded = jsonDecode(raw);
      if (decoded is List) {
        return decoded.whereType<String>().toList(growable: false);
      }
    } catch (_) {
      return const [];
    }

    return const [];
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.title,
    required this.icon,
    required this.body,
  });

  final String title;
  final IconData icon;
  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20),
                const SizedBox(width: AppConstants.spacingSmall),
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.spacingSmall),
            Text(
              body,
              style: theme.textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: AppConstants.spacingSmall),
            child,
          ],
        ),
      ),
    );
  }
}

class _TipRow extends StatelessWidget {
  const _TipRow({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.spacingSmall),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2),
            child: Icon(Icons.check_circle_outline, size: 18),
          ),
          const SizedBox(width: AppConstants.spacingSmall),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
