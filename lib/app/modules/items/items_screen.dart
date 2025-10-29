import 'package:flutter/material.dart';

class ItemsScreen extends StatelessWidget {
  const ItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Items', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              _QuickAction(
                icon: Icons.add_circle_outline,
                title: 'Add Your First Items',
                desc: 'Scan a barcode or enter details to start your inventory.',
                onTap: () => _showSnack(context, 'Add Item tapped'),
              ),
              _QuickAction(
                icon: Icons.group_add_outlined,
                title: 'Invite Your Team',
                desc: 'Add teammates to manage your inventory together.',
                onTap: () => _showSnack(context, 'Invite Team tapped'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showSnack(context, 'FAB: Add Item'),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;
  final VoidCallback onTap;

  const _QuickAction({
    required this.icon,
    required this.title,
    required this.desc,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 3, offset: Offset(0, 2)),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 26),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  Text(desc, style: const TextStyle(fontSize: 14, color: Colors.black54)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

