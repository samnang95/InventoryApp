import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/app/modules/addItems/addItem_controller.dart';

class AdditemScreen extends GetView<AdditemController> {
  const AdditemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Item")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddItemBottomSheet(context);
        },
        child: const Icon(Icons.add),
      ),
      body: const Center(child: Text("Click + to Add Item")),
    );
  }

  void _showAddItemBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Name
              TextFormField(
                controller: controller.productNameController,
                decoration: const InputDecoration(labelText: "Product Name"),
              ),
              const SizedBox(height: 12),

              // Category Dropdown
              Obx(
                () => DropdownButtonFormField(
                  value: controller.selectedCategory.value.isEmpty
                      ? null
                      : controller.selectedCategory.value,
                  decoration: const InputDecoration(labelText: "Category"),
                  items: controller.categories
                      .map(
                        (cat) => DropdownMenuItem(value: cat, child: Text(cat)),
                      )
                      .toList(),
                  onChanged: (value) {
                    controller.selectedCategory.value = value!;
                  },
                ),
              ),
              const SizedBox(height: 12),

              // Brand Dropdown
              Obx(
                () => DropdownButtonFormField(
                  value: controller.selectedBrand.value.isEmpty
                      ? null
                      : controller.selectedBrand.value,
                  decoration: const InputDecoration(labelText: "Brand"),
                  items: controller.brands
                      .map(
                        (brand) =>
                            DropdownMenuItem(value: brand, child: Text(brand)),
                      )
                      .toList(),
                  onChanged: (value) {
                    controller.selectedBrand.value = value!;
                  },
                ),
              ),
              const SizedBox(height: 12),

              // Price
              TextFormField(
                controller: controller.priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Price"),
              ),
              const SizedBox(height: 12),

              // Description
              TextFormField(
                controller: controller.descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(labelText: "Description"),
              ),

              const SizedBox(height: 20),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Call your submit logic here
                    Get.back();
                    Get.snackbar("Success", "Item Added Successfully");
                  },
                  child: const Text("Save"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
