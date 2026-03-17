import 'package:flutter/material.dart';
import 'package:innenkompass/core/constants/app_constants.dart';

/// Formular für Disputation-Schritte (RSA D1/D2)
///
/// Zeigt große vertikale Answer-Cards aus [answerOptions] und
/// ein optionales Begründungsfeld ([noteLabel]).
/// Ruft [onComplete] mit der Auswahl und optionaler Begründung auf.
class DisputationForm extends StatefulWidget {
  final List<String> answerOptions;
  final String? noteLabel;
  final int? noteMaxLength;
  final Function(String answer, String? note) onComplete;

  const DisputationForm({
    super.key,
    required this.answerOptions,
    this.noteLabel,
    this.noteMaxLength,
    required this.onComplete,
  });

  @override
  State<DisputationForm> createState() => _DisputationFormState();
}

class _DisputationFormState extends State<DisputationForm> {
  String? _selectedAnswer;
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _notifyComplete() {
    if (_selectedAnswer == null) return;
    final note = _noteController.text.trim();
    widget.onComplete(_selectedAnswer!, note.isEmpty ? null : note);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Answer-Cards
        ...widget.answerOptions.map((option) {
          final isSelected = _selectedAnswer == option;

          return Padding(
            padding: const EdgeInsets.only(bottom: AppConstants.spacingSmall),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _selectedAnswer = option;
                  });
                  _notifyComplete();
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(AppConstants.spacingMedium),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey[300]!,
                      width: isSelected ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    color: isSelected
                        ? Theme.of(context)
                            .colorScheme
                            .primary
                            .withValues(alpha: 0.1)
                        : Colors.transparent,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey[400]!,
                            width: 2,
                          ),
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : Colors.transparent,
                        ),
                        child: isSelected
                            ? const Icon(Icons.check,
                                size: 14, color: Colors.white)
                            : null,
                      ),
                      const SizedBox(width: AppConstants.spacingMedium),
                      Expanded(
                        child: Text(
                          option,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                    color: isSelected
                                        ? Theme.of(context).colorScheme.primary
                                        : null,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),

        // Begründungsfeld (optional)
        if (widget.noteLabel != null) ...[
          const SizedBox(height: AppConstants.spacingMedium),
          Text(
            widget.noteLabel!,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: AppConstants.spacingSmall),
          TextField(
            controller: _noteController,
            maxLines: 3,
            maxLength: widget.noteMaxLength ?? 300,
            decoration: InputDecoration(
              hintText: 'Optional: Begründung eingeben…',
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              filled: true,
              fillColor: Colors.grey[50],
            ),
            onChanged: (_) => _notifyComplete(),
          ),
        ],
      ],
    );
  }
}
