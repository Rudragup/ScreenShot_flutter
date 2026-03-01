import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:screenshot_flutter/core/theme/app_colors.dart';

class AppTypography {
  // Prevent instantiation
  AppTypography._();

  // Font Weights
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;

  // Font Sizes
  static const double displayLargeSize = 57.0;
  static const double displayMediumSize = 45.0;
  static const double displaySmallSize = 36.0;

  static const double headlineLargeSize = 32.0;
  static const double headlineMediumSize = 28.0;
  static const double headlineSmallSize = 24.0;

  static const double titleLargeSize = 22.0;
  static const double titleMediumSize = 16.0;
  static const double titleSmallSize = 14.0;

  static const double bodyLargeSize = 16.0;
  static const double bodyMediumSize = 14.0;
  static const double bodySmallSize = 12.0;

  static const double labelLargeSize = 14.0;
  static const double labelMediumSize = 12.0;
  static const double labelSmallSize = 11.0;

  // Display Styles
  static TextStyle get displayLarge => GoogleFonts.manrope(
    fontSize: displayLargeSize,
    fontWeight: regular,
    height: 1.1, // Adjusted standard height
    letterSpacing: -0.25,
    color: AppColors.textPrimary,
  );

  static TextStyle get displayMedium => GoogleFonts.manrope(
    fontSize: displayMediumSize,
    fontWeight: regular,
    height: 1.1,
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  static TextStyle get displaySmall => GoogleFonts.urbanist(
    fontSize: displaySmallSize,
    fontWeight: regular,
    color: AppColors.textPrimary,
  );

  // Headline Styles
  static TextStyle get headlineLarge => GoogleFonts.manrope(
    fontSize: headlineLargeSize,
    fontWeight: regular,
    color: AppColors.textPrimary,
  );

  static TextStyle get headlineMedium => GoogleFonts.manrope(
    fontSize: headlineMediumSize,
    fontWeight: regular,
    color: AppColors.textPrimary,
  );

  static TextStyle get headlineSmall => GoogleFonts.manrope(
    fontSize: headlineSmallSize,
    fontWeight: regular,
    color: AppColors.textPrimary,
  );

  // Title Styles
  static TextStyle get titleLarge => GoogleFonts.manrope(
    fontSize: titleLargeSize,
    fontWeight: medium,
    color: AppColors.textPrimary,
  );

  static TextStyle get titleMedium => GoogleFonts.manrope(
    fontSize: titleMediumSize,
    fontWeight: medium,
    color: AppColors.textPrimary,
  );

  static TextStyle get titleSmall => GoogleFonts.manrope(
    fontSize: titleSmallSize,
    fontWeight: medium,
    color: AppColors.textPrimary,
  );

  // Body Styles
  static TextStyle get bodyLarge => GoogleFonts.manrope(
    fontSize: bodyLargeSize,
    fontWeight: medium,
    color: AppColors.textPrimary,
  );

  static TextStyle get bodyMedium => GoogleFonts.manrope(
    fontSize: bodyMediumSize,
    fontWeight: regular,
    color: AppColors.textPrimary,
  );

  static TextStyle get bodySmall => GoogleFonts.manrope(
    fontSize: bodySmallSize,
    fontWeight: regular,
    color: AppColors.textPrimary,
  );

  // Label Styles
  static TextStyle get labelLarge => GoogleFonts.manrope(
    fontSize: labelLargeSize,
    fontWeight: medium,
    color: AppColors.textSecondary,
  );

  static TextStyle get labelMedium => GoogleFonts.manrope(
    fontSize: labelMediumSize,
    fontWeight: medium,
    color: AppColors.textSecondary,
  );

  static TextStyle get labelSmall => GoogleFonts.manrope(
    fontSize: labelSmallSize,
    fontWeight: medium,
    color: AppColors.textSecondary,
  );

  // Legacy/Custom Styles (Preserved)
  static TextStyle get buttonText => GoogleFonts.manrope(
    fontSize: 17,
    fontWeight: semiBold,
    color: AppColors.onPrimary,
  );

  static TextStyle get authHeading => GoogleFonts.manrope(
    fontSize: 30,
    fontWeight: bold,
    color: AppColors.textPrimary,
  );

  static TextStyle get onboardingTitle => GoogleFonts.manrope(
    fontSize: 30,
    fontWeight: bold,
    color: AppColors.textDarker,
  );

  static TextStyle get onboardingDescription => GoogleFonts.manrope(
    fontSize: 16,
    fontWeight: regular,
    color: AppColors.textDarker,
  );

  static TextStyle get dashboardTitle => GoogleFonts.manrope(
    fontSize: 17,
    fontWeight: semiBold,
    color: AppColors.textDark, // Replaced hex with named color
  );

  // Backward compatibility & Theme Bridge
  static TextTheme get textTheme => TextTheme(
    displayLarge: displayLarge,
    displayMedium: displayMedium,
    displaySmall: displaySmall,
    headlineLarge: headlineLarge,
    headlineMedium: headlineMedium,
    headlineSmall: headlineSmall,
    titleLarge: titleLarge,
    titleMedium: titleMedium,
    titleSmall: titleSmall,
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
    bodySmall: bodySmall,
    labelLarge: labelLarge,
    labelMedium: labelMedium,
    labelSmall: labelSmall,
  );
}

// Extension Methods for common variants
extension TextStyleExtensions on TextStyle {
  TextStyle get extraaBold => copyWith(fontWeight: FontWeight.w900);
  TextStyle get extraBold => copyWith(fontWeight: FontWeight.w800);
  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);
  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);
  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);
  TextStyle get light => copyWith(fontWeight: FontWeight.w300);

  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);
  TextStyle get underlined => copyWith(decoration: TextDecoration.underline);

  TextStyle withColor(Color color) => copyWith(color: color);
  TextStyle withSize(double size) => copyWith(fontSize: size);
}
