import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:inventoryapp/modules/splash/splash_binding.dart';
import 'package:inventoryapp/modules/splash/splash_screen.dart';
import 'package:inventoryapp/app/routes/app_routes.dart';

class SplashPage {
  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
  ];
}
