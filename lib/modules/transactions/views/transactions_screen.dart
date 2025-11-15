import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/app/constants/app_color.dart';
import 'package:inventoryapp/app/widgets/item_card_widget.dart';
import 'package:inventoryapp/app/widgets/summary_card_widget.dart';
import 'package:inventoryapp/modules/transactions/widgets/add_stock_dialog.dart';
import '../controllers/transactions_controller.dart';

class TransactionsScreen extends StatelessWidget {
  TransactionsScreen({super.key});

  final TransactionsController transactionsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transactions"),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SummaryCardWidget(
            date: "Today, Nov 15",
            items: transactionsController.summaryItems,
          ),
          const SizedBox(height: 24),
          Obx(() {
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: transactionsController.transactions.length,
              separatorBuilder: (_, __) => const SizedBox(height: 4.0),
              itemBuilder: (context, index) {
                final item = transactionsController.transactions[index];
                return ItemCardWidget(
                  icon: item["icon"],
                  title: item["title"],
                  subtitle: item["desc"],
                  onTap: () => transactionsController.navigateTo(item["title"]),
                );
              },
            );
          }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () => AddStockDialog.show(),
        child: const Icon(Icons.add, size: 32),
      ),
    );
  }
}