import 'package:flutter/material.dart';
import 'colors.dart';
import 'typography.dart';
import '../../core/constants/app_constants.dart';

/// App theme for Innenkompass.
///
/// Calm UX design with muted colors, clear contrasts, and large buttons
/// for one-handed operation.
class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  // Light theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _lightColorScheme,
      textTheme: _textTheme,
      appBarTheme: _appBarTheme,
      scaffoldBackgroundColor: AppColors.background,
      cardTheme: _cardTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      textButtonTheme: _textButtonTheme,
      outlinedButtonTheme: _outlinedButtonTheme,
      inputDecorationTheme: _inputDecorationTheme,
      floatingActionButtonTheme: _floatingActionButtonTheme,
      bottomNavigationBarTheme: _bottomNavigationBarTheme,
      navigationBarTheme: _navigationBarTheme,
      snackBarTheme: _snackBarTheme,
      dialogTheme: _dialogTheme,
      bottomSheetTheme: _bottomSheetTheme,
      dividerTheme: _dividerTheme,
      sliderTheme: _sliderTheme,
      chipTheme: _chipTheme,
      progressIndicatorTheme: _progressIndicatorTheme,
      iconTheme: _iconTheme,
    );
  }

  // Dark theme (optional, can be implemented later)
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _darkColorScheme,
      textTheme: _textTheme,
      appBarTheme: _appBarTheme.copyWith(
        backgroundColor: AppColors.surfaceVariant,
        foregroundColor: AppColors.onSurface,
      ),
      scaffoldBackgroundColor: const Color(0xFF1A1A1A),
    );
  }

  // Color schemes
  static const ColorScheme _lightColorScheme = ColorScheme.light(
    primary: AppColors.primary,
    onPrimary: Colors.white,
    primaryContainer: AppColors.primaryLight,
    onPrimaryContainer: AppColors.primaryDark,
    secondary: AppColors.secondary,
    onSecondary: Colors.white,
    secondaryContainer: AppColors.secondaryLight,
    onSecondaryContainer: AppColors.secondaryDark,
    error: AppColors.error,
    onError: Colors.white,
    errorContainer: AppColors.errorLight,
    onErrorContainer: AppColors.onSurface,
    background: AppColors.background,
    onBackground: AppColors.textPrimary,
    surface: AppColors.surface,
    onSurface: AppColors.onSurface,
    surfaceVariant: AppColors.surfaceVariant,
    onSurfaceVariant: AppColors.onSurfaceVariant,
    outline: AppColors.border,
    outlineVariant: AppColors.borderLight,
  );

  static const ColorScheme _darkColorScheme = ColorScheme.dark(
    primary: AppColors.primaryLight,
    onPrimary: Colors.white,
    secondary: AppColors.secondaryLight,
    onSecondary: Colors.white,
    error: AppColors.error,
    onError: Colors.white,
    background: Color(0xFF1A1A1A),
    onBackground: AppColors.surface,
    surface: Color(0xFF2A2A2A),
    onSurface: AppColors.surface,
  );

  // Text theme
  static const TextTheme _textTheme = TextTheme(
    displayLarge: AppTypography.displayLarge,
    displayMedium: AppTypography.displayMedium,
    displaySmall: AppTypography.displaySmall,
    headlineLarge: AppTypography.headlineLarge,
    headlineMedium: AppTypography.headlineMedium,
    headlineSmall: AppTypography.headlineSmall,
    titleLarge: AppTypography.titleLarge,
    titleMedium: AppTypography.titleMedium,
    titleSmall: AppTypography.titleSmall,
    bodyLarge: AppTypography.bodyLarge,
    bodyMedium: AppTypography.bodyMedium,
    bodySmall: AppTypography.bodySmall,
    labelLarge: AppTypography.labelLarge,
    labelMedium: AppTypography.labelMedium,
    labelSmall: AppTypography.labelSmall,
  );

  // App bar theme
  static const AppBarTheme _appBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: true,
    backgroundColor: AppColors.surface,
    foregroundColor: AppColors.textPrimary,
    iconTheme: IconThemeData(color: AppColors.textPrimary),
    titleTextStyle: AppTypography.headlineSmall,
    surfaceTintColor: Colors.transparent,
  );

  // Card theme
  static CardTheme _cardTheme = CardTheme(
    elevation: AppConstants.cardElevation,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppConstants.borderRadius),
    ),
    color: AppColors.surface,
    surfaceTintColor: Colors.transparent,
    margin: const EdgeInsets.symmetric(
      horizontal: AppConstants.spacingMedium,
      vertical: AppConstants.spacingSmall,
    ),
  );

  // Elevated button theme
  static final ElevatedButtonThemeData _elevatedButtonTheme =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      minimumSize: const Size.fromHeight(AppConstants.buttonHeight),
      elevation: 0,
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spacingLarge,
        vertical: AppConstants.spacingMedium,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
      textStyle: AppTypography.labelLarge,
    ),
  );

  // Text button theme
  static final TextButtonThemeData _textButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.primary,
      minimumSize: const Size.fromHeight(AppConstants.buttonHeight),
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spacingMedium,
        vertical: AppConstants.spacingMedium,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
      textStyle: AppTypography.labelLarge,
    ),
  );

  // Outlined button theme
  static final OutlinedButtonThemeData _outlinedButtonTheme =
      OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.primary,
      minimumSize: const Size.fromHeight(AppConstants.buttonHeight),
      side: const BorderSide(color: AppColors.primary, width: 1.5),
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spacingLarge,
        vertical: AppConstants.spacingMedium,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
      textStyle: AppTypography.labelLarge,
    ),
  );

  // Input decoration theme
  static final InputDecorationTheme _inputDecorationTheme =
      InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surfaceVariant,
    contentPadding: EdgeInsets.symmetric(
      horizontal: AppConstants.spacingMedium,
      vertical: AppConstants.spacingMedium,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(AppConstants.borderRadius),
      ),
      borderSide: BorderSide(color: AppColors.border, width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(AppConstants.borderRadius),
      ),
      borderSide: BorderSide(color: AppColors.border, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(AppConstants.borderRadius),
      ),
      borderSide: BorderSide(color: AppColors.primary, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(AppConstants.borderRadius),
      ),
      borderSide: BorderSide(color: AppColors.error, width: 1),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(AppConstants.borderRadius),
      ),
      borderSide: BorderSide(color: AppColors.error, width: 2),
    ),
    labelStyle: AppTypography.bodyMedium,
    hintStyle: AppTypography.bodyMedium.copyWith(
      color: AppColors.textTertiary,
    ),
    errorStyle: AppTypography.bodySmall.copyWith(
      color: AppColors.error,
    ),
  );

  // Floating action button theme
  static const FloatingActionButtonThemeData _floatingActionButtonTheme =
      FloatingActionButtonThemeData(
    backgroundColor: AppColors.primary,
    foregroundColor: Colors.white,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
  );

  // Bottom navigation bar theme
  static const BottomNavigationBarThemeData _bottomNavigationBarTheme =
      BottomNavigationBarThemeData(
    elevation: 0,
    backgroundColor: AppColors.surface,
    selectedItemColor: AppColors.primary,
    unselectedItemColor: AppColors.textTertiary,
    selectedLabelStyle: AppTypography.labelSmall,
    unselectedLabelStyle: AppTypography.labelSmall,
    type: BottomNavigationBarType.fixed,
  );

  // Navigation bar theme (Material 3)
  static const NavigationBarThemeData _navigationBarTheme =
      NavigationBarThemeData(
    elevation: 0,
    backgroundColor: AppColors.surface,
    indicatorColor: AppColors.primaryLight,
    labelTextStyle: MaterialStatePropertyAll(AppTypography.labelSmall),
    iconTheme: MaterialStatePropertyAll(
      IconThemeData(color: AppColors.textTertiary),
    ),
  );

  // Snack bar theme
  static SnackBarThemeData _snackBarTheme = SnackBarThemeData(
    backgroundColor: AppColors.onSurface,
    contentTextStyle: AppTypography.bodyMedium.copyWith(
      color: Colors.white,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppConstants.borderRadius),
    ),
    behavior: SnackBarBehavior.floating,
    elevation: 4,
  );

  // Dialog theme
  static DialogTheme _dialogTheme = DialogTheme(
    backgroundColor: AppColors.surface,
    elevation: 8,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppConstants.borderRadius),
    ),
    titleTextStyle: AppTypography.headlineSmall,
    contentTextStyle: AppTypography.bodyMedium,
  );

  // Bottom sheet theme
  static BottomSheetThemeData _bottomSheetTheme = BottomSheetThemeData(
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppConstants.borderRadius),
      ),
    ),
    elevation: 8,
  );

  // Divider theme
  static const DividerThemeData _dividerTheme = DividerThemeData(
    color: AppColors.divider,
    thickness: 1,
    space: AppConstants.spacingMedium,
  );

  // Slider theme
  static SliderThemeData _sliderTheme = SliderThemeData(
    activeTrackColor: AppColors.primary,
    inactiveTrackColor: AppColors.borderLight,
    thumbColor: AppColors.primary,
    overlayColor: AppColors.primary.withOpacity(0.12),
    trackHeight: 4,
    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
    overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
  );

  // Chip theme
  static ChipThemeData _chipTheme = ChipThemeData(
    backgroundColor: AppColors.surfaceVariant,
    selectedColor: AppColors.primaryLight,
    labelStyle: AppTypography.labelMedium,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppConstants.borderRadius / 2),
    ),
    side: BorderSide.none,
  );

  // Progress indicator theme
  static const ProgressIndicatorThemeData _progressIndicatorTheme =
      ProgressIndicatorThemeData(
    color: AppColors.primary,
    linearTrackColor: AppColors.borderLight,
  );

  // Icon theme
  static const IconThemeData _iconTheme = IconThemeData(
    color: AppColors.textSecondary,
    size: 24,
  );

  /// Custom border radius for different components
  static BorderRadius borderRadiusSmall = BorderRadius.circular(8);
  static BorderRadius borderRadiusMedium = BorderRadius.circular(12);
  static BorderRadius borderRadiusLarge = BorderRadius.circular(16);

  /// Custom shadows
  static List<BoxShadow> shadowSmall = [
    BoxShadow(
      color: AppColors.shadowLight,
      blurRadius: 4,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> shadowMedium = [
    BoxShadow(
      color: AppColors.shadowMedium,
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> shadowLarge = [
    BoxShadow(
      color: AppColors.shadowDark,
      blurRadius: 16,
      offset: const Offset(0, 8),
    ),
  ];
}
