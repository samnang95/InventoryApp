import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/app/modules/home/home_controller.dart';
import 'package:inventoryapp/app/modules/items/items_screen.dart';
import 'package:inventoryapp/app/modules/transactions/transactions_screen.dart';
import 'package:inventoryapp/app/modules/settings/settings_screen.dart';

class HomeDashboard extends GetView<HomeController> {
  const HomeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = const [
      HomeScreen(),
      ItemsScreen(),
      TransactionsScreen(),
      SettingsScreen(),
    ];

    return Obx(
      () => WillPopScope(
        onWillPop: () async {
          if (controller.selectedIndex.value != 0) {
            controller.onTabSelected(0);
            return false;
          }
          return true;
        },
        child: Scaffold(
          // appBar: AppBar(
          //   title: const Text('InventoryApp'),
          //   centerTitle: true,
          // ),
          body: SafeArea(child: pages[controller.selectedIndex.value]),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.selectedIndex.value,
            onTap: controller.onTabSelected,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.inventory_2_outlined),
                label: 'Items',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.swap_horiz),
                label: 'Transactions',
              ),

              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
            _appBar(),

            // 2. Summary Card
            _buildSummaryCard(),

            const SizedBox(height: 20),

            // 3. Search Bar
            _buildSearchBar(),

            const SizedBox(height: 20),

            // 4. Items Section
            _buildActionSection('Items', [
              _buildActionTile(Icons.add_circle_outline, 'Add Item', () {}),
            ]),

            const SizedBox(height: 20),

            // 5. Transactions Section
            _buildActionSection('Transactions', [
              _buildActionTile(Icons.arrow_downward, 'Stock In', () {}),
              _buildActionTile(Icons.arrow_upward, 'Stock Out', () {}),
              _buildActionTile(Icons.compare_arrows, 'Move Stock', () {}),
              _buildActionTile(Icons.history, 'Adjust Stock', () {}),
            ]),
            const SizedBox(height: 20),

            // 6.Low Stock Alerts Section
            _buildActionSection('StockAlerts', [
              _buildActionTile(
                Icons.add_circle_outline,
                'View Shortages',
                () {},
              ),
            ]),

            // 7. Inventory Count Section
            _buildActionSection('Inventory Count', [
              _buildActionTile(
                Icons.add_circle_outline,
                'Start Inventory Count',
                () {},
              ),
            ]),

            // 8. Team Member Section
            _buildActionSection('Team Members', [
              _buildActionTile(
                Icons.add_circle_outline,
                'Invite Members',
                () {},
              ),
            ]),

            // 9. Past Quantity Section
            _buildActionSection('Past Quantity', [
              _buildActionTile(
                Icons.add_circle_outline,
                'View Stock by Date',
                () {},
              ),
            ]),

            // 10.BarCode Labels Section
            _buildActionSection('BarCode Labels', [
              _buildActionTile(
                Icons.add_circle_outline,
                'Print items label',
                () {},
              ),
            ]),

            // 11. Purchase & Sales Section
            _buildActionSection('Purchase & Sales', [
              _buildActionTile(Icons.add_circle_outline, 'Purchese', () {}),
              _buildActionTile(Icons.add_circle_outline, 'Sales', () {}),
              _buildActionTile(Icons.add_circle_outline, 'Returns', () {}),
            ]),

            // ... Other Sections would follow ...
            const SizedBox(height: 30),

            // 6. More Button
            Center(
              child: OutlinedButton.icon(
                icon: Icon(Icons.add),
                label: Text('More'),
                onPressed: () {},
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

  Widget _appBar() {
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
          style: TextStyle(fontSize: 16, color: Colors.black),
          children: <TextSpan>[
            TextSpan(
              text: 'Hello',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            // Adding a second span for demonstration, e.g., an account status
            TextSpan(text: ' '),
            TextSpan(
              text: 'Nang',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      trailing: Icon(Icons.more_vert),
    );
  }

  // Helper for the dark blue Summary Card
  Widget _buildSummaryCard() {
    return Card(
      color: Colors.blue[900], // Dark blue background
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Today Oct 22', style: TextStyle(color: Colors.white70)),
                Icon(Icons.more_horiz, color: Colors.white70),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSummaryItem('Total', '100'),
                _buildSummaryItem('Stock In', '50'),
                _buildSummaryItem('Stock Out', '50'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper for the individual items in the Summary Card
  Widget _buildSummaryItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(label, style: TextStyle(color: Colors.white70)),
      ],
    );
  }

  // Helper for the Search Bar
  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.grey),
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
          Icon(Icons.fullscreen, color: Colors.grey),
        ],
      ),
    );
  }

  // Helper to create a section with a title and action list
  Widget _buildActionSection(String title, List<Widget> tiles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
        // Use Card or a Container with rounded corners for the background,
        // similar to the image's grouping.
        Card(
          elevation: 0,
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: Column(children: tiles),
        ),
      ],
    );
  }
  // Helper to create a section with a title and action list

  // Helper for individual ListTiles in the action sections
  Widget _buildActionTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.black54),
      title: Text(title, style: TextStyle(fontSize: 15)),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
