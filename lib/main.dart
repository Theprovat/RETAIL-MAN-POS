// main.dart
import 'package:flutter/material.dart';
import 'screens/registration_screen.dart';
import 'screens/sign_in_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RETAIL-MAN-POS',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const RegistrationSignInScreen(),
      routes: {
        '/registration': (context) => const RegistrationScreen(),
        '/sign_in': (context) => const SignInScreen(),
      },
    );
  }
}

class RegistrationSignInScreen extends StatelessWidget {
  const RegistrationSignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.white,
              child: Center(
                child: Image.asset(
                  'lib\\assets\\images\\retail-pos.jpg',
                  width: 400,
                  height: 400,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/registration');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        textStyle: const TextStyle(fontSize: 18.0),
                      ),
                      child: const Text('REGISTRATION'),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/sign_in');
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.green, width: 2.0),
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        textStyle: const TextStyle(fontSize: 18.0),
                        foregroundColor: Colors.blue,
                      ),
                      child: const Text('SIGN IN'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
