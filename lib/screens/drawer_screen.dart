import 'package:flutter/material.dart';
import 'package:pos/screens/receipts_screen.dart';
import 'package:pos/screens/items_screen.dart';
import 'package:pos/screens/settings_screen.dart';
import 'package:pos/screens/support_screen.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF1C1C1C),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Owner',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'POS 1',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                Text(
                  'Marketing',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildMenuItem(context, Icons.shopping_basket, 'Sales'),
          _buildMenuItem(
            context,
            Icons.receipt_long,
            'Receipts',
            screen: const ReceiptsScreen(),
          ),
          _buildMenuItem(
            context,
            Icons.view_list,
            'Items',
            screen: const ItemsScreen(),
          ),
          _buildMenuItem(context,
  Icons.settings,
  'Settings',
  screen: const SettingsScreen(),),
          const Divider(color: Colors.white24, height: 32),
          // _buildMenuItem(context, Icons.bar_chart, 'Back office'),
          // _buildMenuItem(context, Icons.card_giftcard, 'Apps'),
          _buildMenuItem(
  context,
  Icons.support_agent,
  'Support',
  screen: const SupportScreen(),
),
          const Spacer(),
          const Padding(padding: EdgeInsets.only(left: 16.0, bottom: 12)),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String title, {
    bool selected = false,
    Widget? screen,
  }) {
    return Container(
      color: selected ? Colors.black54 : Colors.transparent,
      child: ListTile(
        leading: Icon(icon, color: selected ? Colors.green : Colors.white),
        title: Text(
          title,
          style: TextStyle(
            color: selected ? Colors.green : Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        onTap: () {
          Navigator.pop(context); // Close the drawer
          if (screen != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => screen),
            );
          }
        },
      ),
    );
  }
}
