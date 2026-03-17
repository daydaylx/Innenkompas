import 'package:flutter/material.dart';
import '../../../app/theme/colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/cards/app_card.dart';

/// Single onboarding page widget.
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    this.icon,
    this.illustration,
    this.showCrisisInfo = false,
  });

  final String title;
  final String description;
  final IconData? icon;
  final Widget? illustration;
  final bool showCrisisInfo;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(AppConstants.spacingLarge),
      child: AppCard(
        variant: AppCardVariant.glass,
        margin: EdgeInsets.zero,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            if (icon != null) ...[
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: AppColors.primarySoft,
                  borderRadius:
                      BorderRadius.circular(AppConstants.borderRadiusLarge),
                ),
                child: Icon(
                  icon,
                  size: 48,
                  color: AppColors.primaryDark,
                ),
              ),
              const SizedBox(height: AppConstants.spacingXLarge),
            ],
            if (illustration != null) ...[
              illustration!,
              const SizedBox(height: AppConstants.spacingXLarge),
            ],
            Text(
              title,
              style: theme.textTheme.headlineMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.spacingMedium),
            Text(
              description,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondary,
                height: 1.55,
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

/// Page indicator for onboarding.
class OnboardingPageIndicator extends StatelessWidget {
  const OnboardingPageIndicator({
    super.key,
    required this.currentPage,
    required this.totalPages,
  });

  final int currentPage;
  final int totalPages;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalPages,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: currentPage == index ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: currentPage == index
                ? AppColors.primary
                : AppColors.primarySoft,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
