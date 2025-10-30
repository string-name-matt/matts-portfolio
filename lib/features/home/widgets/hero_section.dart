import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matt_smith_portfolio/shared/constants.dart';
import 'package:matt_smith_portfolio/shared/theme.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? AppTheme.spacingXL : AppTheme.spacingXXL * 2,
        horizontal: AppTheme.spacingM,
      ),
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(AppTheme.radiusXL),
        boxShadow: AppTheme.glowShadow,
      ),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Profile Image Placeholder

              ClipOval(
                child: Image.asset(
                  'assets/images/matt.jpg',
                  width: isMobile ? 120 : 200,
                  height: isMobile ? 120 : 200,
                  fit: BoxFit.cover,
                ),
              ),

              SizedBox(height: AppTheme.spacingL),

              // Name
              Text(
                AppConstants.heroTitle,
                style: AppTheme.displayLarge.copyWith(
                  color: Colors.white,
                  fontSize: isMobile ? 36 : 56,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: AppTheme.spacingS),

              // Title
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingM,
                  vertical: AppTheme.spacingS,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusM),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  AppConstants.heroSubtitle,
                  style: AppTheme.headingMedium.copyWith(
                    color: Colors.white,
                    fontSize: isMobile ? 16 : 24,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(height: AppTheme.spacingL),

              // Description
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Text(
                  AppConstants.heroDescription,
                  style: AppTheme.bodyLarge.copyWith(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: isMobile ? 16 : 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(height: AppTheme.spacingXL),

              // CTA Buttons
              Wrap(
                spacing: AppTheme.spacingS,
                runSpacing: AppTheme.spacingS,
                alignment: WrapAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => context.go('/projects'),
                    icon: const Icon(Icons.work_outline),
                    label: const Text('View Projects'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppTheme.primaryBlue,
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 24 : 32,
                        vertical: isMobile ? 14 : 16,
                      ),
                      elevation: 8,
                      shadowColor: Colors.black.withOpacity(0.3),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => context.go('/resume'),
                    icon: const Icon(Icons.description_outlined),
                    label: const Text('View Resume'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white, width: 2),
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 24 : 32,
                        vertical: isMobile ? 14 : 16,
                      ),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      // TODO: Scroll to contact section or open email
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Email: ${AppConstants.email}'),
                          backgroundColor: AppTheme.primaryBlue,
                        ),
                      );
                    },
                    icon: const Icon(Icons.email_outlined),
                    label: const Text('Contact Me'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white, width: 2),
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 24 : 32,
                        vertical: isMobile ? 14 : 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
