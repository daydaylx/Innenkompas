import 'package:flutter/material.dart';

/// Warm, calm palette for Innenkompass.
class AppColors {
  AppColors._();

  // Core palette
  static const Color primary = Color(0xFFC27A60);
  static const Color primaryLight = Color(0xFFD8A28D);
  static const Color primaryDark = Color(0xFF9E5E46);
  static const Color primarySoft = Color(0xFFF2DED4);

  static const Color secondary = Color(0xFF778D7E);
  static const Color secondaryLight = Color(0xFFAABAAF);
  static const Color secondaryDark = Color(0xFF5C7063);
  static const Color secondarySoft = Color(0xFFDCE6DE);

  static const Color accent = Color(0xFF7A6172);
  static const Color accentLight = Color(0xFFCDBFC8);
  static const Color accentSoft = Color(0xFFF1E8ED);

  // Semantic colors
  static const Color success = Color(0xFF708A79);
  static const Color successLight = Color(0xFF96AA9D);
  static const Color successSoft = Color(0xFFE4ECE7);
  static const Color warning = Color(0xFFC59B63);
  static const Color warningLight = Color(0xFFE0C59F);
  static const Color warningSoft = Color(0xFFF5ECDC);
  static const Color error = Color(0xFF9F5A53);
  static const Color errorLight = Color(0xFFC9857A);
  static const Color errorSoft = Color(0xFFF2DFDB);

  // Crisis / higher-contrast safety palette
  static const Color crisis = Color(0xFF8F4F49);
  static const Color crisisSurface = Color(0xFFF5E2DE);

  // Neutrals and materials
  static const Color background = Color(0xFFF6F0EA);
  static const Color backgroundElevated = Color(0xFFFBF6F1);
  static const Color surface = Color(0xFFF9F4EF);
  static const Color surfaceStrong = Color(0xFFFFFBF8);
  static const Color surfaceVariant = Color(0xFFF0E5DC);
  static const Color surfaceMuted = Color(0xFFE7D9CD);
  static const Color onSurface = Color(0xFF2F2926);
  static const Color onSurfaceVariant = Color(0xFF5C524C);

  static const Color textPrimary = Color(0xFF332B28);
  static const Color textSecondary = Color(0xFF675A54);
  static const Color textTertiary = Color(0xFF8B7C74);
  static const Color textDisabled = Color(0xFFB7AAA3);

  static const Color border = Color(0xFFDCCFC4);
  static const Color borderLight = Color(0xFFEBE1D8);
  static const Color divider = Color(0xFFE5D8CD);

  static const Color overlay = Color(0x80332B28);
  static const Color overlayLight = Color(0x40332B28);
  static const Color glassOverlay = Color(0xCCFFF8F3);

  // Emotion colors kept muted and warm.
  static const Color emotionAnger = Color(0xFFB96A5D);
  static const Color emotionFear = Color(0xFF8A6B7C);
  static const Color emotionSadness = Color(0xFF718698);
  static const Color emotionShame = Color(0xFFB68A68);
  static const Color emotionJoy = Color(0xFF7B9078);
  static const Color emotionDisgust = Color(0xFF8D8B64);
  static const Color emotionSurprise = Color(0xFFC49B68);
  static const Color emotionGuilt = Color(0xFF938287);
  static const Color emotionPride = Color(0xFF8A6A73);
  static const Color emotionLoneliness = Color(0xFF8B93A0);

  // System state colors
  static const Color stateAcuteActivation = warning;
  static const Color stateReflectiveReady = success;
  static const Color stateRumination = accent;
  static const Color stateConflict = error;
  static const Color stateSelfDevaluation = accent;
  static const Color stateOverwhelm = primaryDark;
  static const Color stateCrisis = crisis;

  static const List<Color> intensityGradient = [
    Color(0xFF7E9887),
    Color(0xFFA9B894),
    Color(0xFFD2AF72),
    Color(0xFFC78367),
    Color(0xFFAB6056),
  ];

  // Shadows
  static const Color shadowLight = Color(0x1461493A);
  static const Color shadowMedium = Color(0x1F61493A);
  static const Color shadowDark = Color(0x33584237);

  static Color intensityColor(int rating) {
    if (rating <= 2) return intensityGradient[0];
    if (rating <= 4) return intensityGradient[1];
    if (rating <= 6) return intensityGradient[2];
    if (rating <= 8) return intensityGradient[3];
    return intensityGradient[4];
  }

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
