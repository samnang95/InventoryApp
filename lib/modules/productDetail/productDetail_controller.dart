import 'package:get/get.dart';

class ProductDetailController extends GetxController {
  RxInt currentImage = 0.obs;

  // Item data - using Rx for reactive updates
  RxString id = ''.obs;
  RxString name = ''.obs;
  RxString category = ''.obs;
  RxInt stock = 0.obs;
  RxDouble price = 0.0.obs;
  RxString image = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Get arguments passed from navigation
    final arguments = Get.arguments;
    if (arguments != null && arguments is Map) {
      id.value = arguments['id'] ?? '';
      name.value = arguments['name'] ?? '';
      category.value = arguments['category'] ?? '';
      stock.value = arguments['stock'] ?? 0;
      price.value = arguments['price'] ?? 0.0;
      image.value = arguments['image'] ?? '';
    }
  }

  List<String> get images => image.value.isNotEmpty ? [image.value] : [];
}
