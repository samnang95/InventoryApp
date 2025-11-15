import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/modules/transactions/controllers/stock_in_controller.dart';
import 'package:inventoryapp/modules/transactions/widgets/stock_date_picker.dart';
import 'package:inventoryapp/modules/transactions/widgets/stock_dropdown.dart';
import 'package:inventoryapp/modules/transactions/widgets/stock_text_field_widget.dart';

class AddStockInScreen extends StatelessWidget {
  AddStockInScreen({super.key});

  final StockInController stockInController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Stock In"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Scrollable Form
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  stockTextFieldWidget(stockInController.itemController, "Item Name"),
                  stockTextFieldWidget(stockInController.quantityController, "Quantity", keyboard: TextInputType.number),
                  StockDropdown(
                    label: "Unit",
                    items: stockInController.units,
                    selected: stockInController.selectedUnit,
                  ),
                  StockDropdown(
                    label: "Location",
                    items: stockInController.locations,
                    selected: stockInController.selectedLocation,
                  ),
                  StockDropdown(
                    label: "Supplier",
                    items: stockInController.suppliers,
                    selected: stockInController.selectedSupplierOrCustomer,
                  ),
                  stockTextFieldWidget(stockInController.priceController, "Price", keyboard: TextInputType.number),
                  stockTextFieldWidget(stockInController.batchController, "Batch / Lot Number"),
                  StockDatePicker(
                    selectedDate: stockInController.selectedDate,
                    pickDate: stockInController.pickDate,
                    label: "Select Date",
                  ),
                  stockTextFieldWidget(stockInController.notesController, "Notes", maxLines: 3),
                ].map((w) => Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: w,
                )).toList(),
              )
            ),
          ),

          // Submit Button
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.snackbar("Stock In", "Transaction saved successfully");
                    stockInController.clearAll();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Submit", style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}