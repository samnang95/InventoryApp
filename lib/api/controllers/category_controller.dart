import 'package:get/get.dart';
import 'package:inventoryapp/api/models/category_model.dart';
import 'package:inventoryapp/api/services/category_service.dart';
import 'package:flutter/material.dart';

class CategoryController extends GetxController {
  final CategoryService _service = Get.put(CategoryService());

  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  RxBool loading = false.obs;

  var query = "".obs;
  var sort = "".obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  /// Fetch Category (Search, Sort, Get)
  Future<void> fetchCategories() async {
    loading.value = true;
    try {
      categories.value = await _service.getCategories(
        query: query.value,
        sort: sort.value,
      );
    } finally {
      loading.value = false;
    }
  }

  void onSearchChanged(String text) {
    query.value = text;
    fetchCategories();
  }

  void setSort(String value) {
    sort.value = value;
    fetchCategories();
  }

  /// Create Category
  Future<void> createCategory(CategoryModel category) async {
    final newCat = await _service.createCategory(category);
    categories.add(newCat);
  }

  /// Update Category
  Future<void> updateCategory(int id, CategoryModel category) async {
    final updated = await _service.updateCategory(id, category);
    int index = categories.indexWhere((c) => c.id == id);
    categories[index] = updated;
  }

  /// Delete Category
  Future<void> deleteCategory(int id) async {
    Get.defaultDialog(
      title: "Confirm Delete",
      middleText: "Are you sure you want to delete this category?",
      textCancel: "No",
      textConfirm: "Yes",
      confirmTextColor: Colors.white,
      onConfirm: () async {
        Get.back();
        try {
          await _service.deleteCategory(id);
          categories.removeWhere((c) => c.id == id);

          Get.defaultDialog(
            title: "Success",
            middleText: "Category deleted successfully",
          );await Future.delayed(const Duration(seconds: 3));
          Get.back();
        } catch (e) {
          Get.defaultDialog(
            title: "Error",
            middleText: "Cannot delete category. There are products linked to it.",
          );
          await Future.delayed(const Duration(seconds: 3));
          Get.back();
        }
      },
    );
  }

}