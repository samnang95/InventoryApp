import 'package:get/get.dart';
import 'package:inventoryapp/modules/category/category_binding.dart';
import 'package:inventoryapp/modules/category/category_view.dart';
import 'package:inventoryapp/app/routes/app_routes.dart';

class CategoryPage {
  static final routes = [
    GetPage(
      name: AppRoutes.category,
      page: () => CategoryView(),
      binding: CategoryBinding(),
    ),
  ];
}