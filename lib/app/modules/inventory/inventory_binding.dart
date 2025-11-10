import 'package:get/get.dart';
import 'package:inventoryapp/app/modules/inventory/inventory_controller.dart';

class InventoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InventoryController>(() => InventoryController());
  }
}
