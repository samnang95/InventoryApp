import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:inventoryapp/app/constants/app_spacing.dart';
import 'package:inventoryapp/app/widgets/summary_card_widget.dart';
import 'package:inventoryapp/modules/transactions/transactions_controller.dart';
import 'widgets/stock_tab_widget.dart';

class TransactionsScreen extends StatelessWidget {
  TransactionsScreen({super.key});

  final TransactionsController controller = Get.put(TransactionsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transactions"),
        // actions: [
        //   GestureDetector(
        //     onTap: (){
        //       controller.loadStockIn();
        //       controller.loadStockOut();
        //     },
        //     child: Icon(Icons.refresh),
        //   )
        // ],
        centerTitle: true,
      ),

      body: Obx(() {
        final dateFormatted =
        DateFormat("dd MMM, yyyy").format(controller.selectedDate.value);

        return Padding(
          padding: EdgeInsets.all(AppSpacing.paddingSM),
          child: Column(
            children: [

              /// Summary Card
              SummaryCardWidget(
                date: dateFormatted,
                items: controller.summaryItems.toList(),
                onDateTap: () async {
                  final selected = await showDatePicker(
                    context: context,
                    initialDate: controller.selectedDate.value,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                  );
                  if (selected != null) {
                    await controller.loadData(date: selected);
                  }
                },
              ),
              SizedBox(height: AppSpacing.paddingS),

              /// Tabs for stock in/out
              Expanded(
                child: StockTabsWidget(
                  stockInItems: controller.stockInList,
                  stockOutItems: controller.stockOutList,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}