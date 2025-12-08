import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/api/models/product_model.dart';
import 'package:inventoryapp/api/services/product_service.dart';

class ProductController extends GetxController {

  final ProductService _service = Get.put(ProductService());

  var products = <ProductModel>[].obs;
  var isLoading = false.obs;

  String? searchQuery;
  String? sortQuery;
  int? filterCategoryId;
  int? filterSupplierId;

  //Product Detail
  var productDetail = Rxn<ProductModel>();
  var isDetailLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadProducts();
  }

  /// Load Product
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

  /// Create Product
  Future<void> createProduct(ProductModel product) async {
    try {
      isLoading.value = true;
      final newProduct = await _service.createProduct(product);
      products.insert(0, newProduct);
    } finally {
      isLoading.value = false;
    }
  }

  /// Update product
  Future<void> updateProduct(int id, ProductModel product) async {
    try {
      isLoading.value = true;
      final updatedProduct = await _service.updateProduct(id, product);
      final index = products.indexWhere((p) => p.id == id);
      if (index != -1) products[index] = updatedProduct;
    } finally {
      isLoading.value = false;
    }
  }

  /// Delete Product
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

  /// Product Detail
  Future<void> loadProductDetail(int id) async {
    try {
      isDetailLoading.value = true;
      productDetail.value = await _service.getProductDetail(id);
    } finally {
      isDetailLoading.value = false;
    }
  }
}