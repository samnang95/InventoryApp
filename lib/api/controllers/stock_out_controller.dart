import 'package:get/get.dart';
import 'package:inventoryapp/api/models/stock_out_model.dart';
import 'package:inventoryapp/api/services/stock_out_service.dart';

class StockOutController extends GetxController {
  final StockOutService _service = StockOutService();

  var stockOutList = <StockOutModel>[].obs;

  var isLoading = false.obs;

  // Validation Errors
  var quantityError = "".obs;
  var dateError = "".obs;

  @override
  void onInit() {
    super.onInit();
    loadStockOut();
  }

  /// ===== LOAD LIST =====
  Future<void> loadStockOut({String? date}) async {
    try {
      isLoading.value = true;

      // Call service with string date
      stockOutList.value = await _service.getStockOutList(date: date);
    } finally {
      isLoading.value = false;
    }
  }

  /// ===== ADD STOCK OUT =====
  Future<void> addStockOut(StockOutModel model) async {
    try {
      isLoading.value = true;

      // Clear errors
      quantityError.value = "";
      dateError.value = "";

      final newItem = await _service.createStockOut(model);
      stockOutList.insert(0, newItem);
    } finally {
      isLoading.value = false;
    }
  }

  /// ===== DELETE STOCK OUT =====
  Future<bool> deleteStockOut(int id) async {
    try {
      isLoading.value = true;
      final success = await _service.deleteStockOut(id);

      if (success) {
        stockOutList.removeWhere((item) => item.id == id);
      }
      return success;
    } finally {
      isLoading.value = false;
    }
  }
}