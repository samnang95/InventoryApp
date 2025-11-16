import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/app/constants/app_spacing.dart';
import 'package:inventoryapp/app/widgets/item_card_widget.dart';
import 'package:inventoryapp/modules/productDetail/widgets/product_chip_widget.dart';
import 'package:inventoryapp/modules/productDetail/widgets/product_header_widget.dart';
import 'package:inventoryapp/modules/productDetail/widgets/stock_update_dialog.dart';
import 'package:inventoryapp/modules/productDetail/widgets/supplier_update_dialog.dart';

class ProductDetailScreen extends StatelessWidget {
  ProductDetailScreen({super.key});

  // ---------------------------------------------------------
  // FIXED PRODUCT DATA (NO ARGUMENTS)
  // ---------------------------------------------------------
  final item = {
    "id": 1,
    "name": "Wireless Headphones",
    "price": 59.99,
    "image":
    "https://images.unsplash.com/photo-1518443737228-7d3f339a7e31?w=600",
    "category": "Electronics",
    "brand": "Sony",
    "sku": "WH-1000XM",
    "stock": 42,
    "supplier": "Sony Supplier Ltd",
    "supplier_contact": "+855 98 888 777",
    "description":
    "Premium wireless headphones with noise cancellation, deep bass, and long-lasting battery performance.",
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          _buildHeader(theme),
          Expanded(child: _buildContent(theme, context)),
        ],
      ),
    );
  }

  // ======================================================
  // HEADER WITH GRADIENT + HERO
  // ======================================================
  Widget _buildHeader(ThemeData theme) {
    final List<String> productImages = [
      "https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=600",
      "https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?w=600",
      "https://images.pexels.com/photos/335257/pexels-photo-335257.jpeg",
      "https://images.pexels.com/photos/90946/pexels-photo-90946.jpeg",
      "https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=600",
      "https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?w=600",
      "https://images.pexels.com/photos/335257/pexels-photo-335257.jpeg",
      "https://images.pexels.com/photos/90946/pexels-photo-90946.jpeg"
    ];

    return ProductHeaderWidget(
      productId: 1,
      images: productImages,
    );

  }

  Widget _buildContent(ThemeData theme, BuildContext context) {
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
              item["name"].toString(),
              style: theme.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Text(
              "\$${item["price"]}",
              style: theme.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
                fontSize: 22,
              ),
            ),
            SizedBox(height: AppSpacing.paddingL),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                productChipWidget(theme, Icons.category, item["category"].toString()),
                productChipWidget(theme, Icons.store, item["brand"].toString()),
                productChipWidget(theme, Icons.qr_code, "SKU: ${item["sku"]}"),
              ],
            ),
            SizedBox(height: AppSpacing.paddingL),
            _buildStockCard(context),
            SizedBox(height: AppSpacing.paddingXS),
            _buildSupplierCard(),
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
              item["description"].toString(),
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

  Widget _buildStockCard(BuildContext context) {
    return ItemCardWidget(
      icon: Icons.inventory_2_rounded,
      title: "Stock Available",
      subtitle: "${item["stock"]} items",
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => StockUpdateDialog(
            item: item,
            onUpdate: (type, qty, date) {

            },
          ),
        );
      },
      showArrow: true,
      trailing: null,
    );
  }

  Widget _buildSupplierCard() {
    return ItemCardWidget(
      icon: Icons.business_center,
      title: item["supplier"].toString(),
      subtitle: item["supplier_contact"].toString(),
      onTap: () {
        showDialog(
          context: Get.context!,
          builder: (_) => SupplierDialogWidget(
            onSubmit: (name, contact, address) {

            },
          ),
        );
      },
      showArrow: true,
      trailing: null,
    );
  }

}
