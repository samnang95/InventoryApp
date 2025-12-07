import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/api/controllers/product_controller.dart';
import 'package:inventoryapp/app/constants/app_spacing.dart';
import 'package:inventoryapp/app/widgets/item_card_widget.dart';
import 'package:inventoryapp/modules/productDetail/widgets/product_chip_widget.dart';
import 'package:inventoryapp/modules/productDetail/widgets/product_header_widget.dart';
import 'package:inventoryapp/modules/productDetail/widgets/stock_update_dialog.dart';
import 'package:inventoryapp/modules/productDetail/widgets/supplier_update_dialog.dart';

class ProductDetailScreen extends StatefulWidget {
  final int productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {

  final ProductController controller = Get.put(ProductController());

  @override
  void initState() {
    super.initState();
    controller.loadProductDetail(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final product = controller.productDetail.value;

        if (product == null) {
          return const Center(child: Text("Product not found"));
        }

        return Column(
          children: [
            _buildHeader(product),
            Expanded(child: _buildContent(theme, context, product)),
          ],
        );
      }),
    );
  }

  /// HEADER WITH IMAGE
  Widget _buildHeader(product) {
    final imgs = product.images;

    // If no images, show placeholder with back button
    if (imgs == null || imgs.isEmpty) {
      return Stack(
        children: [
          Container(
            height: 240,
            width: double.infinity,
            color: Colors.grey.shade200,
            child: const Center(
              child: Text(
                "No Image",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ),
          ),

          // Back button
          Positioned(
            top: 40,
            left: 16,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.12),
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.primary),
                onPressed: () => Get.back(),
              ),
            ),
          ),
        ],
      );
    }

    // If images exist, use ProductHeaderWidget
    return ProductHeaderWidget(
      productId: product.id!,
      images: imgs,
    );
  }

  /// MAIN CONTENT
  Widget _buildContent(
      ThemeData theme, BuildContext context, product) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.paddingSM),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title + Price
            Text(
              product.name ?? "No Name",
              style: theme.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Text(
              "\$${product.price}",
              style: theme.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
                fontSize: 22,
              ),
            ),

            SizedBox(height: AppSpacing.paddingL),

            // Chips
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                productChipWidget(
                  theme,
                  Icons.category,
                  (product.category != null && product.category!.isNotEmpty)
                      ? (product.category!["name"] ?? "N/A")
                      : "N/A",
                ),
                productChipWidget(
                    theme, Icons.store, product.brand ?? "N/A"),
                productChipWidget(theme, Icons.qr_code,
                    "SKU: ${product.sku ?? "N/A"}"),
              ],
            ),

            SizedBox(height: AppSpacing.paddingL),

            _buildStockCard(context, product),
            SizedBox(height: AppSpacing.paddingXS),
            _buildSupplierCard(product),

            SizedBox(height: AppSpacing.paddingL),

            // Description
            Text(
              "Description",
              style: theme.textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),

            Text(
              product.description ?? "No description",
              style: theme.textTheme.bodyMedium!.copyWith(
                height: 1.5,
                color: theme.colorScheme.onSurface.withOpacity(.7),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  /// STOCK CARD
  Widget _buildStockCard(BuildContext context, product) {
    return ItemCardWidget(
      icon: Icons.inventory_2_rounded,
      title: "Stock Available",
      subtitle: "${product.stockQuantity} items",
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => StockUpdateDialog(
            item: product,
            onUpdate: (type, qty, date) {
              // Add your logic here
            },
          ),
        );
      },
      showArrow: true,
      trailing: null,
    );
  }

  /// SUPPLIER CARD
  Widget _buildSupplierCard(product) {

    final hasSupplier = product.supplier != null && product.supplier!.isNotEmpty;
    final supplierName = hasSupplier ? (product.supplier!["name"] ?? "No Supplier") : "No Supplier";
    final supplierContact = hasSupplier ? (product.supplier!["contact"] ?? "No contact") : "No contact";

    return ItemCardWidget(
      icon: Icons.business_center,
      title: supplierName,
      subtitle: supplierContact,
      onTap: () {
        showDialog(
          context: Get.context!,
          builder: (_) => SupplierDialogWidget(
            onSubmit: (name, contact, address) {
              // Your update logic here...
            },
          ),
        );
      },
      showArrow: true,
      trailing: null,
    );
  }
}