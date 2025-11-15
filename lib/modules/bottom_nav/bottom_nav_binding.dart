import 'package:get/get.dart';
import 'package:inventoryapp/modules/bottom_nav/bottom_nav_controller.dart';
import 'package:inventoryapp/modules/home/home_controller.dart';
import 'package:inventoryapp/modules/inventory/inventory_controller.dart';
import 'package:inventoryapp/modules/transactions/controllers/transactions_controller.dart';

class BottomNavBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavController>(() => BottomNavController());
    Get.lazyPut<TransactionsController>(() => TransactionsController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<InventoryController>(() => InventoryController());
  }
}
