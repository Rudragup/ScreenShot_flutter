import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screenshot_flutter/core/api/base_repository.dart';
import 'package:screenshot_flutter/core/theme/app_colors.dart';
import 'package:screenshot_flutter/core/theme/app_typography.dart';
import 'package:screenshot_flutter/core/theme/responsive_typography.dart';

/// ===============================
/// GLOBAL ERROR SNACKBAR HANDLER
/// ===============================

class AppErrorSnackbar {
  static void handle(BuildContext context, ApiError error) {
    final _SnackConfig config = _resolveConfig(error);

    // 🔔 HAPTIC FEEDBACK
    _triggerHaptic(config.haptic);

    // 🍿 SHOW SNACKBAR
    _showSnack(
      context,
      message: error.message,
      background: config.color,
      icon: config.icon,
    );

    // 🔐 AUTH HANDLING
    if (error.type == ApiErrorType.unauthorized) {
      // onUnauthorized?.call();
    }
  }

  // ===============================
  // CONFIG MAPPER
  // ===============================
  static _SnackConfig _resolveConfig(ApiError error) {
    switch (error.type) {
      case ApiErrorType.network:
        return _SnackConfig(
          color: Colors.orange.shade700,
          haptic: HapticFeedbackType.light,
          icon: Icons.wifi_off,
        );

      case ApiErrorType.timeout:
        return _SnackConfig(
          color: Colors.amber.shade700,
          haptic: HapticFeedbackType.light,
          icon: Icons.timer_off,
        );

      case ApiErrorType.validation:
        return const _SnackConfig(
          color: Colors.orange,
          haptic: HapticFeedbackType.medium,
          icon: Icons.warning_amber,
        );

      case ApiErrorType.unauthorized:
        return _SnackConfig(
          color: Colors.red.shade700,
          haptic: HapticFeedbackType.heavy,
          icon: Icons.lock_outline,
        );

      case ApiErrorType.forbidden:
        return _SnackConfig(
          color: Colors.red.shade600,
          haptic: HapticFeedbackType.heavy,
          icon: Icons.block,
        );

      case ApiErrorType.notFound:
        return const _SnackConfig(
          color: Colors.blueGrey,
          haptic: HapticFeedbackType.light,
          icon: Icons.search_off,
        );

      case ApiErrorType.server:
        return _SnackConfig(
          color: Colors.red.shade900,
          haptic: HapticFeedbackType.heavy,
          icon: Icons.cloud_off,
        );
      case ApiErrorType.success:
        return const _SnackConfig(
          color: Colors.green,
          haptic: HapticFeedbackType.light,
          icon: Icons.check,
        );

      case ApiErrorType.cancelled:
        return const _SnackConfig(
          color: Colors.grey,
          haptic: HapticFeedbackType.light,
          icon: Icons.cancel_outlined,
        );

      case ApiErrorType.unknown:
        return _SnackConfig(
          color: Colors.grey.shade800,
          haptic: HapticFeedbackType.light,
          icon: Icons.error_outline,
        );
    }
  }

  // ===============================
  // UI HELPERS
  // ===============================
  static void _showSnack(
    BuildContext context, {
    required String message,
    required Color background,
    required IconData icon,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: background,
          content: Row(
            children: [
              Icon(icon, color: AppColors.onPrimary),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: AppTypography.labelLarge
                      .withColor(AppColors.onPrimary)
                      .responsive(context),
                ),
              ),
            ],
          ),
        ),
      );
  }

  static void _triggerHaptic(HapticFeedbackType type) {
    switch (type) {
      case HapticFeedbackType.light:
        HapticFeedback.lightImpact();
        break;
      case HapticFeedbackType.medium:
        HapticFeedback.mediumImpact();
        break;
      case HapticFeedbackType.heavy:
        HapticFeedback.heavyImpact();
        break;
    }
  }
}

/// ===============================
/// INTERNAL CONFIG MODELS
/// ===============================

enum HapticFeedbackType { light, medium, heavy }

class _SnackConfig {
  final Color color;
  final HapticFeedbackType haptic;
  final IconData icon;

  const _SnackConfig({
    required this.color,
    required this.haptic,
    required this.icon,
  });
}
