import 'package:get/get.dart';
import 'package:inventoryapp/app/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    // Wait 2 seconds and navigate
    Future.delayed(const Duration(seconds: 2), () {
      Get.offNamed(AppRoutes.login); // Navigate to Login
    });
  }
}
