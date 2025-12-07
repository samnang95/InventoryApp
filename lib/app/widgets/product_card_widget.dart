import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:inventoryapp/app/constants/app_spacing.dart';
import 'package:inventoryapp/app/constants/app_widget_size.dart';
import 'package:inventoryapp/app/helper/base64_helper.dart';
import 'package:inventoryapp/app/widgets/circle_icon_button.dart';

class ProductCardWidget extends StatelessWidget {
  final List<String> images;
  final String name;
  final String category;
  final int stock;
  final double price;
  final VoidCallback? onTap;
  final VoidCallback? onTapEdit;
  final VoidCallback? onTapDelete;

  const ProductCardWidget({
    super.key,
    required this.images,
    required this.name,
    required this.category,
    required this.stock,
    required this.price,
    this.onTap,
    this.onTapEdit,
    this.onTapDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget _buildImage() {
      if (images.isEmpty) {
        return Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.image,
            size: AppWidgetSize.iconMedium,
            color: theme.colorScheme.primary,
          ),
        );
      }

      final firstImage = images.first;

      if (firstImage.startsWith('data:image')) {
        final bytes = base64Decode(Base64Helper.extractBase64(firstImage));
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.memory(
            bytes,
            height: 70,
            width: 70,
            fit: BoxFit.cover,
          ),
        );
      }

      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          firstImage,
          height: 70,
          width: 70,
          fit: BoxFit.cover,
        ),
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              _buildImage(),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      category.isNotEmpty ? category : "N/A",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.hintColor,
                      ),
                    ),
                    SizedBox(height: AppSpacing.paddingS),
                    Text(
                      "Stock: $stock",
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // Edit Button
                      CircleIconButton(
                        icon: Icons.edit,
                        backgroundColor: Colors.blue.withOpacity(0.8),
                        size: AppWidgetSize.iconMedium,
                        onTap: onTapEdit ?? () {},
                      ),
                      const SizedBox(width: 10),
                      // Delete Button
                      CircleIconButton(
                        icon: Icons.delete,
                        backgroundColor: Colors.red.withOpacity(0.9),
                        size: AppWidgetSize.iconMedium,
                        onTap: onTapDelete ?? () {},
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}