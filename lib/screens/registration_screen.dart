import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String selectedCountry = 'India';
  bool agreeToTerms = false;

  final List<String> countries = [
    'India',
    'United States',
    'United Kingdom',
    'Canada',
    'Australia',
    'Germany',
    'France',
    'Japan',
    'China',
    'Brazil',
    'Russia',
    'South Africa',
    'New Zealand',
    'Mexico',
    'Italy',
    'Spain',
    'Netherlands',
    'Singapore',
    'Indonesia',
    'Malaysia',
    'Thailand',
    'Philippines',
    'Bangladesh',
    'Pakistan',
    'Sri Lanka',
    'Nepal',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registration')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.visibility_off),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Business Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Country',
                  border: OutlineInputBorder(),
                ),
                value: selectedCountry,
                items:
                    countries.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedCountry = newValue;
                    });
                  }
                },
              ),
              const SizedBox(height: 16.0),
              Row(
                children: <Widget>[
                  Checkbox(
                    value: agreeToTerms,
                    onChanged: (bool? newValue) {
                      setState(() {
                        agreeToTerms = newValue ?? false;
                      });
                    },
                  ),
                  const Expanded(
                    child: Text(
                      'I agree to Retail-Man Terms of Use and have read and acknowledged Privacy Policy',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed:
                    agreeToTerms
                        ? () {
                          // Handle registration logic
                          print('Sign Up button pressed');
                          print('Country: $selectedCountry');
                        }
                        : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  textStyle: const TextStyle(fontSize: 18.0),
                ),
                child: const Text('SIGN UP'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
