import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:screenshot_flutter/core/error/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> verifyOTP(String otp);
  Future<Either<Failure, Position>> getCurrentLocation();
  Future<Either<Failure, Unit>> saveSecurityData({
    required File screenshot,
    required double latitude,
    required double longitude,
    required int attempt,
  });
}
