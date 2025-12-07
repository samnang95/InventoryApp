import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/api/controllers/category_controller.dart';
import 'package:inventoryapp/api/models/category_model.dart';
import 'package:inventoryapp/app/constants/app_spacing.dart';

class CategoryBottomSheet extends StatelessWidget {
  final CategoryModel? category;

  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();

  final controller = Get.find<CategoryController>();

  CategoryBottomSheet({super.key, this.category}) {
    if (category != null) {
      _nameCtrl.text = category!.name;
      _descCtrl.text = category!.description ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  height: 4,
                  width: 50,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              // Title
              Text(
                category == null ? "Add New Category" : "Edit Category",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),

              SizedBox(height: AppSpacing.paddingXXL),

              // Name
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(
                  hintText: "Category Name",
                ),
              ),

              const SizedBox(height: 12),

              // Description
              TextFormField(
                controller: _descCtrl,
                decoration: const InputDecoration(
                  hintText: "Category Description",
                ),
              ),

              SizedBox(height: AppSpacing.paddingXXL),

              // Submit button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final data = CategoryModel(
                      name: _nameCtrl.text.trim(),
                      description: _descCtrl.text.trim(),
                    );

                    if (category == null) {
                      controller.createCategory(data);
                    } else {
                      controller.updateCategory(category!.id!, data);
                    }

                    Get.back();
                  },
                  child: Text(category == null ? "Add Category" : "Update Category"),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}