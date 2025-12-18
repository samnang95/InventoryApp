import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/api/controllers/product_controller.dart';
import 'package:inventoryapp/api/models/product_model.dart';
import 'package:inventoryapp/app/constants/app_spacing.dart';
import 'package:inventoryapp/app/constants/app_widget_size.dart';
import 'package:inventoryapp/app/widgets/circle_icon_button.dart';
import 'package:inventoryapp/app/widgets/item_card_widget.dart';
import 'package:inventoryapp/app/widgets/title_text_widget.dart';
import 'package:inventoryapp/modules/product/widgets/product_form_bottomsheet.dart';
import 'package:inventoryapp/modules/productDetail/widgets/product_chip_widget.dart';
import 'package:inventoryapp/modules/productDetail/widgets/product_header_widget.dart';
import 'package:inventoryapp/modules/productDetail/widgets/stock_tab_dialog.dart';
import 'package:inventoryapp/modules/productDetail/widgets/supplier_select_dialog.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ProductFormBottomSheet.open(product: controller.productDetail.value);
        },
        child: const Icon(Icons.edit),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final product = controller.productDetail.value;

        if (product == null) {
          return const Center(child: Text("Product not found"));
        }

        return RefreshIndicator(
          onRefresh: () async {
            await controller.loadProductDetail(widget.productId);
          },
          child: Column(
            children: [
              _buildHeader(product),
              Expanded(child: _buildContent(theme, context, product)),
            ],
          ),
        );
      }),
    );
  }

  /// HEADER WITH IMAGE
  Widget _buildHeader(ProductModel product) {
    final imgs = product.image;

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
      imageUrl: imgs,
    );
  }

  /// MAIN CONTENT
  Widget _buildContent(ThemeData theme, BuildContext context, ProductModel product) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.paddingSM),
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
                  (product.category != null)
                      ? (product.category!.name.toString() ?? "N/A")
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
            TitleTextWidget(text: "Product Description"),
            Text(
              product.description ?? "No description",
              style: theme.textTheme.bodyMedium,
            ),
            SizedBox(height: AppSpacing.paddingL),

            // Create By
            TitleTextWidget(text: "Create By"),
            Text(
              product.creator!.name.toString() ?? "No description",
              style: theme.textTheme.bodyMedium,
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
      trailing: CircleIconButton(
        size: AppWidgetSize.iconSM,
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.9),
        icon: Icons.edit,
        onTap: () async {
          Get.dialog(
            StockTabDialog(
                productId: widget.productId,
                currentStock: controller.productDetail.value!.stockQuantity!.toInt()
            ),
          );
        },
      ),
      showArrow: false,
    );
  }

  /// SUPPLIER CARD
  Widget _buildSupplierCard(ProductModel product) {
    return ItemCardWidget(
      icon: Icons.business_center,
      title: product.supplier!.name.toString(),
      subtitle: product.supplier!.contactInfo.toString(),
      showArrow: true,
      trailing: CircleIconButton(
          size: AppWidgetSize.iconSM,
          backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.9),
          icon: Icons.edit,
          onTap: (){
            showDialog(
              context: Get.context!,
              builder: (_) => SupplierSelectionDialog(
                productId: product.id!,
                onUpdated: () {
                  final controller = Get.find<ProductController>();
                  controller.loadProductDetail(product.id!);
                },
              ),
            );
          }
      ),
    );
  }
}