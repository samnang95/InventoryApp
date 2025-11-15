import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InventoryController extends GetxController {
  final searchController = TextEditingController();
  var searchQuery = ''.obs;

  // Sample item list
  final items = <Map<String, dynamic>>[
    {
      "name": "Sting",
      "category": "Soft drink",
      "stock": 36,
      "price": 15.00,
      "id": "123456789",
      "image": "https://picsum.photos/200?random=1",
    },
    {
      "name": "Coca Cola",
      "category": "Soft drink",
      "stock": 50,
      "price": 12.50,
      "id": "987654321",
      "image": "https://picsum.photos/200?random=2",
    },
    {
      "name": "Pepsi",
      "category": "Soft drink",
      "stock": 20,
      "price": 10.00,
      "id": "456789123",
      "image": "https://picsum.photos/200?random=3",
    },
  ];

  List<Map<String, dynamic>> get filteredItems {
    final q = searchQuery.value.trim().toLowerCase();
    if (q.isEmpty) return items;
    return items
        .where((item) => item['name'].toString().toLowerCase().contains(q))
        .toList();
  }

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(() {
      searchQuery.value = searchController.text;
    });
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void clearSearch() {
    searchController.clear();
    searchQuery.value = '';
  }
}