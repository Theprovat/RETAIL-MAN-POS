import 'package:flutter/material.dart';

class GeneralSettingsScreen extends StatefulWidget {
  const GeneralSettingsScreen({super.key});

  @override
  State<GeneralSettingsScreen> createState() => _GeneralSettingsScreenState();
}

class _GeneralSettingsScreenState extends State<GeneralSettingsScreen> {
  bool useCameraToScan = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C1C),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('General', style: TextStyle(color: Colors.white)),
        elevation: 0,
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text(
              'Use camera to scan barcodes',
              style: TextStyle(color: Colors.white),
            ),
            value: useCameraToScan,
            onChanged: (val) {
              setState(() {
                useCameraToScan = val;
              });
            },
            activeColor: Colors.green,
          ),
          ListTile(
            title: const Text('Dark mode', style: TextStyle(color: Colors.white)),
            subtitle: const Text('Use device settings', style: TextStyle(color: Colors.white70)),
            onTap: () {
              // Add dark mode configuration logic
            },
          ),
          ListTile(
            title: const Text('Home screen item layout', style: TextStyle(color: Colors.white)),
            subtitle: const Text('List', style: TextStyle(color: Colors.white70)),
            onTap: () {
              // Navigate to layout options
            },
          ),
          ListTile(
            title: const Text('Language', style: TextStyle(color: Colors.white)),
            subtitle: const Text('English', style: TextStyle(color: Colors.white70)),
            onTap: () {
              // Navigate to language selection
            },
          ),
        ],
      ),
    );
  }
}
