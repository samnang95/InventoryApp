// lib/app/bindings/auth_binding.dart
import 'package:get/get.dart';
import 'package:inventoryapp/app/modules/login/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
