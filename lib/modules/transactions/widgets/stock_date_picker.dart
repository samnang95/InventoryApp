import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class StockDatePicker extends StatelessWidget {
  final Rx<DateTime> selectedDate;
  final void Function(BuildContext) pickDate;
  final String label;

  const StockDatePicker({
    super.key,
    required this.selectedDate,
    required this.pickDate,
    this.label = "Select Date",
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final date = selectedDate.value;
      return GestureDetector(
        onTap: () => pickDate(context),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat.yMMMd().format(date),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Icon(Icons.calendar_today, color: Colors.grey),
            ],
          ),
        ),
      );
    });
  }
}