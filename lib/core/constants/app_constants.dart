/// Application-wide constants for Innenkompass.
class AppConstants {
  // Private constructor to prevent instantiation
  AppConstants._();

  // App Information
  static const String appName = 'Innenkompass';
  static const String appVersion = '1.0.0';
  static const String organization = 'dev.innenkompass';

  // Validation Constants
  static const int minSituationDescriptionLength = 3;
  static const int maxSituationDescriptionLength = 300;
  static const int maxThoughtDescriptionLength = 200;
  static const int maxBehaviorDescriptionLength = 300;
  static const int minReflectionFieldLength = 3;
  static const int maxNeedDescriptionLength = 240;
  static const int maxNextStepLength = 240;
  static const int maxNoteLength = 500;

  // Rating scales
  static const int minIntensityRating = 1;
  static const int maxIntensityRating = 10;
  static const int minBodyTensionRating = 1;
  static const int maxBodyTensionRating = 10;
  static const int minClarityRating = 1;
  static const int maxClarityRating = 10;
  static const int minHelpfulnessRating = 1;
  static const int maxHelpfulnessRating = 5;

  // Time constants
  static const int defaultInterventionDurationSec = 300; // 5 minutes
  static const int minBreathingCycleDuration = 4; // seconds
  static const int maxBreathingCycleDuration = 6; // seconds
  static const int minPauseDurationSec = 30;
  static const int maxPauseDurationSec = 300;

  // Database
  static const String databaseName = 'innenkompass.db';
  static const int databaseVersion = 4;

  // Pagination
  static const int defaultHistoryPageSize = 20;
  static const int defaultPatternAnalysisMinEntries = 3;

  // Pattern analysis
  static const int minEntriesForPatternAnalysis = 3;
  static const int minEntriesForTrendAnalysis = 5;

  // Storage keys
  static const String keyOnboardingCompleted = 'onboarding_completed';
  static const String keyNotificationsEnabled = 'notifications_enabled';
  static const String keyLocale = 'locale';
  static const String keyAppLockEnabled = 'app_lock_enabled';
  static const String keyFirstLaunch = 'first_launch';

  // Default values
  static const String defaultLocale = 'de';
  static const bool defaultNotificationsEnabled = false;
  static const bool defaultAppLockEnabled = false;

  // Crisis resources
  static const String germanCrisisHotline = '0800 111 0 111';
  static const String germanCrisisHotlineAlternative = '0800 111 0 222';
  static const String germanEmergencyNumber = '112';

  // Animation durations (in milliseconds)
  static const int animationDurationFast = 150;
  static const int animationDurationNormal = 300;
  static const int animationDurationSlow = 500;

  // Layout
  static const double buttonHeight = 60.0;
  static const double cardElevation = 0.0;
  static const double borderRadius = 20.0;
  static const double borderRadiusLarge = 28.0;
  static const double borderRadiusPill = 999.0;
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 16.0;
  static const double spacingLarge = 24.0;
  static const double spacingXLarge = 32.0;

  // Text styles
  static const double fontSizeSmall = 14.0;
  static const double fontSizeNormal = 16.0;
  static const double fontSizeLarge = 18.0;
  static const double fontSizeXLarge = 24.0;
  static const double fontSizeXXLarge = 32.0;

  // Body symptoms (for selection)
  static const List<String> commonBodySymptoms = [
    'Herzrasen',
    'Enge in der Brust',
    'Kloß im Hals',
    'Zittern',
    'Schwitzen',
    'Kopfdruck',
    'Magendruck',
    'Muskelverspannung',
    'Atemnot',
    'Schwindel',
    'Taubheitsgefühl',
    'Hitzewallung',
    'Kältegefühl',
    'Übelkeit',
    'Sonstiges',
  ];

  // Emergency contact labels
  static const List<String> emergencyContactLabels = [
    'Partner/in',
    'Elternteil',
    'Geschwister',
    'Freund/in',
    'Kollege/in',
    'Therapeut/in',
    'Arzt/Ärztin',
    'Sonstiges',
  ];
}
