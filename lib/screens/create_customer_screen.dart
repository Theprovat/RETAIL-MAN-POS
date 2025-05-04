import 'package:flutter/material.dart';

class CreateCustomerScreen extends StatelessWidget {
  const CreateCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final inputDecoration = InputDecoration(
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.green),
      ),
      hintStyle: const TextStyle(color: Colors.grey),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create customer'),
        backgroundColor: Colors.blueGrey,
        actions: [
          TextButton(
            onPressed: () {
              // Save logic here
              Navigator.pop(context);
            },
            child: const Text('SAVE', style: TextStyle(color: Colors.black)),
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            buildTextField(icon: Icons.person, hint: 'Name', decoration: inputDecoration),
            buildTextField(icon: Icons.email, hint: 'Email', decoration: inputDecoration),
            buildTextField(icon: Icons.phone, hint: 'Phone', decoration: inputDecoration),
            buildTextField(icon: Icons.location_on, hint: 'Address', decoration: inputDecoration),
            buildTextField(hint: 'City', decoration: inputDecoration),
            buildTextField(hint: 'State', decoration: inputDecoration),
            buildTextField(hint: 'Postal code', decoration: inputDecoration),
            buildTextField(icon: Icons.code, hint: 'Customer code', decoration: inputDecoration),
            buildTextField(icon: Icons.message, hint: 'Note', decoration: inputDecoration),
            
            DropdownButtonFormField<String>(
              dropdownColor: Colors.black,
              decoration: inputDecoration.copyWith(hintText: 'Country'),
              items: ['India', 'USA', 'UK', 'Germany'].map((country) {
                return DropdownMenuItem(
                  value: country,
                  child: Text(country, style: const TextStyle(color: Colors.white)),
                );
              }).toList(),
              onChanged: (value) {},
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField({
    IconData? icon,
    required String hint,
    required InputDecoration decoration,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        decoration: decoration.copyWith(
          prefixIcon: icon != null ? Icon(icon, color: Colors.white) : null,
          hintText: hint,
        ),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
