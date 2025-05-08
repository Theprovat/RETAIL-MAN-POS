// import 'package:flutter/material.dart';
// import 'package:pos/screens/ticket_screen.dart';

// class SignInScreen extends StatelessWidget {
//   const SignInScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.lightBlue,
//       appBar: AppBar(
//         backgroundColor: Colors.lightBlue,
//         title: const Text('Sign In'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 'Welcome Back!',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 24.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 24.0),
//               TextField(
//                 style: const TextStyle(color: Colors.white),
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                   labelStyle: const TextStyle(color: Colors.white70),
//                   filled: true,
//                   fillColor: Colors.grey[800],
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16.0),
//               TextField(
//                 obscureText: true,
//                 style: const TextStyle(color: Colors.white),
//                 decoration: InputDecoration(
//                   labelText: 'Password',
//                   labelStyle: const TextStyle(color: Colors.white70),
//                   filled: true,
//                   fillColor: Colors.grey[800],
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 24.0),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,  
//                     MaterialPageRoute(builder: (context) => const TicketScreen()),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.green,
//                   padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 16.0),
//                 ),
//                 child: const Text(
//                   'Sign In',
//                   style: TextStyle(fontSize: 16.0, color: Colors.white),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../services/offline_sync_service.dart';
import 'package:pos/screens/ticket_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String errorMessage = '';

  void _signInUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    final storedData = await OfflineSyncService.getUserDataByEmail(email);

    if (storedData != null && storedData['password'] == password) {
      setState(() => errorMessage = '');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TicketScreen()),
      );
    } else {
      setState(() {
        errorMessage = 'Invalid email or password.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text('Sign In'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome Back!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24.0),
              TextField(
                controller: emailController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: passwordController,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              if (errorMessage.isNotEmpty)
                Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: _signInUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 16.0),
                ),
                child: const Text(
                  'Sign In',
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

