import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/api/controllers/product_controller.dart';
import 'package:inventoryapp/app/constants/app_spacing.dart';
import 'package:inventoryapp/app/constants/app_widget_size.dart';
import 'package:inventoryapp/app/widgets/item_card_widget.dart';
import 'package:inventoryapp/app/widgets/product_card_widget.dart';
import 'package:inventoryapp/app/widgets/title_text_widget.dart';
import 'package:inventoryapp/modules/product/widgets/product_form_bottomsheet.dart';
import 'package:inventoryapp/modules/productDetail/productDetail_screen.dart';
import '../../app/constants/app_color.dart';

class ProductView extends StatelessWidget {
  ProductView({super.key});

  final ProductController controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ProductFormBottomSheet.open(); // Add new product
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Products"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _search(),
            _productList(context),
          ],
        ),
      ),
    );
  }

  Widget _search(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.paddingL, horizontal: AppSpacing.paddingM),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Search products...',
          prefixIcon: const Icon(Icons.search),
        ),
        onChanged: (val) => controller.searchProducts(val),
      ),
    );
  }

  Widget _productList(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: AppColors.surfaceColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleTextWidget(text: "Product Items"),
                GestureDetector(
                  onTap: () {
                    _showSortDialog(context);
                  },
                  child: const Icon(Icons.filter_alt, color: AppColors.primary),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.products.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.inventory_2, size: AppWidgetSize.iconSM,
                            color: Theme.of(context).colorScheme.primary
                        ),
                        Text(
                          "No product",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: controller.products.length,
                  itemBuilder: (context, index) {
                    final product = controller.products[index];
                    return ProductCardWidget(
                      images: product.images!,
                      name: product.name!,
                      category: product.category?['name'] ?? 'N/A',
                      stock: product.stockQuantity!,
                      price: product.price!,
                      onTapEdit: () {
                        ProductFormBottomSheet.open(product: product);
                      },
                      onTapDelete: () {
                        controller.deleteProduct(product.id!);
                      },
                      onTap: () {
                        Get.to(() => ProductDetailScreen(productId: product.id!));
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  void _showSortDialog(BuildContext context) {
    Get.defaultDialog(
      title: "Sort Product",
      titleStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.w700
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ItemCardWidget(
            title: "Price: Low to High",
            icon: Icons.arrow_downward,
            showArrow: false,
            onTap: () {
              controller.sortProducts("price");
              Get.back();
            },
          ),
          ItemCardWidget(
            title: "Price: High to Low",
            icon: Icons.arrow_upward,
            showArrow: false,
            onTap: () {
              controller.sortProducts("-price");
              Get.back();
            },
          ),
          ItemCardWidget(
            title: "Name: A-Z",
            icon: Icons.arrow_downward,
            showArrow: false,
            onTap: () {
              controller.sortProducts("name");
              Get.back();
            },
          ),
          ItemCardWidget(
            title: "Name: Z-A",
            icon: Icons.arrow_upward,
            showArrow: false,
            onTap: () {
              controller.sortProducts("-name");
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}