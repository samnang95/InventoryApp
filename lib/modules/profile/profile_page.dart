import 'package:get/get.dart';
import 'package:inventoryapp/modules/profile/profile_binding.dart';
import 'package:inventoryapp/modules/profile/profile_screen.dart';
import 'package:inventoryapp/app/routes/app_routes.dart';

class ProfilePage {
  static final routes = [
    GetPage(
      name: AppRoutes.profile,
      page: () => ProfileScreen(),
      binding: ProfileBinding(),
    ),
  ];
}
