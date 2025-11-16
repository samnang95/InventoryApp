import 'package:get/get.dart';
import 'package:inventoryapp/modules/dashboard/dashboard_binding.dart';
import 'package:inventoryapp/modules/dashboard/dashboard_view.dart';
import 'package:inventoryapp/app/routes/app_routes.dart';

class DashboardPage {
  static final routes = [
    GetPage(
      name: AppRoutes.dashboard,
      page: () => DashboardView(),
      binding: DashboardBinding(),
    ),
  ];
}