import 'package:flutter/material.dart';
import 'package:inventoryapp/app/constants/app_widget_size.dart';

class ItemCardWidget extends StatelessWidget {
  final IconData? icon;
  final String title;
  final String? subtitle;
  final Widget? subtitleWidget;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool showArrow;

  final Color? iconBackgroundColor;
  final Color? iconColor;

  const ItemCardWidget({
    super.key,
    this.icon,
    required this.title,
    this.subtitle,
    this.subtitleWidget,
    this.onTap,
    this.trailing,
    this.showArrow = true,
    this.iconBackgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              if (icon != null)
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: iconBackgroundColor ??
                        theme.colorScheme.primary.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    size: 22,
                    color: iconColor ?? theme.colorScheme.primary,
                  ),
                ),

              if (icon != null) const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (subtitle != null || subtitleWidget != null) ...[
                      const SizedBox(height: 4),
                      subtitleWidget ??
                          Text(
                            subtitle!,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                    ],
                  ],
                ),
              ),

              trailing ??
                  (showArrow
                      ? Icon(
                    Icons.arrow_circle_right_outlined,
                    color: theme.colorScheme.onSurfaceVariant,
                    size: AppWidgetSize.iconXS,
                  )
                      : const SizedBox.shrink()),
            ],
          ),
        ),
      ),
    );
  }
}