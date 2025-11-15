import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/app/controllers/theme_controller.dart';
import 'package:inventoryapp/app/widgets/item_card_widget.dart';
import 'package:inventoryapp/modules/settings/settings_controller.dart';
import 'package:inventoryapp/modules/settings/widgets/profile_widget.dart';
import 'package:inventoryapp/app/routes/app_routes.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({super.key});

  Widget sectionTitle(BuildContext context, String title) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Text(
        title,
        style: theme.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.secondary,
        ),
      ),
    );
  }

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
                const SizedBox(height: 10),

                ItemCardWidget(
                  icon: Icons.qr_code_scanner_outlined,
                  title: "Barcode Scanning",
                  onTap: () => controller.navigate("Barcode Scanning"),
                ),

                // ----------------- DATA CENTER -----------------
                sectionTitle(context, "Data Center"),
                ItemCardWidget(
                  icon: Icons.category_outlined,
                  title: "Attributes",
                  onTap: () => controller.navigate("Attributes"),
                ),
                ItemCardWidget(
                  icon: Icons.location_on_outlined,
                  title: "Locations",
                  onTap: () => controller.navigate("Locations"),
                ),
                ItemCardWidget(
                  icon: Icons.handshake_outlined,
                  title: "Partners",
                  onTap: () => controller.navigate("Partners"),
                ),

                // ----------------- TEAM MEMBERS -----------------
                sectionTitle(context, "Team Members"),
                ItemCardWidget(
                  icon: Icons.people_alt_outlined,
                  title: "Team Details",
                  onTap: () => controller.navigate("Team Details"),
                ),
                ItemCardWidget(
                  icon: Icons.group_outlined,
                  title: "Members",
                  onTap: () => controller.navigate("Members"),
                ),

                // ----------------- APPEARANCE -----------------
                sectionTitle(context, "Appearance"),
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

                ItemCardWidget(
                  icon: Icons.display_settings_outlined,
                  title: "Display Settings",
                  onTap: () => controller.navigate("Display Settings"),
                ),

                // ----------------- SUPPORT -----------------
                sectionTitle(context, "Support"),
                ItemCardWidget(
                  icon: Icons.info_outline,
                  title: "Notice",
                  onTap: () => controller.navigate("Notice"),
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

                const SizedBox(height: 30),
                Center(
                  child: Text(
                    "App Version 3.3.3+485",
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}