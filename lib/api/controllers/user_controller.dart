import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/api/models/user_model.dart';
import 'package:inventoryapp/api/services/user_service.dart';

class UserController extends GetxController {
  final UserService _service = UserService();

  var users = <User>[].obs;
  var isLoading = false.obs;

  // Search & Sort
  var searchQuery = "".obs;
  var sortField = "".obs;

  @override
  void onInit() {
    super.onInit();
    loadUsers();
  }

  Future<void> loadUsers() async {
    try {
      isLoading.value = true;
      users.value = await _service.getUsers(
        search: searchQuery.value.isEmpty ? null : searchQuery.value,
        sort: sortField.value.isEmpty ? null : sortField.value,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addUser({
    required String name,
    required String email,
    required String password,
    required String role,
    File? avatarFile, // changed from avatarBase64
  }) async {
    final newUser = await _service.createUser(
      name: name,
      email: email,
      password: password,
      role: role,
      avatarFile: avatarFile, // pass file to service
    );

    // Insert new user at the top of the list
    users.insert(0, newUser);
  }

  Future<void> editUser({
    required int id,
    String? name,
    String? email,
    String? passwordHash,
    String? role,
    File? avatar,
  }) async {
    // Call updateUser service with file
    final updatedUser = await _service.updateUser(
      id: id,
      name: name,
      email: email,
      passwordHash: passwordHash,
      role: role,
      avatar: avatar, // pass File
    );

    // Update the local users list
    int index = users.indexWhere((u) => u.id == id);
    if (index != -1) {
      users[index] = updatedUser;
    }
  }

  Future<void> removeUser(int id, {String? userName}) async {
    Get.defaultDialog(
      title: "Confirm Delete",
      middleText: "Are you sure you want to remove ${userName ?? 'this user'}?",
      textCancel: "No",
      textConfirm: "Yes",
      confirmTextColor: Colors.white,
      onConfirm: () async {
        Get.back();
        try {
          await _service.deleteUser(id);
          users.removeWhere((u) => u.id == id);
        } catch (e) {
          print(e);
        }
      },
    );
  }
}