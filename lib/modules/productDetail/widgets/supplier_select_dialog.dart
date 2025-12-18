import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/api/controllers/product_controller.dart';
import 'package:inventoryapp/api/controllers/supplier_controller.dart';
import 'package:inventoryapp/api/models/product_model.dart';
import 'package:inventoryapp/app/constants/app_spacing.dart';
import 'package:inventoryapp/app/widgets/item_card_widget.dart';
import 'package:inventoryapp/modules/supplier/supplier_screen.dart';

class SupplierSelectionDialog extends StatelessWidget {

  final int productId;
  final ProductController productController = Get.put(ProductController());
  final Function()? onUpdated;

  SupplierSelectionDialog({super.key, required this.productId, this.onUpdated});

  @override
  Widget build(BuildContext context) {
    final SupplierController controller = Get.put(SupplierController());

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: EdgeInsets.all(AppSpacing.paddingL),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.6,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Supplier",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppSpacing.paddingM),

            // Button to navigate to Supplier Screen
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text("Go to Supplier Screen"),
                onPressed: () {
                  Get.to(() => SupplierScreen());
                },
              ),
            ),

            SizedBox(height: AppSpacing.paddingM),

            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.suppliers.isEmpty) {
                  return const Center(
                    child: Text("No suppliers available"),
                  );
                }

                return ListView.builder(
                  itemCount: controller.suppliers.length,
                  itemBuilder: (context, index) {
                    final supplier = controller.suppliers[index];
                    return ItemCardWidget(
                      icon: Icons.store,
                      title: supplier.name ?? "No Name",
                      subtitle: supplier.contactInfo ?? "",
                      onTap: () async {
                        print(supplier.id);
                        final updatedProduct = ProductModel(supplierId: supplier.id);
                        await productController.updateProduct(productId);

                        if (onUpdated != null) onUpdated!();

                        Get.back();
                      },
                      showArrow: true,
                      trailing: null,
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}