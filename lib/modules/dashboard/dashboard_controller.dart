import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {

  // Reactive variables for dashboard KPIs
  var totalProducts = 0.obs;
  var lowStockItems = 0.obs;
  var totalCategories = 0.obs;
  var inventoryValue = 0.0.obs;
  var stockInCount = 0.obs;
  var stockOutCount = 0.obs;

  // Sample recent activities
  var recentActivities = <Map<String, String>>[].obs;
  final kpiData = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchDashboardData();
    // Initialize transactions
    kpiData.addAll([
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
  }

  void fetchDashboardData() {
    // TODO: Replace with API calls
    totalProducts.value = 120;
    lowStockItems.value = 5;
    totalCategories.value = 8;
    inventoryValue.value = 50000.50;
    stockInCount.value = 20;
    stockOutCount.value = 15;

  }

  void onAddProduct() {
    Get.toNamed('/products/add');
  }

  void onScanBarcode() {
    Get.toNamed('/scanner');
  }
}