import 'package:get/get.dart';
import 'package:inventoryapp/modules/productDetail/productDetail_controller.dart';

class ProductdetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductDetailController>(() => ProductDetailController());
  }
}
