import 'package:get/get.dart';
import 'package:inventoryapp/app/modules/home/home_binding.dart';
import 'package:inventoryapp/app/modules/home/home_screen.dart';
import 'package:inventoryapp/app/routes/app_routes.dart';

class HomePage {
  static final routes = [
    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
  ];
}
