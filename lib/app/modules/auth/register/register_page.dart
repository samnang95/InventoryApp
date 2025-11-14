import 'package:get/get.dart';
import 'package:inventoryapp/app/modules/auth/register/register_binding.dart';
import 'package:inventoryapp/app/modules/auth/register/register_screen.dart';
import 'package:inventoryapp/app/routes/app_routes.dart';

class RegisterPage {
  static final routes = [
    GetPage(
      name: AppRoutes.register,
      page: () => RegisterScreen(),
      binding: RegisterBinding(),
    ),
  ];
}
