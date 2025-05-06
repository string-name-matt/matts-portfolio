import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'features/home/home_screen.dart';
import 'features/projects/project_screen.dart';
import 'features/resume/resume_screen.dart';

final _router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (_, __) => const HomeScreen()),
    GoRoute(path: '/projects', builder: (_, __) => const ProjectScreen()),
    GoRoute(path: '/resume', builder: (_, __) => const ResumeScreen()),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Matt Smith Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Sans',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      ),
      routerConfig: _router,
    );
  }
}
