import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:innenkompass/core/constants/app_constants.dart';
import 'package:innenkompass/domain/models/intervention_step.dart';
import 'package:innenkompass/features/intervention/widgets/breathing_exercise.dart';
import 'package:innenkompass/features/intervention/widgets/timer_widget.dart';
import 'package:innenkompass/features/intervention/widgets/fact_check_form.dart';
import 'package:innenkompass/features/intervention/widgets/reflection_step.dart';
import 'package:innenkompass/features/intervention/widgets/selection_step.dart';
import 'package:innenkompass/features/intervention/widgets/action_step.dart';
import 'package:innenkompass/features/intervention/widgets/rating_step.dart';
import 'package:innenkompass/features/intervention/widgets/multi_item_reflection.dart';
import 'package:innenkompass/features/intervention/widgets/disputation_form.dart';

/// Generischer Renderer für alle Arten von Interventionsschritten
class InterventionStepRenderer extends StatefulWidget {
  final InterventionStep step;
  final Function(InterventionStepResponse) onResponse;
  final InterventionStepResponse? existingResponse;

  const InterventionStepRenderer({
    super.key,
    required this.step,
    required this.onResponse,
    this.existingResponse,
  });

  @override
  State<InterventionStepRenderer> createState() =>
      _InterventionStepRendererState();
}

class _InterventionStepRendererState extends State<InterventionStepRenderer> {
  late InterventionStepResponse? _currentResponse;

  @override
  void initState() {
    super.initState();
    _currentResponse = widget.existingResponse;
  }

  @override
  void didUpdateWidget(covariant InterventionStepRenderer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.step.id != widget.step.id ||
        oldWidget.existingResponse != widget.existingResponse) {
      _currentResponse = widget.existingResponse;
    }
  }

  void _updateResponse(InterventionStepResponse response) {
    setState(() {
      _currentResponse = response;
    });
    widget.onResponse(response);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Titel
        Text(
          widget.step.title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),

        if (widget.step.subtitle != null) ...[
          const SizedBox(height: AppConstants.spacingSmall),
          Text(
            widget.step.subtitle!,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
        ],

        const SizedBox(height: AppConstants.spacingLarge),

        // Body Text
        if (widget.step.body.isNotEmpty) ...[
          Text(
            widget.step.body,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: AppConstants.spacingLarge),
        ],

        // Step-spezifischer Content
        _buildStepContent(),

        // Hilfetext (falls vorhanden)
        if (widget.step.helpText != null) ...[
          const SizedBox(height: AppConstants.spacingLarge),
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingMedium),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue[200]!),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.blue[700], size: 20),
                const SizedBox(width: AppConstants.spacingSmall),
                Expanded(
                  child: Text(
                    widget.step.helpText!,
                    style: TextStyle(
                      color: Colors.blue[900],
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildStepContent() {
    switch (widget.step.type) {
      case InterventionStepType.text:
        return _TextStepWidget(
          step: widget.step,
          response: _currentResponse,
          onResponse: _updateResponse,
        );

      case InterventionStepType.breathing:
        return _BreathingStepWidget(
          step: widget.step,
          response: _currentResponse,
          onResponse: _updateResponse,
        );

      case InterventionStepType.timer:
        return _TimerStepWidget(
          step: widget.step,
          response: _currentResponse,
          onResponse: _updateResponse,
        );

      case InterventionStepType.reflection:
        return _ReflectionStepWidget(
          step: widget.step,
          response: _currentResponse,
          onResponse: _updateResponse,
        );

      case InterventionStepType.selection:
        return _SelectionStepWidget(
          step: widget.step,
          response: _currentResponse,
          onResponse: _updateResponse,
        );

      case InterventionStepType.action:
        return _ActionStepWidget(
          step: widget.step,
          response: _currentResponse,
          onResponse: _updateResponse,
        );

      case InterventionStepType.factCheck:
        return _FactCheckStepWidget(
          step: widget.step,
          response: _currentResponse,
          onResponse: _updateResponse,
        );

      case InterventionStepType.rating:
        return _RatingStepWidget(
          step: widget.step,
          response: _currentResponse,
          onResponse: _updateResponse,
        );
    }
  }
}

// ============================================
// STEP-RENDERER KLASSEN
// ============================================

/// Text-Step: Nur Information anzeigen
class _TextStepWidget extends StatelessWidget {
  final InterventionStep step;
  final InterventionStepResponse? response;
  final Function(InterventionStepResponse) onResponse;

  const _TextStepWidget({
    required this.step,
    required this.response,
    required this.onResponse,
  });

  @override
  Widget build(BuildContext context) {
    // Automatisch als "gelesen" markieren
    if (response == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        onResponse(InterventionStepResponse(
          stepId: step.id,
          type: step.type,
          answeredAt: DateTime.now(),
        ));
      });
    }

    return const SizedBox.shrink();
  }
}

