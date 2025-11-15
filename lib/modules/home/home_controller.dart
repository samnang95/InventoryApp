import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/widgets/summary_card_widget.dart';

class HomeController extends GetxController {
  // Summary items list (RxList)
  final summaryItems = <SummaryItem>[].obs;

  @override
  void onInit() {
    super.onInit();

    // Initialize summary items
    summaryItems.addAll([
      SummaryItem(
        label: "Total",
        value: "100",
        icon: Icons.inventory,
        color: Colors.yellow,
      ),
      SummaryItem(
        label: "Stock In",
        value: "50",
        icon: Icons.arrow_downward,
        color: Colors.green,
      ),
      SummaryItem(
        label: "Stock Out",
        value: "50",
        icon: Icons.arrow_upward,
        color: Colors.red,
      ),
    ]);
  }
}