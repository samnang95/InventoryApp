import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:inventoryapp/api/services/stock_in_service.dart';
import 'package:inventoryapp/api/services/stock_out_service.dart';
import '../../api/models/stock_in_model.dart';
import '../../api/models/stock_out_model.dart';
import '../../app/widgets/summary_card_widget.dart';

class TransactionsController extends GetxController {
  final StockInService _stockInService = StockInService();
  final StockOutService _stockOutService = StockOutService();

  RxBool isLoading = false.obs;

  RxList<StockInModel> stockInList = <StockInModel>[].obs;
  RxList<StockOutModel> stockOutList = <StockOutModel>[].obs;

  Rx<DateTime> selectedDate = DateTime.now().obs;

  // Summary items (already SummaryItem model)
  RxList<SummaryItem> summaryItems = <SummaryItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadData(date: selectedDate.value);
  }

  Future<void> loadData({required DateTime date}) async {
    selectedDate.value = date;

    final formatted = DateFormat('yyyy-MM-dd').format(date);

    await loadStockIn(date: formatted);
    await loadStockOut(date: formatted);

    buildSummary();
  }

  Future<void> loadStockIn({String? date}) async {
    try {
      isLoading.value = true;
      stockInList.value = await _stockInService.getStockIn(date: date);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadStockOut({String? date}) async {
    try {
      isLoading.value = true;
      stockOutList.value = await _stockOutService.getStockOutList(date: date);
    } finally {
      isLoading.value = false;
    }
  }

  void buildSummary() {
    final totalIn = stockInList.fold<int>(0, (sum, e) => sum + (e.quantity ?? 0));
    final totalOut = stockOutList.fold<int>(0, (sum, e) => sum + (e.quantity ?? 0));

    summaryItems.value = [
      SummaryItem(
        label: "Stock In",
        value: "$totalIn",
        color: const Color(0xFF4CAF50),
        icon: Icons.arrow_downward,
      ),
      SummaryItem(
        label: "Stock Out",
        value: "$totalOut",
        color: const Color(0xFFF44336),
        icon: Icons.arrow_upward,
      ),
    ];
  }
}