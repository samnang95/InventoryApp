import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/app/modules/home/widgets/add_item_bottomsheet.dart';
import 'package:inventoryapp/app/modules/inventory/inventory_controller.dart';
import 'package:inventoryapp/app/modules/inventory/widgets/item_card.dart';

class InventoryScreen extends GetView<InventoryController> {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade800,
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
                    child: TextField(
                      onChanged: (value) =>
                          controller.searchQuery.value = value,
                      decoration: InputDecoration(
                        hintText: "Search for an item",
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        filled: true,
                        fillColor: const Color(
                          0xFFE9E8F8,
                        ), // soft lavender background
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
                        color: const Color(
                          0xFFE9E8F8,
                        ), // same color as search field
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
                        size: 28,
                        color: Colors.black87,
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
                    style: TextStyle(fontSize: 16, color: Colors.grey),
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
                          itemBuilder: (_, i) => ItemCard(
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
                          itemBuilder: (_, i) => ItemCard(
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
                          itemBuilder: (_, i) => ItemCard(
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
                          itemBuilder: (_, i) => ItemCard(
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
                          itemBuilder: (_, i) => ItemCard(
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
                          itemBuilder: (_, i) => ItemCard(
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
                          itemBuilder: (_, i) => ItemCard(
                            image: items[i]["image"],
                            name: items[i]["name"],
                            category: items[i]["category"],
                            stock: items[i]["stock"],
                            id: items[i]["id"],
                            price: items[i]["price"],
                          ),
                        ),
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
