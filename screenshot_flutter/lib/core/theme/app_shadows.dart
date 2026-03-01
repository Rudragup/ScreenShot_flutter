import 'package:flutter/material.dart';

/// Centralised shadow tokens used across the app.
class AppShadows {
  AppShadows._();

  /// Subtle card shadow – cards, containers
  static List<BoxShadow> get cardSm => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.04),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];

  /// Standard elevation – modals, dropdowns
  static List<BoxShadow> get cardMd => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.06),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ];

  /// Heavy elevation – dialogs, overlays
  static List<BoxShadow> get cardLg => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.10),
      blurRadius: 32,
      offset: const Offset(0, 8),
    ),
  ];

  /// Branded glow for primary CTA buttons
  static List<BoxShadow> primaryGlow(Color brandColor) => [
    BoxShadow(
      color: brandColor.withValues(alpha: 0.30),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ];
}
