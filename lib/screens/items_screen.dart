import 'package:flutter/material.dart';

class ItemsScreen extends StatelessWidget {
  const ItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Items'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Closes this screen and returns to drawer
          },
        ),
      ),
      body: Column(
        children: [
          const Divider(height: 1),
          // _buildItemTile(Icons.list, 'Items'),
          _buildItemTile(Icons.category, 'Categories'),
          _buildItemTile(Icons.playlist_add_check, 'Modifiers'),
          _buildItemTile(Icons.local_offer, 'Discounts'),
          
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
                    // TODO: Add logic for "Go to Back Office"
                  },
                  child: const Text(
                    'GO TO BACK OFFICE',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    // TODO: Dismiss action
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
      backgroundColor: Colors.black87,
    );
  }

  Widget _buildItemTile(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: () {
        // You can add navigation for each tile here
      },
    );
  }
}
