import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/app/widgets/product_card_widget.dart';
import 'package:inventoryapp/app/widgets/add_item_bottomsheet.dart';
import 'package:inventoryapp/modules/inventory/widgets/inventory_search_widget.dart';
import 'inventory_controller.dart';

class InventoryScreen extends GetView<InventoryController> {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Inventory"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => const AddItemBottomsheet(),
          );
        },
        child: const Icon(Icons.add, size: 32),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const InventorySearchRowWidget(),
              const SizedBox(height: 22),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Items", style: theme.textTheme.titleLarge),
                  Text("View all", style: theme.textTheme.titleSmall),
                ],
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Obx(() {
                  final items = controller.filteredItems;
                  if (items.isEmpty) {
                    return Center(
                      child: Text(
                        "No items found",
                        style: theme.textTheme.bodyMedium,
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (_, i) => ProductCardWidget(
                      image: items[i]["image"],
                      name: items[i]["name"],
                      category: items[i]["category"],
                      stock: items[i]["stock"],
                      id: items[i]["id"],
                      price: items[i]["price"],
                      onTap: () {
                        print("Tapped ${items[i]["name"]}");
                      },
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}