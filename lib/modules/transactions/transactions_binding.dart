import 'package:get/get.dart';
import 'package:inventoryapp/modules/transactions/controllers/stock_in_controller.dart';
import 'package:inventoryapp/modules/transactions/controllers/stock_out_controller.dart';

class TransactionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StockInController>(() => StockInController());
    Get.lazyPut<StockOutController>(() => StockOutController());
  }
}