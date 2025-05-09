// Enhanced login dialog with password reset and access request toggle

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginDialog extends StatefulWidget {
  const LoginDialog({super.key});

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  // Controllers to handle user input
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController sourceController = TextEditingController();

  bool _isLoading = false; // Indicates whether a background process is ongoing
  bool _showAccessRequest =
      false; // Toggles between login and access request forms
  String? _errorMessage; // Displays error messages
  String? _successMessage; // Displays success messages

  // Handles login logic with Firebase Auth
  Future<void> _handleLogin() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _successMessage = null;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (!mounted) return;
      Navigator.of(context).pop(); // Close dialog upon successful login
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message;
      });
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  // Sends a password reset email
  Future<void> _handlePasswordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
      setState(() => _successMessage = 'Password reset link sent.');
    } catch (e) {
      setState(() => _errorMessage = 'Failed to send reset email.');
    }
  }

  // Submits an access request to Firestore
  Future<void> _submitAccessRequest() async {
    final data = {
      'email': emailController.text.trim(),
      'company': companyController.text.trim(),
      'source': sourceController.text.trim(),
      'timestamp': FieldValue.serverTimestamp(),
    };

    try {
      await FirebaseFirestore.instance
          .collection('resume_access_requests')
          .add(data);
      setState(() => _successMessage = 'Access request submitted!');
    } catch (e) {
      setState(() => _errorMessage = 'Error submitting request.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      // Rounded dialog box
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 450, maxHeight: 500),
        // Set a consistent width
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // Dialog takes up only the needed space
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _showAccessRequest ? 'Request Access' : 'Sign In',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () =>
                        Navigator.of(context).pop(), // Close the dialog
                  )
                ],
              ),
              const SizedBox(height: 16),
              // Email input
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              // Conditional form inputs based on view state
              if (_showAccessRequest)
                Column(
                  children: [
                    TextField(
                      controller: companyController,
                      decoration: const InputDecoration(
                        labelText: 'Company (optional)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: sourceController,
                      decoration: const InputDecoration(
                        labelText: 'How did you find me?',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                )
              else
                Column(
                  children: [
                    TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true, // Hide password input
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: _handlePasswordReset,
                        // Trigger password reset
                        child: const Text('Forgot Password?'),
                      ),
                    ),
                  ],
                ),
              // Display error message if any
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              // Display success message if any
              if (_successMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    _successMessage!,
                    style: const TextStyle(color: Colors.green),
                  ),
                ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Toggle between access request and sign in view
                  TextButton(
                    onPressed: () => setState(
                        () => _showAccessRequest = !_showAccessRequest),
                    child: Text(_showAccessRequest
                        ? 'Back to Sign In'
                        : 'Request Access'),
                  ),
                  // Show loading indicator or submit button
                  ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : _showAccessRequest
                            ? _submitAccessRequest
                            : _handleLogin,
                    child: _isLoading
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(
                            _showAccessRequest ? 'Submit Request' : 'Sign In'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
