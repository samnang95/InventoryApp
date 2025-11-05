import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/app/modules/home/home_screen.dart';
import 'package:inventoryapp/app/modules/items/items_screen.dart';
import 'package:inventoryapp/app/modules/navigationBotton/navigationBotton_controller.dart';
import 'package:inventoryapp/app/modules/settings/settings_screen.dart';
import 'package:inventoryapp/app/modules/transactions/transactions_screen.dart';

class NavigationbottonScreen extends GetView<NavigationbottonController> {
  const NavigationbottonScreen({super.key});

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
          appBar: AppBar(title: const Text('InventoryApp'), centerTitle: true),
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
