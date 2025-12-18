import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/api/controllers/category_controller.dart';
import 'package:inventoryapp/api/controllers/product_controller.dart';
import 'package:inventoryapp/api/controllers/supplier_controller.dart';
import 'package:inventoryapp/app/constants/app_spacing.dart';
import 'package:inventoryapp/app/helper/image_picker_helper.dart';

class ProductFormBottomSheet {
  static void open({product}) {
    final ProductController controller = Get.put(ProductController());
    final CategoryController categoryController = Get.put(CategoryController());
    final SupplierController supplierController = Get.put(SupplierController());

    // Prepare form using product data if provided
    controller.prepareForm(product: product);

    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(AppSpacing.paddingL),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Text(
                product == null ? "Add Product" : "Update Product",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // ================= Name =================
              Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: controller.nameCtrl,
                    decoration: const InputDecoration(labelText: "Product Name *"),
                  ),
                  if (controller.nameError.value)
                    const Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        "Product Name is required",
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                ],
              )),
              SizedBox(height: AppSpacing.paddingS),

              // ================= Brand =================
              TextField(
                controller: controller.brandCtrl,
                decoration: const InputDecoration(labelText: "Brand *"),
              ),
              SizedBox(height: AppSpacing.paddingS),

              // ================= Price =================
              Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: controller.priceCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: "Price *"),
                  ),
                  if (controller.priceError.value)
                    const Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        "Price is required",
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                ],
              )),
              SizedBox(height: AppSpacing.paddingS),

              // ================= Stock Quantity =================
              TextField(
                controller: controller.stockCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Stock Quantity *"),
              ),
              SizedBox(height: AppSpacing.paddingS),

              // ================= Description (Optional) =================
              TextField(
                controller: controller.descCtrl,
                maxLines: 3,
                decoration: const InputDecoration(labelText: "Description"),
              ),
              SizedBox(height: AppSpacing.paddingS),

              // ================= Category Dropdown =================
              Obx(() {
                final categories = categoryController.categories;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonFormField<int>(
                      value: categories.any((c) => c.id == controller.selectedCategory.value)
                          ? controller.selectedCategory.value
                          : null,
                      decoration: const InputDecoration(labelText: "Category *"),
                      hint: const Text("Select category"),
                      items: categories
                          .map((c) => DropdownMenuItem(
                        value: c.id,
                        child: Text(c.name),
                      ))
                          .toList(),
                      onChanged: (v) => controller.selectedCategory.value = v,
                    ),
                    if (controller.categoryError.value)
                      const Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text(
                          "Category is required",
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                  ],
                );
              }),
              const SizedBox(height: 15),

              // ================= Supplier Dropdown =================
              Obx(() {
                final suppliers = supplierController.suppliers;
                if (suppliers.isEmpty) return const SizedBox();
                return DropdownButtonFormField<int>(
                  value: suppliers.any((s) => s.id == controller.selectedSupplier.value)
                      ? controller.selectedSupplier.value
                      : null,
                  decoration: const InputDecoration(labelText: "Supplier *"),
                  hint: const Text("Select supplier"),
                  items: suppliers
                      .map((s) => DropdownMenuItem(
                    value: s.id,
                    child: Text(s.name),
                  ))
                      .toList(),
                  onChanged: (v) => controller.selectedSupplier.value = v,
                );
              }),
              SizedBox(height: 15),

              // ================= Image Picker (Optional) =================
              Obx(() {
                ImageProvider? imageProvider;

                if (controller.selectedImage.value != null) {
                  imageProvider = FileImage(controller.selectedImage.value!);
                } else if (product?.image != null && product.image!.isNotEmpty) {
                  imageProvider = NetworkImage(product.image!);
                }

                return GestureDetector(
                  onTap: () async {
                    final file = await ImagePickerHelper.pickImageFromGallery();
                    if (file != null) controller.selectedImage.value = file;
                  },
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade200,
                      image: imageProvider != null
                          ? DecorationImage(fit: BoxFit.cover, image: imageProvider)
                          : null,
                    ),
                    child: imageProvider == null
                        ? const Icon(Icons.add_a_photo, size: 40)
                        : null,
                  ),
                );
              }),
              const SizedBox(height: 20),

              // ================= Submit Button =================
              ElevatedButton(
                onPressed: () {
                  if (product?.id == null) {
                    controller.createProduct();
                  } else {
                    controller.updateProduct(product.id!);
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: Text(product == null ? "Create" : "Update"),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }
}