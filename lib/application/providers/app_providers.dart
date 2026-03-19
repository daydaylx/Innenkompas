import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../../app/router.dart';
import '../../core/constants/app_constants.dart';
import '../../features/onboarding/screens/onboarding_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/splash/screens/splash_screen.dart';
import '../../features/settings/screens/settings_screen.dart';
import '../../features/new_situation/screens/situation_event_screen.dart';
import '../../features/new_situation/screens/situation_emotion_screen.dart';
import '../../features/new_situation/screens/situation_thought_impulse_screen.dart';
import '../../features/new_situation/screens/situation_reflection_screen.dart';
import '../../features/crisis/screens/crisis_screen.dart';
import '../../features/crisis/screens/crisis_plan_edit_screen.dart';
import '../../features/history/screens/history_screen.dart';
import '../../features/history/screens/entry_detail_screen.dart';
import '../../features/lock/screens/lock_screen.dart';
import '../../features/patterns/screens/patterns_screen.dart';
import '../../features/intervention/screens/intervention_screen.dart';
import '../../features/intervention/screens/post_evaluation_screen.dart';
import '../../features/evaluation/screens/entry_evaluation_screen.dart';
import '../../features/new_situation/screens/quick_checkin_screen.dart';
import 'bootstrap_provider.dart';
import 'database_provider.dart';
import 'lock_provider.dart';
import 'settings_provider.dart';

/// Provider for the GoRouter instance.
///
/// This is the main router provider that depends on onboarding status
/// and database initialization.
final routerProvider = Provider<GoRouter>((ref) {
  ref.watch(databaseInitProvider);
  final bootstrapState = ref.watch(appBootstrapProvider);
  final settings = ref.watch(settingsNotifierProvider);
  final lockState = ref.watch(lockStateProvider);

  // Check onboarding status from settings provider
  bool isOnboardingCompleted() {
    return settings?.onboardingCompleted ?? false;
  }

  bool isAppLocked() {
    return lockState.isLocked;
  }

  bool isAppReady() {
    return bootstrapState.hasValue && !lockState.isLoading && settings != null;
  }

  return AppRouter.createRouter(
    splashScreen: (context) => const SplashScreen(),
    onboardingScreen: (context) => const OnboardingScreen(),
    homeScreen: (context) => const HomeScreen(),
    historyScreen: (context) => const HistoryScreen(),
    patternsScreen: (context) => const PatternsScreen(),
    crisisScreen: (context) => const CrisisScreen(),
    crisisEditScreen: (context) => const CrisisPlanEditScreen(),
    settingsScreen: (context) => const SettingsScreen(),
    lockScreen: (context) => const LockScreen(),
    newSituationEventScreen: (context, state) => const SituationEventScreen(),
    newSituationEmotionScreen: (context, state) =>
        const SituationEmotionScreen(),
    newSituationThoughtImpulseScreen: (context, state) =>
        const SituationThoughtImpulseScreen(),
    newSituationReflectionScreen: (context, state) =>
        const SituationReflectionScreen(),
    interventionScreen: (context, state) => InterventionScreen(
      interventionId: state.uri.queryParameters['id'] ??
          ((state.extra is Map<String, dynamic>)
              ? ((state.extra as Map<String, dynamic>)['interventionId']
                      as String?) ??
                  ((state.extra as Map<String, dynamic>)['type'] as String?)
              : null),
    ),
    postEvaluationScreen: (context, state) => const PostEvaluationScreen(),
    entryEvaluationScreen: (context, state) {
      final id = int.tryParse(state.pathParameters['id'] ?? '');
      if (id == null) {
        return const Scaffold(
          body: Center(
            child: Text('Eintrag nicht gefunden'),
          ),
        );
      }
      return EntryEvaluationScreen(entryId: id);
    },
    entryDetailScreen: (context, state) {
      final id = int.tryParse(state.pathParameters['id'] ?? '');
      if (id == null) {
        return const Scaffold(
          body: Center(
            child: Text('Eintrag nicht gefunden'),
          ),
        );
      }
      return EntryDetailScreen(entryId: id);
    },
    isOnboardingCompleted: isOnboardingCompleted,
    isAppLocked: isAppLocked,
    isAppReady: isAppReady,
    quickCheckinScreen: (context) => const QuickCheckinScreen(),
  );
});

/// Provider for app initialization status.
///
/// This provider can be used to show a splash screen while the app
/// initializes (database, settings, etc.)
final appInitProvider = Provider<bool>((ref) {
  final bootstrapState = ref.watch(appBootstrapProvider);
  return bootstrapState.hasValue;
});

/// Provider for the current locale/language.
///
/// Default is 'de' (German), can be changed to 'en' (English).
final localeProvider = Provider<String>((ref) {
  // Watch settings provider for reactive locale updates
  final settings = ref.watch(settingsNotifierProvider);
  return settings?.locale ?? AppConstants.defaultLocale;
});

/// Provider for notifications enabled status.
final notificationsEnabledProvider = Provider<bool>((ref) {
  // Watch settings provider for reactive notification updates
  final settings = ref.watch(settingsNotifierProvider);
  return settings?.notificationsEnabled ??
      AppConstants.defaultNotificationsEnabled;
});

/// Provider for app lock enabled status.
final appLockEnabledProvider = Provider<bool>((ref) {
  final lockState = ref.watch(lockStateProvider);
  return lockState.isEnabled;
});
