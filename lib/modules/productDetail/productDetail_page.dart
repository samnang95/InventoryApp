import 'package:get/get.dart';
import 'package:inventoryapp/modules/productDetail/productDetail_binding.dart';
import 'package:inventoryapp/modules/productDetail/productDetail_screen.dart';
import 'package:inventoryapp/app/routes/app_routes.dart';

class ProductdetailPage {
  static final routes = [
    GetPage(
      name: AppRoutes.productDetail,
      page: () => ProductDetailView(),
      binding: ProductdetailBinding(),
    ),
  ];
}
