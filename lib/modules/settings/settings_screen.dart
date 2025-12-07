import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/api/controllers/auth_controller.dart';
import 'package:inventoryapp/app/constants/app_spacing.dart';
import 'package:inventoryapp/app/controllers/theme_controller.dart';
import 'package:inventoryapp/app/widgets/item_card_widget.dart';
import 'package:inventoryapp/app/widgets/title_text_widget.dart';
import 'package:inventoryapp/modules/settings/settings_controller.dart';
import 'package:inventoryapp/modules/settings/widgets/profile_widget.dart';
import 'package:inventoryapp/app/routes/app_routes.dart';

class SettingsScreen extends GetView<SettingsController> {
  SettingsScreen({super.key});

  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final themeController = Get.put(ThemeController(), permanent: true);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// PROFILE
                GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.profile),
                  child: ProfileWidget(),
                ),
                SizedBox(height: AppSpacing.paddingL),

                // ----------------- TEAM MEMBERS -----------------
                TitleTextWidget(text: "Team Member"),
                ItemCardWidget(
                  icon: Icons.group_outlined,
                  title: "Staff",
                  onTap: () => controller.navigate("Members"),
                ),
                ItemCardWidget(
                  icon: Icons.handshake_outlined,
                  title: "Suppliers",
                  onTap: () => controller.navigate("Partners"),
                ),
                SizedBox(height: AppSpacing.paddingM),

                // ----------------- APPEARANCE -----------------
                TitleTextWidget(text: "Appearance"),
                Obx(() => ItemCardWidget(
                    icon: Icons.dark_mode_outlined,
                    title: themeController.isDarkMode.value
                        ? "Dark Mode"
                        : "Light Mode",
                    showArrow: false,
                    trailing: Switch(
                      value: themeController.isDarkMode.value,
                      onChanged: themeController.setTheme,
                      activeColor: theme.colorScheme.primary,
                    ),
                    onTap: themeController.toggleTheme,
                  ),
                ),
                SizedBox(height: AppSpacing.paddingM),

                // ----------------- SUPPORT -----------------
                TitleTextWidget(text: "Support"),
                ItemCardWidget(
                  icon: Icons.help_outline,
                  title: "About Us",
                  onTap: () => controller.navigate("Help & Docs"),
                ),
                ItemCardWidget(
                  icon: Icons.help_outline,
                  title: "Help & Docs",
                  onTap: () => controller.navigate("Help & Docs"),
                ),
                ItemCardWidget(
                  icon: Icons.call_outlined,
                  title: "Contact Us",
                  onTap: () => controller.navigate("Contact Us"),
                ),
                ItemCardWidget(
                  icon: Icons.gavel_outlined,
                  title: "Legal",
                  onTap: () => controller.navigate("Legal"),
                ),
                SizedBox(height: AppSpacing.paddingM),
                Center(
                  child: Text(
                    "App Version 3.3.3+485",
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                SizedBox(height: AppSpacing.paddingM),
                ItemCardWidget(
                  icon: Icons.login,
                  title: "Logout",
                  onTap: () => authController.logout(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}