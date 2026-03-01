import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:screenshot_flutter/core/error/failures.dart';
import 'package:screenshot_flutter/features/auth/domain/repositories/auth_repository.dart';

class GetLocationUseCase {
  final AuthRepository repository;

  GetLocationUseCase(this.repository);

  Future<Either<Failure, Position>> call() async {
    return await repository.getCurrentLocation();
  }
}
