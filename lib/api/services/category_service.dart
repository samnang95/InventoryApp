import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inventoryapp/api/models/category_model.dart';
import 'package:inventoryapp/app/constants/app_constant.dart';
import 'package:inventoryapp/app/services/storage_service.dart';
import 'package:get/get.dart';

class CategoryService {
  final StorageService _storage = Get.find();

  String get token => _storage.token ?? '';

  // Create
  Future<CategoryModel> createCategory(CategoryModel category) async {
    final response = await http.post(
      Uri.parse("${AppConstants.baseUrl}/api/categories"),
      headers: AppConstants.headers(token),
      body: jsonEncode(category.toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return CategoryModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to create category");
  }

  // Update
  Future<CategoryModel> updateCategory(int id, CategoryModel category) async {
    final response = await http.put(
      Uri.parse("${AppConstants.baseUrl}/api/categories/$id"),
      headers: AppConstants.headers(token),
      body: jsonEncode(category.toJson()),
    );

    if (response.statusCode == 200) {
      return CategoryModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to update category");
  }

  // Delete
  Future<void> deleteCategory(int id) async {
    final response = await http.delete(
      Uri.parse("${AppConstants.baseUrl}/api/categories/$id"),
      headers: AppConstants.headers(token),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to delete category");
    }
  }

  // List all
  Future<List<CategoryModel>> getCategories({String? query, String? sort}) async {
    final uri = Uri.parse("${AppConstants.baseUrl}/api/categories").replace(
      queryParameters: {
        if (query != null && query.isNotEmpty) 'q': query,
        if (sort != null && sort.isNotEmpty) 'sort': sort,
      },
    );

    final response = await http.get(
      uri,
      headers: AppConstants.headers(token),
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => CategoryModel.fromJson(e)).toList();
    }

    throw Exception("Failed to fetch categories");
  }

  // Get by ID
  Future<CategoryModel> getCategoryById(int id) async {
    final response = await http.get(
      Uri.parse("${AppConstants.baseUrl}/api/categories/$id"),
      headers: AppConstants.headers(token),
    );

    if (response.statusCode == 200) {
      return CategoryModel.fromJson(jsonDecode(response.body));
    }

    throw Exception("Category not found");
  }
}