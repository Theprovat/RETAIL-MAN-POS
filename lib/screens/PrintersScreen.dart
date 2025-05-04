import 'package:flutter/material.dart';
import 'package:pos/screens/CreatePrinterScreen.dart';

class PrintersScreen extends StatelessWidget {
  const PrintersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C1C),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Printers', style: TextStyle(color: Colors.white)),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.print, size: 100, color: Colors.white38),
            const SizedBox(height: 16),
            const Text(
              'You have no printers yet',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                const Text(
                  'Here you can connect your receipt printer. ',
                  style: TextStyle(color: Colors.white70),
                ),
                GestureDetector(
                  onTap: () {
                    // Implement navigation or external link here
                  },
                  child: const Text(
                    'Learn more',
                    style: TextStyle(color: Colors.lightBlue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreatePrinterScreen()),
    );
  },
  backgroundColor: Colors.green,
  child: const Icon(Icons.add),
),

    );
  }
}
