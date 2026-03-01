import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screenshot_flutter/features/auth/domain/usecases/get_location_usecase.dart';
import 'package:screenshot_flutter/features/auth/domain/usecases/save_security_data_usecase.dart';
import 'package:screenshot_flutter/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:screenshot_flutter/features/auth/presentation/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final VerifyOTPUseCase verifyOTPUseCase;
  final GetLocationUseCase getLocationUseCase;
  final SaveSecurityDataUseCase saveSecurityDataUseCase;

  int _wrongAttemptCount = 0;

  LoginCubit({
    required this.verifyOTPUseCase,
    required this.getLocationUseCase,
    required this.saveSecurityDataUseCase,
  }) : super(LoginInitial());

  Future<void> verifyOTP(String otp, File? screenshotFile) async {
    emit(OTPLoading());

    final failureOrSuccess = await verifyOTPUseCase(otp);

    failureOrSuccess.fold(
      (failure) {
        emit(
          OTPError(message: failure.message, wrongAttempts: _wrongAttemptCount),
        );
      },
      (isValid) async {
        if (isValid) {
          _wrongAttemptCount = 0;
          emit(OTPVerified());
        } else {
          _wrongAttemptCount++;
          if (_wrongAttemptCount >= 3) {
            await _handleSecurityTrigger(screenshotFile);
          } else {
            emit(
              OTPError(
                message: "Incorrect OTP. Please try again.",
                wrongAttempts: _wrongAttemptCount,
              ),
            );
          }
        }
      },
    );
  }

  Future<void> _handleSecurityTrigger(File? screenshotFile) async {
    // Fetch Location
    final locationResult = await getLocationUseCase();

    await locationResult.fold(
      (failure) async {
        emit(
          OTPBlocked(
            message:
                "Access blocked. Failed to fetch location: ${failure.message}",
          ),
        );
      },
      (position) async {
        if (screenshotFile != null) {
          // Save Data
          final saveResult = await saveSecurityDataUseCase(
            screenshot: screenshotFile,
            latitude: position.latitude,
            longitude: position.longitude,
            attempt: _wrongAttemptCount,
          );

          saveResult.fold(
            (failure) {
              emit(
                OTPBlocked(
                  message:
                      "Blocked. Security data not saved: ${failure.message}",
                ),
              );
            },
            (_) {
              emit(
                const OTPBlocked(
                  message: "Maximum attempts reached. intruder data captured.",
                ),
              );
            },
          );
        } else {
          emit(
            const OTPBlocked(
              message: "Maximum attempts reached. blocker activated.",
            ),
          );
        }
      },
    );
  }

  void reset() {
    _wrongAttemptCount = 0;
    emit(LoginInitial());
  }
}
