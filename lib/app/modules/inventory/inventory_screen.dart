import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/app/modules/home/widgets/add_item_bottomsheet.dart';
import 'package:inventoryapp/app/modules/inventory/inventory_controller.dart';
import 'package:inventoryapp/app/modules/inventory/widgets/ItemCard.dart';

class InventoryScreen extends GetView<InventoryController> {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        // backgroundColor: Colors.blue.shade800,
        onPressed: () {
          // Navigate to Add Item Page
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
              // Search + Filter Row
              Row(
                children: [
                  // Search Bar
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.surface.withOpacity(0.3), // background
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(
                              0.1,
                            ), // shadow color
                            blurRadius: 6, // how soft
                            offset: const Offset(0, 3), // position
                          ),
                        ],
                      ),
                      child: TextField(
                        onChanged: (value) =>
                            controller.searchQuery.value = value,
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium, // text style
                        decoration: InputDecoration(
                          hintText: "Search for an item",
                          hintStyle: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Theme.of(context).hintColor),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Theme.of(context).iconTheme.color,
                            size: Theme.of(context).iconTheme.size,
                          ),
                          filled: true,
                          fillColor: Colors.transparent, // handled by Container
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Filter Button
                  GestureDetector(
                    onTap: () {
                      // TODO: Add filter action or bottom sheet
                      print("Filter tapped");
                    },
                    child: Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface
                            .withOpacity(
                              0.3,
                            ), // theme background color as search field
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                            color: Colors.black.withOpacity(0.10),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.swap_vert, // up-down arrow icon
                        // size: 28,
                        // color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // Items and View all
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Items", style: Theme.of(context).textTheme.titleLarge),
                  Text(
                    "View all",
                    // style: Theme.of(context).textTheme.titleMedium,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Items List
              Expanded(
                child: Obx(() {
                  final items = controller.filteredItems;

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        // First list
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: items.length,
                          itemBuilder: (_, i) => CardScreen(
                            image: items[i]["image"],
                            name: items[i]["name"],
                            category: items[i]["category"],
                            stock: items[i]["stock"],
                            id: items[i]["id"],
                            price: items[i]["price"],
                          ),
                        ),

                        SizedBox(height: 16),

                        // Second list (duplicate section)
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: items.length,
                          itemBuilder: (_, i) => CardScreen(
                            image: items[i]["image"],
                            name: items[i]["name"],
                            category: items[i]["category"],
                            stock: items[i]["stock"],
                            id: items[i]["id"],
                            price: items[i]["price"],
                          ),
                        ),

                        SizedBox(height: 16),
                      ],
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
