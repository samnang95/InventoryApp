import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/app/constants/app_color.dart';
import 'package:inventoryapp/app/constants/app_spacing.dart';
import 'package:inventoryapp/app/widgets/summary_card_widget.dart';
import 'package:inventoryapp/modules/transactions/transactions_controller.dart';
import 'package:inventoryapp/modules/transactions/widgets/stock_tab_widget.dart';
import 'package:inventoryapp/modules/transactions/widgets/stock_transaction_card.dart';

class TransactionsScreen extends StatelessWidget {
  TransactionsScreen({super.key});

  final TransactionsController transactionsController = Get.find();

  final List<Map<String, dynamic>> stockIn = [
    {
      "name": "iPhone 15",
      "type": "Stock In",
      "quantity": 10,
      "date": "2025-01-01",
    },
    {
      "name": "Keyboard",
      "type": "Stock In",
      "quantity": 5,
      "date": "2025-01-03",
    },
  ];

  final List<Map<String, dynamic>> stockOut = [
    {
      "name": "iPhone 15",
      "type": "Stock Out",
      "quantity": 2,
      "date": "2025-01-05",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transactions"),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(AppSpacing.paddingSM),
            child: SummaryCardWidget(
              date: "Nov 16, 2025",
              onDateTap: () async {
                DateTime? selected = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
                if (selected != null) {
                  print("Selected date: $selected");
                }
              },
              items: transactionsController.summaryItems,
            ),
          ),
          Expanded(
            child: StockTabWidget(
              stockInItems: stockIn,
              stockOutItems: stockOut,
            ),
          ),
        ],
      ),
    );
  }
}