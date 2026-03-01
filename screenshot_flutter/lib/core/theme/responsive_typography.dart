import 'package:flutter/material.dart';

class ResponsiveTypography {
  ResponsiveTypography._();
  static TextStyle getResponsiveStyle(
    BuildContext context,
    TextStyle baseStyle,
  ) {
    final width = MediaQuery.of(context).size.width;
    final scaleFactor = width / 375;

    final effectiveScale = scaleFactor > 1.3
        ? 1.3
        : (scaleFactor < 0.7 ? 0.7 : scaleFactor);
    final double currentFontSize = baseStyle.fontSize ?? 14.0;
    final scaledSize = currentFontSize * effectiveScale;

    return baseStyle.copyWith(fontSize: scaledSize);
  }
}

extension ResponsiveTextExtension on TextStyle {
  TextStyle responsive(BuildContext context) {
    return ResponsiveTypography.getResponsiveStyle(context, this);
  }
}
