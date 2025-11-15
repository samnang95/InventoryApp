import 'package:get/get.dart';
import 'package:inventoryapp/modules/bottom_nav/bottom_nav_binding.dart';
import 'package:inventoryapp/modules/bottom_nav/bottom_nav_screen.dart';
import 'package:inventoryapp/app/routes/app_routes.dart';

class BottomNavPage {
  static final routes = [
    GetPage(
      name: AppRoutes.navigationbotton,
      page: () => BottomNavScreen(),
      binding: BottomNavBinding(),
    ),
  ];
}
