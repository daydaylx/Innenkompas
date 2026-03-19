import 'package:flutter/material.dart';
import 'package:innenkompass/core/constants/app_constants.dart';
import 'package:innenkompass/core/constants/emotion_types.dart';
import 'package:innenkompass/core/constants/context_types.dart';
import 'package:innenkompass/core/constants/system_states.dart';
import 'package:innenkompass/domain/models/pattern_summary.dart';
import 'package:innenkompass/shared/widgets/buttons/app_primary_button.dart';
import 'package:innenkompass/shared/widgets/buttons/app_secondary_button.dart';

/// Bottom Sheet für Filter-Optionen im Verlauf
class HistoryFilterSheet extends StatefulWidget {
  final HistoryFilter currentFilter;
  final Function(HistoryFilter) onFilterChanged;

  const HistoryFilterSheet({
    super.key,
    required this.currentFilter,
    required this.onFilterChanged,
  });

  @override
  State<HistoryFilterSheet> createState() => _HistoryFilterSheetState();
}

class _HistoryFilterSheetState extends State<HistoryFilterSheet> {
  late DateRangeFilter _selectedDateRange;
  late Set<EmotionType> _selectedEmotions;
  late Set<ContextType> _selectedContexts;
  late Set<SystemState> _selectedStates;
  late bool _withInterventionOnly;
  late bool _crisisOnly;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedDateRange = widget.currentFilter.dateRange ?? DateRangeFilter.alle;
    _selectedEmotions = widget.currentFilter.emotions?.toSet() ?? {};
    _selectedContexts = widget.currentFilter.contexts?.toSet() ?? {};
    _selectedStates = widget.currentFilter.systemStates?.toSet() ?? {};
    _withInterventionOnly = widget.currentFilter.withInterventionOnly ?? false;
    _crisisOnly = widget.currentFilter.crisisOnly ?? false;
    _searchController.text = widget.currentFilter.searchText ?? '';
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _applyFilter() {
    widget.onFilterChanged(HistoryFilter(
      dateRange: _selectedDateRange == DateRangeFilter.alle
          ? null
          : _selectedDateRange,
      emotions: _selectedEmotions.isEmpty ? null : _selectedEmotions.toList(),
      contexts: _selectedContexts.isEmpty ? null : _selectedContexts.toList(),
      systemStates: _selectedStates.isEmpty ? null : _selectedStates.toList(),
      withInterventionOnly: _withInterventionOnly ? true : null,
      crisisOnly: _crisisOnly ? true : null,
      searchText:
          _searchController.text.isEmpty ? null : _searchController.text,
    ));
    Navigator.pop(context);
  }

  void _resetFilter() {
    setState(() {
      _selectedDateRange = DateRangeFilter.alle;
      _selectedEmotions.clear();
      _selectedContexts.clear();
      _selectedStates.clear();
      _withInterventionOnly = false;
      _crisisOnly = false;
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.all(AppConstants.spacingMedium),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                TextButton(
                  onPressed: _resetFilter,
                  child: const Text('Zurücksetzen'),
                ),
              ],
            ),
          ),

          // Content
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacingMedium,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Zeitraum
                  _buildSectionHeader('Zeitraum'),
                  Wrap(
                    spacing: 8,
                    children: DateRangeFilter.values
                        .where((range) => range != DateRangeFilter.benutzerdefiniert)
                        .map((range) {
                      final isSelected = _selectedDateRange == range;
                      return FilterChip(
                        label: Text(range.toDisplayString()),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            _selectedDateRange = range;
                          });
                        },
                        selectedColor: Theme.of(context)
                            .colorScheme
                            .primary
                            .withValues(alpha: 0.2),
                        checkmarkColor: Theme.of(context).colorScheme.primary,
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: AppConstants.spacingLarge),

