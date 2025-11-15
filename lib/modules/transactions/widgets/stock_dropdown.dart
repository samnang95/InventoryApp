import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StockDropdown extends StatelessWidget {
  final String label;
  final List<String> items;
  final RxString selected;

  const StockDropdown({
    super.key,
    required this.label,
    required this.items,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.grey[100],
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selected.value.isEmpty ? null : selected.value,
            isExpanded: true,
            hint: Text("Select $label"),
            items: items
                .map((e) => DropdownMenuItem(
              value: e,
              child: Text(e),
            ))
                .toList(),
            onChanged: (val) => selected.value = val ?? "",
          ),
        ),
      );
    });
  }
}