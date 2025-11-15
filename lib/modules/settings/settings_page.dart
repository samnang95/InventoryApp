import 'package:get/get.dart';
import 'package:inventoryapp/modules/settings/settings_binding.dart';
import 'package:inventoryapp/modules/settings/settings_screen.dart';
import 'package:inventoryapp/app/routes/app_routes.dart';

class SettingsPage {
  static final routes = [
    GetPage(
      name: AppRoutes.settings,
      page: () => SettingsScreen(),
      binding: SettingsBinding(),
    ),
  ];
}
