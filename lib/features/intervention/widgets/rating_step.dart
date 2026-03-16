import 'package:flutter/material.dart';
import 'package:innenkompass/core/constants/app_constants.dart';
import 'package:innenkompass/app/theme/colors.dart';

/// Widget für Bewertungs-Schritte (1-10)
class RatingStep extends StatelessWidget {
  final int rating;
  final ValueChanged<int> onRatingChanged;
  final String? lowLabel;
  final String? highLabel;

  const RatingStep({
    super.key,
    required this.rating,
    required this.onRatingChanged,
    this.lowLabel,
    this.highLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Rating-Anzeige
        Container(
          padding: const EdgeInsets.all(AppConstants.spacingLarge),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              // Große Rating-Anzeige
              Text(
                '$rating',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: _getRatingColor(rating),
                    ),
              ),

              const SizedBox(height: AppConstants.spacingSmall),

              // Slider
              Slider(
                value: rating.toDouble(),
                min: 1,
                max: 10,
                divisions: 9,
                activeColor: _getRatingColor(rating),
                onChanged: (value) {
                  onRatingChanged(value.toInt());
                },
              ),

              // Labels
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    lowLabel ?? 'Gar nicht',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  Text(
                    highLabel ?? 'Sehr stark',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: AppConstants.spacingMedium),

        // Farbskala-Indikator
        Row(
          children: List.generate(
            10,
            (index) => Expanded(
              child: Container(
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 1),
                decoration: BoxDecoration(
                  color: _getRatingColor(index + 1),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: AppConstants.spacingSmall),

        // Label-Indikatoren
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            5,
            (index) => Text(
              '${(index * 2) + 1}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[500],
                  ),
            ),
          ),
        ),
      ],
    );
  }

  Color _getRatingColor(int rating) {
    if (rating <= 3) return AppColors.success;
    if (rating <= 6) return AppColors.warning;
    return AppColors.error;
  }
}
