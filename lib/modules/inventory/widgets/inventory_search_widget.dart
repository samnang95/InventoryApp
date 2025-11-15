import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../inventory_controller.dart';

class InventorySearchRowWidget extends GetView<InventoryController> {
  const InventorySearchRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: Card(
            child: TextFormField(
              controller: controller.searchController,
              decoration: InputDecoration(
                hintText: "Search for an item",
                hintStyle: theme.textTheme.bodyMedium
                    ?.copyWith(color: theme.hintColor),
                prefixIcon: Icon(
                  Icons.search,
                  color: theme.iconTheme.color,
                ),
                filled: true,
                fillColor: theme.colorScheme.surface.withOpacity(0.2),
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Card(
          child: IconButton(
            icon: const Icon(Icons.filter_alt_outlined),
            onPressed: () {
              print("Filter button tapped");
            },
          ),
        ),
      ],
    );
  }
}