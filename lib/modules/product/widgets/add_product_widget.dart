import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/app/constants/app_spacing.dart';
import 'package:inventoryapp/modules/product/product_controller.dart';

void showAddProductSheet(BuildContext context, int selectedCategoryId) {
  final controller = Get.find<ProductController>();
  controller.categoryId.value = selectedCategoryId;

  // Clear previous values
  controller.nameController.clear();
  controller.skuController.clear();
  controller.brandController.clear();
  controller.priceController.clear();
  controller.descriptionController.clear();

  Get.bottomSheet(
    SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add New Product",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: controller.nameController,
              decoration: const InputDecoration(
                hintText: "Product Name",
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: controller.skuController,
              decoration: const InputDecoration(
                hintText: "SKU",
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: controller.brandController,
              decoration: const InputDecoration(
                hintText: "Brand",
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: controller.priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Price",
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: controller.descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: "Description",
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.addProduct,
                child: const Text("Add Product"),
              ),
            ),
            SizedBox(height: AppSpacing.paddingM),
          ],
        ),
      ),
    ),
    isScrollControlled: true,
    backgroundColor: Theme.of(context).cardColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
  );
}