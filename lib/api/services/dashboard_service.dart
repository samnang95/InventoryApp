import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inventoryapp/app/constants/app_constant.dart';
import 'package:inventoryapp/api/models/dashboard_model.dart';
import 'package:inventoryapp/app/services/storage_service.dart';

class DashboardService {
  final StorageService storageService = StorageService();

  Future<DashboardModel?> getDashboard() async {
    final token = storageService.token;
    if (token == null) return null;

    final uri = Uri.parse("${AppConstants.baseUrl}/api/dashboard");

    final response = await http.get(uri, headers: AppConstants.headers(token));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true && data['data'] != null) {
        return DashboardModel.fromJson(data['data']);
      }
    }

    return null;
  }
}