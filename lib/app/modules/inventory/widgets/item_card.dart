import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final String image;
  final String name;
  final String category;
  final int stock;
  final String id;
  final double price;

  const ItemCard({
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
      color: Colors.white, // background of card
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          // TODO: Navigate to Item Detail or Edit Screen
          print("Tapped $name");
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
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(width: 6),

                        Text(
                          "($category)",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      " $stock in Stock",
                      style: const TextStyle(fontSize: 14),
                    ),
                    Text(
                      " id $id",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),

              // Price + Menu
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "\$$price",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(width: 8),

                  GestureDetector(
                    onTap: () {
                      print("Menu tapped");
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
}
