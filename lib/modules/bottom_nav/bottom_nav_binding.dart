import 'package:get/get.dart';
import 'package:inventoryapp/api/controllers/category_controller.dart';
import 'package:inventoryapp/api/controllers/product_controller.dart';
import 'package:inventoryapp/modules/bottom_nav/bottom_nav_controller.dart';
import 'package:inventoryapp/modules/dashboard/dashboard_controller.dart';
import 'package:inventoryapp/modules/home/home_controller.dart';
import 'package:inventoryapp/modules/transactions/transactions_controller.dart';

class BottomNavBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavController>(() => BottomNavController());
    Get.lazyPut<TransactionsController>(() => TransactionsController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<CategoryController>(() => CategoryController());
    Get.lazyPut<ProductController>(() => ProductController());
  }
}
