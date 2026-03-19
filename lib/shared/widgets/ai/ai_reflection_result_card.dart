import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../domain/models/ai_reflection.dart';

class AiReflectionResultCard extends StatelessWidget {
  const AiReflectionResultCard({
    super.key,
    required this.result,
  });

  final AiReflectionResult result;

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
            Text(
              result.summary,
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: AppConstants.spacingMedium),
            _LabeledBlock(
              label: 'Wahrscheinlichster Kern',
              text: result.likelyCore,
            ),
            const SizedBox(height: AppConstants.spacingMedium),
            _LabeledBlock(
              label: 'Frühester Kipppunkt',
              text: result.earlyTurningPoint,
            ),
            const SizedBox(height: AppConstants.spacingMedium),
            _LabeledBlock(
              label: 'Realistische Alternative',
              text: result.alternative,
            ),
            const SizedBox(height: AppConstants.spacingMedium),
            _LabeledBlock(
              label: 'Nächster sinnvoller Schritt',
              text: result.nextStep,
            ),
            if (result.hasMantra) ...[
              const SizedBox(height: AppConstants.spacingMedium),
              _LabeledBlock(
                label: 'Merksatz',
                text: result.mantra!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _LabeledBlock extends StatelessWidget {
  const _LabeledBlock({
    required this.label,
    required this.text,
  });

  final String label;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 4),
        Text(text),
      ],
    );
  }
}
