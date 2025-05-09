import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';
import 'firebase_options.dart';

void main() async {
  // Ensures Flutter has bound to the platform before calling any async code
  WidgetsFlutterBinding.ensureInitialized();

  // Initializes Firebase so it’s ready to be used in your app
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Runs the app with Riverpod as the state management scope
  runApp(const ProviderScope(child: MyApp()));
}


