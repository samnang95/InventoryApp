import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/modules/transactions/controllers/stock_out_controller.dart';
import 'package:inventoryapp/modules/transactions/widgets/stock_date_picker.dart';
import 'package:inventoryapp/modules/transactions/widgets/stock_dropdown.dart';
import 'package:inventoryapp/modules/transactions/widgets/stock_text_field_widget.dart';

class AddStockOutScreen extends StatelessWidget {
  AddStockOutScreen({super.key});

  final StockOutController stockOutController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Stock Out"),
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
                  stockTextFieldWidget(stockOutController.itemController, "Item Name"),
                  stockTextFieldWidget(stockOutController.quantityController, "Quantity", keyboard: TextInputType.number),
                  StockDropdown(
                    label: "Unit",
                    items: stockOutController.units,
                    selected: stockOutController.selectedUnit,
                  ),
                  StockDropdown(
                    label: "Location",
                    items: stockOutController.locations,
                    selected: stockOutController.selectedLocation,
                  ),
                  StockDropdown(
                    label: "Supplier",
                    items: stockOutController.suppliers,
                    selected: stockOutController.selectedSupplierOrCustomer,
                  ),
                  stockTextFieldWidget(stockOutController.priceController, "Price", keyboard: TextInputType.number),
                  stockTextFieldWidget(stockOutController.batchController, "Batch / Lot Number"),
                  StockDatePicker(
                    selectedDate: stockOutController.selectedDate,
                    pickDate: stockOutController.pickDate,
                    label: "Select Date",
                  ),
                  stockTextFieldWidget(stockOutController.notesController, "Notes", maxLines: 3),
                ].map((w) => Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: w,
                )).toList(),
              ),
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
                    stockOutController.clearAll();
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

  Widget _buildDropdown(String label, List<String> items, RxString selected) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey[100],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selected.value.isEmpty ? null : selected.value,
          isExpanded: true,
          hint: Text("Select $label"),
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (val) => selected.value = val ?? "",
        ),
      ),
    );
  }
}