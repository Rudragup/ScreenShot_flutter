import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:screenshot_flutter/core/theme/app_colors.dart';
import 'package:screenshot_flutter/core/theme/app_typography.dart';
import 'package:screenshot_flutter/core/theme/responsive_typography.dart';

class OtpFields extends StatelessWidget {
  final int length;
  final TextEditingController controller;
  final Function(String)? onCompleted;
  const OtpFields({
    super.key,
    required this.length,
    required this.controller,
    this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Pinput(
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter OTP';
        }
        if (value.length != length) {
          return 'Please enter valid OTP';
        }
        return null;
      },
      length: length,
      autofocus: true,
      onCompleted: onCompleted,
      closeKeyboardWhenCompleted: true,
      enableInteractiveSelection: true,
      hapticFeedbackType: HapticFeedbackType.lightImpact,
      onClipboardFound: (value) {},
      defaultPinTheme: PinTheme(
        width: 70,
        height: 60,
        textStyle: AppTypography.titleLarge.bold.responsive(context),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border(
            top: BorderSide(color: AppColors.grey300),
            bottom: BorderSide(color: AppColors.grey300),
            left: BorderSide(color: AppColors.grey300),
            right: BorderSide(color: AppColors.grey300),
          ),
        ),
      ),
      focusedPinTheme: PinTheme(
        width: 70,
        height: 60,
        textStyle: AppTypography.titleLarge.bold.responsive(context),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border(
            top: BorderSide(color: AppColors.primary, width: 1.5),
            bottom: BorderSide(color: AppColors.primary, width: 1.5),
            left: BorderSide(color: AppColors.primary, width: 1.5),
            right: BorderSide(color: AppColors.primary, width: 1.5),
          ),
        ),
      ),

      submittedPinTheme: PinTheme(
        width: 70,
        height: 60,
        textStyle: AppTypography.titleLarge.bold.responsive(context),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border(
            top: BorderSide(color: AppColors.primary),
            bottom: BorderSide(color: AppColors.primary),
            left: BorderSide(color: AppColors.primary),
            right: BorderSide(color: AppColors.primary),
          ),
        ),
      ),
    );
  }
}
