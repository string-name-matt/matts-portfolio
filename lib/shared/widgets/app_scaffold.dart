// This widget wraps any page with a common AppBar and structure
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/widgets/login_dialog.dart';
import '../../providers/auth_provider.dart';

class AppScaffold extends ConsumerWidget {
  final Widget child;

  const AppScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateChangesProvider);

    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black,
        backgroundColor: const Color(0xFF345D7D),
        toolbarHeight: 80,
        elevation: 4,
        title: Center(child: Image.asset('images/mb_logo.png', height: 400)),
        actions: [
          authState.when(
            data: (user) {
              if (user != null) {
                return IconButton(
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  tooltip: 'Logout',
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Signed out')),
                    );
                  },
                );
              } else {
                return IconButton(
                  icon: const Icon(Icons.login, color: Colors.white),
                  tooltip: 'Sign In',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => const LoginDialog(),
                    );
                  },
                );
              }
            },
            loading: () => const SizedBox(),
            error: (_, __) => const SizedBox(),
          ),
        ],
      ),
      body: child,
    );
  }
}
