import 'package:get/get.dart';

class TransactionsController extends GetxController {
  void stockIn() {
    Get.snackbar("Stock In", "Navigate to Stock In Page");
  }

  void stockOut() {
    Get.snackbar("Stock Out", "Navigate to Stock Out Page");
  }

  void moveStock() {
    Get.snackbar("Move Stock", "Navigate to Move Stock Page");
  }

  void adjustStock() {
    Get.snackbar("Adjust Stock", "Navigate to Adjust Stock Page");
  }
}
