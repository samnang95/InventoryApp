import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/app/controllers/theme_controller.dart';
import 'package:inventoryapp/modules/bottom_nav/bottom_nav_controller.dart';
import 'package:inventoryapp/modules/home/home_screen.dart';
import 'package:inventoryapp/modules/inventory/inventory_screen.dart';
import 'package:inventoryapp/modules/settings/settings_screen.dart';
import 'package:inventoryapp/modules/transactions/transactions_screen.dart';

class BottomNavScreen extends GetView<BottomNavController> {
  BottomNavScreen({super.key});

  final ThemeController themeController = Get.put(ThemeController());

  final List<Widget> _pages = [
    HomeScreen(),
    InventoryScreen(),
    TransactionsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          body: _pages[controller.selectedIndex.value],
          bottomNavigationBar: _buildBottomNavigationBar(),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    if (controller.selectedIndex.value != 0) {
      controller.onTabSelected(0);
      return false;
    }
    return true;
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: controller.selectedIndex.value,
      onTap: controller.onTabSelected,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Theme.of(Get.context!).colorScheme.primary,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.inventory_2_outlined),
          label: 'Inventory',
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
    );
  }
}