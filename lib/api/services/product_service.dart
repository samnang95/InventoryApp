import 'dart:io';
import 'package:dio/dio.dart';
import 'package:inventoryapp/api/models/product_model.dart';
import 'package:inventoryapp/app/services/dio_service.dart';
import 'package:inventoryapp/app/services/storage_service.dart';

class ProductService {
  final StorageService _storage = StorageService();
  final Dio _dio = DioService().client;

  String get token => _storage.token ?? '';

  /// Get all products with optional search, sort, filter
  Future<List<ProductModel>> getProducts({
    String? search,
    String? sort,
    int? categoryId,
    int? supplierId,
  }) async {
    final queryParameters = <String, dynamic>{};

    if (search != null && search.isNotEmpty) queryParameters['q'] = search;
    if (sort != null && sort.isNotEmpty) queryParameters['sort'] = sort;
    if (categoryId != null) queryParameters['category'] = categoryId;
    if (supplierId != null) queryParameters['supplier'] = supplierId;

    final res = await _dio.get(
      '/api/products',
      queryParameters: queryParameters,
    );

    if (res.statusCode == 200) {
      final data = res.data['data'] as List;
      return data.map((e) => ProductModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load products");
    }
  }

  /// Create Product (with optional single image)
  Future<ProductModel> createProduct(ProductModel product,
      {File? image}) async {
    FormData formData;

    if (image != null) {
      formData = FormData.fromMap({
        ...product.toJson(),
        'image': await MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
        ),
      });
    } else {
      formData = FormData.fromMap(product.toJson());
    }

    final res = await _dio.post(
      '/api/products',
      data: formData,
      options: Options(
        contentType: 'multipart/form-data',
      ),
    );

    if (res.statusCode == 201 || res.statusCode == 200) {
      return ProductModel.fromJson(res.data);
    } else {
      throw Exception("Failed to create product");
    }
  }

  /// Update Product (with optional single image)
  Future<ProductModel> updateProduct(int id, ProductModel product, {File? image}) async {

    FormData formData;

    formData = FormData.fromMap({
      ...product.toJson(),
      '_method': 'PUT',
      if (image != null)
        'image': await MultipartFile.fromFile(image.path, filename: image.path.split('/').last,
        ),
    });

    final res = await _dio.post(
      '/api/products/$id',
      data: formData,
      options: Options(
        contentType: 'multipart/form-data',
      ),
    );

    if (res.statusCode == 200) {
      return ProductModel.fromJson(res.data);
    } else {
      throw Exception("Failed to update product");
    }
  }

  /// Delete Product
  Future<void> deleteProduct(int id) async {
    final res = await _dio.delete('/api/products/$id');

    if (res.statusCode != 200) {
      throw Exception("Failed to delete product");
    }
  }

  /// Product Detail
  Future<ProductModel> getProductDetail(int id) async {
    final res = await _dio.get('/api/products/$id');

    if (res.statusCode == 200) {
      return ProductModel.fromJson(res.data);
    } else {
      throw Exception("Failed to load product detail");
    }
  }
}