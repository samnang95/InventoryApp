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
      {
        "icon": Icons.east,
        "title": "Move Stock",
        "desc": "Transfer items between locations to stay organized and updated.",
      },
      {
        "icon": Icons.north_east,
        "title": "Adjust Stock",
        "desc": "Update item quantities to match actual stock and reconcile discrepancies in the system.",
      },
    ]);

    // Initialize summary items
    summaryItems.addAll([
      SummaryItem(label: "Total", value: "100", icon: Icons.inventory, color: Colors.yellow,),
      SummaryItem(label: "Stock In", value: "50", icon: Icons.arrow_downward, color: Colors.green,),
      SummaryItem(label: "Stock Out", value: "50", icon: Icons.arrow_upward, color: Colors.red,),
    ]);
  }
}