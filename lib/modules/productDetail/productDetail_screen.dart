import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/modules/productDetail/productDetail_controller.dart';

class ProductDetailView extends StatelessWidget {
  final controller = Get.put(ProductDetailController());

  ProductDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _header(context),
              _imageSection(context),
              _infoSection(context),
              _descriptionSection(context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // HEADER
  Widget _header(context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            size: 26,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          "Product Detail",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }

  Widget _imageSection(BuildContext context) {
    return Obx(() {
      if (controller.image.value.isEmpty) {
        return const SizedBox.shrink();
      }
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
                  controller.image.value,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.image_not_supported, size: 50),
                    );
                  },
                ),
              ),
            ),
            if (controller.images.length > 1) ...[
              const SizedBox(height: 10),
              _indicator(context),
            ],
          ],
        ),
      );
    });
  }

  Widget _indicator(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        controller.images.length,
        (index) => Obx(() {
          bool active = controller.currentImage.value == index;
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: active
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey,
            ),
          );
        }),
      ),
    );
  }

  Widget _infoSection(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Text(
                    controller.name.value.isNotEmpty
                        ? controller.name.value
                        : "Product",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (controller.category.value.isNotEmpty) ...[
                    const SizedBox(width: 5),
                    Text(
                      "(${controller.category.value})",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ],
              ),
            ),
            Text(
              "\$ ${controller.price.value.toStringAsFixed(2)}",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _descriptionSection(BuildContext context) {
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
          Text(
            "Lorem ipsum dolor sit amet consectetur. Adipiscing cursus "
            "ultrices venenatis velit eu aliquet convallis.",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          _bottomButtons(),
        ],
      ),
    );
  }

  Widget _ratingRow() {
    return Obx(
      () => Row(
        children: [
          const Icon(Icons.inventory_2, size: 22),
          const SizedBox(width: 4),
          Text("${controller.stock.value} in Stock"),
          if (controller.id.value.isNotEmpty) ...[
            const SizedBox(width: 15),
            Container(height: 20, width: 1.2, color: Colors.grey),
            const SizedBox(width: 15),
            Text("ID: ${controller.id.value}"),
          ],
        ],
      ),
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
