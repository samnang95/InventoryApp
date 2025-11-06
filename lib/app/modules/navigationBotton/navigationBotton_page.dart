import 'package:get/get.dart';
import 'package:inventoryapp/app/modules/navigationBotton/navigationBotton_binding.dart';
import 'package:inventoryapp/app/modules/navigationBotton/navigationBotton_screen.dart';
import 'package:inventoryapp/app/routes/app_routes.dart';

class NavigationbottonPage {
  static final routes = [
    GetPage(
      name: AppRoutes.navigationbotton,
      page: () => NavigationbottonScreen(),
      binding: NavigationbottonBinding(),
    ),
  ];
}
