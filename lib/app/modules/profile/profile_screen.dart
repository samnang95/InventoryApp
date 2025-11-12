import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'profile_controller.dart'; // make sure you create this file

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Obx(
          () => Text(
            'Username: ${controller.username}',
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
