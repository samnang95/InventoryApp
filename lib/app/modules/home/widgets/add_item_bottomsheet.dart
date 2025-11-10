import 'package:flutter/material.dart';

class AddItemBottomsheet extends StatefulWidget {
  const AddItemBottomsheet({super.key});

  @override
  State<AddItemBottomsheet> createState() => _AddItemBottomsheetState();
}

class _AddItemBottomsheetState extends State<AddItemBottomsheet> {
  final productNameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

  String? selectedCategory;
  String? selectedBrand;

  List<String> categories = ["Electronics", "Clothes", "Food", "Other"];
  List<String> brands = ["Samsung", "Apple", "Nike", "Adidas"];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Name
            TextFormField(
              controller: productNameController,
              decoration: const InputDecoration(labelText: "Product Name"),
            ),
            const SizedBox(height: 12),

            // Category Dropdown
            DropdownButtonFormField(
              value: selectedCategory,
              decoration: const InputDecoration(labelText: "Category"),
              items: categories
                  .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                  .toList(),
              onChanged: (value) {
                setState(() => selectedCategory = value);
              },
            ),
            const SizedBox(height: 12),

            // Brand Dropdown
            DropdownButtonFormField(
              value: selectedBrand,
              decoration: const InputDecoration(labelText: "Brand"),
              items: brands
                  .map(
                    (brand) =>
                        DropdownMenuItem(value: brand, child: Text(brand)),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() => selectedBrand = value);
              },
            ),
            const SizedBox(height: 12),

            // Price
            TextFormField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Price"),
            ),
            const SizedBox(height: 12),

            // Description
            TextFormField(
              controller: descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(labelText: "Description"),
            ),

            const SizedBox(height: 20),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Item Added Successfully")),
                  );
                },
                child: const Text("Save"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
