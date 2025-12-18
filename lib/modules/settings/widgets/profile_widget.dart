import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/api/controllers/dashboard_controller.dart';
import 'package:inventoryapp/app/constants/app_color.dart';
import 'package:inventoryapp/app/routes/app_routes.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final DashboardController controller = Get.put(DashboardController());

    return Obx(() {
      final dashboard = controller.dashboard.value;
      final user = dashboard?.user;
      final summary = dashboard?.summary;

      if (user == null || summary == null) {
        return const SizedBox(
          height: 120,
          child: Center(child: CircularProgressIndicator(color: Colors.white)),
        );
      }

      return GestureDetector(
        onTap: () => Get.toNamed(AppRoutes.profile),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.primary, AppColors.secondary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Avatar
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.5),
                        Colors.white.withOpacity(0.2),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: user.avatar?.isNotEmpty == true
                        ? NetworkImage(user.avatar!)
                        : const AssetImage('assets/images/s6.jpg') as ImageProvider,
                  ),
                ),
                const SizedBox(width: 16),

                // Name and Badges
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi, ${user.name ?? 'User'}",
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: [
                          Badge(
                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                            backgroundColor: Colors.yellow.shade200,
                            label: Text(
                              "${summary.totalProducts} items",
                              style: theme.textTheme.labelLarge,
                            ),
                          ),
                          Badge(
                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                            backgroundColor: Colors.green.shade200,
                            label: Text(
                              "${summary.totalStaff} staff",
                              style: theme.textTheme.labelLarge,
                            ),
                          ),
                          Badge(
                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                            backgroundColor: Colors.blue.shade200,
                            label: Text(
                              "${summary.totalSuppliers} supplier",
                              style: theme.textTheme.labelLarge,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const Icon(Icons.arrow_forward_ios, size: 20, color: Colors.white70),
              ],
            ),
          ),
        ),
      );
    });
  }
}