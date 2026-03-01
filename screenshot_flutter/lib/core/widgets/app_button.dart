import 'package:flutter/material.dart';
import 'package:screenshot_flutter/core/theme/app_colors.dart';
import 'package:screenshot_flutter/core/theme/app_typography.dart';
import 'package:screenshot_flutter/core/theme/responsive_typography.dart';

enum AppButtonType { elevated, outlined, text }

enum AppButtonIconPosition { start, end }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final Widget? icon;
  final AppButtonIconPosition iconPosition;
  final double? width;
  final double height;
  final Gradient? gradient;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final TextStyle? textStyle;
  final double borderRadius;
  final bool isLoading;
  final EdgeInsets? padding;
  final Color? shadowColor;
  final BorderRadius? borderShape;
  const AppButton({
    super.key,
    this.padding,
    required this.text,
    this.onPressed,
    this.type = AppButtonType.elevated,
    this.icon,
    this.iconPosition = AppButtonIconPosition.end,
    this.width = double.infinity,
    this.height = 50,
    this.gradient,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.textStyle,
    this.borderRadius = 22,
    this.isLoading = false,
    this.shadowColor,
    this.borderShape,
  });

  @override
  Widget build(BuildContext context) {
    final isElevated = type == AppButtonType.elevated;
    final isOutlined = type == AppButtonType.outlined;
    final isText = type == AppButtonType.text;
    final isDisabled = onPressed == null || isLoading;

    final Color effectiveTextColor;
    if (isDisabled) {
      effectiveTextColor = AppColors.grey400;
    } else if (textColor != null) {
      effectiveTextColor = textColor!;
    } else if (isElevated) {
      effectiveTextColor = AppColors.onPrimary;
    } else {
      effectiveTextColor = AppColors.primary;
    }

    final Color resolvedBackgroundColor;
    if (isDisabled) {
      resolvedBackgroundColor = isElevated
          ? AppColors.grey300
          : Colors.transparent;
    } else if (backgroundColor != null) {
      resolvedBackgroundColor = backgroundColor!;
    } else {
      resolvedBackgroundColor = isElevated
          ? AppColors.primary
          : isOutlined
          ? AppColors.onPrimary
          : Colors.transparent;
    }

    final Color resolvedBorderColor;
    if (isDisabled) {
      resolvedBorderColor = AppColors.grey300;
    } else if (borderColor != null) {
      resolvedBorderColor = borderColor!;
    } else {
      resolvedBorderColor = AppColors.primary;
    }

    final List<Widget> children = [
      if (icon != null && iconPosition == AppButtonIconPosition.start) ...[
        IconTheme(
          data: IconThemeData(color: effectiveTextColor, size: 20),
          child: icon!,
        ),
        const SizedBox(width: 8),
      ],
      Text(
        text,
        style:
            textStyle ??
            AppTypography.bodyMedium.bold
                .responsive(context)
                .withColor(effectiveTextColor),
      ),
      if (icon != null && iconPosition == AppButtonIconPosition.end) ...[
        const SizedBox(width: 8),
        IconTheme(
          data: IconThemeData(color: effectiveTextColor, size: 20),
          child: icon!,
        ),
      ],
    ];
    final shadow = isElevated
        ? [
            BoxShadow(
              color: shadowColor ?? AppColors.primary,
              blurRadius: 4.71,
              offset: const Offset(0, 2.35),
            ),
          ]
        : null;
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      onTap: isDisabled ? null : onPressed,
      child: isText
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: children,
            )
          : AnimatedContainer(
              margin: EdgeInsets.zero,
              padding: padding ?? EdgeInsets.zero,
              duration: const Duration(milliseconds: 300),
              width: width == double.infinity ? null : width,
              height: height,
              decoration: BoxDecoration(
                boxShadow: shadow,
                shape: BoxShape.rectangle,
                color: resolvedBackgroundColor,
                border: isText
                    ? null
                    : Border.all(
                        width: 1,
                        style: BorderStyle.solid,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        color: resolvedBorderColor,
                      ),
                borderRadius:
                    borderShape ??
                    BorderRadius.all(Radius.circular(borderRadius)),
              ),
              child: Center(
                child: isLoading
                    ? SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: effectiveTextColor,
                          strokeWidth: 2.5,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: children,
                      ),
              ),
            ),
    );
  }
}
