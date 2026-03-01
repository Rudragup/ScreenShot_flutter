import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:screenshot_flutter/core/error/failures.dart';
import 'package:screenshot_flutter/features/auth/domain/repositories/auth_repository.dart';

class SaveSecurityDataUseCase {
  final AuthRepository repository;

  SaveSecurityDataUseCase(this.repository);

  Future<Either<Failure, Unit>> call({
    required File screenshot,
    required double latitude,
    required double longitude,
    required int attempt,
  }) async {
    return await repository.saveSecurityData(
      screenshot: screenshot,
      latitude: latitude,
      longitude: longitude,
      attempt: attempt,
    );
  }
}
