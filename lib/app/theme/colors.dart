import 'package:flutter/material.dart';

/// App color palette for Innenkompass.
///
/// Calm UX design with muted, calming colors and clear contrasts.
class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // Primary colors
  static const Color primary = Color(0xFF4A6FA5); // Calming blue
  static const Color primaryLight = Color(0xFF7A9FC7);
  static const Color primaryDark = Color(0xFF335577);

  // Secondary colors
  static const Color secondary = Color(0xFF7B8FA1); // Muted gray-blue
  static const Color secondaryLight = Color(0xFFABBFC7);
  static const Color secondaryDark = Color(0xFF556F7F);

  // Semantic colors
  static const Color success = Color(0xFF6B9080); // Soft green
  static const Color successLight = Color(0xFF9BC0B0);
  static const Color warning = Color(0xFFE9B44C); // Muted orange
  static const Color warningLight = Color(0xFFF5D47C);
  static const Color error = Color(0xFFC05C5C); // Soft red
  static const Color errorLight = Color(0xFFE08C8C);

  // Neutral colors
  static const Color background = Color(0xFFF5F5F0); // Warm white
  static const Color surface = Color(0xFFFFFFFF); // Pure white
  static const Color surfaceVariant = Color(0xFFF0F0EB);
  static const Color onSurface = Color(0xFF1A1A1A);
  static const Color onSurfaceVariant = Color(0xFF4A4A4A);

  // Text colors
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF4A4A4A);
  static const Color textTertiary = Color(0xFF7A7A7A);
  static const Color textDisabled = Color(0xFFBDBDBD);

  // Border and divider
  static const Color border = Color(0xFFE0E0E0);
  static const Color borderLight = Color(0xFFF0F0F0);
  static const Color divider = Color(0xFFE8E8E8);

  // Overlay colors
  static const Color overlay = Color(0x80000000);
  static const Color overlayLight = Color(0x40000000);

  // Emotion colors (muted versions)
  static const Color emotionAnger = Color(0xFFC05C5C); // Red
  static const Color emotionFear = Color(0xFF8B5FBF); // Purple
  static const Color emotionSadness = Color(0xFF6B8E9B); // Blue-gray
  static const Color emotionShame = Color(0xFFD4A574); // Brownish
  static const Color emotionJoy = Color(0xFF6B9080); // Green
  static const Color emotionDisgust = Color(0xFF9B8B5F); // Olive
  static const Color emotionSurprise = Color(0xFFE9B44C); // Orange
  static const Color emotionGuilt = Color(0xFF7B8FA1); // Gray-blue
  static const Color emotionPride = Color(0xFF4A6FA5); // Blue
  static const Color emotionLoneliness = Color(0xFF8899A6); // Desaturated blue

  // System state colors
  static const Color stateAcuteActivation = Color(0xFFE9B44C); // Orange
  static const Color stateReflectiveReady = Color(0xFF6B9080); // Green
  static const Color stateRumination = Color(0xFF7B8FA1); // Gray-blue
  static const Color stateConflict = Color(0xFFC05C5C); // Red
  static const Color stateSelfDevaluation = Color(0xFF8B5FBF); // Purple
  static const Color stateOverwhelm = Color(0xFFD4A574); // Brownish
  static const Color stateCrisis = Color(0xFFB03030); // Dark red

  // Intensity colors (gradient from green to red)
  static const List<Color> intensityGradient = [
    Color(0xFF6B9080), // 1-2: Good/OK
    Color(0xFF9BB57D), // 3-4: Mostly OK
    Color(0xFFE9B44C), // 5-6: Moderate
    Color(0xFFD4845C), // 7-8: High
    Color(0xFFC05C5C), // 9-10: Severe
  ];

  // Shadows
  static const Color shadowLight = Color(0x1A000000);
  static const Color shadowMedium = Color(0x33000000);
  static const Color shadowDark = Color(0x4D000000);

  /// Get intensity color based on rating (1-10)
  static Color intensityColor(int rating) {
    if (rating <= 2) return intensityGradient[0];
    if (rating <= 4) return intensityGradient[1];
    if (rating <= 6) return intensityGradient[2];
    if (rating <= 8) return intensityGradient[3];
    return intensityGradient[4];
  }

  /// Get color for emotion type
  static Color emotionColor(String emotionType) {
    switch (emotionType.toLowerCase()) {
      case 'wut':
      case 'anger':
        return emotionAnger;
      case 'angst':
      case 'fear':
        return emotionFear;
      case 'trauer':
      case 'sadness':
        return emotionSadness;
      case 'scham':
      case 'shame':
        return emotionShame;
      case 'freude':
      case 'joy':
        return emotionJoy;
      case 'ekel':
      case 'disgust':
        return emotionDisgust;
      case 'überraschung':
      case 'surprise':
        return emotionSurprise;
      case 'schuld':
      case 'guilt':
        return emotionGuilt;
      case 'stolz':
      case 'pride':
        return emotionPride;
      case 'einsamkeit':
      case 'loneliness':
        return emotionLoneliness;
      default:
        return secondary;
    }
  }
}
