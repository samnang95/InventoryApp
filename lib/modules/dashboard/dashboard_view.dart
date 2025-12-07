import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/app/constants/app_spacing.dart';
import 'package:inventoryapp/app/routes/app_routes.dart';
import 'package:inventoryapp/app/widgets/item_card_widget.dart';
import 'package:inventoryapp/app/widgets/title_text_widget.dart';
import 'package:inventoryapp/modules/dashboard/dashboard_controller.dart';
import 'package:inventoryapp/app/widgets/kpi_card_widget.dart';
import 'package:inventoryapp/app/widgets/profile_card_widget.dart';

class DashboardView extends StatelessWidget {
  DashboardView({super.key});

  final DashboardController dashboardController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(AppSpacing.paddingSM),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileCardWidget(
                userName: "Samnang",
                imageUrl: "https://images.pexels.com/photos/1040880/pexels-photo-1040880.jpeg",
                iconData: Icons.search,
                onIconTap: (){
                  Get.toNamed(AppRoutes.search);
                },
                onTap: () {

                },
              ),
              SizedBox(height: AppSpacing.paddingM),
              _kpi(),
              SizedBox(height: AppSpacing.paddingM),
              _activities()
            ],
          ),
        ),
      ),
    );
  }

  Widget _kpi(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KpiCardWidget(
          rows: [
            [
              KpiItem(icon: Icons.inventory_2, value: "120", label: "Total Product", color: Colors.blue),
              KpiItem(icon: Icons.warning, value: "50", label: "Low Stock", color: Colors.red),
              KpiItem(icon: Icons.category, value: "8", label: "Categories", color: Colors.green),
            ],
          ],
        ),
        Row(
          children: [
            Expanded(
              child: KpiCardWidget(
                rows: [
                  [
                    KpiItem(icon: Icons.arrow_downward, value: "20", label: "Stock IN", color: Colors.green, layout: KpiIconLayout.row),
                  ],
                ],
              ),
            ),
            Expanded(
              child: KpiCardWidget(
                rows: [
                  [
                    KpiItem(icon: Icons.arrow_upward, value: "15", label: "Stock OUT", color: Colors.orange, layout: KpiIconLayout.row),
                  ],
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _activities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleTextWidget(
          text: "Recent Activities",
        ),
        ItemCardWidget(
          showArrow: false,
          icon: Icons.add_shopping_cart,
          title: "New product added",
          subtitle: "Laptop X200 added to Electronics",
          onTap: () {},
        ),
        ItemCardWidget(
          showArrow: false,
          icon: Icons.download,
          title: "Stock updated",
          subtitle: "12 pcs of Laptop X200 added",
          onTap: () {},
        ),
        ItemCardWidget(
          showArrow: false,
          icon: Icons.payment,
          title: "Order completed",
          subtitle: "Order #1023 has been completed",
          onTap: () {},
        ),
        ItemCardWidget(
          showArrow: false,
          icon: Icons.people,
          title: "New supplier added",
          subtitle: "Supplier ABC added to your list",
          onTap: () {Get.toNamed(AppRoutes.supplier);},
        ),
        ItemCardWidget(
          showArrow: false,
          icon: Icons.remove_shopping_cart,
          title: "Product removed",
          subtitle: "Old Mouse Model removed from inventory",
          onTap: () {},
        ),
      ],
    );
  }

}