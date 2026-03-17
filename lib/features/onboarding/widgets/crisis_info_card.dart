import 'package:flutter/material.dart';
import '../../../app/theme/colors.dart';
import '../../../core/constants/app_constants.dart';

/// Crisis info card for onboarding.
///
/// Displays crisis hotline information in a prominent but non-alarming way.
class OnboardingCrisisInfoCard extends StatelessWidget {
  const OnboardingCrisisInfoCard({
    super.key,
    this.title = 'Wichtige Notfallnummern',
    this.message =
        'Falls du dich in einer Krise befindest oder sofort Hilfe brauchst:',
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppConstants.spacingMedium),
      padding: const EdgeInsets.all(AppConstants.spacingMedium),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(
          color: AppColors.error.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.emergency,
                  size: 18,
                  color: AppColors.error,
                ),
              ),
              const SizedBox(width: AppConstants.spacingSmall),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.error,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingSmall),
          Text(
            message,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
          const SizedBox(height: AppConstants.spacingSmall),
          const _HotlineItem(
            label: 'Telefonseelsorge',
            number: '0800 111 0 111',
          ),
          const _HotlineItem(
            label: 'Telefonseelsorge (alternativ)',
            number: '0800 111 0 222',
          ),
          const _HotlineItem(
            label: 'Notruf',
            number: '112',
          ),
        ],
      ),
    );
  }
}

class _HotlineItem extends StatelessWidget {
  const _HotlineItem({
    required this.label,
    required this.number,
  });

  final String label;
  final String number;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          const Icon(
            Icons.phone,
            size: 14,
            color: AppColors.error,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '$label: $number',
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
