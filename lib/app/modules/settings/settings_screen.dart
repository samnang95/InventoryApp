import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/app/modules/profile/profile_screen.dart';
import 'package:inventoryapp/app/modules/settings/widgets/profile.dart';
import 'settings_controller.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({super.key});

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey[700],
        ),
      ),
    );
  }

  Widget menuTile(String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 15)),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                },
                child: Profile(),
              ),

              const SizedBox(height: 10),
              menuTile(
                "Team details",
                () => controller.navigate("Team Details"),
              ),

              // SECTION: Data Center
              sectionTitle("Data Center"),
              menuTile("Attributes", () => controller.navigate("Attributes")),
              menuTile("Locations", () => controller.navigate("Locations")),
              menuTile("Partners", () => controller.navigate("Partners")),

              // SECTION: Team Members
              sectionTitle("Team Members"),
              menuTile("Members", () => controller.navigate("Members")),
              menuTile(
                "Roles & Permissions",
                () => controller.navigate("Roles & Permissions"),
              ),

              // SECTION: Billing
              sectionTitle("Billing"),
              menuTile("Manage Plan", () => controller.navigate("Manage Plan")),
              menuTile(
                "Notifications",
                () => controller.navigate("Notifications"),
              ),
              menuTile(
                "Barcode Scanning",
                () => controller.navigate("Barcode Scanning"),
              ),
              menuTile(
                "Display Settings",
                () => controller.navigate("Display Settings"),
              ),

              // SECTION: Support
              sectionTitle("Support"),
              menuTile("Use on Web", () => controller.navigate("Use on Web")),
              menuTile("Notice", () => controller.navigate("Notice")),
              menuTile("Help & Docs", () => controller.navigate("Help & Docs")),
              menuTile("Contact Us", () => controller.navigate("Contact Us")),
              menuTile("Legal", () => controller.navigate("Legal")),
              menuTile("Delete Data", () => controller.navigate("Delete Data")),

              const SizedBox(height: 30),
              Center(
                child: const Text(
                  "App Version 3.3.3+485",
                  style: TextStyle(color: Colors.black45, fontSize: 13),
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
