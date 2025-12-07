import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventoryapp/app/constants/app_color.dart';
import 'package:inventoryapp/app/constants/app_spacing.dart';
import 'package:inventoryapp/app/widgets/item_card_widget.dart';
import 'package:inventoryapp/app/widgets/title_text_widget.dart';
import 'package:inventoryapp/modules/category/widgets/category_bottomsheet.dart';
import '../../api/controllers/category_controller.dart';

class CategoryView extends StatelessWidget {
  CategoryView({super.key});

  final CategoryController controller = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    controller.fetchCategories();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _search(),
          Expanded(child: _categoryList(context)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.bottomSheet(
            CategoryBottomSheet(),
            isScrollControlled: true,
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  /// Search Field
  Widget _search() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppSpacing.paddingL,
        horizontal: AppSpacing.paddingM,
      ),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Search categories...',
          prefixIcon: const Icon(Icons.search),
        ),
        onChanged: controller.onSearchChanged,
      ),
    );
  }

  /// Category List with Sort option
  Widget _categoryList(BuildContext context) {
    return Container(
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
              TitleTextWidget(text: "All Categories"),
              GestureDetector(
                onTap: (){
                  _showSortDialog(context);
                },
                child: const Icon(Icons.filter_alt, color: AppColors.primary),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Obx(() {
              if (controller.loading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.categories.isEmpty) {
                return const Center(child: Text("No categories found"));
              }

              return ListView.builder(
                itemCount: controller.categories.length,
                itemBuilder: (context, index) {
                  final category = controller.categories[index];
                  return ItemCardWidget(
                    title: category.name,
                    icon: Icons.category,
                    subtitle: category.description,
                    onTap: () {
                      Get.bottomSheet(
                        CategoryBottomSheet(category: category),
                        isScrollControlled: true,
                      );
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  /// Sort Dialog
  void _showSortDialog(BuildContext context) {
    Get.defaultDialog(
      title: "Sort Categories",
      titleStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w700
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ItemCardWidget(
            title: "Name (Ascending)",
            icon: Icons.arrow_downward,
            showArrow: false,
            onTap: () {
              controller.setSort("name");
              Get.back();
            },
          ),
          ItemCardWidget(
            title: "Name (Descending)",
            icon: Icons.arrow_upward,
            showArrow: false,
            onTap: () {
              controller.setSort("-name");
              Get.back();
            },
          ),
        ],
      ),
    );
  }

}