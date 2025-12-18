import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/api/models/product_model.dart';
import 'package:inventoryapp/api/services/product_service.dart';

class ProductController extends GetxController {
  final ProductService _service = Get.put(ProductService());

  // ===================== Product List =====================
  var products = <ProductModel>[].obs;
  var isLoading = false.obs;

  // ===================== Product Detail =====================
  var productDetail = Rxn<ProductModel>();
  var isDetailLoading = false.obs;

  // ===================== Filters & Search =====================
  String? searchQuery;
  String? sortQuery;
  int? filterCategoryId;
  int? filterSupplierId;

  // ===================== Form Controllers =====================
  final nameCtrl = TextEditingController();
  final brandCtrl = TextEditingController();
  final skuCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final stockCtrl = TextEditingController();

  var selectedCategory = Rxn<int>();
  var selectedSupplier = Rxn<int>();
  var selectedImage = Rx<File?>(null);

  // Validation flags
  var nameError = false.obs;
  var priceError = false.obs;
  var categoryError = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadProducts();
  }

  @override
  void onClose() {
    // Dispose all text controllers
    nameCtrl.dispose();
    brandCtrl.dispose();
    skuCtrl.dispose();
    descCtrl.dispose();
    priceCtrl.dispose();
    stockCtrl.dispose();
    super.onClose();
  }

  // ===================== Load Products =====================
  Future<void> loadProducts() async {
    try {
      isLoading.value = true;
      products.value = await _service.getProducts(
        search: searchQuery,
        sort: sortQuery,
        categoryId: filterCategoryId,
        supplierId: filterSupplierId,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void searchProducts(String query) {
    searchQuery = query;
    loadProducts();
  }

  void sortProducts(String sort) {
    sortQuery = sort;
    loadProducts();
  }

  void filterProductCategory({int? categoryId, int? supplierId}) {
    searchQuery = null;
    sortQuery = null;
    filterCategoryId = categoryId;
    filterSupplierId = supplierId;
    loadProducts();
  }

  // ===================== Load Product Detail =====================
  Future<void> loadProductDetail(int id) async {
    try {
      isDetailLoading.value = true;
      productDetail.value = await _service.getProductDetail(id);
    } finally {
      isDetailLoading.value = false;
    }
  }

  // ===================== Prepare Form =====================
  void prepareForm({ProductModel? product}) {
    nameCtrl.text = product?.name ?? '';
    brandCtrl.text = product?.brand ?? '';
    skuCtrl.text = product?.sku ?? '';
    descCtrl.text = product?.description ?? '';
    priceCtrl.text = product?.price?.toString() ?? '';
    stockCtrl.text = product?.stockQuantity?.toString() ?? '';

    selectedCategory.value = product?.categoryId;
    selectedSupplier.value = product?.supplierId;
    selectedImage.value = null; // reset picked image

    // Reset validation flags
    nameError.value = false;
    priceError.value = false;
    categoryError.value = false;
  }

  // ===================== Validate Form =====================
  bool _validateForm() {
    bool hasError = false;

    if (nameCtrl.text.trim().isEmpty) {
      nameError.value = true;
      hasError = true;
    } else {
      nameError.value = false;
    }

    if (priceCtrl.text.trim().isEmpty ||
        double.tryParse(priceCtrl.text) == null) {
      priceError.value = true;
      hasError = true;
    } else {
      priceError.value = false;
    }

    if (selectedCategory.value == null) {
      categoryError.value = true;
      hasError = true;
    } else {
      categoryError.value = false;
    }

    return !hasError;
  }

  // ===================== Create Product =====================
  Future<void> createProduct() async {
    if (!_validateForm()) return;

    final newProduct = ProductModel(
      name: nameCtrl.text.trim(),
      brand: brandCtrl.text.trim(),
      sku: skuCtrl.text.trim(),
      description: descCtrl.text.trim(),
      price: double.tryParse(priceCtrl.text) ?? 0.0,
      stockQuantity: int.tryParse(stockCtrl.text) ?? 0,
      categoryId: selectedCategory.value!,
      supplierId: selectedSupplier.value,
    );

    try {
      isLoading.value = true;
      final createdProduct =
      await _service.createProduct(newProduct, image: selectedImage.value);
      products.insert(0, createdProduct);

      Get.back();
      print("Success");
    } finally {
      isLoading.value = false;
    }
  }

  // ===================== Update Product =====================
  Future<void> updateProduct(int id) async {
    // ===================== Validation =====================
    nameError.value = nameCtrl.text.trim().isEmpty;
    priceError.value = priceCtrl.text.trim().isEmpty;
    categoryError.value = selectedCategory.value == null;

    if (nameError.value || priceError.value || categoryError.value) {
      Get.snackbar(
        "Error",
        "Please fill all required fields",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // ===================== Prepare ProductModel =====================
    final productToUpdate = ProductModel(
      id: id,
      name: nameCtrl.text.trim(),
      brand: brandCtrl.text.trim(),
      description: descCtrl.text.trim(),
      price: double.tryParse(priceCtrl.text) ?? 0.0,
      stockQuantity: int.tryParse(stockCtrl.text) ?? 0,
      categoryId: selectedCategory.value,
      supplierId: selectedSupplier.value, // optional
    );

    try {
      isLoading.value = true;

      // ===================== Call Service =====================
      final updatedProduct = await _service.updateProduct(
        id,
        productToUpdate,
        image: selectedImage.value,
      );

      // ===================== Update Local List =====================
      final index = products.indexWhere((p) => p.id == id);
      if (index != -1) products[index] = updatedProduct;

      Get.back(); // Close bottom sheet
      print("Success");
    } catch (e) {
      if (e is DioException && e.response?.statusCode == 422) {
        final errors = e.response?.data["errors"];
        print(errors.toString());
      } else {
        print(e.toString());
      }
    } finally {
      isLoading.value = false;
    }
  }

  // ===================== Delete Product =====================
  Future<void> deleteProduct(int id) async {
    Get.defaultDialog(
      title: "Confirm Delete",
      middleText: "Are you sure you want to delete this product?",
      textConfirm: "Yes",
      textCancel: "No",
      confirmTextColor: Colors.white,
      onConfirm: () async {
        Get.back(); // close dialog first
        try {
          isLoading.value = true;
          await _service.deleteProduct(id);
          products.removeWhere((p) => p.id == id);
        } finally {
          isLoading.value = false;
        }
      },
    );
  }
}