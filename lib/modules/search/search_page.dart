import 'package:get/get.dart';
import 'package:inventoryapp/app/routes/app_routes.dart';
import 'package:inventoryapp/modules/search/search_binding.dart';
import 'package:inventoryapp/modules/search/search_screen.dart';

class SearchPage {
  static final routes = [
    GetPage(
      name: AppRoutes.search,
      page: () => SearchScreen(),
      binding: SearchBinding(),
    ),
  ];
}