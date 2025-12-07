import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductHeaderWidget extends StatefulWidget {
  final int productId;
  final List<String> images;

  const ProductHeaderWidget({
    super.key,
    required this.productId,
    required this.images,
  });

  @override
  State<ProductHeaderWidget> createState() => _ProductHeaderWidgetState();
}

class _ProductHeaderWidgetState extends State<ProductHeaderWidget> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // SAFETY CHECK
    if (widget.images.isEmpty) {
      return const SizedBox(
        height: 240,
        child: Center(child: Text("No Image Available")),
      );
    }

    // Decode safely
    Uint8List decodeImage(String data) {
      final base64Data = data.contains(',') ? data.split(',').last : data;
      return base64Decode(base64Data);
    }

    return Column(
      children: [
        Stack(
          children: [
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
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Hero(
                tag: widget.productId.toString(),
                child: Image.memory(
                  decodeImage(widget.images[_currentIndex]),
                  height: 220,
                  fit: BoxFit.fill,
                ),
              ),
            ),

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

        if (widget.images.length > 1)
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(12),
              itemCount: widget.images.length,
              itemBuilder: (context, index) {
                final img = widget.images[index];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding: _currentIndex == index
                        ? const EdgeInsets.all(3)
                        : EdgeInsets.zero,
                    decoration: BoxDecoration(
                      border: _currentIndex == index
                          ? Border.all(color: Colors.blue, width: 2)
                          : null,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.memory(
                        decodeImage(img),
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}