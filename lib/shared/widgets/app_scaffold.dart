import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../auth/widgets/login_dialog.dart';
import '../../providers/auth_provider.dart';
import '../theme.dart';
import '../constants.dart';

/// Global scaffold providing consistent AppBar and navigation across all pages
class AppScaffold extends ConsumerWidget {
  final Widget child;

  const AppScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateChangesProvider);
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.darkBg,
        toolbarHeight: isMobile ? 64 : 72,
        title: InkWell(
          onTap: () => context.go('/'),
          borderRadius: BorderRadius.circular(AppTheme.radiusS),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/mb_logo.png',
                    height: isMobile ? 32 : 40,
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback if logo not found
                      return Container(
                        width: isMobile ? 32 : 40,
                        height: isMobile ? 32 : 40,
                        decoration: BoxDecoration(
                          color: AppTheme.primaryBlue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            'MS',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: isMobile ? 14 : 16,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (!isMobile) ...[
                  const SizedBox(width: 12),
                  Text(
                    AppConstants.name,
                    style: AppTheme.headingMedium.copyWith(
                      color: AppTheme.lightText,
                      fontSize: 18,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        actions: [
          // Navigation Menu
          if (!isMobile) ...[
            TextButton(
              onPressed: () => context.go('/'),
              child: Text(
                'Home',
                style: TextStyle(
                  color: AppTheme.lightText,
                  fontSize: 16,
                ),
              ),
            ),
            TextButton(
              onPressed: () => context.go('/projects'),
              child: Text(
                'Projects',
                style: TextStyle(
                  color: AppTheme.lightText,
                  fontSize: 16,
                ),
              ),
            ),
            TextButton(
              onPressed: () => context.go('/resume'),
              child: Text(
                'Resume',
                style: TextStyle(
                  color: AppTheme.lightText,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],

          // Auth Button
          authState.when(
            data: (user) {
              if (user != null) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Signed out successfully'),
                            backgroundColor: AppTheme.darkBg,
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.logout, size: 18),
                    label: Text(isMobile ? '' : 'Logout'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.lightText,
                      side: BorderSide(
                        color: AppTheme.mutedText.withOpacity(0.3),
                      ),
                    ),
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => const LoginDialog(),
                      );
                    },
                    icon: const Icon(Icons.login, size: 18),
                    label: Text(isMobile ? '' : 'Sign In'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryBlue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                );
              }
            },
            loading: () => const Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
            error: (_, __) => const SizedBox(),
          ),
        ],
      ),
      body: child,
    );
  }
}