                  // Emotionen
                  _buildSectionHeader('Emotionen'),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: EmotionType.values.map((emotion) {
                      final isSelected = _selectedEmotions.contains(emotion);
                      return FilterChip(
                        label: Text(_getEmotionLabel(emotion)),
                        avatar: Text(_getEmotionEmoji(emotion)),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              _selectedEmotions.add(emotion);
                            } else {
                              _selectedEmotions.remove(emotion);
                            }
                          });
                        },
                        selectedColor: Theme.of(context)
                            .colorScheme
                            .primary
                            .withValues(alpha: 0.2),
                        checkmarkColor: Theme.of(context).colorScheme.primary,
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: AppConstants.spacingLarge),

                  // Kontexte
                  _buildSectionHeader('Kontexte'),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: ContextType.values.map((ctx) {
                      final isSelected = _selectedContexts.contains(ctx);
                      return FilterChip(
                        label: Text(_getContextLabel(ctx)),
                        avatar: Text(_getContextEmoji(ctx)),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              _selectedContexts.add(ctx);
                            } else {
                              _selectedContexts.remove(ctx);
                            }
                          });
                        },
                        selectedColor: Theme.of(context)
                            .colorScheme
                            .primary
                            .withValues(alpha: 0.2),
                        checkmarkColor: Theme.of(context).colorScheme.primary,
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: AppConstants.spacingLarge),

                  // Systemzustände
                  _buildSectionHeader('Systemzustände'),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: SystemState.values.map((state) {
                      final isSelected = _selectedStates.contains(state);
                      return FilterChip(
                        label: Text(_getStateLabel(state)),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              _selectedStates.add(state);
                            } else {
                              _selectedStates.remove(state);
                            }
                          });
                        },
                        selectedColor: Theme.of(context)
                            .colorScheme
                            .primary
                            .withValues(alpha: 0.2),
                        checkmarkColor: Theme.of(context).colorScheme.primary,
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: AppConstants.spacingLarge),

                  // Weitere Filter
                  _buildSectionHeader('Weitere Filter'),
                  CheckboxListTile(
                    title: const Text('Nur mit Intervention'),
                    value: _withInterventionOnly,
                    onChanged: (value) {
                      setState(() {
                        _withInterventionOnly = value ?? false;
                      });
                    },
                    contentPadding: EdgeInsets.zero,
                  ),
                  CheckboxListTile(
                    title: const Text('Nur Krisen-Einträge'),
                    value: _crisisOnly,
                    onChanged: (value) {
                      setState(() {
                        _crisisOnly = value ?? false;
                      });
                    },
                    contentPadding: EdgeInsets.zero,
                  ),

                  const SizedBox(height: AppConstants.spacingLarge),

                  // Suchfeld
                  _buildSectionHeader('Suche'),
                  TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'In Beschreibung oder Gedanken suchen...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: AppConstants.spacingLarge),
                ],
              ),
            ),
          ),

          // Buttons
          Padding(
            padding: const EdgeInsets.all(AppConstants.spacingMedium),
            child: Row(
              children: [
                Expanded(
                  child: AppSecondaryButton(
                    onPressed: () => Navigator.pop(context),
                    label: 'Abbrechen',
                  ),
                ),
                const SizedBox(width: AppConstants.spacingSmall),
                Expanded(
                  child: AppPrimaryButton(
                    onPressed: _applyFilter,
                    label: 'Anwenden',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  String _getEmotionLabel(EmotionType emotion) {
    final labels = {
      EmotionType.anger: 'Wut',
      EmotionType.fear: 'Angst',
      EmotionType.sadness: 'Trauer',
      EmotionType.shame: 'Scham',
      EmotionType.disgust: 'Ekel',
      EmotionType.joy: 'Freude',
      EmotionType.surprise: 'Überraschung',
      EmotionType.guilt: 'Schuld',
      EmotionType.pride: 'Stolz',
      EmotionType.loneliness: 'Einsamkeit',
    };
    return labels[emotion] ?? emotion.name;
  }

  String _getEmotionEmoji(EmotionType emotion) {
    final emojis = {
      EmotionType.anger: '😠',
      EmotionType.fear: '😨',
      EmotionType.sadness: '😢',
      EmotionType.shame: '😳',
      EmotionType.disgust: '🤢',
      EmotionType.joy: '😊',
      EmotionType.surprise: '😲',
      EmotionType.guilt: '😔',
      EmotionType.pride: '😌',
      EmotionType.loneliness: '😞',
    };
    return emojis[emotion] ?? '😐';
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
}
