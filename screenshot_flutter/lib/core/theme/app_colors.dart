import 'package:flutter/material.dart';

class AppColors {
  // Prevent instantiation
  AppColors._();

  // Primary Brand Colors
  static const Color primary = Color(0xFF249FFB);
  static const Color primaryVariant = Color(0xFF3700B3);
  static const Color secondary = Color(0xFF03DAC6);
  static const Color secondaryVariant = Color(0xFF018786);
  static const Color tertiary = Color(0xFF4579A1);

  // Status Colors
  static const Color error = Color(0xFFF44336);
  static const Color success = Color(0xFF6FCF97);
  static const Color warning = Color(
    0xFFF57F17,
  ); // Added standard warning if missing
  static const Color info = Color(
    0xFF29C5F6,
  ); // using splash start as info?? or standard blue
  static const Color failure = Color(0xFFB00020);
  static const Color uploading = Color(0xFFF2994A);

  // Background & Surface
  static const Color background = Color(
    0xFFF5F5F7,
  ); // Light grey/white for modern feel
  static const Color backgroundPrimary = Color(
    0xFFF5F5F7,
  ); // Alias for consistency
  static const Color backgroundSecondary = Colors.white; // Surface
  static const Color surface = Colors.white;

  // Text Colors
  static const Color textPrimary = Color(0xFF000000); // onBackground
  static const Color textSecondary = Color(0xFF757575); // grey600
  static const Color textDisabled = Color(0xFFBDBDBD); // grey400
  static const Color textOnPrimary = Colors.white;
  static const Color textOnSecondary = Colors.black;
  static const Color textGrey = Color(0xFF8391A1); // Keep existing
  static const Color textDark = Color(0xFF212121); // Keep existing
  static const Color textDarker = Color(0xFF101828); // Keep existing
  static const Color darkBackground = Color(0xFF1D1E24);

  // Material aliases
  static const Color onPrimary = Colors.white;
  static const Color onSecondary = Colors.black;
  static const Color onBackground = Color(0xFF1D1D1F);
  static const Color onSurface = Color(0xFF1D1D1F);
  static const Color onError = Colors.white;

  // Neutrals
  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF5E5E5E);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey900 = Color(0xFF212121);
  static const Color grey = Color(0XFF4F4F4F);
  static const Color greyE9E9E9 = Color(0xFFE9E9E9);
  static const Color greyE6 = Color(0xFFE6E6E6);
  static const Color greyCDDDEA = Color(0xFFCDDDEA);
  static const Color slateGrey = Color(0xFF64748B);
  static const Color fieldstyle = Color(0xFF1E232C);
  static const Color greyD9D9D9 = Color(0xFFD9D9D9);
  static const Color greyE7 = Color(0xFFE7E7E7);
  static const Color grey36 = Color(0xFF364B63);

  // Gradients & others
  static const Color splashGradientStart = Color(0xFF28C3F6);
  static const Color splashGradientEnd = Color(0xFF238CFF);
  static const Color activeBlue = Color(0xFF249AFD);
  static const Color borderColor = Color(0xFFE3E3E3);
  static const Color bnbColor = Color(0xff7D848D);

  static const LinearGradient bgGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [splashGradientStart, splashGradientEnd],
  );

  static const LinearGradient appBarGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF29C5F6), Color(0xFF238CFF)],
  );
}
