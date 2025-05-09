// Resume screen with access control — only visible to authorized, signed-in users

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matt_smith_portfolio/features/resume/widgets/request_access_form.dart';
import 'package:matt_smith_portfolio/shared/widgets/app_scaffold.dart';

// 🧠 ConsumerWidget: A Riverpod widget that lets us read providers like auth state
class ResumeScreen extends ConsumerWidget {
  const ResumeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;

    // If not signed in, prompt the user to log in
    if (user == null) {
      return const AppScaffold(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Center(child: RequestAccessForm()),
        ),
      );

    }

    final userEmail = user.email ?? 'unknown';

    // 🧠 FutureBuilder: Lets us build different UI based on the result of a Future (like a Firestore read)
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('authorized_viewers')
          .doc(userEmail)
          .get(), // checks if this email has a matching doc
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // 🧠 Show loading spinner while we wait for Firestore response
          return const AppScaffold(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        // 🧠 If no doc exists, user is not authorized to view the resume
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const AppScaffold(
            child: Center(
              child: Text(
                '🚫 You do not have access to view this resume.\n\nPlease request access from Matt.',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        // ✅ User is authorized — show resume content here
        return const AppScaffold(
          child: Center(
            child: Text('📄 Welcome! You are authorized to view the resume.'),
          ),
        );
      },
    );
  }
}

// Tips:
// - FirebaseAuth.instance.currentUser: Returns the signed-in user (or null).
// - FutureBuilder: Used to show loading/data/error states while waiting for async data.
// - Firestore .get(): Grabs a snapshot of a document — used here to verify access.
// - You can add a document in the Firestore `authorized_viewers` collection to grant access.
