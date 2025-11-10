import 'package:get/get.dart';

class InventoryController extends GetxController {
  // reactive search text
  var searchQuery = ''.obs;

  // non-reactive source list (can be obs too)
  List<Map<String, dynamic>> items = [
    {
      "name": "Sting",
      "category": "Soft drink",
      "stock": 36,
      "price": 15.00,
      "id": "123456789",
      "image": "assets/images/box1.jpg", // Use your real image path
    },
    // ...more items
  ];

  // computed getter that uses searchQuery
  List<Map<String, dynamic>> get filteredItems {
    final q = searchQuery.value.trim().toLowerCase();
    if (q.isEmpty) return items;
    return items
        .where((e) => e['name'].toString().toLowerCase().contains(q))
        .toList();
  }
}
