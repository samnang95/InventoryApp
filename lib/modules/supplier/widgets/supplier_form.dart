import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/api/controllers/supplier_controller.dart';
import 'package:inventoryapp/api/models/supplier_model.dart';

class SupplierForm extends StatelessWidget {
  final SupplierModel? supplier;
  final SupplierController controller = Get.find();

  SupplierForm({super.key, this.supplier});

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController contactCtrl = TextEditingController();
  final TextEditingController addressCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    /// Pre-fill form when editing
    if (supplier != null) {
      nameCtrl.text = supplier!.name;
      contactCtrl.text = supplier!.contactInfo ?? '';
      addressCtrl.text = supplier!.address ?? '';
    }

    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Small drag handle bar
            Center(
              child: Container(
                width: 40,
                height: 5,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            Text(
              supplier == null ? "Add Supplier" : "Edit Supplier",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: contactCtrl,
              decoration: const InputDecoration(
                labelText: "Contact Info",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: addressCtrl,
              decoration: const InputDecoration(
                labelText: "Address",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  supplier == null ? "Create Supplier" : "Update Supplier",
                  style: const TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  final newSupplier = SupplierModel(
                    name: nameCtrl.text.trim(),
                    contactInfo: contactCtrl.text.trim(),
                    address: addressCtrl.text.trim(),
                  );

                  if (supplier == null) {
                    controller.createSupplier(newSupplier);
                  } else {
                    controller.updateSupplier(supplier!.id!, newSupplier);
                  }

                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}