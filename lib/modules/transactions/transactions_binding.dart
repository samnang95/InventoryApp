import 'package:get/get.dart';
import 'package:inventoryapp/modules/transactions/transactions_controller.dart';

class TransactionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionsController>(() => TransactionsController());
  }
}