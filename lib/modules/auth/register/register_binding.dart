import 'package:get/get.dart';
import 'package:inventoryapp/api/controllers/auth_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