/// Breathing-Step: Atemübung anzeigen
class _BreathingStepWidget extends StatelessWidget {
  final InterventionStep step;
  final InterventionStepResponse? response;
  final Function(InterventionStepResponse) onResponse;

  const _BreathingStepWidget({
    required this.step,
    required this.response,
    required this.onResponse,
  });

  @override
  Widget build(BuildContext context) {
    final metadata = step.metadata ?? {};
    final inhaleDuration = metadata['inhale_duration'] as int? ?? 4;
    final holdDuration = metadata['hold_duration'] as int? ?? 4;
    final exhaleDuration = metadata['exhale_duration'] as int? ?? 6;
    final cycles = metadata['cycles'] as int? ?? 6;

    return BreathingExercise(
      inhaleDuration: inhaleDuration,
      holdDuration: holdDuration,
      exhaleDuration: exhaleDuration,
      totalCycles: cycles,
      onComplete: () {
        onResponse(InterventionStepResponse(
          stepId: step.id,
          type: step.type,
          boolResponse: true,
          actualDurationSec: step.durationSec,
          answeredAt: DateTime.now(),
        ));
      },
    );
  }
}

/// Timer-Step: Countdown-Timer anzeigen
class _TimerStepWidget extends StatelessWidget {
  final InterventionStep step;
  final InterventionStepResponse? response;
  final Function(InterventionStepResponse) onResponse;

  const _TimerStepWidget({
    required this.step,
    required this.response,
    required this.onResponse,
  });

  @override
  Widget build(BuildContext context) {
    final duration = step.durationSec ?? 60;

    return TimerWidget(
      durationSec: duration,
      onComplete: () {
        onResponse(InterventionStepResponse(
          stepId: step.id,
          type: step.type,
          boolResponse: true,
          actualDurationSec: duration,
          answeredAt: DateTime.now(),
        ));
      },
    );
  }
}

/// Reflection-Step: Textfeld für Reflexion
class _ReflectionStepWidget extends StatefulWidget {
  final InterventionStep step;
  final InterventionStepResponse? response;
  final Function(InterventionStepResponse) onResponse;

  const _ReflectionStepWidget({
    required this.step,
    required this.response,
    required this.onResponse,
  });

  @override
  State<_ReflectionStepWidget> createState() => _ReflectionStepWidgetState();
}

