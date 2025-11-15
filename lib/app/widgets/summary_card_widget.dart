import 'package:flutter/material.dart';

class SummaryCardWidget extends StatelessWidget {
  final String date;
  final List<SummaryItem> items;

  const SummaryCardWidget({
    super.key,
    required this.date,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
      shadowColor: Colors.black.withOpacity(0.1),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.primary.withOpacity(0.9),
              theme.colorScheme.primary.withOpacity(0.7),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            // Date & More Icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                  ),
                ),
                const Icon(Icons.more_horiz, color: Colors.white),
              ],
            ),
            const SizedBox(height: 16),

            // Summary Items
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: items
                  .map((item) => _buildSummaryItem(context, item))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(BuildContext context, SummaryItem item) {
    final theme = Theme.of(context);

    return Column(
      children: [
        // Optional icon with colored background
        if (item.icon != null)
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: item.color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(item.icon, color: item.color, size: 28),
          ),
        if (item.icon != null) const SizedBox(height: 8),

        Text(
          item.value,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          item.label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}

// Helper Model
class SummaryItem {
  final String label;
  final String value;
  final IconData? icon;
  final Color color;

  SummaryItem({
    required this.label,
    required this.value,
    this.icon,
    this.color = Colors.white,
  });
}