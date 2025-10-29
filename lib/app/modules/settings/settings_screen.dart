import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            Text(
              title,
              style: const TextStyle(fontSize: 15),
              // TextStyle(
              //   fontSize: 16,
              //   fontWeight: FontWeight.bold,
              //   color: Colors.grey[700],
              // ),
            ),
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
              // TOP HEADER
              Container(
                // width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Settings",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // TEAM HEADER CARD
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(top: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.inventory_2_outlined, size: 42),
                    // Image.asset('assets/images/s6.jpg'),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "ThangChii",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                        SizedBox(height: 5),

                        Text(
                          "0 items  _  1 location  _  1 member",
                          style: TextStyle(fontSize: 13, color: Colors.black54),
                        ),
                      ],
                    ),
                  ],
                ),
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