class _ReflectionStepWidgetState extends State<_ReflectionStepWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.response?.textResponse ?? '',
    );
  }

  @override
  void didUpdateWidget(covariant _ReflectionStepWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    final nextText = widget.response?.textResponse ?? '';
    if (oldWidget.response?.textResponse != widget.response?.textResponse &&
        _controller.text != nextText) {
      _controller.text = nextText;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final metadata = widget.step.metadata ?? {};
    final minItems = metadata['min_items'] as int?;

    if (minItems != null) {
      final maxItems = metadata['max_items'] as int? ?? 10;
      final raw = widget.response?.textResponse ?? '';
      final initialItems = raw.isEmpty
          ? null
          : raw.split('|').where((s) => s.isNotEmpty).toList();

      return MultiItemReflection(
        minItems: minItems,
        maxItems: maxItems,
        initialItems: initialItems,
        onChanged: (items) {
          widget.onResponse(InterventionStepResponse(
            stepId: widget.step.id,
            type: widget.step.type,
            textResponse: items.isEmpty ? null : items.join('|'),
            answeredAt: DateTime.now(),
          ));
        },
      );
    }

    return ReflectionStep(
      controller: _controller,
      onChanged: (value) {
        widget.onResponse(InterventionStepResponse(
          stepId: widget.step.id,
          type: widget.step.type,
          textResponse: value.isEmpty ? null : value,
          answeredAt: DateTime.now(),
        ));
      },
    );
  }
}

/// Selection-Step: Auswahl aus Optionen
/// Unterstützt Multi-Select wenn metadata['multi_select'] == true
class _SelectionStepWidget extends StatefulWidget {
  final InterventionStep step;
  final InterventionStepResponse? response;
  final Function(InterventionStepResponse) onResponse;

  const _SelectionStepWidget({
    required this.step,
    required this.response,
    required this.onResponse,
  });

  @override
  State<_SelectionStepWidget> createState() => _SelectionStepWidgetState();
}

class _SelectionStepWidgetState extends State<_SelectionStepWidget> {
  late List<String> _selectedOptions;

  @override
  void initState() {
    super.initState();
    final raw = widget.response?.selectionResponse ?? '';
    _selectedOptions = raw.isEmpty ? [] : raw.split('|');
  }

  @override
  void didUpdateWidget(covariant _SelectionStepWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    final raw = widget.response?.selectionResponse ?? '';
    final nextOptions = raw.isEmpty ? <String>[] : raw.split('|');
    if (oldWidget.response?.selectionResponse != widget.response?.selectionResponse) {
      _selectedOptions = nextOptions;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMulti = widget.step.metadata?['multi_select'] == true;

    if (isMulti) {
      return SelectionStep(
        options: widget.step.options ?? [],
        selectedOptions: _selectedOptions,
        onOptionsChanged: (options) {
          setState(() {
            _selectedOptions = options;
          });
          widget.onResponse(InterventionStepResponse(
            stepId: widget.step.id,
            type: widget.step.type,
            selectionResponse: options.isEmpty ? null : options.join('|'),
            answeredAt: DateTime.now(),
          ));
        },
        allowMultiple: true,
      );
    }

    return SelectionStep(
      options: widget.step.options ?? [],
      selectedOption: widget.response?.selectionResponse,
      onOptionSelected: (option) {
        widget.onResponse(InterventionStepResponse(
          stepId: widget.step.id,
          type: widget.step.type,
          selectionResponse: option,
          answeredAt: DateTime.now(),
        ));
      },
    );
  }
}

/// Action-Step: Handlungsaufforderung mit Bestätigung
class _ActionStepWidget extends StatelessWidget {
  final InterventionStep step;
  final InterventionStepResponse? response;
  final Function(InterventionStepResponse) onResponse;

  const _ActionStepWidget({
    required this.step,
    required this.response,
    required this.onResponse,
  });

  @override
  Widget build(BuildContext context) {
    return ActionStep(
      isCompleted: response?.boolResponse ?? false,
      onComplete: () {
        onResponse(InterventionStepResponse(
          stepId: step.id,
          type: step.type,
          boolResponse: true,
          answeredAt: DateTime.now(),
        ));
      },
    );
  }
}

/// FactCheck-Step: Fakt/Deutung Formular oder Disputation-Form
/// Wenn metadata['answer_options'] vorhanden → DisputationForm (RSA D1/D2)
/// Sonst → klassisches FactCheckForm
class _FactCheckStepWidget extends StatelessWidget {
  final InterventionStep step;
  final InterventionStepResponse? response;
  final Function(InterventionStepResponse) onResponse;

