import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/api/controllers/supplier_controller.dart';
import 'package:inventoryapp/app/constants/app_color.dart';
import 'package:inventoryapp/app/constants/app_spacing.dart';
import 'package:inventoryapp/app/widgets/item_card_widget.dart';
import 'package:inventoryapp/app/widgets/title_text_widget.dart';
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
      body: Column(
        children: [
          _search(),
          SizedBox(height: AppSpacing.paddingS),
          Expanded(child: _supplierList(context))
        ],
      )
    );
  }

  Widget _search() {
    return Padding(
      padding: EdgeInsets.all(AppSpacing.paddingM),
      child: TextFormField(
          decoration: InputDecoration(
            hintText: 'Search categories...',
            prefixIcon: const Icon(Icons.search),
          ),
          onChanged: controller.setSearch
      ),
    );
  }

  Widget _supplierList(BuildContext context){
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TitleTextWidget(text: "All Suppliers"),
              GestureDetector(
                onTap: (){
                  _showSortDialog(context);
                },
                child: const Icon(Icons.filter_alt, color: AppColors.primary),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.paddingXS),
          Expanded(
            child: Obx(() {
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
            }),
          ),
        ],
      ),
    );
  }

  void _showSortDialog(BuildContext context) {
    Get.defaultDialog(
      title: "Sort Supplier",
      titleStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.w700
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ItemCardWidget(
            title: "Name (Ascending)",
            icon: Icons.arrow_downward,
            showArrow: false,
            onTap: () {
              controller.setSort("name");
              Get.back();
            },
          ),
          ItemCardWidget(
            title: "Name (Descending)",
            icon: Icons.arrow_upward,
            showArrow: false,
            onTap: () {
              controller.setSort("-name");
              Get.back();
            },
          ),
        ],
      ),
    );
  }

}