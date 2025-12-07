import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/api/models/supplier_model.dart';
import 'package:inventoryapp/api/services/supplier_service.dart';

class SupplierController extends GetxController {
  final SupplierService _service = SupplierService();

  RxList<SupplierModel> suppliers = <SupplierModel>[].obs;
  RxBool isLoading = false.obs;

  // Load all suppliers
  Future<void> loadSuppliers() async {
    isLoading.value = true;
    suppliers.value = await _service.getSuppliers();
    isLoading.value = false;
  }

  // Create supplier
  Future<void> createSupplier(SupplierModel supplier) async {
    await _service.createSupplier(supplier);
    await loadSuppliers();
  }

  // Update supplier
  Future<void> updateSupplier(int id, SupplierModel supplier) async {
    await _service.updateSupplier(id, supplier);
    await loadSuppliers();
  }

  // Delete supplier
  Future<void> deleteSupplier(int id) async {
    Get.defaultDialog(
      title: "Confirm Delete",
      middleText: "Are you sure you want to delete this supplier?",
      textCancel: "No",
      textConfirm: "Yes",
      confirmTextColor: Colors.white,
      onConfirm: () async {
        Get.back();
        try {
          await _service.deleteSupplier(id);
          suppliers.removeWhere((s) => s.id == id);
        } catch (e) {
          print(e);
        }
      },
    );
  }
}