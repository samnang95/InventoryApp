import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/app/modules/home/home_controller.dart';
import 'package:inventoryapp/app/modules/home/widgets/add_item_bottomsheet.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // Allows the content to scroll
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 1. ThangChii Header
            _appBar(context),

            // 2. Summary Card
            _buildSummaryCard(context),

            const SizedBox(height: 20),

            // 3. Search Bar
            _buildSearchBar(context),

            const SizedBox(height: 20),

            // 4. Items Section
            _buildActionSection(context, 'Items', [
              _buildActionTile(Icons.add_circle_outline, 'Add Item', () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => const AddItemBottomsheet(),
                );
              }),
            ]),

            const SizedBox(height: 20),

            // 5. Transactions Section
            _buildActionSection(context, 'Transactions', [
              _buildActionTile(Icons.arrow_downward, 'Stock In', () {}),
              _buildActionTile(Icons.arrow_upward, 'Stock Out', () {}),
              _buildActionTile(Icons.compare_arrows, 'Move Stock', () {}),
              _buildActionTile(Icons.history, 'Adjust Stock', () {}),
            ]),

            const SizedBox(height: 20),

            // 6.Low Stock Alerts Section
            _buildActionSection(context, 'StockAlerts', [
              _buildActionTile(Icons.view_agenda, 'View Shortages', () {}),
            ]),

            const SizedBox(height: 20),

            // 7. Inventory Count Section
            _buildActionSection(context, 'Inventory Count', [
              _buildActionTile(Icons.inventory, 'Start Inventory Count', () {}),
            ]),

            const SizedBox(height: 20),

            // 8. Team Member Section
            _buildActionSection(context, 'Team Members', [
              _buildActionTile(Icons.people, 'Invite Members', () {}),
            ]),

            const SizedBox(height: 20),

            // 9. Past Quantity Section
            _buildActionSection(context, 'Past Quantity', [
              _buildActionTile(
                Icons.production_quantity_limits,
                'View Stock by Date',
                () {},
              ),
            ]),

            const SizedBox(height: 20),

            // 10.BarCode Labels Section
            _buildActionSection(context, 'BarCode Labels', [
              _buildActionTile(
                Icons.barcode_reader,
                'Print items label',
                () {},
              ),
            ]),

            const SizedBox(height: 20),

            // 11. Purchase & Sales Section
            _buildActionSection(context, 'Purchase & Sales', [
              _buildActionTile(Icons.sell_outlined, 'Purchese', () {}),
              _buildActionTile(Icons.sell, 'Sales', () {}),
              _buildActionTile(
                Icons.keyboard_return_outlined,
                'Returns',
                () {},
              ),
            ]),

            // ... Other Sections would follow ...
            const SizedBox(height: 30),

            // 6. More Button
            Center(
              child: OutlinedButton.icon(
                icon: Icon(Icons.add),
                label: Text('More'),
                onPressed: () {
                  print("click more button");
                },
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _appBar(context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        // The radius controls the size of the avatar
        radius: 20,
        // Use backgroundImage for images loaded from assets or network
        backgroundImage: AssetImage('assets/images/s6.jpg'),
      ),
      // *** RichText is placed here, in the title property ***
      title: RichText(
        text: TextSpan(
          // Ensure you set a default style for the entire title
          style: Theme.of(context).textTheme.headlineSmall,
          children: <TextSpan>[
            TextSpan(text: 'Hello,'),
            // Adding a second span for demonstration, e.g., an account status
            // TextSpan(text: ' '),
            TextSpan(text: 'ThangChii'),
          ],
        ),
      ),
      trailing: Icon(Icons.more_vert),
    );
  }

  // Helper for the dark blue Summary Card
  Widget _buildSummaryCard(context) {
    return Card(
      // color: Colors.blue[900], // Dark blue background
      color: Theme.of(context).secondaryHeaderColor,
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Today Oct 22',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Icon(Icons.more_horiz),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSummaryItem(context, 'Total', '100'),
                _buildSummaryItem(context, 'Stock In', '50'),
                _buildSummaryItem(context, 'Stock Out', '50'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper for the individual items in the Summary Card
  Widget _buildSummaryItem(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(value, style: Theme.of(context).textTheme.displaySmall),
        const SizedBox(height: 5),
        Text(label, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }

  // Helper for the Search Bar
  Widget _buildSearchBar(context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        // color: Colors.grey[200],
        color: Theme.of(context).secondaryHeaderColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Icon(Icons.search),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for an item',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          // Icon(Icons.fullscreen, color: Colors.grey),
        ],
      ),
    );
  }

  // Helper to create a section with a title and action list
  Widget _buildActionSection(
    BuildContext context,
    String title,
    List<Widget> tiles,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        Card(
          elevation: 0,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(children: tiles),
        ),
      ],
    );
  }
  // Helper to create a section with a title and action list

  // Helper for individual ListTiles in the action sections
  Widget _buildActionTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title, style: Theme.of(Get.context!).textTheme.titleMedium),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
