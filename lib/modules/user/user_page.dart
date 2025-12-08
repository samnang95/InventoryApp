import 'package:get/get.dart';
import 'package:inventoryapp/app/routes/app_routes.dart';
import 'package:inventoryapp/modules/user/user_view.dart';

class UserPage {
  static final routes = [
    GetPage(
      name: AppRoutes.user,
      page: () => UserView(),
      // binding: SearchBinding(),
    ),
  ];
}