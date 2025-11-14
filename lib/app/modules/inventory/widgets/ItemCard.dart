import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/app/routes/app_routes.dart';

class CardScreen extends StatelessWidget {
  final String image;
  final String name;
  final String category;
  final int stock;
  final String id;
  final double price;

  const CardScreen({
    super.key,
    required this.image,
    required this.name,
    required this.category,
    required this.stock,
    required this.id,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      // color: Colors.white, // background of card
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          Get.toNamed(
            AppRoutes.productDetail,
            arguments: {
              'id': id,
              'name': name,
              'category': category,
              'stock': stock,
              'price': price,
              'image': image,
            },
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 7),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              // Product Image
              Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                  color: const Color(0xFFE9E8F8),
                ),
              ),

              const SizedBox(width: 16),

              // Item Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          name,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),

                        const SizedBox(width: 6),

                        Text(
                          "($category)",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),
                    Text(
                      " $stock in Stock",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),

                    const SizedBox(height: 4),

                    Text(
                      " id $id",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ),

              // Price + Menu
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    // "\$ $price",
                    "\$ ${price.toStringAsFixed(2)}",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),

                  const SizedBox(width: 8),

                  // option menu Delete/Edit icon
                  GestureDetector(
                    onTap: () {
                      _showOptionBottomSheet(context);
                    },
                    child: const Icon(Icons.more_vert, size: 22),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showOptionBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit'),
                onTap: () {
                  Navigator.of(ctx).pop();
                  // TODO: Navigate to edit screen
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Delete'),
                onTap: () {
                  Navigator.of(ctx).pop();
                  // TODO: Handle delete action
                },
              ),
              ListTile(
                leading: const Icon(Icons.close),
                title: const Text('Close'),
                onTap: () => Navigator.of(ctx).pop(),
              ),
            ],
          ),
        );
      },
    );
  }
}
