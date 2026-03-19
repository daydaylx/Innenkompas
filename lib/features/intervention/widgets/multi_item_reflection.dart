import 'package:flutter/material.dart';
import 'package:innenkompass/core/constants/app_constants.dart';

/// Widget für die Eingabe mehrerer Gedanken/Einträge (z.B. ABC-3 B-Step)
///
/// Erlaubt bis zu [maxItems] Freitext-Einträge mit je einem TextField.
/// Der „+ Gedanke hinzufügen"-Button ist deaktiviert, wenn [maxItems] erreicht.
/// Das Löschen-Icon pro Eintrag ist deaktiviert, wenn nur noch 1 Eintrag vorhanden ist.
class MultiItemReflection extends StatefulWidget {
  final int minItems;
  final int maxItems;
  final List<String>? initialItems;
  final ValueChanged<List<String>> onChanged;

  const MultiItemReflection({
    super.key,
    this.minItems = 1,
    this.maxItems = 10,
    this.initialItems,
    required this.onChanged,
  });

  @override
  State<MultiItemReflection> createState() => _MultiItemReflectionState();
}

class _MultiItemReflectionState extends State<MultiItemReflection> {
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    final initial = _normalizedInitialItems(widget.initialItems);
    _controllers = initial.isEmpty
        ? [TextEditingController()]
        : initial.map((text) => TextEditingController(text: text)).toList();
  }

  @override
  void didUpdateWidget(covariant MultiItemReflection oldWidget) {
    super.didUpdateWidget(oldWidget);
    final previous = _normalizedInitialItems(oldWidget.initialItems);
    final current = _normalizedInitialItems(widget.initialItems);
    if (previous.join('|') != current.join('|')) {
      for (final controller in _controllers) {
        controller.dispose();
      }
      _controllers = current.isEmpty
          ? [TextEditingController()]
          : current.map((text) => TextEditingController(text: text)).toList();
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _notifyChanged() {
    final items = _controllers
        .map((c) => c.text.trim())
        .where((s) => s.isNotEmpty)
        .toList();
    widget.onChanged(items);
  }

  List<String> _normalizedInitialItems(List<String>? items) {
    return items?.where((s) => s.isNotEmpty).toList() ?? const [];
  }

  void _addItem() {
    if (_controllers.length >= widget.maxItems) return;
    setState(() {
      _controllers.add(TextEditingController());
    });
  }

  void _removeItem(int index) {
    if (_controllers.length <= 1) return;
    setState(() {
      _controllers[index].dispose();
      _controllers.removeAt(index);
    });
    _notifyChanged();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Eintrags-Liste
        ...List.generate(_controllers.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppConstants.spacingSmall),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nummer
                Padding(
                  padding: const EdgeInsets.only(
                      top: 14, right: AppConstants.spacingSmall),
                  child: Text(
                    '${index + 1}.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),

                // Textfeld
                Expanded(
                  child: TextField(
                    controller: _controllers[index],
                    minLines: 1,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Gedanke eingeben…',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                    ),
                    onChanged: (_) => _notifyChanged(),
                  ),
                ),

                // Löschen-Button
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 4),
                  child: IconButton(
                    icon: Icon(
                      Icons.remove_circle_outline,
                      color: _controllers.length > 1
                          ? Colors.red[400]
                          : Colors.grey[300],
                    ),
                    onPressed: _controllers.length > 1
                        ? () => _removeItem(index)
                        : null,
                    tooltip: 'Eintrag entfernen',
                  ),
                ),
              ],
            ),
          );
        }),

        const SizedBox(height: AppConstants.spacingSmall),

        // „+ Gedanke hinzufügen" Button
        OutlinedButton.icon(
          onPressed: _controllers.length < widget.maxItems ? _addItem : null,
          icon: const Icon(Icons.add),
          label: const Text('Gedanke hinzufügen'),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.spacingMedium,
              vertical: AppConstants.spacingSmall,
            ),
          ),
        ),

        const SizedBox(height: AppConstants.spacingSmall),

        // Datenschutz-Hinweis
        Container(
          padding: const EdgeInsets.all(AppConstants.spacingSmall),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.lock, size: 16, color: Colors.blue[700]),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Deine Antworten werden nur lokal auf deinem Gerät gespeichert.',
                  style: TextStyle(
                    color: Colors.blue[900],
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
