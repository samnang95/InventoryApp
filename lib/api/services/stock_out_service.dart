import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inventoryapp/api/models/stock_out_model.dart';
import 'package:inventoryapp/app/constants/app_constant.dart';
import 'package:inventoryapp/app/services/storage_service.dart';

class StockOutService {
  final StorageService _storage = StorageService();

  // Get Token Header
  Map<String, String> get header {
    final token = _storage.token;
    return AppConstants.headers(token ?? "");
  }

  // ===== GET ALL STOCK OUT =====
  Future<List<StockOutModel>> getStockOutList() async {
    final url = Uri.parse("${AppConstants.baseUrl}/api/stock-out");
    final response = await http.get(url, headers: header);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)["data"];
      return data.map((e) => StockOutModel.fromJson(e)).toList();
    }

    throw Exception("Failed to load stock out");
  }

  // ===== CREATE STOCK OUT =====
  Future<StockOutModel> createStockOut(StockOutModel model) async {
    final url = Uri.parse("${AppConstants.baseUrl}/api/stock-out");
    final body = jsonEncode(model.toJson());

    final response = await http.post(url, headers: header, body: body);

    if (response.statusCode == 201 || response.statusCode == 200) {
      final data = jsonDecode(response.body)["data"];
      return StockOutModel.fromJson(data);
    }

    throw Exception("Failed to create stock out");
  }

  // ===== DELETE STOCK OUT =====
  Future<bool> deleteStockOut(int id) async {
    final url = Uri.parse("${AppConstants.baseUrl}/api/stock-out/$id");

    final response = await http.delete(url, headers: header);

    return response.statusCode == 200;
  }
}