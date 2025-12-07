import 'package:get/get.dart';
import 'package:inventoryapp/app/routes/app_routes.dart';
import 'package:inventoryapp/modules/supplier/supplier_screen.dart';

class SupplierPage {
  static final routes = [
    GetPage(
      name: AppRoutes.supplier,
      page: () => SupplierScreen(),
      // binding: BottomNavBinding(),
    ),
  ];
}