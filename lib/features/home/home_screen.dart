// Basic Flutter imports
import 'package:flutter/material.dart';
// Used for navigating between pages (e.g., pushing a new screen)
import 'package:go_router/go_router.dart';

// Shared scaffold wrapper that includes global app bar and login/logout logic
import 'package:matt_smith_portfolio/shared/widgets/app_scaffold.dart';

// Reusable custom widgets
import 'widgets/home_intro.dart';
import 'widgets/project_card.dart';

// This is the home screen that appears when you first open the app
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold( // Wraps the page with a common AppBar and layout
      child: Padding(
        padding: const EdgeInsets.all(24), // Adds spacing around the entire page
        child: SingleChildScrollView( // Allows scrolling if content overflows vertically
          child: Column(
            children: [
              const HomeIntro(), // Widget that shows your name, title, and CTA buttons
              const SizedBox(height: 32), // Adds vertical spacing

              // Wrap allows items to flow into multiple rows automatically (great for responsive cards)
              Wrap(
                spacing: 20,     // Horizontal space between cards
                runSpacing: 20,  // Vertical space between wrapped rows
                children: [
                  // A card representing your first major project
                  ProjectCard(
                    title: 'Courthouse Connect',
                    description: 'Employee app used by 300+ staff. Includes article search, maintenance board, and more.',
                    onTap: () => context.go('/projects'), // Navigates to the Projects screen
                  ),

                  // A card representing your second major project
                  ProjectCard(
                    title: 'HealthPass',
                    description: 'Secure health program dashboard with SFTP sync, CSV automation, and AI workflows.',
                    onTap: () => context.go('/projects'), // Same navigation for now — can be made dynamic later
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

//  Tips:
//  Wrap vs Row: Wrap is great when you want content to automatically wrap to the next line instead of overflowing horizontally.
//  AppScaffold: This is a custom scaffold we built to keep the AppBar (login/logout) consistent across screens.
//  context.go(): Comes from go_router, and it’s how you navigate to another page.