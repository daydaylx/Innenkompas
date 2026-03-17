import 'package:flutter/material.dart';
import 'package:innenkompass/core/constants/app_constants.dart';
import 'package:innenkompass/domain/models/intervention.dart';

/// Fortschrittsanzeige für Interventionen
///
/// Zeigt den aktuellen Fortschritt innerhalb einer Intervention an
class InterventionProgressIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final Intervention? intervention;

  const InterventionProgressIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    this.intervention,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spacingMedium,
        vertical: AppConstants.spacingSmall,
      ),
      child: Column(
        children: [
          // Text-Progress
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Schritt $currentStep von $totalSteps',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
              ),
              if (intervention != null)
                Text(
                  _formatDuration(intervention!.estimatedDurationSec),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[500],
                      ),
                ),
            ],
          ),

          const SizedBox(height: AppConstants.spacingSmall),

          // Progress-Balken
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: (currentStep - 1) / totalSteps,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.primary,
              ),
              minHeight: 6,
            ),
          ),

          const SizedBox(height: AppConstants.spacingSmall),

          // Step-Indikatoren (Punkte)
          Row(
            children: List.generate(
              totalSteps,
              (index) => Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  height: 4,
                  decoration: BoxDecoration(
                    color: index < currentStep - 1
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    if (minutes == 0) return '< 1 Min';
    if (minutes == 1) return 'ca. 1 Min';
    return 'ca. $minutes Min';
  }
}
