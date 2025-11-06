import 'package:get/get.dart';
import 'package:inventoryapp/app/modules/transactions/transactions_binding.dart';
import 'package:inventoryapp/app/modules/transactions/transactions_screen.dart';
import 'package:inventoryapp/app/routes/app_routes.dart';

class TransactionsPage {
  static final routes = [
    GetPage(
      name: AppRoutes.transactions,
      page: () => TransactionsScreen(),
      binding: TransactionsBinding(),
    ),
  ];
}
