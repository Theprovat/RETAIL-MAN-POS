import 'package:flutter/material.dart';
import 'package:pos/screens/create_discout_screen.dart ';



class AllDiscountsScreen extends StatelessWidget {
  const AllDiscountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Matches dark background
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Discounts',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // TODO: Search functionality
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.local_offer_outlined, size: 100, color: Colors.grey),
            SizedBox(height: 20),
            Text(
              'You have no discounts yet',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Text.rich(
                TextSpan(
                  text: 'Create discounts that can be applied at the time of sale. ',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                  children: [
                    TextSpan(
                      text: 'Learn more',
                      style: TextStyle(color: Colors.blueAccent),
                      // TODO: Add GestureRecognizer if you want tappable link
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
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
      MaterialPageRoute(builder: (context) => const CreateDiscountScreen()),
    );
  },
  child: const Icon(Icons.add, color: Colors.white, size: 32),
),

    );
  }
}
