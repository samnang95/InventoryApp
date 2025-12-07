import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inventoryapp/api/models/user_model.dart';
import 'package:inventoryapp/app/constants/app_constant.dart';

class AuthService {

  /// Register
  Future<AuthResponse> register({
    required String name,
    required String email,
    required String password,
    required String role,
    String? avatarBase64,
  }) async {
    final response = await http.post(
      Uri.parse(AppConstants.registerUrl),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": password,
        "role": role,
        "avatar": avatarBase64 ?? "",
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return AuthResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(jsonDecode(response.body)['message'] ?? "Registration failed");
    }
  }

  /// Login
  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse(AppConstants.loginUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      return AuthResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(jsonDecode(response.body)['message'] ?? "Login failed");
    }
  }

  /// Logout
  Future<void> logout(String token) async {
    final response = await http.post(
      Uri.parse(AppConstants.logoutUrl),
      headers: AppConstants.headers(token),
    );
    if (response.statusCode != 200) {
      throw Exception("Logout failed");
    }
  }
}