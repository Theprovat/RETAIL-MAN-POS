import 'package:flutter/material.dart';
import 'package:pos/screens/create_item_screen.dart';

class AllItemsScreen extends StatelessWidget {
  const AllItemsScreen({super.key});

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
        title: Row(
          children: const [
            Text("All items", style: TextStyle(color: Colors.white)),
            SizedBox(width: 4),
            Icon(Icons.keyboard_arrow_down, color: Colors.white),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Implement search functionality here
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Search'),
                  content: TextField(
                    decoration: const InputDecoration(hintText: 'Search items...'),
                    onSubmitted: (value) {
                      // Handle search action
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
              

            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.list, size: 80, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              'You have no items yet',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                text: 'Here you can manage your items. ',
                style: const TextStyle(color: Colors.grey),
                children: [
                  TextSpan(
                    text: 'Learn more',
                    style: const TextStyle(color: Colors.blueAccent),
                    // Add recognizer if you want to handle tap
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
     floatingActionButton: FloatingActionButton(
  backgroundColor: Colors.green,
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateItemScreen()),
    );
  },
  child: const Icon(Icons.add, color: Colors.white),
),
    );
  }
}