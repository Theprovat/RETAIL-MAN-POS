import 'package:flutter/material.dart';

class CreateCategoryScreen extends StatefulWidget {
  const CreateCategoryScreen({super.key});

  @override
  State<CreateCategoryScreen> createState() => _CreateCategoryScreenState();
}

class _CreateCategoryScreenState extends State<CreateCategoryScreen> {
  final TextEditingController _categoryNameController = TextEditingController();
  int selectedColorIndex = 0;

  final List<Color> colors = [
    Colors.grey,
    Colors.red,
    Colors.pink,
    Colors.orange,
    Colors.lime,
    Colors.green,
    Colors.blue,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF212121), // dark background
      appBar: AppBar(
        backgroundColor: const Color(0xFF212121),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Create category',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Handle save logic
            },
            child: const Text('SAVE', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _categoryNameController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Category name',
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Category color',
              style: TextStyle(color: Colors.green),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: List.generate(colors.length, (index) {
                final isSelected = selectedColorIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedColorIndex = index;
                    });
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: colors[index],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: isSelected
                        ? const Icon(Icons.check, color: Colors.white, size: 30)
                        : null,
                  ),
                );
              }),
            ),
            // const Spacer(),
            OutlinedButton(
              
              onPressed: () {
                // Handle assign items logic
              },
              
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.green),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Center(
                child: Text(
                  'ASSIGN ITEMS',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () {
                // Handle create item logic
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.green),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Center(
                child: Text(
                  'CREATE ITEM',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
