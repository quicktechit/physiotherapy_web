import 'package:get/get.dart';
import 'package:e_prescription/services/auth_services/quick_tech_auth_storage_service.dart';
import 'dart:convert';

class QuickTechSplashScreenController extends GetxController {
  bool _started = false;

  /// Call this once to begin navigation decision from Splash.
  void startNavigation() {
    if (_started) return;
    _started = true;
    _navigateToNext();
  }

  void _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 2));
    final token = QuickTechAuthStorageService.getToken();
    if (token != null && token.isNotEmpty && !_isTokenExpired(token)) {
      print('Token found and valid: $token');
      Get.offNamed('/mainhome');
    } else {
    
      await QuickTechAuthStorageService.clear();
      Get.offNamed('/login');
    }
  }

  bool _isTokenExpired(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return true;
      final payload = json.decode(utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
      final exp = payload['exp'];
      if (exp == null) return true;
      final expiry = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      return DateTime.now().isAfter(expiry);
    } catch (e) {
      return true;
    }
  }
}