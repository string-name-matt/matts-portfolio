// A form that allows someone to request resume access — stored in Firestore for review

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// 🧠 GlobalKey lets us validate and reset the form later
final _formKey = GlobalKey<FormState>();

class RequestAccessForm extends StatefulWidget {
  const RequestAccessForm({super.key});

  @override
  State<RequestAccessForm> createState() => _RequestAccessFormState();
}

class _RequestAccessFormState extends State<RequestAccessForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController sourceController = TextEditingController();

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    final requestData = {
      'email': emailController.text.trim(),
      'company': companyController.text.trim(),
      'source': sourceController.text.trim(),
      'timestamp': FieldValue.serverTimestamp(),
    };

    try {
      await FirebaseFirestore.instance
          .collection('resume_access_requests')
          .add(requestData);
      // 🧠 mounted: Ensures the widget is still in the widget tree before using context (important after async calls)
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Access request submitted!')),
        );
      }


      emailController.clear();
      companyController.clear();
      sourceController.clear();
    } catch (e) {
      // 🧠 mounted: Ensures the widget is still in the widget tree before using context (important after async calls)
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error submitting access request: $e')),
        );
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey, // 🧠 Allows form-wide validation
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '🔐 Request Resume Access',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Your Email'),
            keyboardType: TextInputType.emailAddress,
            validator: (value) =>
            value == null || !value.contains('@') ? 'Enter a valid email' : null,
          ),

          TextFormField(
            controller: companyController,
            decoration: const InputDecoration(labelText: 'Company (optional)'),
          ),

          TextFormField(
            controller: sourceController,
            decoration: const InputDecoration(labelText: 'How did you find me?'),
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: _submitForm,
            child: const Text('Request Access'),
          ),
        ],
      ),
    );
  }
}
