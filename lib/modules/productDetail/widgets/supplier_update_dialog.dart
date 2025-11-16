import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupplierDialogWidget extends StatefulWidget {
  final Function(String name, String contact, String address) onSubmit;

  const SupplierDialogWidget({
    super.key,
    required this.onSubmit,
  });

  @override
  State<SupplierDialogWidget> createState() => _SupplierDialogWidgetState();
}

class _SupplierDialogWidgetState extends State<SupplierDialogWidget> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                "Add / Edit Supplier",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Supplier Name
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Supplier Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Contact
              TextField(
                controller: contactController,
                decoration: InputDecoration(
                  labelText: "Contact Number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Address
              TextField(
                controller: addressController,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: "Address",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    // if (nameController.text.isEmpty ||
                    //     contactController.text.isEmpty ||
                    //     addressController.text.isEmpty) {
                    //   Get.snackbar("Error", "All fields are required");
                    //   return;
                    // }
                    //
                    // widget.onSubmit(
                    //   nameController.text,
                    //   contactController.text,
                    //   addressController.text,
                    // );

                    Get.back();
                  },
                  child: const Text(
                    "Save Supplier",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}