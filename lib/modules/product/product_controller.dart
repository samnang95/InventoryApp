import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {

  // TextControllers
  final nameController = TextEditingController();
  final skuController = TextEditingController();
  final brandController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

  // Selected category ID (passed from category screen)
  var categoryId = 0.obs;

  // Example list to store added products
  var productList = <Map<String, dynamic>>[].obs;

  void addProduct() {
    if (nameController.text.isEmpty || skuController.text.isEmpty) {
      Get.snackbar("Error", "Name and SKU cannot be empty");
      return;
    }

    final newProduct = {
      "id": DateTime.now().millisecondsSinceEpoch,
      "name": nameController.text,
      "sku": skuController.text,
      "category_id": categoryId.value,
      "brand": brandController.text,
      "price": double.tryParse(priceController.text) ?? 0,
      "description": descriptionController.text,
      "created_at": DateTime.now().toIso8601String(),
      "updated_at": DateTime.now().toIso8601String(),
    };

    productList.add(newProduct);
    Get.back(); // Close bottom sheet
    Get.snackbar("Success", "${nameController.text} added successfully");

    // Clear fields
    nameController.clear();
    skuController.clear();
    brandController.clear();
    priceController.clear();
    descriptionController.clear();
  }
}