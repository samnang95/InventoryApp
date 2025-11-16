import 'package:flutter/material.dart';
import 'package:inventoryapp/app/constants/app_color.dart';
import 'package:inventoryapp/app/constants/app_spacing.dart';
import 'stock_transaction_card.dart';

class StockTabWidget extends StatelessWidget {
  final List<Map<String, dynamic>> stockInItems;
  final List<Map<String, dynamic>> stockOutItems;

  const StockTabWidget({
    super.key,
    required this.stockInItems,
    required this.stockOutItems,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: AppSpacing.paddingM),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: AppColors.primary,
              indicator: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: const [
                Tab(text: "Stock In"),
                Tab(text: "Stock Out"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildStockList(stockInItems),
                _buildStockList(stockOutItems),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStockList(List<Map<String, dynamic>> items) {
    if (items.isEmpty) {
      return const Center(child: Text("No data available"));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return StockTransactionCard(
          productName: item['name'],
          type: item['type'],
          quantity: item['quantity'],
          date: item['date'],
        );
      },
    );
  }
}