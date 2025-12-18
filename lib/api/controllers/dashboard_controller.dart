import 'package:get/get.dart';
import 'package:inventoryapp/api/models/dashboard_model.dart';
import 'package:inventoryapp/api/services/dashboard_service.dart';

class DashboardController extends GetxController {
  final DashboardService service = DashboardService();

  var isLoading = false.obs;
  var dashboard = Rx<DashboardModel?>(null);

  @override
  void onInit() {
    super.onInit();
    loadDashboard();
  }

  Future<void> loadDashboard() async {
    try {
      isLoading.value = true;
      final data = await service.getDashboard();
      dashboard.value = data;
    } finally {
      isLoading.value = false;
    }
  }
}