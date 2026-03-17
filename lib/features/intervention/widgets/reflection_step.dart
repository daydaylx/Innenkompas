import 'package:flutter/material.dart';
import 'package:innenkompass/core/constants/app_constants.dart';

/// Widget für Reflexions-Schritte mit Textfeld
class ReflectionStep extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String? hintText;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;

  const ReflectionStep({
    super.key,
    required this.controller,
    required this.onChanged,
    this.hintText,
    this.maxLength = 500,
    this.minLines = 3,
    this.maxLines = 6,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          maxLength: maxLength,
          minLines: minLines,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText ??
                'Nimm dir einen Moment, um zu refektieren. Schreibe deine Gedanken auf...',
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            filled: true,
            fillColor: Colors.grey[50],
          ),
          onChanged: onChanged,
        ),

        const SizedBox(height: AppConstants.spacingSmall),

        // Hinweis zur Datenschutz
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
