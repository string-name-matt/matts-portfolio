// This screen handles user sign-in using Firebase Email/Password authentication

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// A stateful widget is needed because we're managing user input and async state
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // TextEditingControllers store the user's email and password input
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // This function signs in the user using Firebase Auth
  Future<void> _signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(), // Remove any extra spaces
        password: passwordController.text.trim(),
      );

      // Show success message on successful login
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Signed in successfully')),
      );
    } catch (e) {
      // Show error if login fails (bad credentials, no internet, etc.)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar at the top of the screen
      appBar: AppBar(title: const Text('Sign In')),

      // Main content area with input fields and sign in button
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Input field for email
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),

            // Input field for password (obscured)
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),

            const SizedBox(height: 20),

            // Button that calls the _signIn function when pressed
            ElevatedButton(
              onPressed: _signIn,
              child: const Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
