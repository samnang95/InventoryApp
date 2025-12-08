import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/api/controllers/stock_in_controller.dart';
import 'package:inventoryapp/api/controllers/stock_out_controller.dart';
import 'package:inventoryapp/api/models/stock_in_model.dart';
import 'package:inventoryapp/api/models/stock_out_model.dart';
import 'package:inventoryapp/app/constants/app_spacing.dart';
import 'package:inventoryapp/app/constants/app_widget_size.dart';
import 'package:inventoryapp/app/helper/datetime_helper.dart';
import 'package:inventoryapp/app/widgets/item_card_widget.dart';
import 'package:inventoryapp/app/widgets/text_background.dart';
import 'package:inventoryapp/modules/productDetail/productDetail_screen.dart';

class StockTabsWidget extends StatelessWidget {
  final List<StockInModel> stockInItems;
  final List<StockOutModel> stockOutItems;

  StockTabsWidget({
    super.key,
    required this.stockInItems,
    required this.stockOutItems,
  });

  final StockInController stockInController = Get.put(StockInController());
  final StockOutController stockOutController = Get.put(StockOutController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [

          // Tabs
          TabBar(
            dividerHeight: 0,
            indicatorColor: Colors.blue,
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor: Colors.black54,
            tabs: [
              Tab(text: "Stock In"),
              Tab(text: "Stock Out"),
            ],
          ),
          SizedBox(height: AppSpacing.paddingS),

          // Tab Views
          Expanded(
            child: TabBarView(
              children: [
                _buildStockInList(),
                _buildStockOutList(),
              ],
            ),
          ),
        ],
      ),
    );
  }


  /// STOCK IN LIST
  Widget _buildStockInList() {
    if (stockInItems.isEmpty) {
      return const Center(child: Text("No stock in records"));
    }

    return RefreshIndicator(
      onRefresh: () async {
        await stockInController.loadStockIn();
      },
      child: ListView.builder(
        itemCount: stockInItems.length,
        itemBuilder: (context, index) {

          final item = stockInItems[index];
          final result = DateTimeHelper.splitDateTime(item.date.toString());

          return ItemCardWidget(
            title: item.product!.name.toString(),
            icon: Icons.arrow_upward,
            subtitleWidget: Row(
              children: [
                Icon(Icons.date_range, size: AppWidgetSize.iconXS, color: Theme.of(context).colorScheme.primary),
                SizedBox(width: 2),
                Text(result['date'].toString()),

                SizedBox(width: AppSpacing.paddingS),

                Icon(Icons.access_time_rounded, size: AppWidgetSize.iconXS, color: Theme.of(context).colorScheme.primary),
                SizedBox(width: 2),
                Text(result['time'].toString()),
              ],
            ),
            trailing: TextBackground(
                text: item.quantity.toString(),
            ),
            onTap: (){
              Get.to(ProductDetailScreen(productId: item.productId));
            },

          );
        },
      ),
    );
  }


  /// STOCK OUT LIST
  Widget _buildStockOutList() {
    if (stockOutItems.isEmpty) {
      return const Center(child: Text("No stock out records"));
    }

    return RefreshIndicator(
      onRefresh: () async {
        await stockOutController.loadStockOut();
      },
      child: ListView.builder(
        itemCount: stockOutItems.length,
        itemBuilder: (context, index) {

          final item = stockOutItems[index];
          final result = DateTimeHelper.splitDateTime(item.date.toString());

          return ItemCardWidget(
              title: item.product!.name.toString(),
              icon: Icons.arrow_downward,
              iconColor: Theme.of(context).colorScheme.error,
              iconBackgroundColor: Theme.of(context).colorScheme.error.withOpacity(0.15),
              subtitleWidget: Row(
                children: [
                  Icon(Icons.date_range, size: AppWidgetSize.iconXS, color: Theme.of(context).colorScheme.primary),
                  SizedBox(width: 2),
                  Text(result['date'].toString()),

                  SizedBox(width: AppSpacing.paddingS),

                  Icon(Icons.access_time_rounded, size: AppWidgetSize.iconXS, color: Theme.of(context).colorScheme.primary),
                  SizedBox(width: 2),
                  Text(result['time'].toString()),
                ],
              ),
              trailing: TextBackground(
                text: item.quantity.toString(),
                backgroundColor: Theme.of(context).colorScheme.error.withOpacity(0.15),
                textColor: Theme.of(context).colorScheme.error,
              ),
              onTap: (){
                Get.to(ProductDetailScreen(productId: item.productId));
              },
          );
        },
      ),
    );
  }
}