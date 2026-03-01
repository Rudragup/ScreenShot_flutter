import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:screenshot_flutter/core/error/failures.dart';
import 'package:screenshot_flutter/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:screenshot_flutter/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, bool>> verifyOTP(String otp) async {
    try {
      final isValid = await localDataSource.verifyOTP(otp);
      return Right(isValid);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Position>> getCurrentLocation() async {
    try {
      final position = await localDataSource.getCurrentLocation();
      return Right(position);
    } catch (e) {
      return Left(SecurityFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveSecurityData({
    required File screenshot,
    required double latitude,
    required double longitude,
    required int attempt,
  }) async {
    try {
      await localDataSource.saveSecurityData(
        screenshot: screenshot,
        latitude: latitude,
        longitude: longitude,
        attempt: attempt,
      );
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
