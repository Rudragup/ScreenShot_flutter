import 'package:flutter/material.dart';

/// Centralised sizing constants for the app.
/// Use these for consistent border radii, icon sizes, elevations, and
/// any other dimension not covered by [AppSpacings].
class AppSizing {
  AppSizing._();

  // ─── Border Radii ──────────────────────────────────────────────────────
  static const double radiusXs = 4.0;
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 20.0;
  static const double radiusXxl = 24.0;
  static const double radiusRound = 100.0;

  static const BorderRadius borderRadiusSm = BorderRadius.all(
    Radius.circular(radiusSm),
  );
  static const BorderRadius borderRadiusMd = BorderRadius.all(
    Radius.circular(radiusMd),
  );
  static const BorderRadius borderRadiusLg = BorderRadius.all(
    Radius.circular(radiusLg),
  );
  static const BorderRadius borderRadiusXl = BorderRadius.all(
    Radius.circular(radiusXl),
  );
  static const BorderRadius borderRadiusXxl = BorderRadius.all(
    Radius.circular(radiusXxl),
  );
  static const BorderRadius borderRadiusRound = BorderRadius.all(
    Radius.circular(radiusRound),
  );

  // ─── Icon Sizes ────────────────────────────────────────────────────────
  static const double iconXs = 16.0;
  static const double iconSm = 20.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;
  static const double iconXl = 48.0;
  static const double iconXxl = 64.0;
  static const double iconHero = 80.0;

  // ─── Elevation ─────────────────────────────────────────────────────────
  static const double elevationNone = 0.0;
  static const double elevationSm = 2.0;
  static const double elevationMd = 4.0;
  static const double elevationLg = 8.0;
  static const double elevationXl = 16.0;

  // ─── Button Heights ────────────────────────────────────────────────────
  static const double buttonHeightSm = 40.0;
  static const double buttonHeightMd = 50.0;
  static const double buttonHeightLg = 56.0;

  // ─── Avatar / Logo ────────────────────────────────────────────────────
  static const double avatarSm = 32.0;
  static const double avatarMd = 48.0;
  static const double avatarLg = 64.0;
  static const double avatarXl = 96.0;

  // ─── Misc ──────────────────────────────────────────────────────────────
  static const double dividerThickness = 1.0;
  static const double inputBorderWidth = 1.5;
  static const double progressStrokeWidth = 3.0;
}
