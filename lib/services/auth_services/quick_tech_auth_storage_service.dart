import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:e_prescription/models/user_model/quick_tech_user_model.dart';

class QuickTechAuthStorageService {
  static final _storage = GetStorage();
  static const _tokenKey = 'access_token';
  static const _userKey = 'user';

  static Future<void> saveToken(String token) async {
    await _storage.write(_tokenKey, token);
  }

  static String? getToken() {
    return _storage.read(_tokenKey);
  }

  /// Read the latest token from storage (always fresh, not cached)
  static String? getFreshToken() {
    return _storage.read(_tokenKey);
  }

  static Future<void> saveUser(QuickTechUserModel user) async {
    await _storage.write(_userKey, user.toRawJson());
  }

  static QuickTechUserModel? getUser() {
    final userJson = _storage.read(_userKey);
    if (userJson == null) return null;
    return QuickTechUserModel.fromRawJson(userJson);
  }

  static Future<void> clear() async {
    await _storage.remove(_tokenKey);
    await _storage.remove(_userKey);
  }

  /// Handle 401 Unauthorized response: clear storage, logout user, redirect to login
  static Future<void> handleUnauthorized() async {
    print('WARN: Received 401 Unauthorized. Clearing tokens and redirecting to login.');
    await clear();
    Get.offAllNamed('/login');
  }
}
