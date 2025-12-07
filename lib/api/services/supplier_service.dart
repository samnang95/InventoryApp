import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inventoryapp/api/models/supplier_model.dart';
import 'package:inventoryapp/app/constants/app_constant.dart';
import 'package:inventoryapp/app/services/storage_service.dart';

class SupplierService {
  final StorageService _storage = StorageService();

  String get _token => _storage.token ?? "";

  // GET: all suppliers
  Future<List<SupplierModel>> getSuppliers() async {
    final res = await http.get(
      Uri.parse("${AppConstants.baseUrl}/api/suppliers"),
      headers: AppConstants.headers(_token),
    );

    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.map((e) => SupplierModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load suppliers");
    }
  }

  // GET: supplier by ID
  Future<SupplierModel> getSupplier(int id) async {
    final res = await http.get(
      Uri.parse("${AppConstants.baseUrl}/api/suppliers/$id"),
      headers: AppConstants.headers(_token),
    );

    return SupplierModel.fromJson(jsonDecode(res.body));
  }

  // POST: create supplier
  Future<SupplierModel> createSupplier(SupplierModel supplier) async {
    final res = await http.post(
      Uri.parse("${AppConstants.baseUrl}/api/suppliers"),
      headers: AppConstants.headers(_token),
      body: jsonEncode(supplier.toJson()),
    );

    return SupplierModel.fromJson(jsonDecode(res.body));
  }

  // PUT: update supplier
  Future<SupplierModel> updateSupplier(int id, SupplierModel supplier) async {
    final res = await http.put(
      Uri.parse("${AppConstants.baseUrl}/api/suppliers/$id"),
      headers: AppConstants.headers(_token),
      body: jsonEncode(supplier.toJson()),
    );

    return SupplierModel.fromJson(jsonDecode(res.body));
  }

  // DELETE: supplier
  Future<void> deleteSupplier(int id) async {
    await http.delete(
      Uri.parse("${AppConstants.baseUrl}/api/suppliers/$id"),
      headers: AppConstants.headers(_token),
    );
  }
}