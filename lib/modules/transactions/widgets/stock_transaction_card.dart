import 'package:flutter/material.dart';
import 'package:inventoryapp/app/constants/app_color.dart';
import 'package:inventoryapp/app/constants/app_spacing.dart';

class StockTransactionCard extends StatelessWidget {
  final String productName;
  final String type;
  final int quantity;
  final String date;

  const StockTransactionCard({
    super.key,
    required this.productName,
    required this.type,
    required this.quantity,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {

    final bool isStockIn = type.toLowerCase() == "stock in";

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.grey.shade50,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: 8,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isStockIn
                        ? [AppColors.success.withOpacity(0.9), AppColors.success.withOpacity(0.5)]
                        : [AppColors.error.withOpacity(0.9), AppColors.error.withOpacity(0.5)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(AppSpacing.paddingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Product Name
                  Text(
                    productName,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          // Date
                          Icon(
                            Icons.access_time,
                            size: 15,
                            color: AppColors.lightTextSecondary,
                          ),
                          SizedBox(width: AppSpacing.paddingXS),
                          Text(
                            date,
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: AppColors.greyColor
                            ),
                          ),
                          SizedBox(width: AppSpacing.paddingM),
                          Icon(
                            Icons.inventory_2_outlined,
                            size: 16,
                            color: AppColors.lightTextSecondary,
                          ),
                          SizedBox(width: AppSpacing.paddingXS),
                          Text(
                            "$quantity pcs",
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: AppColors.greyColor
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: (isStockIn ? AppColors.success : AppColors.error).withOpacity(0.18),
                          border: Border.all(
                            color: isStockIn ? AppColors.success : AppColors.error,
                            width: 0.7,
                          ),
                        ),
                        child: Text(
                          type,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: isStockIn ? AppColors.success : AppColors.error,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}