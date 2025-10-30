import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'auth/sign_in_screen.dart';
import 'features/home/home_screen.dart';
import 'features/projects/project_screen.dart';
import 'features/resume/resume_screen.dart';
import 'shared/theme.dart';

final _router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (_, __) => const HomeScreen()),
    GoRoute(path: '/projects', builder: (_, __) => const ProjectScreen()),
    GoRoute(path: '/resume', builder: (_, __) => const ResumeScreen()),
    GoRoute(path: '/signin', builder: (_, __) => const SignInScreen()),
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
