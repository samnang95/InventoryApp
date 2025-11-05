import 'package:get/get.dart';
import 'package:inventoryapp/app/modules/navigationBotton/navigationBotton_controller.dart';

class NavigationbottonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavigationbottonController>(() => NavigationbottonController());
  }
}
