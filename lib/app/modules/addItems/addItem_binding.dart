import 'package:inventoryapp/app/modules/addItems/addItem_controller.dart';
import 'package:get/get.dart';

class AdditemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdditemController>(() => AdditemController());
  }
}
