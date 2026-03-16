import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// App routes for Innenkompass.
///
/// All route paths and constants used throughout the app.
class AppRoutes {
  // Private constructor to prevent instantiation
  AppRoutes._();

  // Route paths
  static const String root = '/';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String newSituation = '/new-situation';
  static const String newSituationEvent = '/new-situation/event';
  static const String newSituationEmotion = '/new-situation/emotion';
  static const String newSituationThoughtImpulse =
      '/new-situation/thought-impulse';
  static const String intervention = '/intervention';
  static const String postEvaluation = '/post-evaluation';
  static const String history = '/history';
  static const String entryDetail = '/history/:id';
  static const String patterns = '/patterns';
  static const String crisis = '/crisis';
  static const String settings = '/settings';
}

/// GoRouter configuration for Innenkompass.
///
/// Uses a shell route for bottom navigation (optional).
/// All routes are protected by onboarding check.
class AppRouter {
  // Private constructor to prevent instantiation
  AppRouter._();

  /// Create the GoRouter configuration
  static GoRouter createRouter({
    required Widget Function(BuildContext) onboardingScreen,
    required Widget Function(BuildContext) homeScreen,
    required Widget Function(BuildContext) historyScreen,
    required Widget Function(BuildContext) patternsScreen,
    required Widget Function(BuildContext) crisisScreen,
    required Widget Function(BuildContext) settingsScreen,
    required Widget Function(BuildContext, GoRouterState)
        newSituationEventScreen,
    required Widget Function(BuildContext, GoRouterState)
        newSituationEmotionScreen,
    required Widget Function(BuildContext, GoRouterState)
        newSituationThoughtImpulseScreen,
    required Widget Function(BuildContext, GoRouterState) interventionScreen,
    required Widget Function(BuildContext, GoRouterState) postEvaluationScreen,
    required Widget Function(BuildContext, GoRouterState) entryDetailScreen,
    required bool Function() isOnboardingCompleted,
  }) {
    return GoRouter(
      initialLocation: AppRoutes.root,
      debugLogDiagnostics: true,
      redirect: (context, state) {
        // Check if onboarding is completed
        final onboardingCompleted = isOnboardingCompleted();

        // If trying to access root and onboarding not completed, go to onboarding
        if (state.matchedLocation == AppRoutes.root && !onboardingCompleted) {
          return AppRoutes.onboarding;
        }

        // If trying to access onboarding and already completed, go to home
        if (state.matchedLocation == AppRoutes.onboarding && onboardingCompleted) {
          return AppRoutes.home;
        }

        // If onboarding not completed and not on onboarding screen, redirect
        if (!onboardingCompleted &&
            state.matchedLocation != AppRoutes.onboarding) {
          return AppRoutes.onboarding;
        }

        // No redirect needed
        return null;
      },
      routes: [
        // Onboarding route
        GoRoute(
          path: AppRoutes.onboarding,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: onboardingScreen(context),
          ),
        ),

        // Home route
        GoRoute(
          path: AppRoutes.home,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: homeScreen(context),
          ),
        ),

        // New situation flow
        GoRoute(
          path: AppRoutes.newSituationEvent,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: newSituationEventScreen(context, state),
          ),
        ),
        GoRoute(
          path: AppRoutes.newSituationEmotion,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: newSituationEmotionScreen(context, state),
          ),
        ),
        GoRoute(
          path: AppRoutes.newSituationThoughtImpulse,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: newSituationThoughtImpulseScreen(context, state),
          ),
        ),

        // Intervention route
        GoRoute(
          path: AppRoutes.intervention,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: interventionScreen(context, state),
          ),
        ),

        // Post evaluation route
        GoRoute(
          path: AppRoutes.postEvaluation,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: postEvaluationScreen(context, state),
          ),
        ),

        // History route
        GoRoute(
          path: AppRoutes.history,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: historyScreen(context),
          ),
        ),

        // Entry detail route
        GoRoute(
          path: AppRoutes.entryDetail,
          pageBuilder: (context, state) {
            // The ID is available in state.pathParameters['id'] if needed later
            return MaterialPage(
              key: state.pageKey,
              child: entryDetailScreen(context, state),
            );
          },
        ),

        // Patterns route
        GoRoute(
          path: AppRoutes.patterns,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: patternsScreen(context),
          ),
        ),

        // Crisis route (always accessible)
        GoRoute(
          path: AppRoutes.crisis,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: crisisScreen(context),
          ),
        ),

        // Settings route
        GoRoute(
          path: AppRoutes.settings,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: settingsScreen(context),
          ),
        ),

        // Root route - redirects based on onboarding status
        GoRoute(
          path: AppRoutes.root,
          pageBuilder: (context, state) => const MaterialPage(
            key: ValueKey('splash'),
            child: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      ],

      // Error page
      errorPageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: Scaffold(
          appBar: AppBar(title: const Text('Fehler')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.red,
                ),
                const SizedBox(height: 16),
                const Text('Seite nicht gefunden'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.go(AppRoutes.home),
                  child: const Text('Zurück zum Start'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Helper method to navigate to entry detail
  static void goToEntryDetail(BuildContext context, String id) {
    context.go('/history/$id');
  }

  /// Helper method to navigate to intervention with parameters
  static void goToIntervention(
    BuildContext context, {
    required String interventionId,
    Map<String, dynamic>? extra,
  }) {
    context.go(AppRoutes.intervention, extra: {
      'interventionId': interventionId,
      ...?extra,
    });
  }

  /// Helper method to navigate back with result
  static void goBackWithResult<T>(
    BuildContext context,
    T result,
  ) {
    context.pop(result);
  }
}
