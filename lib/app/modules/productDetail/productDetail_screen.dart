import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/app/modules/productDetail/productDetail_controller.dart';

class ProductDetailView extends StatelessWidget {
  final controller = Get.put(ProductDetailController());

  ProductDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
              _imageSection(),
              _infoSection(),
              _descriptionSection(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      children: [
        IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, size: 26),
        ),
        const SizedBox(width: 5),
        const Text(
          "product detail",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _imageSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.grey.shade100,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                "assets/images/cat1.png",
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          _indicator(),
        ],
      ),
    );
  }

  Widget _indicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (index) => Obx(() {
          bool active = controller.currentImage.value == index;
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: active ? Colors.blue : Colors.grey,
            ),
          );
        }),
      ),
    );
  }

  Widget _infoSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const Expanded(
            child: Row(
              children: [
                Text(
                  "Sting",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),
                SizedBox(width: 5),
                Text("(soft drink)", style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
          const Text(
            "15.00 \$",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _descriptionSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ratingRow(),
          const SizedBox(height: 20),
          const Text(
            "Description",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          const Text(
            "Lorem ipsum dolor sit amet consectetur. Adipiscing cursus "
            "ultrices venenatis velit eu aliquet convallis.",
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 20),
          _bottomButtons(),
        ],
      ),
    );
  }

  Widget _ratingRow() {
    return Row(
      children: [
        const Icon(Icons.star, size: 22),
        const SizedBox(width: 4),
        const Text("4.5"),
        const SizedBox(width: 15),
        Container(height: 20, width: 1.2, color: Colors.grey),
        const SizedBox(width: 15),
        const Text("193 sold"),
      ],
    );
  }

  Widget _bottomButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: const [
        Icon(Icons.chat_bubble_outline, size: 28),
        SizedBox(width: 18),
        Icon(Icons.favorite_border, size: 28),
      ],
    );
  }
}
