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

  /// ===== GET ALL STOCK OUT =====
  Future<List<StockOutModel>> getStockOutList({String? date}) async {
    final token = _storage.token!;
    String urlString = "${AppConstants.baseUrl}/api/stock-out";

    if (date != null && date.isNotEmpty) {
      urlString += "?date=$date";
    }

    final url = Uri.parse(urlString);
    final response = await http.get(url, headers: AppConstants.headers(token));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((e) => StockOutModel.fromJson(e)).toList();
    }

    throw Exception("Failed to load stock out");
  }

  /// ===== CREATE STOCK OUT =====
  Future<StockOutModel> createStockOut(StockOutModel model) async {
    final url = Uri.parse("${AppConstants.baseUrl}/api/stock-out");
    final body = jsonEncode(model.toJson());

    final response = await http.post(url, headers: header, body: body);
    if (response.statusCode == 201 || response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return StockOutModel.fromJson(data);
    }

    throw Exception("Failed to create stock out");
  }

  /// ===== DELETE STOCK OUT =====
  Future<bool> deleteStockOut(int id) async {
    final url = Uri.parse("${AppConstants.baseUrl}/api/stock-out/$id");
    final response = await http.delete(url, headers: header);
    return response.statusCode == 200;
  }
}