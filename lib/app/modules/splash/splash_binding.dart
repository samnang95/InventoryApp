// lib/app/bindings/splash_binding.dart
import 'package:get/get.dart';
import 'package:inventoryapp/app/modules/splash/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
  }
}
