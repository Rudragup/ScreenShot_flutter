import 'package:dartz/dartz.dart';
import 'package:screenshot_flutter/core/error/failures.dart';
import 'package:screenshot_flutter/features/auth/domain/repositories/auth_repository.dart';

class VerifyOTPUseCase {
  final AuthRepository repository;

  VerifyOTPUseCase(this.repository);

  Future<Either<Failure, bool>> call(String otp) async {
    return await repository.verifyOTP(otp);
  }
}
