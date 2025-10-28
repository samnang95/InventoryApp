import 'package:get/get.dart';
import 'package:inventoryapp/app/routes/app_routes.dart';
import 'package:inventoryapp/app/services/storage_service.dart';

class LoginController extends GetxController {
  final email = ''.obs;
  final password = ''.obs;
  final isLoading = false.obs;

  void login() async {
    if (email.value.isEmpty || password.value.isEmpty) {
      Get.snackbar('Error', 'Please enter email and password');
      return;
    }

    isLoading.value = true;

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      // Save user data to storage
      await StorageService.saveUserData(email.value, password.value);

      Get.snackbar('Success', 'Login successful!');

      // Navigate to home page
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      Get.snackbar('Error', 'Login failed: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Route to register page
  void goToRegister() {
    Get.toNamed(AppRoutes.register);
  }

  // Route to home page
  // void goToHome() {
  //   Get.toNamed(AppRoutes.home);
  // }

  // Load saved user data
  void loadSavedData() {
    final savedEmail = StorageService.getEmail();
    final savedPassword = StorageService.getPassword();

    if (savedEmail != null) email.value = savedEmail;
    if (savedPassword != null) password.value = savedPassword;
  }

  // Clear saved data (logout)
  void logout() async {
    await StorageService.clearUserData();
    email.value = '';
    password.value = '';
    Get.snackbar('Success', 'Logged out successfully');
  }
}
