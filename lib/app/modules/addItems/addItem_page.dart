import 'package:inventoryapp/app/modules/addItems/addItem_binding.dart';
import 'package:inventoryapp/app/modules/addItems/addItem_screen.dart';
import 'package:inventoryapp/app/routes/app_routes.dart';
import 'package:get/get.dart';

class AdditemPage {
  static final routes = [
    GetPage(
      name: AppRoutes.additem,
      page: () => AdditemScreen(),
      binding: AdditemBinding(),
    ),
  ];
}
