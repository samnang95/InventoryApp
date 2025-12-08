import 'package:get/get.dart';
import 'package:inventoryapp/app/routes/app_routes.dart';
import 'package:inventoryapp/app/services/storage_service.dart';

class SplashController extends GetxController {
  final StorageService _storageService = StorageService();

  @override
  void onReady() {
    super.onReady();
    _navigate();
  }

  void _navigate() async {
    await Future.delayed(const Duration(seconds: 2));

    final token = _storageService.token;
    final role = _storageService.role;

    if (token != null && role == 'admin') {
      Get.offNamed(AppRoutes.navigationbotton);
    }else if(token != null && role == 'staff') {
      Get.offNamed(AppRoutes.navigationbotton);
    }else {
      Get.offNamed(AppRoutes.login);
    }
  }
}