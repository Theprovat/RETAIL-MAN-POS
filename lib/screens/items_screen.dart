import 'package:flutter/material.dart';
// Removed duplicate import for all_discounts_screen.dart

import 'package:pos/screens/all_items_screen.dart';
import 'package:pos/screens/all_categories_screen.dart';
import 'package:pos/screens/all_modifier_screen.dart';
import 'package:pos/screens/all_discounts_screen.dart';

class ItemsScreen extends StatelessWidget {
  const ItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF212121), // Dark theme
      appBar: AppBar(
        backgroundColor: const Color(0xFF212121),
        title: const Text('Items', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(height: 1, color: Colors.white30),
          _buildItemTile(
            icon: Icons.list,
            title: 'Items',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AllItemsScreen()),
              );
            },
          ),
          _buildItemTile(
            icon: Icons.category,
            title: 'Categories',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AllCategoryScreen()),
              );
            },
          ),
          _buildItemTile(
            icon: Icons.settings,
            title: 'Modifiers',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AllModifierScreen()),
              );
            },
          ),
          _buildItemTile(
            icon: Icons.discount,
            title: 'Discounts',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AllDiscountsScreen()),
              );
            },
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Extended item settings are available in the Back Office',
              style: TextStyle(color: Colors.white70),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                TextButton(
                  onPressed: () {
                    // TODO: Add logic to open Back Office screen
                  },
                  child: const Text(
                    'GO TO BACK OFFICE',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'GOT IT',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildItemTile({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }
}


