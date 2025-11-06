import 'package:get/get.dart';
import 'package:inventoryapp/app/modules/login/login_binding.dart';
import 'package:inventoryapp/app/modules/login/login_screen.dart';
import 'package:inventoryapp/app/routes/app_routes.dart';

class LoginPage {
  static final routes = [
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
  ];
}
