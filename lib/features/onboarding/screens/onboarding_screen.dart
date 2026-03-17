import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../application/providers/settings_provider.dart';
import '../../../app/router.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../../shared/widgets/buttons/buttons.dart';
import '../../../core/constants/app_constants.dart';
import '../widgets/onboarding_widgets.dart';

/// Main onboarding screen for Innenkompass.
///
/// Displays a multi-page onboarding flow with:
/// - Page 1: What is Innenkompass?
/// - Page 2: Not a therapy replacement
/// - Page 3: Private and secure
/// - Page 4: Crisis info (with hotline numbers)
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Total number of onboarding pages
  static const int _totalPages = 4;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _completeOnboarding() async {
    // Complete onboarding through settings provider
    await ref.read(settingsNotifierProvider.notifier).completeOnboarding();

    // Navigate to home
    if (mounted) {
      context.go(AppRoutes.home);
    }
  }

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _skipOnboarding() {
    _completeOnboarding();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: '',
      showAppBar: false,
      backgroundVariant: AppBackgroundVariant.calm,
      body: Column(
        children: [
          if (_currentPage < _totalPages - 1)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppConstants.spacingMedium,
                AppConstants.spacingMedium,
                AppConstants.spacingMedium,
                0,
              ),
              child: Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: _skipOnboarding,
                  child: const Text('Überspringen'),
                ),
              ),
            ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: const [
                _Page1Intro(),
                _Page2Disclaimer(),
                _Page3Privacy(),
                _Page4CrisisInfo(),
              ],
            ),
          ),
          OnboardingPageIndicator(
            currentPage: _currentPage,
            totalPages: _totalPages,
          ),
          const SizedBox(height: AppConstants.spacingLarge),
          Padding(
            padding: const EdgeInsets.all(AppConstants.spacingMedium),
            child: AppPrimaryButton(
              label: _currentPage < _totalPages - 1 ? 'Weiter' : 'Loslegen',
              onPressed: _nextPage,
            ),
          ),
        ],
      ),
    );
  }
}

/// Page 1: What is Innenkompass?
class _Page1Intro extends StatelessWidget {
  const _Page1Intro();

  @override
  Widget build(BuildContext context) {
    return OnboardingPage(
      title: 'Willkommen bei Innenkompass',
      description:
          'Dein Begleiter für situationsbasierte Selbstwahrnehmung und Selbstregulation. '
          'Erfasse Situationen, erkenne Muster und finde passende Interventionen.',
      icon: Icons.explore,
    );
  }
}

/// Page 2: Not a therapy replacement
class _Page2Disclaimer extends StatelessWidget {
  const _Page2Disclaimer();

  @override
  Widget build(BuildContext context) {
    return OnboardingPage(
      title: 'Kein Therapieersatz',
      description:
          'Innenkompass ist ein Selbsthilf-Tool und ersetzt keine professionelle Therapie '
          'oder ärztliche Behandlung. Bei schweren psychischen Problemen oder '
          'Krisen wende dich bitte an Fachleute.',
      icon: Icons.health_and_safety,
    );
  }
}

/// Page 3: Private and secure
class _Page3Privacy extends StatelessWidget {
  const _Page3Privacy();

  @override
  Widget build(BuildContext context) {
    return OnboardingPage(
      title: 'Privat und sicher',
      description:
          'Deine Daten gehören nur dir. Alles wird lokal auf deinem Gerät gespeichert. '
          'Keine Cloud, keine Analyse, keine Weitergabe an Dritte. '
          'Du hast die volle Kontrolle.',
      icon: Icons.lock,
    );
  }
}

/// Page 4: Crisis info
class _Page4CrisisInfo extends StatelessWidget {
  const _Page4CrisisInfo();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: OnboardingPage(
        title: 'Hilfe in Krisen',
        description:
            'Wenn du dich in einer Krise befindest oder sofort Hilfe brauchst, '
            'gibt es Unterstützung rund um die Uhr.',
        icon: Icons.phone_in_talk,
      ),
    );
  }
}
