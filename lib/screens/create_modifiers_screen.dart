import 'package:flutter/material.dart';

class CreateModifierScreen extends StatefulWidget {
  const CreateModifierScreen({super.key});

  @override
  State<CreateModifierScreen> createState() => _CreateModifierScreenState();
}

class _CreateModifierScreenState extends State<CreateModifierScreen> {
  final TextEditingController _modifierNameController = TextEditingController();
  List<Map<String, dynamic>> _options = [
    {'name': '', 'price': 0.0}
  ];

  void _addOption() {
    setState(() {
      _options.add({'name': '', 'price': 0.0});
    });
  }

  void _removeOption(int index) {
    setState(() {
      _options.removeAt(index);
    });
  }

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
        title: const Text('Create modifier', style: TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: () {
              // Save logic here
            },
            child: const Text('SAVE', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _modifierNameController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Modifier name',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ..._options.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> option = entry.value;

              return Row(
                children: [
                  const Icon(Icons.drag_handle, color: Colors.white),
                  Expanded(
                    child: TextField(
                      onChanged: (val) => _options[index]['name'] = val,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Option name',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      onChanged: (val) => _options[index]['price'] = double.tryParse(val) ?? 0.0,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Price',
                        labelStyle: TextStyle(color: Colors.white),
                        prefixText: '₹',
                        prefixStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.white),
                    onPressed: () => _removeOption(index),
                  ),
                ],
              );
            }).toList(),
            const SizedBox(height: 20),
            TextButton.icon(
              onPressed: _addOption,
              icon: const Icon(Icons.add, color: Colors.green),
              label: const Text('ADD OPTION', style: TextStyle(color: Colors.green)),
            ),
          ],
        ),
      ),
    );
  }
}
