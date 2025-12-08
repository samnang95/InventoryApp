import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/api/models/stock_in_model.dart';
import 'package:inventoryapp/api/services/stock_in_service.dart';

class StockInController extends GetxController {
  final StockInService _service = StockInService();

  var stockInList = <StockInModel>[].obs;
  var isLoading = false.obs;

  // Optional: Keep selected date for filtering
  var selectedDate = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    loadStockIn();
  }

  /// Load stock in list
  Future<void> loadStockIn({DateTime? date}) async {
    try {
      isLoading.value = true;
      String? dateStr;
      if (date != null) {
        dateStr = "${date.year.toString().padLeft(4,'0')}-${date.month.toString().padLeft(2,'0')}-${date.day.toString().padLeft(2,'0')}";
      }
      stockInList.value = await _service.getStockIn(date: dateStr);
    } finally {
      isLoading.value = false;
    }
  }

  /// Add to stock
  Future<void> addStockIn(StockInModel stockIn) async {
    try {
      isLoading.value = true;
      final newStockIn = await _service.createStockIn(stockIn);
      stockInList.insert(0, newStockIn);
    } finally {
      isLoading.value = false;
    }
  }

  /// Delete Stock
  Future<void> deleteStockIn(int id) async {
    final confirmed = await Get.defaultDialog(
      title: "Confirm Delete",
      middleText: "Are you sure you want to delete this record?",
      textCancel: "No",
      textConfirm: "Yes",
      confirmTextColor: Colors.white,
      onConfirm: () async {
        Get.back(result: true);
      },
      onCancel: () {
        Get.back(result: false);
      },
    );

    if (confirmed != true) return;

    try {
      isLoading.value = true;
      await _service.deleteStockIn(id);
      stockInList.removeWhere((s) => s.id == id);
    } catch (e) {
      Get.defaultDialog(
        title: "Error",
        middleText: e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }
}