import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../../app/router.dart';
import '../../core/constants/app_constants.dart';
import 'database_provider.dart';

/// Provider for the GoRouter instance.
///
/// This is the main router provider that depends on onboarding status
/// and database initialization.
final routerProvider = Provider<GoRouter>((ref) {
  // Watch the database initialization to ensure it's ready
  ref.watch(databaseInitProvider);

  // For now, default to false (not completed) since we need synchronous access
  // This will be updated when the onboarding flow is implemented
  bool isOnboardingCompleted() => false;

  return AppRouter.createRouter(
    onboardingScreen: (context) => const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    ),
    homeScreen: (context) => const Scaffold(
      body: Center(
        child: Text('Home Screen - To be implemented'),
      ),
    ),
    historyScreen: (context) => const Scaffold(
      body: Center(
        child: Text('History Screen - To be implemented'),
      ),
    ),
    patternsScreen: (context) => const Scaffold(
      body: Center(
        child: Text('Patterns Screen - To be implemented'),
      ),
    ),
    crisisScreen: (context) => const Scaffold(
      body: Center(
        child: Text('Crisis Screen - To be implemented'),
      ),
    ),
    settingsScreen: (context) => const Scaffold(
      body: Center(
        child: Text('Settings Screen - To be implemented'),
      ),
    ),
    newSituationEventScreen: (context, state) => const Scaffold(
      body: Center(
        child: Text('New Situation Event Screen - To be implemented'),
      ),
    ),
    newSituationEmotionScreen: (context, state) => const Scaffold(
      body: Center(
        child: Text('New Situation Emotion Screen - To be implemented'),
      ),
    ),
    newSituationThoughtImpulseScreen: (context, state) => const Scaffold(
      body: Center(
        child: Text('New Situation Thought Impulse Screen - To be implemented'),
      ),
    ),
    interventionScreen: (context, state) => const Scaffold(
      body: Center(
        child: Text('Intervention Screen - To be implemented'),
      ),
    ),
    postEvaluationScreen: (context, state) => const Scaffold(
      body: Center(
        child: Text('Post Evaluation Screen - To be implemented'),
      ),
    ),
    entryDetailScreen: (context, state) => const Scaffold(
      body: Center(
        child: Text('Entry Detail Screen - To be implemented'),
      ),
    ),
    isOnboardingCompleted: isOnboardingCompleted,
  );
});

/// Provider for app initialization status.
///
/// This provider can be used to show a splash screen while the app
/// initializes (database, settings, etc.)
final appInitProvider = Provider<bool>((ref) {
  final databaseInit = ref.watch(databaseInitProvider);
  // Add other initialization providers here as needed
  return databaseInit;
});

/// Provider for the current locale/language.
///
/// Default is 'de' (German), can be changed to 'en' (English).
final localeProvider = Provider<String>((ref) {
  // For Phase 1, use default locale. Will be updated from settings in Phase 2.
  return AppConstants.defaultLocale;
});

/// Provider for notifications enabled status.
final notificationsEnabledProvider = Provider<bool>((ref) {
  // For Phase 1, use default. Will be updated from settings in Phase 2.
  return AppConstants.defaultNotificationsEnabled;
});

/// Provider for app lock enabled status.
final appLockEnabledProvider = Provider<bool>((ref) {
  // For Phase 1, use default. Will be updated from settings in Phase 2.
  return AppConstants.defaultAppLockEnabled;
});
