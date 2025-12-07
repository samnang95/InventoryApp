import 'package:get_storage/get_storage.dart';
import 'package:inventoryapp/app/constants/app_constant.dart';

class StorageService {
  final _storage = GetStorage();

  // Save token & role
  Future<void> saveToken(String token) async => await _storage.write(AppConstants.tokenKey, token);
  Future<void> saveRole(String role) async => await _storage.write(AppConstants.roleKey, role);

  // Read token & role
  String? get token => _storage.read(AppConstants.tokenKey);
  String? get role => _storage.read(AppConstants.roleKey);

  // Remove token & role
  Future<void> clearStorage() async => await _storage.erase();
}