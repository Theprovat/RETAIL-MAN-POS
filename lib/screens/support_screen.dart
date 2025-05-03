import 'package:flutter/material.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C1C),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Support',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.help_outline, color: Colors.white),
            title: Text('Help', style: TextStyle(color: Colors.white)),
          ),
          Divider(color: Colors.white24),
          ListTile(
            leading: Icon(Icons.privacy_tip_outlined, color: Colors.white),
            title: Text('Legal information', style: TextStyle(color: Colors.white)),
          ),
          Divider(color: Colors.white24),
          ListTile(
            leading: Icon(Icons.person_outline, color: Colors.white),
            title: Text('Account', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
