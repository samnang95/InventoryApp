import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class StorageService {
  static final _storage = GetStorage();

  // Keys for storage
  static const String _emailKey = 'user_email';
  static const String _passwordKey = 'user_password';
  static const String _isLoggedInKey = 'is_logged_in';

  // Get storage path
  static Future<String> getStoragePath() async {
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        final directory = await getApplicationDocumentsDirectory();
        return directory.path;
      } else if (Platform.isWindows) {
        return '${Platform.environment['APPDATA']}\\get_storage\\';
      } else if (Platform.isMacOS) {
        return '${Platform.environment['HOME']}/Library/Application Support/get_storage/';
      } else if (Platform.isLinux) {
        return '${Platform.environment['HOME']}/.local/share/get_storage/';
      } else {
        return 'Web Browser localStorage';
      }
    } catch (e) {
      return 'Web Browser localStorage (Error: $e)';
    }
  }

  // Save user email
  static Future<void> saveEmail(String email) async {
    await _storage.write(_emailKey, email);
  }

  // Get user email
  static String? getEmail() {
    return _storage.read(_emailKey);
  }

  // Save user password
  static Future<void> savePassword(String password) async {
    await _storage.write(_passwordKey, password);
  }

  // Get user password
  static String? getPassword() {
    return _storage.read(_passwordKey);
  }

  // Save login status
  static Future<void> setLoggedIn(bool isLoggedIn) async {
    await _storage.write(_isLoggedInKey, isLoggedIn);
  }

  // Get login status
  static bool isLoggedIn() {
    return _storage.read(_isLoggedInKey) ?? false;
  }

  // Save all user data at once
  static Future<void> saveUserData(String email, String password) async {
    await _storage.write(_emailKey, email);
    await _storage.write(_passwordKey, password);
    await _storage.write(_isLoggedInKey, true);
  }

  // Clear all user data (logout)
  static Future<void> clearUserData() async {
    await _storage.remove(_emailKey);
    await _storage.remove(_passwordKey);
    await _storage.remove(_isLoggedInKey);
  }

  // Get all user data
  static Map<String, dynamic> getUserData() {
    return {
      'email': getEmail(),
      'password': getPassword(),
      'isLoggedIn': isLoggedIn(),
    };
  }
}
