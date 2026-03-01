import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screenshot_flutter/core/theme/app_colors.dart';
import 'package:screenshot_flutter/core/theme/app_typography.dart';
import 'package:screenshot_flutter/core/theme/responsive_typography.dart';

// ============================================================================
// CONSTANTS
// ============================================================================

/// Default input decoration constants for consistent styling across the app.
abstract final class _FieldConstants {
  static const double borderRadius = 10.0;
  static const double borderWidth = 2.0;
  static const double disabledBorderWidth = 1.0;

  static const EdgeInsets contentPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 18,
  );

  static const Color enabledBorderColor = AppColors.greyCDDDEA;
  static const Color disabledBorderColor = Color(0xffE8ECF4);
  static const Color errorBorderColor = Colors.red;
  static const Color disabledFillColor = Color(0xffF5F6FA);
  static const Color passwordIconColor = Color(0xff8391A1);
}

/// Standard input borders used across CustomField variants.
abstract final class _FieldBorders {
  static const OutlineInputBorder enabled = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(_FieldConstants.borderRadius),
    ),
    borderSide: BorderSide(
      color: _FieldConstants.enabledBorderColor,
      width: _FieldConstants.borderWidth,
    ),
  );

  static const OutlineInputBorder disabled = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(_FieldConstants.borderRadius),
    ),
    borderSide: BorderSide(
      color: _FieldConstants.disabledBorderColor,
      width: _FieldConstants.disabledBorderWidth,
    ),
  );

  static const OutlineInputBorder error = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(_FieldConstants.borderRadius),
    ),
    borderSide: BorderSide(
      color: _FieldConstants.errorBorderColor,
      width: _FieldConstants.borderWidth,
    ),
  );
}

class CustomField<T> extends StatefulWidget {
  const CustomField({
    this.hintstyle,
    super.key,
    required this.hintText,
    this.controller,
    this.validator,
    this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.isPassword = false,
    this.maxLines = 1,
    this.spacing = 16,
    this.contentPadding,
    this.inputFormatters,
    this.textInputAction = TextInputAction.next,
    this.onTap,
    this.onChanged,
    this.keyboardType,
  });

  // ─────────────────────────────────────────────────────────────────────────
  // Core Properties
  // ─────────────────────────────────────────────────────────────────────────

  final TextEditingController? controller;
  final String hintText;
  final TextStyle? hintstyle;
  final String? label;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final List<TextInputFormatter>? inputFormatters;

  // ─────────────────────────────────────────────────────────────────────────
  // Behavior Properties
  // ─────────────────────────────────────────────────────────────────────────

  final bool enabled;
  final bool readOnly;
  final bool autofocus;
  final bool isPassword;
  final int? maxLines;
  final double spacing;
  final TextInputAction? textInputAction;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;

  @override
  State<CustomField<T>> createState() => _CustomFieldState<T>();
}

class _CustomFieldState<T> extends State<CustomField<T>>
    with SingleTickerProviderStateMixin {
  late TextEditingController _controller;
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  final _focusNode = FocusNode();
  final _layerLink = LayerLink();

  bool _obscureText = false;
  bool _hasError = false;

  // ─────────────────────────────────────────────────────────────────────────
  // Lifecycle
  // ─────────────────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _initShakeAnimation();
    _obscureText = widget.isPassword;
  }

  void _initShakeAnimation() {
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _shakeAnimation = TweenSequence<double>(
      [
        TweenSequenceItem(tween: Tween(begin: 0, end: -8), weight: 1),
        TweenSequenceItem(tween: Tween(begin: -8, end: 8), weight: 2),
        TweenSequenceItem(tween: Tween(begin: 8, end: -8), weight: 2),
        TweenSequenceItem(tween: Tween(begin: -8, end: 0), weight: 1),
      ],
    ).animate(CurvedAnimation(parent: _shakeController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _shakeController.dispose();
    _focusNode.dispose();
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Validation
  // ─────────────────────────────────────────────────────────────────────────

  void _triggerErrorShake() {
    HapticFeedback.mediumImpact();
    _shakeController.forward(from: 0);
  }

  String? _validateField(String? value) {
    final error = widget.validator?.call(value);
    if (error != null && !_hasError) {
      _hasError = true;
      WidgetsBinding.instance.addPostFrameCallback((_) => _triggerErrorShake());
    }
    if (error == null) _hasError = false;
    return error;
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Build Methods
  // ─────────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: AnimatedBuilder(
        animation: _shakeAnimation,
        builder: (context, child) => Transform.translate(
          offset: Offset(_shakeAnimation.value, 0),
          child: child,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.label != null) _buildLabel(),
            _buildTextField(),
            SizedBox(height: widget.spacing),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        widget.label!,
        style: AppTypography.titleSmall.semiBold.responsive(context),
      ),
    );
  }

  Widget _buildTextField() {
    final textField = TextFormField(
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      style: widget.enabled
          ? AppTypography.labelLarge
                .withSize(15)
                .responsive(context)
                .withColor(AppColors.textGrey)
          : AppTypography.labelLarge
                .withSize(15)
                .responsive(context)
                .withColor(AppColors.textGrey),
      autovalidateMode: .onUserInteraction,
      scrollPhysics: const AlwaysScrollableScrollPhysics(),
      controller: _controller,
      focusNode: _focusNode,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      autofocus: widget.autofocus,
      obscureText: _obscureText,
      maxLines: widget.isPassword ? 1 : widget.maxLines,
      inputFormatters: widget.inputFormatters,
      onTap: widget.enabled ? widget.onTap : null,
      onChanged: widget.onChanged,
      validator: _validateField,
      decoration: _buildInputDecoration(),
    );

    return textField;
  }

  InputDecoration _buildInputDecoration() {
    return InputDecoration(
      hintText: widget.hintText,
      filled: true,
      fillColor: widget.enabled
          ? AppColors.onPrimary
          : _FieldConstants.disabledFillColor,
      contentPadding: widget.contentPadding ?? _FieldConstants.contentPadding,
      prefixIcon: widget.prefixIcon,
      suffixIcon: _buildSuffixIcon(),
      enabledBorder: _FieldBorders.enabled,
      focusedBorder: _FieldBorders.enabled,
      disabledBorder: _FieldBorders.disabled,
      errorBorder: _FieldBorders.error,
      focusedErrorBorder: _FieldBorders.error,
      border: _FieldBorders.enabled,
      enabled: widget.enabled,
      errorStyle: AppTypography.labelSmall
          .responsive(context)
          .withColor(AppColors.error),
      hintStyle:
          widget.enabled == false ||
              widget.readOnly == true ||
              widget.hintstyle != null
          ? widget.hintstyle
          : AppTypography.labelLarge
                .withSize(15)
                .responsive(context)
                .withColor(AppColors.textGrey),
    );
  }

  Widget? _buildSuffixIcon() {
    // Password visibility toggle
    if (widget.isPassword) {
      return IconButton(
        icon: Icon(
          _obscureText ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
          color: _FieldConstants.passwordIconColor,
        ),
        onPressed: () => setState(() => _obscureText = !_obscureText),
      );
    }

    // Custom suffix icon
    return widget.suffixIcon;
  }
}
