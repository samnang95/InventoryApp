import 'package:get/get.dart';
import 'package:inventoryapp/app/routes/app_routes.dart';

class HomeController extends GetxController {
  void navigateToAddItem() {
    Get.toNamed(AppRoutes.additem);
  }
}
