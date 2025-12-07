import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class StockUpdateDialog extends StatefulWidget {

  final Map<String, dynamic> item;
  const StockUpdateDialog({super.key, required this.item});

  @override
  State<StockUpdateDialog> createState() => _StockUpdateDialogState();
}

class _StockUpdateDialogState extends State<StockUpdateDialog> {

  final TextEditingController _quantityController = TextEditingController();
  late Rx<DateTime> _selectedDate;
  late RxString _stockType;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now().obs;
    _stockType = "In".obs;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Text(
              "Update Stock - ${widget.item["name"]}",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Stock Type
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() => ChoiceChip(
                  label: const Text("Stock In"),
                  selected: _stockType.value == "In",
                  onSelected: (_) => _stockType.value = "In",
                  selectedColor: Colors.green,
                )),
                const SizedBox(width: 12),
                Obx(() => ChoiceChip(
                  label: const Text("Stock Out"),
                  selected: _stockType.value == "Out",
                  onSelected: (_) => _stockType.value = "Out",
                  selectedColor: Colors.red,
                )),
              ],
            ),
            const SizedBox(height: 16),

            // Quantity Input
            TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Quantity",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Date Picker
            Obx(() => InkWell(
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate.value,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (picked != null) _selectedDate.value = picked;
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(DateFormat.yMMMMd().format(_selectedDate.value)),
                    const Icon(Icons.calendar_today),
                  ],
                ),
              ),
            )),
            const SizedBox(height: 24),

            // Update Button
            SizedBox(
              width: double.infinity,
              child: Obx(() => ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  _stockType.value == "In" ? Colors.green : Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  final quantity = int.tryParse(_quantityController.text) ?? 0;
                  if (quantity <= 0) {
                    Get.snackbar("Error", "Enter a valid quantity");
                    return;
                  }

                  // UI-only: Show dialog with result
                  Get.back(result: {
                    "productId": widget.item["id"],
                    "type": _stockType.value,
                    "quantity": quantity,
                    "date": _selectedDate.value,
                  });
                },
                child: const Text(
                  "Update Stock",
                  style: TextStyle(color: Colors.white),
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}