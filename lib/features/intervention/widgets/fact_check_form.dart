import 'package:flutter/material.dart';
import 'package:innenkompass/core/constants/app_constants.dart';
import 'package:innenkompass/app/theme/colors.dart';
import 'package:innenkompass/shared/widgets/buttons/app_primary_button.dart';

/// Formular für Fakt-vs-Deutung Analyse
///
/// Hilft Nutzern, objektive Fakten von subjektiven Interpretationen zu trennen
class FactCheckForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onComplete;

  const FactCheckForm({
    super.key,
    required this.onComplete,
  });

  @override
  State<FactCheckForm> createState() => _FactCheckFormState();
}

class _FactCheckFormState extends State<FactCheckForm> {
  final _factController = TextEditingController();
  final _interpretationController = TextEditingController();
  final _alternativeController = TextEditingController();

  @override
  void dispose() {
    _factController.dispose();
    _interpretationController.dispose();
    _alternativeController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    widget.onComplete({
      'fact': _factController.text.trim(),
      'interpretation': _interpretationController.text.trim(),
      'alternative': _alternativeController.text.trim(),
    });
  }

  bool get _isValid =>
      _factController.text.trim().isNotEmpty &&
      _interpretationController.text.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Erklärung
        Container(
          padding: const EdgeInsets.all(AppConstants.spacingMedium),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.lightbulb_outline, color: Colors.blue[700]),
                  const SizedBox(width: 8),
                  Text(
                    'Fakt vs. Deutung',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Fakten sind objektiv überprüfbar (z.B. "Er hat nicht geantwortet").\n'
                'Deutungen sind subjektive Interpretationen (z.B. "Er ignoriert mich").',
                style: TextStyle(
                  color: Colors.blue[900],
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: AppConstants.spacingLarge),

        // Fakt-Feld
        _buildField(
          controller: _factController,
          label: 'Was ist objektiv passiert?',
          hint: 'Beschreibe die Situation wie eine Kamera...',
          icon: Icons.fact_check,
          color: AppColors.success,
        ),

        const SizedBox(height: AppConstants.spacingLarge),

        // Deutung-Feld
        _buildField(
          controller: _interpretationController,
          label: 'Wie hast du es interpretiert?',
          hint: 'Was war dein erster Gedanke?',
          icon: Icons.psychology,
          color: AppColors.warning,
        ),

        const SizedBox(height: AppConstants.spacingLarge),

        // Alternative Deutung
        _buildField(
          controller: _alternativeController,
          label: 'Was könnte es auch sein?',
          hint: 'Welche anderen Erklärungen sind möglich?',
          icon: Icons.sync_alt,
          color: AppColors.primary,
          required: false,
        ),

        const SizedBox(height: AppConstants.spacingLarge),

        // Absenden-Button
        AppPrimaryButton(
          onPressed: _isValid ? _handleSubmit : null,
          text: 'Auswerten',
        ),
      ],
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required Color color,
    bool required = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            if (required)
              Text(
                '*',
                style: TextStyle(
                  color: AppColors.error,
                  fontSize: 18,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: 4,
          maxLength: 500,
          decoration: InputDecoration(
            hintText: hint,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            filled: true,
            fillColor: color.withOpacity(0.05),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(color: color, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
