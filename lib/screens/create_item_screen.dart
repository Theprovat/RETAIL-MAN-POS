import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateItemScreen extends StatefulWidget {
  const CreateItemScreen({super.key});

  @override
  State<CreateItemScreen> createState() => _CreateItemScreenState();
}

class _CreateItemScreenState extends State<CreateItemScreen> {
  String soldBy = 'Each';
  bool trackStock = false;
  String posRepType = 'Color and shape';
  Color selectedColor = Colors.grey;
  String selectedShape = 'square';
  File? selectedImage;

  final List<Color> availableColors = [
    Colors.grey,
    Colors.red,
    Colors.pink,
    Colors.orange,
    Colors.lime,
    Colors.green,
    Colors.blue,
    Colors.purple,
  ];

  final List<String> shapes = ['square', 'circle', 'burst', 'hexagon'];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController costController = TextEditingController();
  final TextEditingController skuController = TextEditingController(text: "10000");
  final TextEditingController barcodeController = TextEditingController();

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create item"),
        actions: [
          TextButton(
            onPressed: () {
              // Save logic
            },
            child: const Text("SAVE", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text("Name"),
            TextField(controller: nameController),
            const SizedBox(height: 16),

            const Text("Category"),
            DropdownButton<String>(
              value: 'No category',
              isExpanded: true,
              items: const [
                DropdownMenuItem(value: 'No category', child: Text('No category')),
              ],
              onChanged: (value) {},
            ),
            const SizedBox(height: 16),

            const Text("Sold by"),
            Row(
              children: [
                Radio<String>(
                  value: 'Each',
                  groupValue: soldBy,
                  onChanged: (value) => setState(() => soldBy = value!),
                ),
                const Text("Each"),
                Radio<String>(
                  value: 'Weight',
                  groupValue: soldBy,
                  onChanged: (value) => setState(() => soldBy = value!),
                ),
                const Text("Weight"),
              ],
            ),
            const SizedBox(height: 16),

            const Text("Price"),
            TextField(controller: priceController, keyboardType: TextInputType.number),
            const Text("To indicate the price upon sale, leave the field blank"),
            const SizedBox(height: 16),

            const Text("Cost"),
            TextField(controller: costController, keyboardType: TextInputType.number),
            const SizedBox(height: 16),

            const Text("SKU"),
            TextField(controller: skuController),
            const Text("Unique identifier assigned to an item"),
            const SizedBox(height: 16),

            const Text("Barcode"),
            TextField(controller: barcodeController),
            const SizedBox(height: 16),

            const Divider(height: 32),
            const Text("Inventory", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
            SwitchListTile(
              title: const Text("Track stock"),
              value: trackStock,
              onChanged: (value) => setState(() => trackStock = value),
            ),

            const Divider(height: 32),
            const Text("Representation on POS", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
            Row(
              children: [
                Radio<String>(
                  value: 'Color and shape',
                  groupValue: posRepType,
                  onChanged: (value) => setState(() => posRepType = value!),
                ),
                const Text("Color and shape"),
                Radio<String>(
                  value: 'Image',
                  groupValue: posRepType,
                  onChanged: (value) => setState(() => posRepType = value!),
                ),
                const Text("Image"),
              ],
            ),

            if (posRepType == 'Color and shape') ...[
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: availableColors.map((color) {
                  return GestureDetector(
                    onTap: () => setState(() => selectedColor = color),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: color,
                        border: Border.all(
                          color: selectedColor == color ? Colors.white : Colors.transparent,
                          width: 3,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 10,
                children: shapes.map((shape) {
                  return GestureDetector(
                    onTap: () => setState(() => selectedShape = shape),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selectedShape == shape ? Colors.white : Colors.grey,
                        ),
                        borderRadius: shape == 'circle'
                            ? BorderRadius.circular(20)
                            : BorderRadius.circular(5),
                      ),
                      child: selectedShape == shape
                          ? const Icon(Icons.check, color: Colors.white)
                          : null,
                    ),
                  );
                }).toList(),
              ),
            ] else if (posRepType == 'Image') ...[
              const SizedBox(height: 10),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () => pickImage(ImageSource.gallery),
                    icon: const Icon(Icons.image),
                    label: const Text("Pick from gallery"),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: () => pickImage(ImageSource.camera),
                    icon: const Icon(Icons.camera_alt),
                    label: const Text("Take photo"),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              if (selectedImage != null)
                Image.file(
                  selectedImage!,
                  height: 120,
                  width: 120,
                  fit: BoxFit.cover,
                )
              else
                const Text("No image selected."),
            ]
          ],
        ),
      ),
    );
  }
}
