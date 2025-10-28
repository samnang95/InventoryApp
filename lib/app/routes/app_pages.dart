import 'package:get/get.dart';
import 'package:inventoryapp/app/modules/home/home_screen.dart';
import 'package:inventoryapp/app/modules/home/home_binding.dart';
import 'package:inventoryapp/app/modules/splash/splash_binding.dart';
import 'package:inventoryapp/app/modules/splash/splash_screen.dart';
import 'package:inventoryapp/app/modules/login/login_binding.dart';
import 'package:inventoryapp/app/modules/login/login_screen.dart';
import 'package:inventoryapp/app/modules/register/register_binding.dart';
import 'package:inventoryapp/app/modules/register/register_screen.dart';
import 'package:inventoryapp/app/routes/app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterScreen(), // ✅ Use the correct class name
      binding: RegisterBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeDashboard(),
      binding: HomeBinding(),
    ),
  ];
}
