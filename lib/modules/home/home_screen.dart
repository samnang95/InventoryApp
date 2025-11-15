import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/app/widgets/item_card_widget.dart';
import '../../app/widgets/summary_card_widget.dart' show SummaryCardWidget;
import 'home_controller.dart';
import 'widgets/home_profile_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================= Profile =================
            homeProfileWidget(context),
            const SizedBox(height: 20),
            SummaryCardWidget(
              date: "Today Nov 15",
              items: homeController.summaryItems,
            ),

            const SizedBox(height: 20),

            // ================= STOCK =================
            _buildCategoryHeader(context, "Stock"),
            Column(
              children: [
                ItemCardWidget(
                  icon: Icons.view_agenda,
                  title: "View Shortages",
                  onTap: () =>
                      Get.snackbar("View Shortages", "Tapped View Shortages"),
                ),
                ItemCardWidget(
                  icon: Icons.inventory,
                  title: "Start Inventory Count",
                  onTap: () => Get.snackbar(
                      "Start Inventory Count", "Tapped Start Inventory Count"),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // ================= TEAM =================
            _buildCategoryHeader(context, "Team"),
            Column(
              children: [
                ItemCardWidget(
                  icon: Icons.people,
                  title: "Invite Members",
                  onTap: () =>
                      Get.snackbar("Invite Members", "Tapped Invite Members"),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // ================= REPORTS =================
            _buildCategoryHeader(context, "Reports"),
            Column(
              children: [
                ItemCardWidget(
                  icon: Icons.production_quantity_limits,
                  title: "View Stock by Date",
                  onTap: () => Get.snackbar(
                      "View Stock by Date", "Tapped View Stock by Date"),
                ),
                ItemCardWidget(
                  icon: Icons.qr_code_2,
                  title: "Print Items Label",
                  onTap: () => Get.snackbar(
                      "Print Items Label", "Tapped Print Items Label"),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // ================= SALES =================
            _buildCategoryHeader(context, "Sales"),
            Column(
              children: [
                ItemCardWidget(
                  icon: Icons.sell_outlined,
                  title: "Purchase",
                  onTap: () => Get.snackbar("Purchase", "Tapped Purchase"),
                ),
                ItemCardWidget(
                  icon: Icons.sell,
                  title: "Sales",
                  onTap: () => Get.snackbar("Sales", "Tapped Sales"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Category header widget
  Widget _buildCategoryHeader(BuildContext context, String title) {
    return Text(
      title.toUpperCase(),
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}