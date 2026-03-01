import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screenshot_flutter/core/theme/app_colors.dart';
import 'package:screenshot_flutter/core/theme/app_sizing.dart';
import 'package:screenshot_flutter/core/theme/app_typography.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: 'Manrope',

      // ─── Color Scheme ────────────────────────────────────────────
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        error: AppColors.error,
        onPrimary: AppColors.onPrimary,
        onSecondary: AppColors.onSecondary,
        onSurface: AppColors.onSurface,
        onError: AppColors.onError,
      ),

      // ─── Text Theme ──────────────────────────────────────────────
      textTheme: AppTypography.textTheme,

      // ─── AppBar ──────────────────────────────────────────────────
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.textPrimary,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: AppTypography.titleMedium.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),

      // ─── Input Decoration ────────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        hintStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.textDisabled,
        ),
        labelStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.textSecondary,
        ),
        errorStyle: AppTypography.labelSmall.copyWith(color: AppColors.error),
        prefixIconColor: AppColors.textSecondary,
        suffixIconColor: AppColors.textSecondary,
        border: OutlineInputBorder(
          borderRadius: AppSizing.borderRadiusMd,
          borderSide: const BorderSide(color: AppColors.grey300, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppSizing.borderRadiusMd,
          borderSide: const BorderSide(color: AppColors.grey300, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppSizing.borderRadiusMd,
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppSizing.borderRadiusMd,
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppSizing.borderRadiusMd,
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: AppSizing.borderRadiusMd,
          borderSide: BorderSide(color: AppColors.grey200, width: 1),
        ),
      ),

      // ─── Elevated Button ─────────────────────────────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          minimumSize: const Size(double.infinity, AppSizing.buttonHeightLg),
          shape: RoundedRectangleBorder(borderRadius: AppSizing.borderRadiusMd),
          textStyle: AppTypography.buttonText,
        ),
      ),

      // ─── Outlined Button ──────────────────────────────────────────
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          minimumSize: const Size(double.infinity, AppSizing.buttonHeightLg),
          shape: RoundedRectangleBorder(borderRadius: AppSizing.borderRadiusMd),
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          textStyle: AppTypography.buttonText.copyWith(
            color: AppColors.primary,
          ),
        ),
      ),

      // ─── Text Button ──────────────────────────────────────────────
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: AppTypography.labelLarge.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ─── Snack Bar ────────────────────────────────────────────────
      snackBarTheme: SnackBarThemeData(
        dismissDirection: DismissDirection.horizontal,
        elevation: 0,
        backgroundColor: AppColors.grey900,
        contentTextStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.onPrimary,
        ),
        actionTextColor: AppColors.splashGradientStart,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: AppSizing.borderRadiusMd),
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),

      // ─── Dialog ───────────────────────────────────────────────────
      dialogTheme: DialogThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: AppSizing.borderRadiusXl),
        backgroundColor: AppColors.surface,
        titleTextStyle: AppTypography.titleLarge.copyWith(
          fontWeight: FontWeight.w700,
        ),
        contentTextStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.textSecondary,
        ),
      ),

      // ─── Bottom Sheet ─────────────────────────────────────────────
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppSizing.radiusXl),
          ),
        ),
      ),

      // ─── Divider ──────────────────────────────────────────────────
      dividerTheme: const DividerThemeData(
        color: AppColors.grey200,
        thickness: AppSizing.dividerThickness,
        space: 0,
      ),

      // ─── Time Picker (Preserved) ──────────────────────────────────
      timePickerTheme: TimePickerThemeData(
        dayPeriodColor: AppColors.primary,
        dayPeriodBorderSide: const BorderSide(
          color: AppColors.primary,
          width: 1,
        ),
        helpTextStyle: AppTypography.titleMedium.copyWith(
          color: AppColors.primary,
        ),
      ),

      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    );
  }
}
