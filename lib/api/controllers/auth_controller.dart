import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/api/services/auth_service.dart';
import 'package:inventoryapp/app/routes/app_routes.dart';
import 'package:inventoryapp/app/services/storage_service.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();
  final StorageService _storageService = StorageService();

  var isLoading = false.obs;

  /// Form fields
  var name = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var role = 'user'.obs;
  var avatarFile = Rx<File?>(null);

  /// Set avatar
  void setAvatar(File file) {
    avatarFile.value = file;
  }

  /// Get avatar as base64, optional
  String? get avatarBase64 {
    if (avatarFile.value == null) return null;
    final bytes = avatarFile.value!.readAsBytesSync();
    return "data:image/png;base64," + base64Encode(bytes);
  }

  /// Register
  Future<void> register() async {
    try {
      isLoading.value = true;

      final res = await _authService.register(
        name: name.value,
        email: email.value,
        password: password.value,
        role: role.value,
        avatarBase64: avatarBase64 ?? "",
      );

      // Save token & role
      await _storageService.saveToken(res.token);
      await _storageService.saveRole(res.user.role);

      Get.offAllNamed(AppRoutes.navigationbotton);
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  /// Login
  Future<void> login() async {
    try {
      isLoading.value = true;

      final res = await _authService.login(
        email: email.value,
        password: password.value,
      );

      await _storageService.saveToken(res.token);
      await _storageService.saveRole(res.user.role);

      if (res.user.role == "admin" || res.user.role == "Admin") {
        Get.offAllNamed(AppRoutes.navigationbotton);
      } else {
        Get.offAllNamed(AppRoutes.login); // Or user dashboard
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  /// Logout
  Future<void> logout() async {
    bool? confirmed = await Get.defaultDialog<bool>(
      title: 'Logout',
      middleText: 'Are you sure you want to logout?',
      textCancel: 'No',
      textConfirm: 'Yes',
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back(result: true);
      },
      onCancel: () {
        Get.back(result: false);
      },
    );

    if (confirmed == true) {
      try {
        isLoading.value = true;
        final token = _storageService.token;
        if (token != null) {
          await _authService.logout(token);
          await _storageService.clearStorage();
          Get.offAllNamed(AppRoutes.login);
        }
      } catch (e) {
        print(e);
      } finally {
        isLoading.value = false;
      }
    }
  }
}