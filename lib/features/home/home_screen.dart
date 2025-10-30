import 'package:flutter/material.dart';
import 'package:matt_smith_portfolio/shared/widgets/app_scaffold.dart';
import 'package:matt_smith_portfolio/shared/theme.dart';

// Import all the impressive new sections
import 'widgets/hero_section.dart';
import 'widgets/skills_section.dart';
import 'widgets/about_section.dart';
import 'widgets/featured_projects_section.dart';
import 'widgets/contact_section.dart';

/// Modern, impressive home screen showcasing skills, projects, and personality
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Hero section with gradient background and CTA buttons
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingM),
              child: const HeroSection(),
            ),

            SizedBox(height: AppTheme.spacingXXL),

            // About Me section with stats
            const AboutSection(),

            SizedBox(height: AppTheme.spacingXXL),

            // Technical skills showcase with animated progress bars
            const SkillsSection(),

            SizedBox(height: AppTheme.spacingXXL),

            // Featured projects gallery
            const FeaturedProjectsSection(),

            SizedBox(height: AppTheme.spacingXXL),

            // Contact CTA and social links
            const ContactSection(),

            SizedBox(height: AppTheme.spacingL),
          ],
        ),
      ),
    );
  }
}