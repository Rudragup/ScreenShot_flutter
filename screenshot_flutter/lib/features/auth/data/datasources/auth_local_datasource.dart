import 'dart:io';
import 'package:geolocator/geolocator.dart';

abstract class AuthLocalDataSource {
  Future<bool> verifyOTP(String otp);
  Future<Position> getCurrentLocation();
  Future<void> saveSecurityData({
    required File screenshot,
    required double latitude,
    required double longitude,
    required int attempt,
  });
}
