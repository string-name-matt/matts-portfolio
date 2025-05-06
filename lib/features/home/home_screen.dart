import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'widgets/home_intro.dart';
import 'widgets/project_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const HomeIntro(),
              const SizedBox(height: 32),
              Wrap(
                spacing: 20,
                runSpacing: 20,
                children: [
                  ProjectCard(
                    title: 'Courthouse Connect',
                    description: 'Employee app used by 300+ staff. Includes article search, maintenance board, and more.',
                    onTap: () => context.go('/projects'),
                  ),
                  ProjectCard(
                    title: 'HealthPass',
                    description: 'Secure health program dashboard with SFTP sync, CSV automation, and AI workflows.',
                    onTap: () => context.go('/projects'),
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
