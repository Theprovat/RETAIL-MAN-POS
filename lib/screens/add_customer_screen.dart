import 'package:flutter/material.dart';
import 'package:pos/screens/create_customer_screen.dart'; // Adjust the import as necessary

class AddCustomerScreen extends StatelessWidget {
  const AddCustomerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add customer to ticket'),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.white),
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.blue),
                border: InputBorder.none,
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CreateCustomerScreen()),
                );
              },
              child: const Text(
                'ADD NEW CUSTOMER',
                style: TextStyle(color: Colors.green, fontSize: 16),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Text(
              'Recent customers',
              style: TextStyle(color: Colors.white70),
            ),
          ),
          // Add customer list here later
        ],
      ),
    );
  }
}