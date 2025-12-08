import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inventoryapp/app/constants/app_constant.dart';
import 'package:inventoryapp/app/services/storage_service.dart';
import 'package:inventoryapp/api/models/stock_in_model.dart';

class StockInService {
  final StorageService _storageService = StorageService();

  /// Create Stock In
  Future<StockInModel> createStockIn(StockInModel stockIn) async {
    final token = _storageService.token;
    final response = await http.post(
      Uri.parse("${AppConstants.baseUrl}/api/stock-in"),
      headers: AppConstants.headers(token!),
      body: jsonEncode(stockIn.toJson()),
    );

    if (response.statusCode == 201) {
      return StockInModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(jsonDecode(response.body)['message'] ?? 'Failed to create stock in');
    }
  }

  /// Get all Stock In
  Future<List<StockInModel>> getStockIn({String? date}) async {
    final token = _storageService.token;
    String url = "${AppConstants.baseUrl}/api/stock-in";

    if (date != null) {
      url += "?date=$date";
    }

    final response = await http.get(
      Uri.parse(url),
      headers: AppConstants.headers(token!),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((e) => StockInModel.fromJson(e)).toList();
    } else {
      throw Exception(jsonDecode(response.body)['message'] ?? 'Failed to get stock in');
    }
  }

  /// Delete Stock In
  Future<void> deleteStockIn(int id) async {
    final token = _storageService.token;
    final response = await http.delete(
      Uri.parse("${AppConstants.baseUrl}/api/stock-in/$id"),
      headers: AppConstants.headers(token!),
    );

    if (response.statusCode != 200) {
      throw Exception(jsonDecode(response.body)['message'] ?? 'Failed to delete stock in');
    }
  }
}