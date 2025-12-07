import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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

  /// ==============================
  ///   STOCK IN TAB
  /// ==============================
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
              final picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              _inDate.value = picked;
              _inDateError.value = "";
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

  /// ==============================
  ///   STOCK OUT TAB
  /// ==============================
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
              final picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              _outDate.value = picked;
              _outDateError.value = "";
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

  /// ==============================
  ///   VALIDATION FUNCTIONS
  /// ==============================

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

    // SUCCESS → return result to caller
    Get.back(result: {
      "type": "in",
      "productId": widget.productId,
      "quantity": qty,
      "date": _inDate.value,
    });

    StockInModel data = StockInModel(
      productId: widget.productId,
      quantity: qty,
      date: _inDate.value.toString(),
    );

    await stockInController.addStockIn(data);

    Get.back();
  }

  Future<void> _validateStockOut() async {
    int? qty = int.tryParse(_outQtyController.text);

    if (qty == null || qty <= 0) {
      _outQtyError.value = "Quantity must be greater than 0";
      return;
    }

    if (qty > widget.currentStock) {
      _outQtyError.value = "Cannot stock out more than current stock.";
      return;
    }

    if (_outDate.value == null) {
      _outDateError.value = "Please select a date";
      return;
    }

    // SUCCESS → return result to caller
    Get.back(result: {
      "type": "out",
      "productId": widget.productId,
      "quantity": qty,
      "date": _outDate.value,
    });

    final model = StockOutModel(
      productId: widget.productId,
      quantity: qty,
      date: _outDate.value.toString(),
    );

    await stockOutController.addStockOut(model);
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
                ? DateFormat.yMMMMd().format(date)
                : "Select Date",
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