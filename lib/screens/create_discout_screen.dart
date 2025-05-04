import 'package:flutter/material.dart';

class CreateDiscountScreen extends StatefulWidget {
  const CreateDiscountScreen({super.key});

  @override
  State<CreateDiscountScreen> createState() => _CreateDiscountScreenState();
}

class _CreateDiscountScreenState extends State<CreateDiscountScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController valueController = TextEditingController();
  bool isPercentage = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Create discount',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // TODO: Save logic here
            },
            child: const Text(
              'SAVE',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Name', style: TextStyle(color: Colors.white)),
            const SizedBox(height: 8),
            TextField(
              controller: nameController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.transparent,
                border: UnderlineInputBorder(),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white38),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Value', style: TextStyle(color: Colors.white)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: valueController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.transparent,
                      border: UnderlineInputBorder(),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white38),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ToggleButtons(
                  borderRadius: BorderRadius.circular(4),
                  selectedColor: Colors.white,
                  color: Colors.white,
                  fillColor: Colors.green,
                  constraints: const BoxConstraints(minWidth: 48, minHeight: 36),
                  isSelected: [isPercentage, !isPercentage],
                  onPressed: (index) {
                    setState(() {
                      isPercentage = index == 0;
                    });
                  },
                  children: const [
                    Text('%'),
                    Text('Σ'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'To indicate the value upon sale, leave the field blank',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
