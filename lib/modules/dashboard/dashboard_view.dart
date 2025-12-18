import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/app/constants/app_spacing.dart';
import 'package:inventoryapp/app/routes/app_routes.dart';
import 'package:inventoryapp/app/widgets/item_card_widget.dart';
import 'package:inventoryapp/app/widgets/title_text_widget.dart';
import 'package:inventoryapp/app/widgets/kpi_card_widget.dart';
import 'package:inventoryapp/app/widgets/profile_card_widget.dart';
import '../../api/controllers/dashboard_controller.dart';

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
              _buildProfile(),
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

  Widget _buildProfile(){
    return Obx(() {
      final user = dashboardController.dashboard.value?.user;

      if (user == null) {
        return const SizedBox.shrink();
      }

      return ProfileCardWidget(
        userName: user.name ?? "Unknown",
        imageUrl: user.avatar.isNotEmpty == true
            ? user.avatar
            : "https://via.placeholder.com/150", // fallback image
        iconData: Icons.search,
        onIconTap: () {
          Get.toNamed(AppRoutes.search);
        },
        onTap: () {
          // Optional: Navigate to user profile page
          // Get.toNamed(AppRoutes.profile);
        },
      );
    });
  }

  Widget _kpi() {
    final DashboardController controller = Get.find<DashboardController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final dashboard = controller.dashboard.value;

      if (dashboard == null) {
        return const Center(child: Text("No dashboard data"));
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top KPI Row
          KpiCardWidget(
            rows: [
              [
                KpiItem(
                  icon: Icons.inventory_2,
                  value: dashboard.summary.totalProducts.toString(),
                  label: "Total Products",
                  color: Colors.blue,
                ),
                KpiItem(
                  icon: Icons.warning,
                  value: dashboard.summary.lowStock.toString(),
                  label: "Low Stock",
                  color: Colors.red,
                ),
                KpiItem(
                  icon: Icons.category,
                  value: dashboard.summary.totalCategories.toString(),
                  label: "Categories",
                  color: Colors.green,
                ),
              ],
            ],
          ),
          // Bottom Stock IN / OUT Row
          Row(
            children: [
              Expanded(
                child: KpiCardWidget(
                  rows: [
                    [
                      KpiItem(
                        icon: Icons.supervised_user_circle_rounded,
                        value: dashboard.summary.totalStaff.toString(), // replace with actual Stock IN if available
                        label: "Total Staff",
                        color: Colors.green,
                        layout: KpiIconLayout.row,
                      ),
                    ],
                  ],
                ),
              ),
              Expanded(
                child: KpiCardWidget(
                  rows: [
                    [
                      KpiItem(
                        icon: Icons.handshake_rounded,
                        value: dashboard.summary.totalSuppliers.toString(), // replace with actual Stock OUT if available
                        label: "Total Supplier",
                        color: Colors.orange,
                        layout: KpiIconLayout.row,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    });
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
          title: "Product",
          subtitle: "Manage all products",
          onTap: () {
            Get.toNamed(AppRoutes.product);
          },
        ),
        ItemCardWidget(
          showArrow: false,
          icon: Icons.supervised_user_circle_rounded,
          title: "User",
          subtitle: "Manage all users",
          onTap: () {
            Get.toNamed(AppRoutes.user);
          },
        ),
        // ItemCardWidget(
        //   showArrow: false,
        //   icon: Icons.download,
        //   title: "Stock",
        //   subtitle: "Manage all stocks",
        //   onTap: () {},
        // ),
        ItemCardWidget(
          showArrow: false,
          icon: Icons.people,
          title: "Supplier",
          subtitle: "Manage all suppliers",
          onTap: () {Get.toNamed(AppRoutes.supplier);},
        ),
      ],
    );
  }

}