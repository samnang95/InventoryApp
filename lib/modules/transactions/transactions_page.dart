import 'package:get/get.dart';
import 'package:inventoryapp/modules/transactions/transactions_binding.dart';
import 'package:inventoryapp/modules/transactions/views/transactions_screen.dart';
import 'package:inventoryapp/app/routes/app_routes.dart';
import 'package:inventoryapp/modules/transactions/views/add_stock_in_screen.dart';
import 'package:inventoryapp/modules/transactions/views/add_stock_out_screen.dart';

class TransactionsPage {
  static final routes = [
    GetPage(
      name: AppRoutes.transactions,
      page: () => TransactionsScreen(),
      binding: TransactionsBinding(),
    ),
    GetPage(
      name: AppRoutes.stockIn,
      page: () => AddStockInScreen(),
      binding: TransactionsBinding(),
    ),
    GetPage(
      name: AppRoutes.stockOut,
      page: () => AddStockOutScreen(),
      binding: TransactionsBinding(),
    ),
  ];
}
