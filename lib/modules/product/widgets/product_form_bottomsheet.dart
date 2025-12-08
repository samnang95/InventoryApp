import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventoryapp/api/controllers/category_controller.dart';
import 'package:inventoryapp/api/controllers/product_controller.dart';
import 'package:inventoryapp/api/controllers/supplier_controller.dart';
import 'package:inventoryapp/api/models/product_model.dart';
import 'package:inventoryapp/app/constants/app_spacing.dart';

class ProductFormBottomSheet {
  static void open({ProductModel? product}) {

    final CategoryController categoryController = Get.put(CategoryController());
    final ProductController controller = Get.put(ProductController());
    final SupplierController supplierController = Get.put(SupplierController());

    // Form controllers
    final nameCtrl = TextEditingController(text: product?.name ?? '');
    final brandCtrl = TextEditingController(text: product?.brand ?? '');
    final skuCtrl = TextEditingController(text: product?.sku ?? '');
    final descCtrl = TextEditingController(text: product?.description ?? '');
    final priceCtrl = TextEditingController(text: product?.price?.toString() ?? '');
    final stockCtrl = TextEditingController(text: product?.stockQuantity?.toString() ?? '');

    // Category & Supplier
    int? selectedCategory = product?.categoryId;
    int? selectedSupplier = product?.supplierId;

    // Validation flags
    final RxBool nameError = false.obs;
    final RxBool priceError = false.obs;
    final RxBool categoryError = false.obs;

    // Images (Base64 List)
    final RxList<String> base64Images =
        (product?.images ?? []).map((e) => e.toString()).toList().obs;

    final picker = ImagePicker();

    Future<void> pickImages() async {
      final picked = await picker.pickMultiImage();
      if (picked != null) {
        for (var img in picked) {
          final bytes = await File(img.path).readAsBytes();
          final base64Str = "data:image/png;base64,${base64Encode(bytes)}";
          base64Images.add(base64Str);
        }
      }
    }

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(AppSpacing.paddingL),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                product == null ? "Add Product" : "Update Product",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Name
              Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: nameCtrl,
                      decoration: const InputDecoration(labelText: "Product Name"),
                    ),
                    if (nameError.value)
                      const Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text(
                          "Product Name is required",
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                  ],
                );
              }),
              SizedBox(height: AppSpacing.paddingS),

              // Brand
              TextField(
                controller: brandCtrl,
                decoration: const InputDecoration(labelText: "Brand"),
              ),
              SizedBox(height: AppSpacing.paddingS),

              // Price
              Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: priceCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "Price"),
                    ),
                    if (priceError.value)
                      const Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text(
                          "Price is required",
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                  ],
                );
              }),
              SizedBox(height: AppSpacing.paddingS),

              // Stock
              TextField(
                controller: stockCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Stock Quantity"),
              ),
              SizedBox(height: AppSpacing.paddingS),

              // Description
              TextField(
                controller: descCtrl,
                maxLines: 3,
                decoration: const InputDecoration(labelText: "Description"),
              ),
              SizedBox(height: AppSpacing.paddingS),

              // Category Dropdown
              Obx(() {
                final categories = categoryController.categories;

                // Ensure selectedCategory exists in items, otherwise null
                final currentValue = categories.any((c) => c.id == selectedCategory)
                    ? selectedCategory
                    : null;

                print("-"*100);
                print(currentValue);
                print("-"*100);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonFormField<int>(
                      value: currentValue,
                      decoration: const InputDecoration(labelText: "Category"),
                      items: categories.map((c) => DropdownMenuItem(
                        value: c.id,
                        child: Text(c.name),
                      )).toList(),
                      onChanged: (v) {
                        selectedCategory = v;
                      },
                    ),
                    if (categoryError.value)
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

              // Images preview
              Obx(() {
                return Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ...base64Images.map((e) {
                      return Stack(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: MemoryImage(base64Decode(e.split(',').last)),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: GestureDetector(
                              onTap: () => base64Images.remove(e),
                              child: const CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.red,
                                child: Icon(Icons.close, size: 14, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                    GestureDetector(
                      onTap: pickImages,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade200,
                        ),
                        child: const Icon(Icons.add, size: 30),
                      ),
                    ),
                  ],
                );
              }),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () async {
                  // Reset errors
                  nameError.value = false;
                  priceError.value = false;
                  categoryError.value = false;

                  bool hasError = false;

                  if (nameCtrl.text.trim().isEmpty) {
                    nameError.value = true;
                    hasError = true;
                  }
                  if (priceCtrl.text.trim().isEmpty ||
                      double.tryParse(priceCtrl.text) == null) {
                    priceError.value = true;
                    hasError = true;
                  }
                  if (selectedCategory == null) {
                    categoryError.value = true;
                    hasError = true;
                  }

                  if (hasError) return;

                  // If category not selected, default to None
                  final categoryId = selectedCategory ?? 0;

                  final newProduct = ProductModel(
                    name: nameCtrl.text.trim(),
                    brand: brandCtrl.text.trim(),
                    description: descCtrl.text.trim(),
                    price: double.tryParse(priceCtrl.text) ?? 0.0,
                    stockQuantity: int.tryParse(stockCtrl.text) ?? 0,
                    categoryId: categoryId,
                    // supplierId: selectedSupplier,
                    images: base64Images,
                  );

                  if (product == null) {
                    await controller.createProduct(newProduct);
                  } else {
                    await controller.updateProduct(product.id!, newProduct);
                  }

                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: Text(product == null ? "Create" : "Update"),
              )
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }
}