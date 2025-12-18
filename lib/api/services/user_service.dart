import 'dart:convert';
import 'dart:io';
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
    File? avatarFile, // Use File instead of base64
  }) async {
    final url = Uri.parse("${AppConstants.baseUrl}/api/users");

    // Multipart request
    final request = http.MultipartRequest('POST', url)
      ..headers.addAll(AppConstants.headers(_storage.token!))
      ..fields['name'] = name
      ..fields['email'] = email
      ..fields['password'] = password
      ..fields['password_hash'] = password
      ..fields['role'] = role;

    // Attach avatar if exists
    if (avatarFile != null) {
      final avatarMultipart = await http.MultipartFile.fromPath(
        'avatar', // field name expected by API
        avatarFile.path,
      );
      request.files.add(avatarMultipart);
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

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
    File? avatar, // <-- file upload
  }) async {
    final uri = Uri.parse("${AppConstants.baseUrl}/api/users/$id");

    // Create multipart request
    var request = http.MultipartRequest('POST', uri); // Use POST with _method=PUT if backend supports
    request.headers.addAll(AppConstants.headers(_storage.token!));

    // Add method override if backend expects PUT
    request.fields['_method'] = 'PUT';

    // Add fields if provided
    if (name != null) request.fields['name'] = name;
    if (email != null) request.fields['email'] = email;
    if (passwordHash != null) request.fields['password_hash'] = passwordHash;
    if (role != null) request.fields['role'] = role;

    // Add avatar file if provided
    if (avatar != null) {
      request.files.add(
        await http.MultipartFile.fromPath('avatar', avatar.path),
      );
    }

    // Send request
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return User.fromJson(data);
    }

    throw Exception("Failed to update user: ${response.body}");
  }

  Future<void> deleteUser(int id) async {
    final url = Uri.parse("${AppConstants.baseUrl}/api/users/$id");
    final response = await http.delete(url, headers: AppConstants.headers(_storage.token!));

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception("Failed to delete user");
    }
  }
}