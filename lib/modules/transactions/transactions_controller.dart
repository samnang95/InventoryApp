import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/app/widgets/summary_card_widget.dart';

class TransactionsController extends GetxController {

  // Transactions list
  final transactions = <Map<String, dynamic>>[].obs;

  // Summary items list
  final summaryItems = <SummaryItem>[].obs;

  @override
  void onInit() {
    super.onInit();

    // Initialize transactions
    transactions.addAll([
      {
        "icon": Icons.south,
        "title": "Stock In",
        "desc": "Add items to inventory by choosing a location and quantity.",
      },
      {
        "icon": Icons.north,
        "title": "Stock Out",
        "desc": "Remove item from inventory by choosing a location and quantity.",
      },
    ]);

    // Initialize summary items
    summaryItems.addAll([
      SummaryItem(
        label: "Total",
        value: "100",
        icon: Icons.inventory,
        color: Colors.yellow,
      ),
      SummaryItem(
        label: "Stock In",
        value: "50",
        icon: Icons.arrow_downward,
        color: Colors.green,
      ),
      SummaryItem(
        label: "Stock Out",
        value: "50",
        icon: Icons.arrow_upward,
        color: Colors.red,
      ),
    ]);
  }

  /// Navigate to corresponding transaction screen
  void navigateTo(String title) {
    switch (title) {
      case "Stock In":
        // Get.toNamed(AppRoutes.stockIn);
        break;
      case "Stock Out":
        // Get.toNamed(AppRoutes.stockOut);
        break;
      case "Move Stock":
        // Get.to(() => const MoveStockScreen());
        break;
      case "Adjust Stock":
        // Get.to(() => const AdjustStockScreen());
        break;
      default:
        Get.snackbar("Unknown", "No screen available for $title");
    }
  }

}