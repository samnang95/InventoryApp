import 'package:get/get.dart';
import 'package:inventoryapp/app/routes/app_routes.dart';
import 'package:inventoryapp/modules/product/product_binding.dart';
import 'package:inventoryapp/modules/product/product_view.dart';

class ProductPage {
  static final routes = [
    GetPage(
      name: AppRoutes.product,
      page: () => ProductView(),
      binding: ProductBinding(),
    ),
  ];
}
