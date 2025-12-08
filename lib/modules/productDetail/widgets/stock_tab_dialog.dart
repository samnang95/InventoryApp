import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:inventoryapp/api/controllers/product_controller.dart';
import 'package:inventoryapp/api/controllers/stock_in_controller.dart';
import 'package:inventoryapp/api/controllers/stock_out_controller.dart';
import 'package:inventoryapp/api/models/stock_in_model.dart';
import 'package:inventoryapp/api/models/stock_out_model.dart';
import 'package:inventoryapp/app/constants/app_spacing.dart';
import 'package:inventoryapp/app/widgets/title_text_widget.dart';

class StockTabDialog extends StatefulWidget {
  final int productId;
  final int currentStock;

  const StockTabDialog({
    super.key,
    required this.productId,
    required this.currentStock,
  });

  @override
  State<StockTabDialog> createState() => _StockTabDialogState();
}

class _StockTabDialogState extends State<StockTabDialog> with SingleTickerProviderStateMixin {
  
  final StockInController stockInController = Get.put(StockInController());
  final StockOutController stockOutController = Get.put(StockOutController());
  final ProductController productController = Get.put(ProductController());
  
  late TabController _tabController;

  /// Stock In controllers
  final TextEditingController _inQtyController = TextEditingController();
  final Rx<DateTime?> _inDate = Rx<DateTime?>(null);

  /// Stock Out controllers
  final TextEditingController _outQtyController = TextEditingController();
  final Rx<DateTime?> _outDate = Rx<DateTime?>(null);

  /// Errors
  final RxString _inQtyError = "".obs;
  final RxString _inDateError = "".obs;

  final RxString _outQtyError = "".obs;
  final RxString _outDateError = "".obs;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _inQtyController.dispose();
    _outQtyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.paddingM),
        child: SizedBox(
          height: 380,
          child: Column(
            children: [
              TabBar(
                controller: _tabController,
                dividerHeight: 0,
                labelColor: Theme.of(context).colorScheme.primary,
                unselectedLabelColor: Colors.grey.shade700,
                tabs: const [
                  Tab(text: "Stock In"),
                  Tab(text: "Stock Out"),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildStockInTab(),
                    _buildStockOutTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// STOCK IN TAB
  Widget _buildStockInTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 10),

          TitleTextWidget(text: "Current Stock"),
          _buildCurrentStockField(),

          SizedBox(height: AppSpacing.paddingL),

          /// Quantity Input
          TextField(
            controller: _inQtyController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Quantity",
              border: OutlineInputBorder(),
            ),
            onChanged: (_) => _inQtyError.value = "",
          ),
          Obx(() => _errorText(_inQtyError.value)),

          const SizedBox(height: 10),

          /// Date Picker
          Obx(() => InkWell(
            onTap: () async {
              // Pick Date
              final pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );

              if (pickedDate != null) {
                // Pick Time
                final pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if (pickedTime != null) {
                  // Combine Date + Time
                  final combinedDateTime = DateTime(
                    pickedDate.year,
                    pickedDate.month,
                    pickedDate.day,
                    pickedTime.hour,
                    pickedTime.minute,
                  );

                  _inDate.value = combinedDateTime;
                  _inDateError.value = "";
                }
              }
            },
            child: _buildDateBox(_inDate.value),
          )),
          Obx(() => _errorText(_inDateError.value)),

          SizedBox(height: AppSpacing.paddingL),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _validateStockIn,
              child: const Text("Update Stock In"),
            ),
          )
        ],
      ),
    );
  }

  /// STOCK OUT TAB
  Widget _buildStockOutTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 10),

          TitleTextWidget(text: "Current Stock"),
          _buildCurrentStockField(),

          SizedBox(height: AppSpacing.paddingL),

          /// Quantity Input
          TextField(
            controller: _outQtyController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Quantity",
              border: OutlineInputBorder(),
            ),
            onChanged: (_) => _outQtyError.value = "",
          ),
          Obx(() => _errorText(_outQtyError.value)),

          const SizedBox(height: 10),

          /// Date Picker
          Obx(() => InkWell(
            onTap: () async {
              // Pick Date
              final pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );

              if (pickedDate != null) {
                // Pick Time
                final pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if (pickedTime != null) {
                  // Combine Date + Time
                  final combinedDateTime = DateTime(
                    pickedDate.year,
                    pickedDate.month,
                    pickedDate.day,
                    pickedTime.hour,
                    pickedTime.minute,
                  );

                  _outDate.value = combinedDateTime;
                  _outDateError.value = "";
                }
              }
            },
            child: _buildDateBox(_outDate.value),
          )),
          Obx(() => _errorText(_outDateError.value)),

          SizedBox(height: AppSpacing.paddingL),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _validateStockOut,
              child: const Text("Update Stock Out"),
            ),
          )
        ],
      ),
    );
  }

  /// VALIDATION FUNCTIONS
  Future<void> _validateStockIn() async {
    int? qty = int.tryParse(_inQtyController.text);

    if (qty == null || qty <= 0) {
      _inQtyError.value = "Quantity must be greater than 0";
      return;
    }
    if (_inDate.value == null) {
      _inDateError.value = "Please select a date";
      return;
    }

    StockInModel data = StockInModel(
      productId: widget.productId,
      quantity: qty,
      date: _inDate.value.toString(),
    );

    await stockInController.addStockIn(data);
    await productController.loadProductDetail(widget.productId);

    _inQtyController.clear();
    _inQtyError.value = "";
    _inDate.value = null;
    _inDateError.value = "";

    Get.back();
  }

  Future<void> _validateStockOut() async {
    int? qty = int.tryParse(_outQtyController.text);

    // Validate quantity
    if (qty == null || qty <= 0) {
      _outQtyError.value = "Quantity must be greater than 0";
      return;
    }

    // Validate current stock
    if (qty > widget.currentStock) {
      _outQtyError.value = "Cannot stock out more than current stock.";
      return;
    }

    // Validate date
    if (_outDate.value == null) {
      _outDateError.value = "Please select a date";
      return;
    }

    final model = StockOutModel(
      productId: widget.productId,
      quantity: qty,
      date: _outDate.value.toString(),
    );

    // Call API
    await stockOutController.addStockOut(model);

    // Reload product
    await productController.loadProductDetail(widget.productId);

    // Reset fields after successful update
    _outQtyController.clear();
    _outQtyError.value = "";
    _outDate.value = null;
    _outDateError.value = "";

    // Close dialog or bottom sheet
    Get.back();
  }

  /// ==============================
  ///   REUSABLE UI WIDGETS
  /// ==============================

  Widget _buildCurrentStockField() {
    return TextFormField(
      readOnly: true,
      initialValue: widget.currentStock.toString(),
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w800,
      ),
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
      ),
    );
  }

  Widget _buildDateBox(DateTime? date) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            date != null
                ? DateFormat('yyyy-MM-dd HH:mm').format(date)
                : "Select Date & Time",
          ),
          const Icon(Icons.calendar_today),
        ],
      ),
    );
  }

  Widget _errorText(String error) {
    if (error.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          error,
          style: const TextStyle(
            color: Colors.red,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}