  const _FactCheckStepWidget({
    required this.step,
    required this.response,
    required this.onResponse,
  });

  @override
  Widget build(BuildContext context) {
    final metadata = step.metadata ?? {};
    final rawOptions = metadata['answer_options'];

    if (rawOptions != null && rawOptions is List) {
      final answerOptions = List<String>.from(rawOptions);
      final noteLabel = metadata['note_label'] as String?;
      final noteMaxLength = metadata['note_max_length'] as int?;
      final existingParts = _parseDisputationResponse(response?.textResponse);

      return DisputationForm(
        answerOptions: answerOptions,
        noteLabel: noteLabel,
        noteMaxLength: noteMaxLength,
        initialSelectedAnswer: existingParts.$1,
        initialNote: existingParts.$2,
        onComplete: (answer, note) {
          onResponse(InterventionStepResponse(
            stepId: step.id,
            type: step.type,
            textResponse: note != null ? '$answer|||$note' : answer,
            answeredAt: DateTime.now(),
          ));
        },
      );
    }

    final existingData = _parseFactCheckResponse(response?.textResponse);

    return FactCheckForm(
      initialFact: existingData['fact'],
      initialInterpretation: existingData['interpretation'],
      initialAlternative: existingData['alternative'],
      onComplete: (data) {
        onResponse(InterventionStepResponse(
          stepId: step.id,
          type: step.type,
          textResponse: jsonEncode(data),
          answeredAt: DateTime.now(),
        ));
      },
    );
  }
}

/// Rating-Step: Bewertung von 1-10
class _RatingStepWidget extends StatefulWidget {
  final InterventionStep step;
  final InterventionStepResponse? response;
  final Function(InterventionStepResponse) onResponse;

  const _RatingStepWidget({
    required this.step,
    required this.response,
    required this.onResponse,
  });

  @override
  State<_RatingStepWidget> createState() => _RatingStepWidgetState();
}

class _RatingStepWidgetState extends State<_RatingStepWidget> {
  late int _rating;

  @override
  void initState() {
    super.initState();
    _rating = widget.response?.ratingResponse ?? 5;
  }

  @override
  void didUpdateWidget(covariant _RatingStepWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    final nextRating = widget.response?.ratingResponse ?? 5;
    if (oldWidget.response?.ratingResponse != widget.response?.ratingResponse) {
      _rating = nextRating;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RatingStep(
      rating: _rating,
      onRatingChanged: (value) {
        setState(() {
          _rating = value;
        });
        widget.onResponse(InterventionStepResponse(
          stepId: widget.step.id,
          type: widget.step.type,
          ratingResponse: value,
          answeredAt: DateTime.now(),
        ));
      },
    );
  }
}

(String?, String?) _parseDisputationResponse(String? raw) {
  if (raw == null || raw.isEmpty) {
    return (null, null);
  }

  final parts = raw.split('|||');
  final answer = parts.isEmpty || parts.first.isEmpty ? null : parts.first;
  final note = parts.length > 1 && parts[1].isNotEmpty ? parts[1] : null;
  return (answer, note);
}

Map<String, String?> _parseFactCheckResponse(String? raw) {
  if (raw == null || raw.isEmpty) {
    return const {
      'fact': null,
      'interpretation': null,
      'alternative': null,
    };
  }

  try {
    final decoded = jsonDecode(raw);
    if (decoded is Map<String, dynamic>) {
      return {
        'fact': decoded['fact'] as String?,
        'interpretation': decoded['interpretation'] as String?,
        'alternative': decoded['alternative'] as String?,
      };
    }
  } catch (_) {
    // Fall back to empty values for legacy in-memory responses.
  }

  return const {
    'fact': null,
    'interpretation': null,
    'alternative': null,
  };
}
