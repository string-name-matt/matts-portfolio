import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matt_smith_portfolio/shared/constants.dart';
import 'package:matt_smith_portfolio/shared/theme.dart';
import 'package:matt_smith_portfolio/shared/widgets/animated_button.dart';
import 'package:matt_smith_portfolio/shared/widgets/scroll_reveal_animation.dart';

class FeaturedProjectsSection extends StatelessWidget {
  const FeaturedProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;
    final featuredProjects =
        AppConstants.projects.where((p) => p.featured).toList();

    return Container(
      width: double.infinity,
      padding:
          EdgeInsets.all(isMobile ? AppTheme.spacingM : AppTheme.spacingXL),
      child: Column(
        children: [
          // Section Title
          Text(
            'Featured Projects',
            style: AppTheme.displayMedium.copyWith(
              color: AppTheme.lightText,
              fontSize: isMobile ? 32 : 40,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppTheme.spacingS),
          Text(
            'Real-world applications serving real users',
            style: AppTheme.bodyLarge.copyWith(
              color: AppTheme.mutedText,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: AppTheme.spacingXL),

          // Projects Grid with staggered animations
          LayoutBuilder(
            builder: (context, constraints) {
              // Better responsive breakpoints
              final isDesktop = constraints.maxWidth >= 1200;
              final isTablet =
                  constraints.maxWidth >= 768 && constraints.maxWidth < 1200;
              final crossAxisCount = isDesktop ? 2 : 1;

              // Calculate better aspect ratio based on screen size
              double aspectRatio;
              if (isMobile) {
                aspectRatio = 0.85; // Taller cards on mobile
              } else if (isTablet) {
                aspectRatio = 1.2; // Balanced on tablet
              } else {
                aspectRatio = 1.4; // Wider on desktop
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: AppTheme.spacingM,
                  mainAxisSpacing: AppTheme.spacingM,
                  childAspectRatio: aspectRatio,
                ),
                itemCount: featuredProjects.length,
                itemBuilder: (context, index) {
                  return ScrollRevealAnimation(
                    delay: index * 150,
                    child: _FeaturedProjectCard(
                      project: featuredProjects[index],
                    ),
                  );
                },
              );
            },
          ),

          SizedBox(height: AppTheme.spacingL),

          // View All Button with animation
          ScrollRevealAnimation(
            delay: 300,
            child: AnimatedButton(
              text: 'View All Projects',
              icon: Icons.arrow_forward,
              onPressed: () => context.go('/projects'),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeaturedProjectCard extends StatefulWidget {
  final ProjectItem project;

  const _FeaturedProjectCard({required this.project});

  @override
  State<_FeaturedProjectCard> createState() => _FeaturedProjectCardState();
}

class _FeaturedProjectCardState extends State<_FeaturedProjectCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _shimmerController;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _shimmerAnimation = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(
        parent: _shimmerController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  void _onHoverChanged(bool isHovered) {
    setState(() => _isHovered = isHovered);
    if (isHovered) {
      _shimmerController.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;
    final isTablet = size.width >= 768 && size.width < 1200;

    return MouseRegion(
        onEnter: (_) => _onHoverChanged(true),
        onExit: (_) => _onHoverChanged(false),
        child: AnimatedScale(
          scale: _isHovered ? 1.03 : 1.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            transform: Matrix4.identity()
              ..translate(0.0, _isHovered ? -4.0 : 0.0)
              ..rotateZ(_isHovered ? -0.005 : 0.0),
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.cardBg,
                borderRadius: BorderRadius.circular(AppTheme.radiusL),
                border: Border.all(
                  color: _isHovered
                      ? AppTheme.primaryBlue
                      : AppTheme.primaryBlue.withOpacity(0.2),
                  width: _isHovered ? 2 : 1,
                ),
                boxShadow: _isHovered
                    ? [
                        BoxShadow(
                          color: AppTheme.primaryBlue.withOpacity(0.3),
                          blurRadius: 30,
                          spreadRadius: 0,
                          offset: const Offset(0, 10),
                        ),
                      ]
                    : AppTheme.cardShadow,
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // Project Image Placeholder with shimmer
                      Stack(
                        children: [
                          Container(
                            height: isMobile ? 140 : (isTablet ? 180 : 200),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  AppTheme.primaryBlue.withOpacity(0.3),
                                  AppTheme.accentPurple.withOpacity(0.3),
                                ],
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(AppTheme.radiusL),
                                topRight: Radius.circular(AppTheme.radiusL),
                              ),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image_outlined,
                                    size: isMobile ? 40 : 48,
                                    color: AppTheme.mutedText,
                                  ),
                                  SizedBox(height: isMobile ? 4 : 8),
                                  Text(
                                    'Project Screenshot',
                                    style: AppTheme.caption.copyWith(
                                      color: AppTheme.mutedText,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Text(
                                      widget.project.imageUrl,
                                      style: AppTheme.caption.copyWith(
                                        color: AppTheme.mutedText,
                                        fontSize: 11,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Shimmer overlay on hover
                          if (_isHovered)
                            AnimatedBuilder(
                              animation: _shimmerAnimation,
                              builder: (context, child) {
                                return Positioned.fill(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft:
                                          Radius.circular(AppTheme.radiusL),
                                      topRight:
                                          Radius.circular(AppTheme.radiusL),
                                    ),
                                    child: Transform.translate(
                                      offset: Offset(
                                          _shimmerAnimation.value * 100, 0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              Colors.transparent,
                                              Colors.white.withOpacity(0.2),
                                              Colors.transparent,
                                            ],
                                            stops: const [0.0, 0.5, 1.0],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                        ],
                      ),
                      // TODO: Replace with actual image when available
                      // Uncomment when you add images to assets
                      // ClipRRect(
                      //   borderRadius: const BorderRadius.only(
                      //     topLeft: Radius.circular(AppTheme.radiusL),
                      //     topRight: Radius.circular(AppTheme.radiusL),
                      //   ),
                      //   child: Image.asset(
                      //     widget.project.imageUrl,
                      //     height: isMobile ? 140 : (isTablet ? 180 : 200),
                      //     width: double.infinity,
                      //     fit: BoxFit.cover,
                      //   ),
                      // ),

                      // Content
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.all(
                            isMobile
                                ? AppTheme.spacingS
                                : (isTablet
                                    ? AppTheme.spacingS + 4
                                    : AppTheme.spacingM),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Top content
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Status Badge
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppTheme.success.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(
                                          AppTheme.radiusS),
                                      border: Border.all(
                                        color: AppTheme.success,
                                        width: 1,
                                      ),
                                    ),
                                    child: Text(
                                      widget.project.status,
                                      style: AppTheme.caption.copyWith(
                                        color: AppTheme.success,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                      height: isMobile ? 8 : AppTheme.spacingS),

                                  // Title
                                  Text(
                                    widget.project.title,
                                    style: AppTheme.headingMedium.copyWith(
                                      color: AppTheme.lightText,
                                      fontSize:
                                          isMobile ? 18 : (isTablet ? 20 : 22),
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                  SizedBox(
                                      height: isMobile ? 6 : AppTheme.spacingS),

                                  // Description
                                  Text(
                                    widget.project.shortDescription,
                                    style: AppTheme.bodyMedium.copyWith(
                                      color: AppTheme.mutedText,
                                      fontSize: isMobile ? 13 : 14,
                                      height: 1.4,
                                    ),
                                    maxLines: isMobile ? 2 : 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                  SizedBox(
                                      height: isMobile ? 8 : AppTheme.spacingS),

                                  // Technologies
                                  Wrap(
                                    spacing: 6,
                                    runSpacing: 6,
                                    children: widget.project.technologies
                                        .take(4)
                                        .map((tech) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: isMobile ? 8 : 10,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppTheme.primaryBlue
                                              .withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(
                                              AppTheme.radiusS),
                                          border: Border.all(
                                            color: AppTheme.primaryBlue
                                                .withOpacity(0.3),
                                            width: 1,
                                          ),
                                        ),
                                        child: Text(
                                          tech,
                                          style: AppTheme.caption.copyWith(
                                            color: AppTheme.primaryBlue,
                                            fontSize: isMobile ? 10 : 11,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),

                              // Bottom buttons
                              Column(
                                children: [
                                  SizedBox(
                                      height: isMobile ? 8 : AppTheme.spacingS),
                                  // Action Buttons
                                  Row(
                                    children: [
                                      if (widget.project.demoUrl.isNotEmpty)
                                        Expanded(
                                          child: ElevatedButton.icon(
                                            onPressed: () {
                                              // TODO: Open demo URL
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content:
                                                      Text('Demo coming soon!'),
                                                  duration:
                                                      Duration(seconds: 2),
                                                ),
                                              );
                                            },
                                            icon: Icon(Icons.play_arrow,
                                                size: isMobile ? 14 : 16),
                                            label: Text(
                                              'Demo',
                                              style: TextStyle(
                                                  fontSize: isMobile ? 12 : 14),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: isMobile ? 8 : 12,
                                                vertical: isMobile ? 8 : 10,
                                              ),
                                            ),
                                          ),
                                        ),
                                      if (widget.project.demoUrl.isNotEmpty)
                                        const SizedBox(width: 8),
                                      Expanded(
                                        child: OutlinedButton.icon(
                                          onPressed: () =>
                                              context.go('/projects'),
                                          icon: Icon(Icons.info_outline,
                                              size: isMobile ? 14 : 16),
                                          label: Text(
                                            'Details',
                                            style: TextStyle(
                                                fontSize: isMobile ? 12 : 14),
                                          ),
                                          style: OutlinedButton.styleFrom(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: isMobile ? 8 : 12,
                                              vertical: isMobile ? 8 : 10,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
