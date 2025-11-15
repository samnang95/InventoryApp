import 'package:get/get.dart';
import 'package:flutter/material.dart';

class StockOutController extends GetxController {
  // Form controllers
  final itemController = TextEditingController();
  final quantityController = TextEditingController();
  final priceController = TextEditingController();
  final batchController = TextEditingController();
  final notesController = TextEditingController();

  // Reactive fields
  var selectedUnit = "pcs".obs;
  var selectedLocation = "".obs;
  var selectedSupplierOrCustomer = "".obs;
  var selectedDate = DateTime.now().obs;

  // Sample dropdown data
  final units = ["pcs", "box", "kg", "liters"];
  final locations = ["Warehouse A", "Warehouse B", "Store 1", "Store 2"];
  final suppliers = ["Supplier A", "Supplier B", "Supplier C"];
  final customers = ["Customer X", "Customer Y", "Customer Z"];

  // Clear all fields
  void clearAll() {
    itemController.clear();
    quantityController.clear();
    priceController.clear();
    batchController.clear();
    notesController.clear();
    selectedUnit.value = "pcs";
    selectedLocation.value = "";
    selectedSupplierOrCustomer.value = "";
    selectedDate.value = DateTime.now();
  }

  // Pick date
  void pickDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) selectedDate.value = picked;
  }
}