import 'package:flutter/material.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  Widget transactionCard({
    required IconData icon,
    required String title,
    required String desc,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 28),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    desc,
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top AppBar Style
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Transactions",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Icon(Icons.filter_alt_outlined),
                      SizedBox(width: 16),
                      Icon(Icons.swap_vert),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            transactionCard(
              icon: Icons.south, // ↓ icon
              title: "Stock In",
              desc:
                  "Add items to inventory by choosing a location and quantity.",
              onTap: () => _showSnack(context, 'Stock In'),
            ),

            transactionCard(
              icon: Icons.north, // ↑ icon
              title: "Stock Out",
              desc:
                  "Remove item from inventory by choosing a location and quantity.",
              onTap: () => _showSnack(context, 'Stock Out'),
            ),

            transactionCard(
              icon: Icons.east, // →
              title: "Move Stock",
              desc: "Transactions item between location to stay organized.",
              onTap: () => _showSnack(context, 'Move Stock'),
            ),

            transactionCard(
              icon: Icons.north_east, // ↗
              title: "Adjust Stock",
              desc: "Update item quantities to match actual stock.",
              onTap: () => _showSnack(context, 'Adjust Stock'),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        shape: const CircleBorder(),
        onPressed: () => _showSnack(context, 'New transaction'),
        child: const Icon(Icons.add, size: 32, color: Colors.white),
      ),
    );
  }

  void _showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
