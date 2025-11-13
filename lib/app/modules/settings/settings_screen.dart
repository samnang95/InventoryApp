import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/app/controllers/theme_controller.dart';
import 'package:inventoryapp/app/modules/settings/settings_controller.dart';
import 'package:inventoryapp/app/modules/settings/widgets/profile.dart';
import 'package:inventoryapp/app/routes/app_routes.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({super.key});

  Widget sectionTitle(BuildContext context, String title) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: theme.colorScheme.secondary,
        ),
      ),
    );
  }

  Widget menuTile(
    BuildContext context,
    String title, {
    VoidCallback? onTap,
    Widget? trailing,
  }) {
    final theme = Theme.of(context);
    final borderColor = theme.dividerColor.withOpacity(0.5);

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          border: Border(bottom: BorderSide(color: borderColor)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Text(title, style: theme.textTheme.titleMedium)),
            trailing ??
                Icon(
                  Icons.chevron_right,
                  color: theme.iconTheme.color ?? theme.colorScheme.onSurface,
                ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Get.isRegistered<ThemeController>()
        ? Get.find<ThemeController>()
        : Get.put(ThemeController());
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.profile);
                },
                child: const Profile(),
              ),

              const SizedBox(height: 10),
              menuTile(
                context,
                "Team details",
                onTap: () => controller.navigate("Team Details"),
              ),

              // SECTION: Data Center
              sectionTitle(context, "Data Center"),
              menuTile(
                context,
                "Attributes",
                onTap: () => controller.navigate("Attributes"),
              ),
              menuTile(
                context,
                "Locations",
                onTap: () => controller.navigate("Locations"),
              ),
              menuTile(
                context,
                "Partners",
                onTap: () => controller.navigate("Partners"),
              ),

              // SECTION: Team Members
              sectionTitle(context, "Team Members"),
              menuTile(
                context,
                "Members",
                onTap: () => controller.navigate("Members"),
              ),
              menuTile(
                context,
                "Roles & Permissions",
                onTap: () => controller.navigate("Roles & Permissions"),
              ),

              // SECTION: Billing
              sectionTitle(context, "Billing"),
              menuTile(
                context,
                "Manage Plan",
                onTap: () => controller.navigate("Manage Plan"),
              ),
              menuTile(
                context,
                "Notifications",
                onTap: () => controller.navigate("Notifications"),
              ),
              menuTile(
                context,
                "Barcode Scanning",
                onTap: () => controller.navigate("Barcode Scanning"),
              ),

              // SECTION: Appearance
              sectionTitle(context, "Appearance"),
              Obx(
                () => menuTile(
                  context,
                  themeController.isDarkMode.value ? "Dark Mode" : "Light Mode",
                  onTap: themeController.toggleTheme,
                  trailing: Switch(
                    value: themeController.isDarkMode.value,
                    onChanged: themeController.setTheme,
                    activeColor: theme.colorScheme.primary,
                  ),
                ),
              ),
              menuTile(
                context,
                "Display Settings",
                onTap: () => controller.navigate("Display Settings"),
              ),

              // SECTION: Support
              sectionTitle(context, "Support"),
              menuTile(
                context,
                "Use on Web",
                onTap: () => controller.navigate("Use on Web"),
              ),
              menuTile(
                context,
                "Notice",
                onTap: () => controller.navigate("Notice"),
              ),
              menuTile(
                context,
                "Help & Docs",
                onTap: () => controller.navigate("Help & Docs"),
              ),
              menuTile(
                context,
                "Contact Us",
                onTap: () => controller.navigate("Contact Us"),
              ),
              menuTile(
                context,
                "Legal",
                onTap: () => controller.navigate("Legal"),
              ),
              menuTile(
                context,
                "Delete Data",
                onTap: () => controller.navigate("Delete Data"),
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
    );
  }
}
