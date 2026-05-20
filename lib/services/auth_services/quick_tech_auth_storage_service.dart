import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:e_prescription/models/user_model/quick_tech_user_model.dart';

class QuickTechAuthStorageService {
  static final _storage = GetStorage();
  static const _tokenKey = 'access_token';
  static const _userKey = 'user';

  static Future<void> saveToken(String token) async {
    try {
      await _storage.write(_tokenKey, token);
      print('[STORAGE] ✅ Token saved: ${token.substring(0, 20)}...');
      print('[STORAGE] Verifying write... reading back: ${_storage.read(_tokenKey)?.toString().substring(0, 20) ?? 'NULL'}...');
    } catch (e) {
      print('[STORAGE] ❌ Error saving token: $e');
    }
  }

  static String? getToken() {
    return _storage.read(_tokenKey);
  }

  /// Read the latest token from storage (always fresh, not cached)
  static String? getFreshToken() {
    return _storage.read(_tokenKey);
  }

  static Future<void> saveUser(QuickTechUserModel user) async {
    try {
      await _storage.write(_userKey, user.toRawJson());
      print('[STORAGE] ✅ User saved: ${user.firstName}');
    } catch (e) {
      print('[STORAGE] ❌ Error saving user: $e');
    }
  }

  static QuickTechUserModel? getUser() {
    try {
      final userJson = _storage.read(_userKey);
      if (userJson == null) {
        print('[STORAGE] User not found in storage');
        return null;
      }
      print('[STORAGE] User found: $userJson');
      return QuickTechUserModel.fromRawJson(userJson);
    } catch (e) {
      print('[STORAGE] ❌ Error reading user: $e');
      return null;
    }
  }

  static Future<void> clear() async {
    try {
      await _storage.remove(_tokenKey);
      await _storage.remove(_userKey);
      print('[STORAGE] ✅ Storage cleared');
    } catch (e) {
      print('[STORAGE] ❌ Error clearing storage: $e');
    }
  }

  /// Handle 401 Unauthorized response: clear storage, logout user, redirect to login
  static Future<void> handleUnauthorized() async {
    print('WARN: Received 401 Unauthorized. Clearing tokens and redirecting to login.');
    await clear();
    Get.offAllNamed('/login');
  }
}
