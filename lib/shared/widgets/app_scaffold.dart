// This widget wraps any page with a common AppBar and structure
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import '../../providers/auth_provider.dart';

class AppScaffold extends ConsumerWidget {
  final Widget child;

  const AppScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateChangesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Matt Builds'),
        actions: [
          authState.when(
            data: (user) {
              if (user != null) {
                return IconButton(
                  icon: const Icon(Icons.logout),
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
                  icon: const Icon(Icons.login),
                  tooltip: 'Sign In',
                  onPressed: () => context.go('/signin'),
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
