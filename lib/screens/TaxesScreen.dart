import 'package:flutter/material.dart';

class TaxesScreen extends StatelessWidget {
  const TaxesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C1C),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Taxes', style: TextStyle(color: Colors.white)),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.percent, size: 100, color: Colors.white38),
            const SizedBox(height: 16),
            const Text(
              'You have no taxes in this store yet',
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                const Text(
                  'Taxes can be applied to specific items and are\ncalculated at the time of sale. ',
                  style: TextStyle(color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
                GestureDetector(
                  onTap: () {
                    // Implement external link or navigation
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
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
        onPressed: () {
          // Handle adding a new tax
        },
      ),
    );
  }
}
