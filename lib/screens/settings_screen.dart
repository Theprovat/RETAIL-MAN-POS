import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C1C),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const ListTile(
              leading: Icon(Icons.print, color: Colors.white),
              title: Text('Printers', style: TextStyle(color: Colors.white)),
            ),
            const Divider(color: Colors.white24),
            const ListTile(
              leading: Icon(Icons.percent, color: Colors.white),
              title: Text('Taxes', style: TextStyle(color: Colors.white)),
            ),
            const Divider(color: Colors.white24),
            const ListTile(
              leading: Icon(Icons.settings, color: Colors.white),
              title: Text('General', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 24),
            const Text(
              'More settings are available in the Back Office',
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'GO TO BACK OFFICE',
                  style: TextStyle(color: Colors.green),
                ),
                SizedBox(width: 24),
                Text(
                  'GOT IT',
                  style: TextStyle(color: Colors.green),
                ),
              ],
            ),
           
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  // Handle sign out logic
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white54),
                ),
                child: const Text(
                  'SIGN OUT',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
