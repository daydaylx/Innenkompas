import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';
import 'colors.dart';
import 'typography.dart';

/// App theme for Innenkompass.
class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: _lightColorScheme,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: _textTheme,
      cardTheme: _cardTheme,
      appBarTheme: _appBarTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      outlinedButtonTheme: _outlinedButtonTheme,
      textButtonTheme: _textButtonTheme,
      inputDecorationTheme: _inputDecorationTheme,
      sliderTheme: _sliderTheme,
      chipTheme: _chipTheme,
      progressIndicatorTheme: _progressIndicatorTheme,
      bottomSheetTheme: _bottomSheetTheme,
      snackBarTheme: _snackBarTheme,
      dividerTheme: _dividerTheme,
      navigationBarTheme: _navigationBarTheme,
      dialogTheme: _dialogTheme,
      iconTheme: const IconThemeData(
        color: AppColors.textSecondary,
        size: 22,
      ),
    );

    return base.copyWith(
      splashFactory: InkSparkle.splashFactory,
    );
  }

  static ThemeData get darkTheme => lightTheme;

  static const ColorScheme _lightColorScheme = ColorScheme.light(
    primary: AppColors.primary,
    onPrimary: Colors.white,
    primaryContainer: AppColors.primarySoft,
    onPrimaryContainer: AppColors.textPrimary,
    secondary: AppColors.secondary,
    onSecondary: Colors.white,
    secondaryContainer: AppColors.secondarySoft,
    onSecondaryContainer: AppColors.textPrimary,
    tertiary: AppColors.accent,
    error: AppColors.error,
    onError: Colors.white,
    errorContainer: AppColors.errorSoft,
    onErrorContainer: AppColors.textPrimary,
    surface: AppColors.surfaceStrong,
    onSurface: AppColors.textPrimary,
    surfaceContainerHighest: AppColors.surfaceVariant,
    onSurfaceVariant: AppColors.textSecondary,
    outline: AppColors.border,
    outlineVariant: AppColors.borderLight,
  );

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

  static const AppBarTheme _appBarTheme = AppBarTheme(
    centerTitle: false,
    elevation: 0,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    foregroundColor: AppColors.textPrimary,
    iconTheme: IconThemeData(
      color: AppColors.textPrimary,
      size: 22,
    ),
    titleTextStyle: AppTypography.titleLarge,
    surfaceTintColor: Colors.transparent,
  );

  static final CardThemeData _cardTheme = CardThemeData(
    margin: EdgeInsets.zero,
    color: AppColors.surfaceStrong,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    shadowColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
      side: const BorderSide(
        color: AppColors.borderLight,
      ),
    ),
  );

  static final ElevatedButtonThemeData _elevatedButtonTheme =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      disabledBackgroundColor: AppColors.textDisabled,
      disabledForegroundColor: Colors.white70,
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

  static final OutlinedButtonThemeData _outlinedButtonTheme =
      OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.textPrimary,
      backgroundColor: AppColors.surfaceStrong.withValues(alpha: 0.72),
      minimumSize: const Size.fromHeight(AppConstants.buttonHeight),
      side: const BorderSide(
        color: AppColors.border,
      ),
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

  static final TextButtonThemeData _textButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.primaryDark,
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spacingMedium,
        vertical: AppConstants.spacingSmall,
      ),
      textStyle: AppTypography.labelLarge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
    ),
  );

  static final InputDecorationTheme _inputDecorationTheme =
      InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surfaceStrong.withValues(alpha: 0.94),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: AppConstants.spacingMedium,
      vertical: AppConstants.spacingMedium,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      borderSide: const BorderSide(color: AppColors.borderLight),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      borderSide: const BorderSide(color: AppColors.border),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      borderSide: const BorderSide(color: AppColors.error),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      borderSide: const BorderSide(color: AppColors.error, width: 1.5),
    ),
    hintStyle: AppTypography.bodyMedium.copyWith(
      color: AppColors.textTertiary,
    ),
    helperStyle: AppTypography.bodySmall.copyWith(
      color: AppColors.textTertiary,
    ),
    errorStyle: AppTypography.bodySmall.copyWith(
      color: AppColors.error,
    ),
  );

  static final SliderThemeData _sliderTheme = SliderThemeData(
    activeTrackColor: AppColors.primary,
    inactiveTrackColor: AppColors.borderLight,
    thumbColor: AppColors.primaryDark,
    overlayColor: AppColors.primary.withValues(alpha: 0.12),
    trackHeight: 6,
    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
    overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
    valueIndicatorColor: AppColors.primaryDark,
    valueIndicatorTextStyle: AppTypography.labelSmall.copyWith(
      color: Colors.white,
    ),
  );

  static final ChipThemeData _chipTheme = ChipThemeData(
    backgroundColor: AppColors.surfaceStrong.withValues(alpha: 0.88),
    selectedColor: AppColors.primarySoft,
    disabledColor: AppColors.surfaceVariant,
    secondarySelectedColor: AppColors.primarySoft,
    padding: const EdgeInsets.symmetric(
      horizontal: AppConstants.spacingSmall,
      vertical: 6,
    ),
    labelStyle: AppTypography.labelMedium.copyWith(
      color: AppColors.textPrimary,
    ),
    secondaryLabelStyle: AppTypography.labelMedium.copyWith(
      color: AppColors.textPrimary,
    ),
    brightness: Brightness.light,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      side: const BorderSide(color: AppColors.borderLight),
    ),
  );

  static const ProgressIndicatorThemeData _progressIndicatorTheme =
      ProgressIndicatorThemeData(
    color: AppColors.primary,
    linearTrackColor: AppColors.borderLight,
  );

  static final BottomSheetThemeData _bottomSheetTheme = BottomSheetThemeData(
    backgroundColor: AppColors.backgroundElevated,
    surfaceTintColor: Colors.transparent,
    modalBackgroundColor: AppColors.backgroundElevated,
    elevation: 0,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppConstants.borderRadiusLarge),
      ),
    ),
  );

  static final SnackBarThemeData _snackBarTheme = SnackBarThemeData(
    backgroundColor: AppColors.textPrimary,
    contentTextStyle: AppTypography.bodyMedium.copyWith(
      color: Colors.white,
    ),
    actionTextColor: AppColors.primaryLight,
    behavior: SnackBarBehavior.floating,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppConstants.borderRadius),
    ),
  );

  static const DividerThemeData _dividerTheme = DividerThemeData(
    color: AppColors.divider,
    thickness: 1,
    space: AppConstants.spacingLarge,
  );

  static final NavigationBarThemeData _navigationBarTheme =
      NavigationBarThemeData(
    elevation: 0,
    backgroundColor: AppColors.backgroundElevated.withValues(alpha: 0.96),
    surfaceTintColor: Colors.transparent,
    indicatorColor: AppColors.primarySoft,
    iconTheme: WidgetStateProperty.resolveWith(
      (states) => IconThemeData(
        color: states.contains(WidgetState.selected)
            ? AppColors.primaryDark
            : AppColors.textTertiary,
      ),
    ),
    labelTextStyle: WidgetStateProperty.resolveWith(
      (states) => AppTypography.labelSmall.copyWith(
        color: states.contains(WidgetState.selected)
            ? AppColors.primaryDark
            : AppColors.textTertiary,
      ),
    ),
  );

  static final DialogThemeData _dialogTheme = DialogThemeData(
    backgroundColor: AppColors.backgroundElevated,
    surfaceTintColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
    ),
    titleTextStyle: AppTypography.headlineSmall.copyWith(
      color: AppColors.textPrimary,
    ),
    contentTextStyle: AppTypography.bodyMedium.copyWith(
      color: AppColors.textSecondary,
    ),
  );

  static List<BoxShadow> get softShadow => const [
        BoxShadow(
          color: AppColors.shadowLight,
          blurRadius: 24,
          offset: Offset(0, 10),
        ),
      ];

  static List<BoxShadow> get floatingShadow => const [
        BoxShadow(
          color: AppColors.shadowMedium,
          blurRadius: 32,
          offset: Offset(0, 14),
        ),
      ];
}
