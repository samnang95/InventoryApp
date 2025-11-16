import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/app/constants/app_spacing.dart';
import 'package:inventoryapp/app/routes/app_routes.dart';
import 'package:inventoryapp/app/widgets/product_card_widget.dart';
import 'package:inventoryapp/app/widgets/title_text_widget.dart';
import 'package:inventoryapp/modules/product/widgets/add_product_widget.dart';
import '../../app/constants/app_color.dart';

class SearchScreen extends GetView<SearchController> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Search Products"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _search(),
            _productList(),
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
        // onChanged: controller.onSearchChanged,
      ),
    );
  }

  Widget _productList() {
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
                    // filter action
                  },
                  child: const Icon(Icons.filter_alt, color: AppColors.primary),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ProductCardWidget(
              image: "https://images.pexels.com/photos/2533266/pexels-photo-2533266.jpeg",
              name: "Product Name",
              category: "Category",
              stock: 1,
              id: "1",
              price: 100,
              onTap: () {
                Get.toNamed(AppRoutes.productDetail);
              },
            ),
          ],
        ),
      ),
    );
  }
}