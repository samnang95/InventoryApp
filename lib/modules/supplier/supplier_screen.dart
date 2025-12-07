import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/api/controllers/supplier_controller.dart';
import 'package:inventoryapp/app/constants/app_spacing.dart';
import 'package:inventoryapp/app/widgets/item_card_widget.dart';
import 'package:inventoryapp/modules/supplier/widgets/supplier_form.dart';

class SupplierScreen extends StatelessWidget {

  final SupplierController controller = Get.put(SupplierController());

  @override
  Widget build(BuildContext context) {
    controller.loadSuppliers();

    return Scaffold(
      appBar: AppBar(title: Text("Suppliers")),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.bottomSheet(
            SupplierForm(),
            isScrollControlled: true,
          );
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppSpacing.paddingS),
        child: Column(
          children: [
            Expanded(child: _supplierList())
          ],
        ),
      )
    );
  }

  Widget _supplierList(){
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }
      return ListView.builder(
        itemCount: controller.suppliers.length,
        itemBuilder: (context, index) {
          final s = controller.suppliers[index];
          return ItemCardWidget(
            icon: Icons.person,
            title: s.name,
            subtitle: s.contactInfo,
            trailing: GestureDetector(
              onTap: (){
                controller.deleteSupplier(s.id!.toInt());
              },
              child: Icon(Icons.delete, color: Colors.red),
            ),
            onTap: (){
              Get.bottomSheet(
                SupplierForm(supplier: s),
                isScrollControlled: true,
              );
            },
          );
        },
      );
    });
  }
}