import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductHeaderWidget extends StatelessWidget {
  final int productId;
  final String? imageUrl;

  const ProductHeaderWidget({
    super.key,
    required this.productId,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            // Background gradient
            Container(
              height: 260,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.deepPurple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),

            // Product Image
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Hero(
                tag: productId.toString(),
                child: Container(
                  height: 200,
                  alignment: Alignment.center,
                  child: imageUrl != null && imageUrl!.isNotEmpty ? Image.network(
                    imageUrl!,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                    height: 200,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.broken_image,
                        size: 80,
                        color: Colors.white70,
                      );
                    },
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return const CircularProgressIndicator(
                        color: Colors.white,
                      );
                    },
                  ) : const Center(
                    child: Text(
                      "No Image Available",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),

            // Back Button
            Positioned(
              top: 40,
              left: 16,
              child: CircleAvatar(
                backgroundColor: Colors.white70,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Get.back(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}