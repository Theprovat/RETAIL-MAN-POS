import 'package:flutter/material.dart';

class CreateTaxScreen extends StatefulWidget {
  const CreateTaxScreen({super.key});

  @override
  State<CreateTaxScreen> createState() => _CreateTaxScreenState();
}

class _CreateTaxScreenState extends State<CreateTaxScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  String selectedType = 'Included in the price';

  final List<String> taxTypes = [
    'Included in the price',
    'Added to the price',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C1C),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Create tax', style: TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: () {
              // Save action here
            },
            child: const Text('SAVE', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder:
                    UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _rateController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Tax rate, %',
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder:
                    UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedType,
              dropdownColor: const Color(0xFF2C2C2C),
              decoration: const InputDecoration(
                labelText: 'Type',
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder:
                    UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
              ),
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {
                setState(() {
                  selectedType = value!;
                });
              },
              items: taxTypes.map((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Apply to items logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2C2C2C),
                padding: const EdgeInsets.symmetric(vertical: 14),
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text('APPLY TO ITEMS', style: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }
}
