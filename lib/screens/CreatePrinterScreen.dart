import 'package:flutter/material.dart';

class CreatePrinterScreen extends StatefulWidget {
  const CreatePrinterScreen({super.key});

  @override
  State<CreatePrinterScreen> createState() => _CreatePrinterScreenState();
}

class _CreatePrinterScreenState extends State<CreatePrinterScreen> {
  final TextEditingController _nameController = TextEditingController();
  bool printReceipts = false;
  String selectedPrinter = 'No printer';

  final List<String> printerModels = ['No printer', 'Epson TM-T20', 'Star TSP100'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C1C),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Create printer', style: TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: () {
              // Save action
            },
            child: const Text('SAVE', style: TextStyle(color: Colors.white)),
          )
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
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedPrinter,
              dropdownColor: const Color(0xFF2C2C2C),
              decoration: const InputDecoration(
                labelText: 'Printer model',
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {
                setState(() {
                  selectedPrinter = value!;
                });
              },
              items: printerModels.map((String printer) {
                return DropdownMenuItem<String>(
                  value: printer,
                  child: Text(printer),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            SwitchListTile(
              title: const Text('Print receipts', style: TextStyle(color: Colors.white)),
              value: printReceipts,
              onChanged: (value) {
                setState(() {
                  printReceipts = value;
                });
              },
              activeColor: Colors.green,
            ),
            // const Spacer(),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2C2C2C),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              onPressed: () {
                // Print test logic
              },
              icon: const Icon(Icons.print, color: Colors.white),
              label: const Text('PRINT TEST', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
