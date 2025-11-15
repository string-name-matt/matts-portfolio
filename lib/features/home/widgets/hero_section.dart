import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matt_smith_portfolio/shared/constants.dart';
import 'package:matt_smith_portfolio/shared/theme.dart';
import 'package:matt_smith_portfolio/shared/widgets/particle_background.dart';
import 'package:matt_smith_portfolio/shared/widgets/animated_button.dart';
import 'tech_logos_animation.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _floatController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _floatAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Entrance animation
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

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    // Floating animation for profile image
    _floatController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -10.0, end: 10.0).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;
    final isTablet = size.width >= 768 && size.width < 1200;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(AppTheme.radiusXL),
        boxShadow: AppTheme.glowShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppTheme.radiusXL),
        child: ParticleBackground(
          particleCount: isMobile ? 15 : 25,
          particleColor: Colors.white,
          maxParticleSize: 3.0,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: isMobile ? AppTheme.spacingXL : AppTheme.spacingXXL * 2,
              horizontal: AppTheme.spacingM,
            ),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1400),
                    child: isMobile || isTablet
                        ? _buildMobileLayout(isMobile)
                        : _buildDesktopLayout(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Mobile and tablet layout - single column with profile and info
  Widget _buildMobileLayout(bool isMobile) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildProfileSection(isMobile),
        SizedBox(height: AppTheme.spacingL),
        _buildInfoSection(isMobile),
        SizedBox(height: AppTheme.spacingXL),
        _buildButtons(isMobile),
      ],
    );
  }

  /// Desktop layout - two columns with profile/info on left and animated logos on right
  Widget _buildDesktopLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left column: Profile and info
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildProfileSection(false),
              SizedBox(height: AppTheme.spacingL),
              _buildInfoSection(false),
              SizedBox(height: AppTheme.spacingXL),
              _buildButtons(false),
            ],
          ),
        ),

        const SizedBox(width: AppTheme.spacingXL),

        // Right column: Animated tech logos
        Expanded(
          flex: 2,
          child: Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: const TechLogosAnimation(),
            ),
          ),
        ),
      ],
    );
  }

  /// Profile image with floating animation
  Widget _buildProfileSection(bool isMobile) {
    return AnimatedBuilder(
      animation: _floatAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatAnimation.value),
          child: child,
        );
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.3),
                blurRadius: 30,
                spreadRadius: 5,
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/images/matt.jpg',
              width: isMobile ? 120 : 200,
              height: isMobile ? 120 : 200,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  /// Info section with name, title, and description
  Widget _buildInfoSection(bool isMobile) {
    return Column(
      children: [
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
      ],
    );
  }

  /// CTA Buttons
  Widget _buildButtons(bool isMobile) {
    return Wrap(
      spacing: AppTheme.spacingS,
      runSpacing: AppTheme.spacingS,
      alignment: WrapAlignment.center,
      children: [
        // White button on gradient background
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => context.go('/projects'),
            child: AnimatedScale(
              scale: 1.0,
              duration: const Duration(milliseconds: 150),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 24 : 32,
                  vertical: isMobile ? 14 : 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.work_outline,
                      color: AppTheme.primaryBlue,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'View Projects',
                      style: AppTheme.bodyLarge.copyWith(
                        color: AppTheme.primaryBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        _HeroOutlinedButton(
          onPressed: () => context.go('/resume'),
          icon: Icons.description_outlined,
          label: 'View Resume',
          isMobile: isMobile,
        ),
        _HeroOutlinedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Email: ${AppConstants.email}'),
                backgroundColor: AppTheme.primaryBlue,
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 3),
              ),
            );
          },
          icon: Icons.email_outlined,
          label: 'Contact Me',
          isMobile: isMobile,
        ),
      ],
    );
  }
}

/// Custom outlined button for hero section with animations
class _HeroOutlinedButton extends StatefulWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;
  final bool isMobile;

  const _HeroOutlinedButton({
    required this.onPressed,
    required this.icon,
    required this.label,
    required this.isMobile,
  });

  @override
  State<_HeroOutlinedButton> createState() => _HeroOutlinedButtonState();
}

class _HeroOutlinedButtonState extends State<_HeroOutlinedButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedScale(
          scale: _isHovered ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 150),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(
              horizontal: widget.isMobile ? 24 : 32,
              vertical: widget.isMobile ? 14 : 16,
            ),
            decoration: BoxDecoration(
              color: _isHovered ? Colors.white.withOpacity(0.1) : Colors.transparent,
              borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 0,
                      ),
                    ]
                  : [],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  widget.icon,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  widget.label,
                  style: AppTheme.bodyLarge.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
