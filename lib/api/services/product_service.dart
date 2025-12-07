import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inventoryapp/api/models/product_model.dart';
import 'package:inventoryapp/app/constants/app_constant.dart';
import 'package:inventoryapp/app/services/storage_service.dart';

class ProductService {

  final StorageService _storage = Get.find();
  String get token => _storage.token ?? '';

  /// Get all products with optional search, sort, filter
  Future<List<ProductModel>> getProducts({
    String? search,
    String? sort,
    int? categoryId,
    int? supplierId,
  }) async {
    var queryParams = <String, String>{};
    if (search != null && search.isNotEmpty) queryParams['q'] = search;
    if (sort != null && sort.isNotEmpty) queryParams['sort'] = sort;
    if (categoryId != null) queryParams['category'] = categoryId.toString();
    if (supplierId != null) queryParams['supplier'] = supplierId.toString();

    final uri = Uri.parse("${AppConstants.baseUrl}/api/products").replace(queryParameters: queryParams);
    final res = await http.get(uri, headers: AppConstants.headers(token));

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body)['data'] as List;
      return data.map((e) => ProductModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load products");
    }
  }

  /// Create Product
  Future<ProductModel> createProduct(ProductModel product) async {
    final uri = Uri.parse("${AppConstants.baseUrl}/api/products");
    final res = await http.post(uri, headers: AppConstants.headers(token), body: jsonEncode(product.toJson()));
    if (res.statusCode == 201) {
      return ProductModel.fromJson(jsonDecode(res.body));
    } else {
      throw Exception("Failed to create product");
    }
  }

  /// Update Product
  Future<ProductModel> updateProduct(int id, ProductModel product) async {
    final uri = Uri.parse("${AppConstants.baseUrl}/api/products/$id");
    final res = await http.put(uri, headers: AppConstants.headers(token), body: jsonEncode(product.toJson()));
    if (res.statusCode == 200) {
      return ProductModel.fromJson(jsonDecode(res.body));
    } else {
      throw Exception("Failed to update product");
    }
  }

  /// Delete Product
  Future<void> deleteProduct(int id) async {
    final uri = Uri.parse("${AppConstants.baseUrl}/api/products/$id");
    final res = await http.delete(uri, headers: AppConstants.headers(token));
    if (res.statusCode != 200) {
      throw Exception("Failed to delete product");
    }
  }

  /// Product Detail
  Future<ProductModel> getProductDetail(int id) async {
    final uri = Uri.parse("${AppConstants.baseUrl}/api/products/$id");
    final res = await http.get(uri, headers: AppConstants.headers(token));
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return ProductModel.fromJson(data);
    } else {
      throw Exception("Failed to load product detail");
    }
  }
}