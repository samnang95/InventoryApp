import 'package:get/get.dart';
import 'package:inventoryapp/app/modules/inventory/inventory_binding.dart';
import 'package:inventoryapp/app/modules/inventory/inventory_screen.dart';
import 'package:inventoryapp/app/routes/app_routes.dart';

class InventoryPage {
  static final routes = [
    GetPage(
      name: AppRoutes.inventory,
      page: () => InventoryScreen(),
      binding: InventoryBinding(),
    ),
  ];
}
