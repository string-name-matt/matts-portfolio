import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'auth/sign_in_screen.dart';
import 'features/home/home_screen.dart';
import 'features/projects/project_screen.dart';
import 'features/resume/resume_screen.dart';
import 'shared/theme.dart';

/// Custom page transition builder with slide and fade effect
CustomTransitionPage<void> _buildPageWithTransition(
  BuildContext context,
  GoRouterState state,
  Widget child,
) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Slide from right with fade
      const begin = Offset(0.1, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeOutCubic;

      final tween = Tween(begin: begin, end: end).chain(
        CurveTween(curve: curve),
      );

      final offsetAnimation = animation.drive(tween);
      final fadeAnimation = animation.drive(
        Tween<double>(begin: 0.0, end: 1.0).chain(
          CurveTween(curve: curve),
        ),
      );

      return SlideTransition(
        position: offsetAnimation,
        child: FadeTransition(
          opacity: fadeAnimation,
          child: child,
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 400),
  );
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => _buildPageWithTransition(
        context,
        state,
        const HomeScreen(),
      ),
    ),
    GoRoute(
      path: '/projects',
      pageBuilder: (context, state) => _buildPageWithTransition(
        context,
        state,
        const ProjectScreen(),
      ),
    ),
    GoRoute(
      path: '/resume',
      pageBuilder: (context, state) => _buildPageWithTransition(
        context,
        state,
        const ResumeScreen(),
      ),
    ),
    GoRoute(
      path: '/signin',
      pageBuilder: (context, state) => _buildPageWithTransition(
        context,
        state,
        const SignInScreen(),
      ),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Matt Smith - Portfolio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark, // Use dark theme by default for premium look
      routerConfig: _router,
    );
  }
}
