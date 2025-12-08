import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inventoryapp/app/constants/app_constant.dart';
import 'package:inventoryapp/api/models/user_model.dart';
import 'package:inventoryapp/app/services/storage_service.dart';

class UserService {
  final StorageService _storage = StorageService();

  Future<List<User>> getUsers({String? search, String? sort}) async {
    String url = "${AppConstants.baseUrl}/api/users";
    List<String> params = [];
    if (search != null) params.add("q=$search");
    if (sort != null) params.add("sort=$sort");
    if (params.isNotEmpty) url += "?${params.join('&')}";

    final response = await http.get(Uri.parse(url), headers: AppConstants.headers(_storage.token!));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((e) => User.fromJson(e)).toList();
    }

    throw Exception("Failed to load users");
  }

  Future<User> createUser({
    required String name,
    required String email,
    required String password,
    required String role,
    String? avatarBase64,
  }) async {
    final url = Uri.parse("${AppConstants.baseUrl}/api/users");

    final body = jsonEncode({
      "name": name,
      "email": email,
      "password": password,
      "password_hash": password,
      "role": role,
      if (avatarBase64 != null) "avatar_base64": avatarBase64,
    });

    final response = await http.post(url, headers: AppConstants.headers(_storage.token!), body: body);

    print(response.body);

    if (response.statusCode == 201 || response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return User.fromJson(data);
    }

    throw Exception("Failed to create user");
  }

  Future<User> updateUser({
    required int id,
    String? name,
    String? email,
    String? passwordHash,
    String? role,
    String? avatar,
  }) async {
    final url = Uri.parse("${AppConstants.baseUrl}/api/users/$id");

    final body = jsonEncode({
      if (name != null) "name": name,
      if (email != null) "email": email,
      if (passwordHash != null) "password_hash": passwordHash,
      if (role != null) "role": role,
      if (avatar != null) "avatar": avatar,
    });

    final response = await http.put(url, headers: AppConstants.headers(_storage.token!), body: body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return User.fromJson(data);
    }

    throw Exception("Failed to update user");
  }

  Future<void> deleteUser(int id) async {
    final url = Uri.parse("${AppConstants.baseUrl}/api/users/$id");
    final response = await http.delete(url, headers: AppConstants.headers(_storage.token!));

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception("Failed to delete user");
    }
  }
}