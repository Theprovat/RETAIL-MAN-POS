import 'package:flutter/material.dart';
import 'package:pos/screens/create_modifiers_screen.dart';

class AllModifierScreen extends StatelessWidget {
  const AllModifierScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Modifiers", style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.list, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'You have no items modifiers yet',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Create sets of options that can be applied to items.',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreateModifierScreen()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
