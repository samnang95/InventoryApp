import 'package:get/get.dart';
import 'package:inventoryapp/api/controllers/auth_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
