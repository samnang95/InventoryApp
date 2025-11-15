import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/app/routes/app_routes.dart';
import 'package:inventoryapp/app/widgets/item_card_widget.dart';

class AddStockDialog extends StatelessWidget {
  const AddStockDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ItemCardWidget(
              icon: Icons.south,
              title: "Add Stock In",
              subtitle: "Add items to inventory",
              onTap: () {
                Get.back(); // Close dialog
                Get.toNamed(AppRoutes.stockIn);
              },
            ),
            const SizedBox(height: 12),
            ItemCardWidget(
              icon: Icons.north,
              title: "Add Stock Out",
              subtitle: "Remove items from inventory",
              onTap: () {
                Get.back(); // Close dialog
                Get.toNamed(AppRoutes.stockOut);
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Static helper to show the dialog
  static void show() {
    Get.dialog(const AddStockDialog());
  }
}