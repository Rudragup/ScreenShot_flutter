import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:screenshot_flutter/core/di/injection_container.dart';
import 'package:screenshot_flutter/core/theme/app_colors.dart';
import 'package:screenshot_flutter/core/theme/app_shadows.dart';
import 'package:screenshot_flutter/core/theme/app_sizing.dart';
import 'package:screenshot_flutter/core/theme/app_spacings.dart';
import 'package:screenshot_flutter/core/theme/app_typography.dart';
import 'package:screenshot_flutter/core/theme/responsive_typography.dart';
import 'package:screenshot_flutter/core/widgets/app_button.dart';
import 'package:screenshot_flutter/core/widgets/customfield.dart';
import 'package:screenshot_flutter/core/widgets/otp_fields.dart';
import 'package:screenshot_flutter/features/auth/presentation/cubit/login_cubit.dart';
import 'package:screenshot_flutter/features/auth/presentation/cubit/login_state.dart';

// ════════════════════════════════════════════════════════════════════════════
// LOGIN SCREEN
// ════════════════════════════════════════════════════════════════════════════

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  // ─── Controllers & State ─────────────────────────────────────────────
  final _mobileController = TextEditingController();
  final _otpController = TextEditingController();
  final _screenshotController = ScreenshotController();
  final _formKey = GlobalKey<FormState>();

  bool _otpSent = false;
  int _failedCount = 0;
  File? _lastCapturedFile; // Tracks the screenshot for preview

  late AnimationController _animCtrl;
  late Animation<double> _fadeIn;
  late Animation<Offset> _slideUp;

  // ─── Lifecycle ───────────────────────────────────────────────────────
  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeIn = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _slideUp = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOutCubic));
    _animCtrl.forward();
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    _mobileController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  // ─── Build ───────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LoginCubit>(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: _onStateChanged,
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.background,
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacings.p24,
                  ),
                  child: Screenshot(
                    controller: _screenshotController,
                    child: FadeTransition(
                      opacity: _fadeIn,
                      child: SlideTransition(
                        position: _slideUp,
                        child: _buildCard(context, state),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ─── Main Card ───────────────────────────────────────────────────────
  Widget _buildCard(BuildContext context, LoginState state) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacings.p24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppSizing.borderRadiusXl,
        boxShadow: AppShadows.cardMd,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ─ Shield Icon ─
          _buildShieldIcon(),
          const SizedBox(height: AppSpacings.s24),

          // ─ Title & Subtitle ─
          Text(
            _otpSent ? "Verify Identity" : "Secure Login",
            style: AppTypography.headlineMedium.bold.responsive(context),
          ),
          const SizedBox(height: AppSpacings.s8),
          Text(
            _otpSent
                ? "Enter the 6-digit code sent to\n+91 ${_mobileController.text}"
                : "Enter your registered mobile number\nto get started",
            style: AppTypography.bodyMedium
                .responsive(context)
                .withColor(AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacings.s32),

          // ─ Form Content ─
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            child: _otpSent
                ? _buildOTPSection(context, state)
                : _buildPhoneSection(context, state),
          ),
        ],
      ),
    );
  }

  // ─── Shield Icon ─────────────────────────────────────────────────────
  Widget _buildShieldIcon() {
    return Container(
      width: AppSizing.iconHero,
      height: AppSizing.iconHero,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF29C5F6), Color(0xFF238CFF)],
        ),
        borderRadius: AppSizing.borderRadiusXl,
        boxShadow: AppShadows.primaryGlow(AppColors.primary),
      ),
      child: const Icon(
        Icons.shield_outlined,
        size: AppSizing.iconXl,
        color: Colors.white,
      ),
    );
  }

  // ─── Phone Number Section ────────────────────────────────────────────
  Widget _buildPhoneSection(BuildContext context, LoginState state) {
    return Form(
      key: _formKey,
      child: Column(
        key: const ValueKey('phone_section'),
        children: [
          CustomField(
            controller: _mobileController,
            hintText: "Enter mobile number",
            label: "Mobile Number",
            keyboardType: TextInputType.phone,
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 16, right: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "🇮🇳",
                    style: AppTypography.titleMedium.responsive(context),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "+91",
                    style: AppTypography.bodyMedium.semiBold
                        .responsive(context)
                        .withColor(AppColors.textPrimary),
                  ),
                  const SizedBox(width: 8),
                  Container(width: 1, height: 24, color: AppColors.grey300),
                ],
              ),
            ),
            validator: (val) {
              if (val == null || val.isEmpty) return "Phone number is required";
              if (val.length < 10) return "Enter a valid 10-digit number";
              return null;
            },
            spacing: AppSpacings.s24,
          ),
          AppButton(
            text: "Send Verification Code",
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                _playTransition();
                setState(() => _otpSent = true);
              }
            },
            gradient: AppColors.bgGradient,
            icon: const Icon(Icons.arrow_forward_rounded, size: 20),
          ),
          const SizedBox(height: AppSpacings.s16),
          _buildMockHint(),
        ],
      ),
    );
  }

  // ─── OTP Section ─────────────────────────────────────────────────────
  Widget _buildOTPSection(BuildContext context, LoginState state) {
    return Column(
      key: const ValueKey('otp_section'),
      children: [
        // OTP Input
        OtpFields(
          length: 6,
          controller: _otpController,
          onCompleted: (pin) => _onOTPSubmitted(context, pin),
        ),
        const SizedBox(height: AppSpacings.s24),

        // Status Indicator
        if (state is OTPLoading)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacings.s16),
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: AppColors.primary,
                strokeWidth: AppSizing.progressStrokeWidth,
              ),
            ),
          ),

        // Attempt Indicator
        if (_failedCount > 0) _buildAttemptIndicator(),

        const SizedBox(height: AppSpacings.s8),

        // Resend / Back
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () {
                    context.read<LoginCubit>().reset();
                    _playTransition();
                    setState(() {
                      _otpSent = false;
                      _otpController.clear();
                      _failedCount = 0;
                      _lastCapturedFile = null;
                    });
                  },
                  icon: const Icon(Icons.arrow_back_rounded, size: 18),
                  label: Text(
                    "Change Number",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.labelLarge
                        .responsive(context)
                        .withColor(AppColors.textSecondary),
                  ),
                ),
              ),
            ),
            Flexible(
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    _otpController.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("OTP resent (Mock: 123456)"),
                      ),
                    );
                  },
                  child: Text(
                    "Resend Code",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.labelLarge.semiBold
                        .responsive(context)
                        .withColor(AppColors.primary),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacings.s16),
        _buildMockHint(),
      ],
    );
  }

  // ─── Attempt Indicator ───────────────────────────────────────────────
  Widget _buildAttemptIndicator() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: AppSpacings.s16),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacings.p16,
        vertical: AppSpacings.p12,
      ),
      decoration: BoxDecoration(
        color: _failedCount >= 2
            ? AppColors.error.withValues(alpha: 0.08)
            : AppColors.warning.withValues(alpha: 0.08),
        borderRadius: AppSizing.borderRadiusMd,
        border: Border.all(
          color: _failedCount >= 2
              ? AppColors.error.withValues(alpha: 0.20)
              : AppColors.warning.withValues(alpha: 0.20),
        ),
      ),
      child: Row(
        children: [
          Icon(
            _failedCount >= 2
                ? Icons.error_outline_rounded
                : Icons.warning_amber_rounded,
            size: AppSizing.iconSm,
            color: _failedCount >= 2 ? AppColors.error : AppColors.warning,
          ),
          const SizedBox(width: AppSpacings.s8),
          Expanded(
            child: Text(
              _failedCount >= 2
                  ? "Last attempt! Next wrong OTP will trigger security lockout."
                  : "Wrong OTP entered. $_failedCount of 3 attempts used.",
              style: AppTypography.labelMedium
                  .responsive(context)
                  .withColor(
                    _failedCount >= 2 ? AppColors.error : AppColors.warning,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Mock Hint ───────────────────────────────────────────────────────
  Widget _buildMockHint() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacings.p12),
      decoration: BoxDecoration(
        color: AppColors.info.withValues(alpha: 0.06),
        borderRadius: AppSizing.borderRadiusSm,
        border: Border.all(color: AppColors.info.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline_rounded,
            size: AppSizing.iconSm,
            color: AppColors.info,
          ),
          const SizedBox(width: AppSpacings.s8),
          Expanded(
            child: Text(
              _otpSent
                  ? "Mock OTP: 123456  •  Enter anything else to simulate failure"
                  : "Demo mode — No real SMS will be sent",
              style: AppTypography.labelSmall
                  .responsive(context)
                  .withColor(AppColors.info),
            ),
          ),
        ],
      ),
    );
  }

  // ════════════════════════════════════════════════════════════════════════
  // LOGIC
  // ════════════════════════════════════════════════════════════════════════

  void _playTransition() {
    _animCtrl.reset();
    _animCtrl.forward();
  }

  void _onStateChanged(BuildContext context, LoginState state) {
    if (state is OTPVerified) {
      _showSuccessSheet();
    } else if (state is OTPError) {
      _failedCount = state.wrongAttempts;
      _otpController.clear();
    } else if (state is OTPBlocked) {
      _showBlockedSheet(state.message);
    }
  }

  Future<void> _onOTPSubmitted(BuildContext ctx, String pin) async {
    final hasAccess = await _checkAndRequestPermissions();
    if (!hasAccess) {
      if (!mounted || !ctx.mounted) return;
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(
          content: Text("Location & Storage permissions are required."),
        ),
      );
      return;
    }

    File? screenshot;
    // Capture screenshot on the 3rd attempt (when _failedCount is 2)
    debugPrint('Current failed count: $_failedCount');
    if (_failedCount >= 2) {
      try {
        debugPrint('Attempting to capture screenshot...');
        final image = await _screenshotController.capture(
          delay: const Duration(milliseconds: 100),
        );
        if (image != null) {
          final tempDir = await getTemporaryDirectory();
          final timestamp = DateTime.now().millisecondsSinceEpoch;
          final file = File('${tempDir.path}/temp_shot_$timestamp.png');
          await file.writeAsBytes(image);
          screenshot = file;
          _lastCapturedFile = file; // Save for preview
          debugPrint('Screenshot captured successfully at: ${file.path}');
        } else {
          debugPrint('Warning: Screenshot capture returned null.');
        }
      } catch (e) {
        debugPrint('Error capturing screenshot: $e');
      }
    }

    if (!mounted || !ctx.mounted) return;
    ctx.read<LoginCubit>().verifyOTP(pin, screenshot);
  }

  Future<bool> _checkAndRequestPermissions() async {
    // 1. Check Location
    LocationPermission locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
    }
    if (locationPermission == LocationPermission.deniedForever) {
      return false;
    }

    if (Platform.isAndroid) {
      await Permission.storage.request();
    }

    return (locationPermission == LocationPermission.always ||
        locationPermission == LocationPermission.whileInUse);
  }

  // ─── Success Bottom Sheet ────────────────────────────────────────────
  void _showSuccessSheet() {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(AppSpacings.p32),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppSizing.radiusXxl),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: AppSizing.iconHero,
              height: AppSizing.iconHero,
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle_rounded,
                size: AppSizing.iconXl,
                color: AppColors.success,
              ),
            ),
            const SizedBox(height: AppSpacings.s24),
            Text("Identity Verified", style: AppTypography.titleLarge.bold),
            const SizedBox(height: AppSpacings.s8),
            Text(
              "Your identity has been successfully verified.\nYou can now access your account.",
              textAlign: TextAlign.center,
              style: AppTypography.bodyMedium.withColor(
                AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacings.s32),
            AppButton(
              text: "Continue to Dashboard",
              onPressed: () {
                Navigator.pop(ctx);
                setState(() {
                  _otpSent = false;
                  _otpController.clear();
                  _failedCount = 0;
                });
              },
              gradient: AppColors.bgGradient,
            ),
            const SizedBox(height: AppSpacings.s16),
          ],
        ),
      ),
    );
  }

  // ─── Blocked Bottom Sheet ────────────────────────────────────────────
  void _showBlockedSheet(String message) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.fromLTRB(
          AppSpacings.p32,
          AppSpacings.p32,
          AppSpacings.p32,
          AppSpacings.p16,
        ),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppSizing.radiusXxl),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: AppSizing.iconHero,
              height: AppSizing.iconHero,
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.10),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.gpp_bad_rounded,
                size: AppSizing.iconXl,
                color: AppColors.error,
              ),
            ),
            const SizedBox(height: AppSpacings.s24),
            Text(
              "Account Locked",
              style: AppTypography.titleLarge.bold.withColor(AppColors.error),
            ),
            const SizedBox(height: AppSpacings.s8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTypography.bodyMedium.withColor(
                AppColors.textSecondary,
              ),
            ),

            // SECURITY PREVIEW
            if (_lastCapturedFile != null) ...[
              const SizedBox(height: AppSpacings.s24),
              Row(
                children: [
                  const Icon(
                    Icons.camera_alt_outlined,
                    size: 14,
                    color: AppColors.error,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "SECURITY EVIDENCE CAPTURED",
                    style: AppTypography.labelSmall.semiBold
                        .withColor(AppColors.error)
                        .copyWith(letterSpacing: 1.2),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacings.s12),
              Container(
                decoration: BoxDecoration(
                  borderRadius: AppSizing.borderRadiusMd,
                  boxShadow: AppShadows.cardSm,
                  border: Border.all(
                    color: AppColors.error.withValues(alpha: 0.15),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: AppSizing.borderRadiusMd,
                  child: Image.file(
                    _lastCapturedFile!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ] else
              _buildFallbackSecurityBanner(),

            const SizedBox(height: AppSpacings.s32),
            AppButton(
              text: "Exit & Verification Support",
              borderColor: AppColors.error,
              textColor: AppColors.error,
              type: AppButtonType.outlined,
              onPressed: () => Navigator.pop(ctx),
            ),
            const SizedBox(height: AppSpacings.s16),
            Text(
              "Ref ID: LOCKED_${DateTime.now().millisecondsSinceEpoch}",
              style: AppTypography.labelSmall.withColor(
                AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppSpacings.s12),
          ],
        ),
      ),
    );
  }

  Widget _buildFallbackSecurityBanner() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: AppSpacings.s12),
      padding: const EdgeInsets.all(AppSpacings.p16),
      decoration: BoxDecoration(
        color: AppColors.grey50,
        borderRadius: AppSizing.borderRadiusMd,
      ),
      child: Row(
        children: [
          const Icon(
            Icons.camera_alt_outlined,
            size: AppSizing.iconSm,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: AppSpacings.s12),
          Expanded(
            child: Text(
              "Screenshot & location data captured for security audit.",
              style: AppTypography.labelSmall.withColor(
                AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
