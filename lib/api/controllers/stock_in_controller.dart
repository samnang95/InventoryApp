import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/api/models/stock_in_model.dart';
import 'package:inventoryapp/api/services/stock_in_service.dart';

class StockInController extends GetxController {
  final StockInService _service = StockInService();

  var stockInList = <StockInModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadStockIn();
  }

  Future<void> loadStockIn() async {
    try {
      isLoading.value = true;
      stockInList.value = await _service.getStockIn();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addStockIn(StockInModel stockIn) async {
    try {
      isLoading.value = true;
      final newStockIn = await _service.createStockIn(stockIn);
      stockInList.insert(0, newStockIn);
    } finally {
      isLoading.value = false;
    }
  }

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