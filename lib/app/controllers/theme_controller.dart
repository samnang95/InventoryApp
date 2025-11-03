import 'package:get/get.dart';
import 'package:inventoryapp/app/themes/dark_theme.dart';
import 'package:inventoryapp/app/themes/light_theme.dart';
import '../services/theme_service.dart';
import 'package:flutter/material.dart';

class ThemeController extends GetxController {
  final ThemeService _service = ThemeService();

  var isDarkMode = false.obs;

  ThemeData get theme => isDarkMode.value ? darkTheme : lightTheme;

  @override
  void onInit() {
    super.onInit();
    loadTheme();
  }

  void loadTheme() async {
    isDarkMode.value = await _service.getTheme();
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    _service.saveTheme(isDarkMode.value);
    Get.changeTheme(isDarkMode.value ? darkTheme : lightTheme);
  }
}
