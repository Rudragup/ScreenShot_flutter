import 'dart:convert';
import 'dart:io';
import 'package:gal/gal.dart'; // Gallery access
import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot_flutter/features/auth/data/datasources/auth_local_datasource.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  @override
  Future<bool> verifyOTP(String otp) async {
    // MOCK OTP is hardcoded as 123456
    return otp == '123456';
  }

  @override
  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition();
  }

  @override
  Future<void> saveSecurityData({
    required File screenshot,
    required double latitude,
    required double longitude,
    required int attempt,
  }) async {
    // 1. Save to Device Gallery (standard)
    try {
      if (await Gal.hasAccess()) {
        await Gal.putImage(screenshot.path);
      } else {
        await Gal.requestAccess();
        await Gal.putImage(screenshot.path);
      }
    } catch (e) {
      // ignore: empty_catches
    }

    // 2. Save Metadata to App Private Storage (Security Audit)
    final directory = await getApplicationDocumentsDirectory();
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();

    final metadata = {
      "timestamp": DateTime.now().toIso8601String(),
      "latitude": latitude.toString(),
      "longitude": longitude.toString(),
      "attempt": attempt,
    };

    final jsonFile = File('${directory.path}/security_data_$timestamp.json');
    await jsonFile.writeAsString(json.encode(metadata));

  }
}
