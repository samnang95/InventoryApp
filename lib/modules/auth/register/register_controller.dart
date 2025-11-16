import 'package:get/get.dart';

class RegisterController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;

  var showPassword = false.obs;
  var showConfirmPassword = false.obs;

  void togglePassword() => showPassword.value = !showPassword.value;
  void toggleConfirmPassword() => showConfirmPassword.value = !showConfirmPassword.value;
}