import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:innenkompass/app/router.dart';
import 'package:innenkompass/core/constants/app_constants.dart';
import 'package:innenkompass/core/constants/emotion_types.dart';
import 'package:innenkompass/core/constants/context_types.dart';
import 'package:innenkompass/core/constants/system_states.dart';
import 'package:innenkompass/data/db/app_database.dart';
import 'package:innenkompass/domain/models/pattern_summary.dart';
import 'package:innenkompass/application/providers/intervention_providers.dart';
import 'package:innenkompass/shared/widgets/app_scaffold.dart';
import 'package:innenkompass/features/history/widgets/history_entry_card.dart';
import 'package:innenkompass/features/history/widgets/history_filter_sheet.dart';

part 'history_screen.g.dart';

/// Screen für den Verlauf aller Situationseinträge
class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  HistoryFilter _currentFilter = const HistoryFilter(
    dateRange: DateRangeFilter.alle,
  );

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  void _loadEntries() {
    // Einträge werden automatisch durch den Provider geladen
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => HistoryFilterSheet(
        currentFilter: _currentFilter,
        onFilterChanged: (filter) {
          setState(() {
            _currentFilter = filter;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final entriesAsync = ref.watch(
      filteredHistoryEntriesProvider(_currentFilter),
    );

    return AppScaffold(
      title: 'Verlauf',
      actions: [
        IconButton(
          icon: const Icon(Icons.filter_list),
          onPressed: _showFilterSheet,
          tooltip: 'Filter',
        ),
      ],
      body: entriesAsync.when(
        data: (entries) {
          if (entries.isEmpty) {
            return _buildEmptyState();
          }

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(filteredHistoryEntriesProvider(_currentFilter));
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(AppConstants.spacingSmall),
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final entry = entries[index];
                return HistoryEntryCard(
                  entry: entry,
                  onTap: () {
                    context.push('${AppRoutes.history}/${entry.id}');
                  },
                  onDelete: () => _showDeleteDialog(entry),
                );
              },
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
              const SizedBox(height: AppConstants.spacingMedium),
              ElevatedButton(
                onPressed: () {
                  ref.invalidate(filteredHistoryEntriesProvider(_currentFilter));
                },
                child: const Text('Erneut versuchen'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    final hasFilter = _currentFilter != const HistoryFilter(
      dateRange: DateRangeFilter.alle,
    );

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            hasFilter ? Icons.filter_list_off : Icons.book,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: AppConstants.spacingMedium),
          Text(
            hasFilter ? 'Keine Einträge gefunden' : 'Noch keine Einträge',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: AppConstants.spacingSmall),
          Text(
            hasFilter
                ? 'Versuche andere Filter-Einstellungen'
                : 'Deine ersten Einträge erscheinen hier',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[500],
                ),
          ),
          if (!hasFilter) ...[
            const SizedBox(height: AppConstants.spacingLarge),
            ElevatedButton.icon(
              onPressed: () => context.push(AppRoutes.newSituationEvent),
              icon: const Icon(Icons.add),
              label: const Text('Neuen Eintrag erstellen'),
            ),
          ],
        ],
      ),
    );
  }

  void _showDeleteDialog(SituationEntryData entry) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eintrag löschen?'),
        content: const Text(
          'Möchtest du diesen Eintrag wirklich löschen? Diese Aktion kann nicht rückgängig gemacht werden.',
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Abbrechen'),
          ),
          TextButton(
            onPressed: () async {
              context.pop();
              final db = ref.read(databaseProvider);
              await db.deleteSituationEntry(entry.id);
              if (mounted) {
                ref.invalidate(filteredHistoryEntriesProvider(_currentFilter));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Eintrag gelöscht')),
                );
              }
            },
            child: const Text(
              'Löschen',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
