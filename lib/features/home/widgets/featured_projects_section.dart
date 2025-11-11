import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matt_smith_portfolio/shared/theme.dart';
import 'package:matt_smith_portfolio/shared/constants.dart';

class FeaturedProjectsSection extends StatelessWidget {
  const FeaturedProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;
    final featuredProjects = AppConstants.projects.where((p) => p.featured).toList();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? AppTheme.spacingM : AppTheme.spacingXL),
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

          // Projects Grid
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 900 ? 2 : 1;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: AppTheme.spacingM,
                  mainAxisSpacing: AppTheme.spacingM,
                  childAspectRatio: isMobile ? 0.7 : 1.35,
                ),
                itemCount: featuredProjects.length,
                itemBuilder: (context, index) {
                  return _FeaturedProjectCard(
                    project: featuredProjects[index],
                  );
                },
              );
            },
          ),

          SizedBox(height: AppTheme.spacingL),

          // View All Button
          ElevatedButton.icon(
            onPressed: () => context.go('/projects'),
            icon: const Icon(Icons.arrow_forward),
            label: const Text('View All Projects'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 16,
              ),
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

class _FeaturedProjectCardState extends State<_FeaturedProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()
          ..translate(0.0, _isHovered ? -8.0 : 0.0),
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
                ? AppTheme.glowShadow
                : AppTheme.cardShadow,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Project Image Placeholder
              Container(
                height: isMobile ? 120 : 200,
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
                        size: 48,
                        color: AppTheme.mutedText,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Project Screenshot',
                        style: AppTheme.caption.copyWith(
                          color: AppTheme.mutedText,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.project.imageUrl,
                        style: AppTheme.caption.copyWith(
                          color: AppTheme.mutedText,
                          fontSize: 11,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              // TODO: Replace with actual image
              // Uncomment when you add images to assets
              // ClipRRect(
              //   borderRadius: const BorderRadius.only(
              //     topLeft: Radius.circular(AppTheme.radiusL),
              //     topRight: Radius.circular(AppTheme.radiusL),
              //   ),
              //   child: Image.asset(
              //     widget.project.imageUrl,
              //     height: isMobile ? 150 : 200,
              //     width: double.infinity,
              //     fit: BoxFit.cover,
              //   ),
              // ),

              // Content
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(isMobile ? AppTheme.spacingS : AppTheme.spacingM),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Status Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.success.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(AppTheme.radiusS),
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

                      const SizedBox(height: AppTheme.spacingS),

                      // Title
                      Text(
                        widget.project.title,
                        style: AppTheme.headingMedium.copyWith(
                          color: AppTheme.lightText,
                          fontSize: 22,
                        ),
                      ),

                      const SizedBox(height: AppTheme.spacingS),

                      // Description
                      Text(
                        widget.project.shortDescription,
                        style: AppTheme.bodyMedium.copyWith(
                          color: AppTheme.mutedText,
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      SizedBox(height: isMobile ? AppTheme.spacingS : AppTheme.spacingM),

                      // Technologies
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: widget.project.technologies.take(4).map((tech) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryBlue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(AppTheme.radiusS),
                            ),
                            child: Text(
                              tech,
                              style: AppTheme.caption.copyWith(
                                color: AppTheme.primaryBlue,
                                fontSize: 11,
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      SizedBox(height: isMobile ? AppTheme.spacingS : AppTheme.spacingM),

                      // Action Buttons
                      Row(
                        children: [
                          if (widget.project.demoUrl.isNotEmpty)
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  // TODO: Open demo URL
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Demo coming soon!'),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.play_arrow, size: isMobile ? 14 : 16),
                                label: const Text('Demo'),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isMobile ? 12 : 16,
                                    vertical: isMobile ? 10 : 12,
                                  ),
                                  textStyle: TextStyle(fontSize: isMobile ? 12 : 14),
                                ),
                              ),
                            ),
                          if (widget.project.demoUrl.isNotEmpty &&
                              widget.project.githubUrl.isNotEmpty)
                            const SizedBox(width: 8),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => context.go('/projects'),
                              icon: Icon(Icons.info_outline, size: isMobile ? 14 : 16),
                              label: const Text('Details'),
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  horizontal: isMobile ? 12 : 16,
                                  vertical: isMobile ? 10 : 12,
                                ),
                                textStyle: TextStyle(fontSize: isMobile ? 12 : 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
