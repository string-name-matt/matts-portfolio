import 'package:flutter/material.dart';
import 'package:matt_smith_portfolio/shared/constants.dart';
import 'package:matt_smith_portfolio/shared/theme.dart';
import 'package:matt_smith_portfolio/shared/widgets/app_scaffold.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  // Category filters removed - can be added back when there are more projects
  // Future consideration: Filter for pro-bono work (school/church projects)

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return AppScaffold(
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.all(isMobile ? AppTheme.spacingM : AppTheme.spacingXL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Center(
                child: Column(
                  children: [
                    Text(
                      'My Projects',
                      style: AppTheme.displayMedium.copyWith(
                        color: AppTheme.lightText,
                        fontSize: isMobile ? 36 : 48,
                      ),
                    ),
                    SizedBox(height: AppTheme.spacingS),
                    Text(
                      'Real-world applications built with modern technologies',
                      style: AppTheme.bodyLarge.copyWith(
                        color: AppTheme.mutedText,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              SizedBox(height: AppTheme.spacingXL),

              // Projects Grid
              LayoutBuilder(
                builder: (context, constraints) {
                  final isDesktop = constraints.maxWidth > 1200;
                  final isTablet = constraints.maxWidth > 768 && constraints.maxWidth <= 1200;
                  final crossAxisCount = isDesktop ? 3 : (isTablet ? 2 : 1);

                  // Adjust aspect ratio based on screen size
                  double aspectRatio;
                  if (isMobile) {
                    aspectRatio = 0.75; // Taller cards on mobile for better content fit
                  } else if (isTablet) {
                    aspectRatio = 0.8;
                  } else {
                    aspectRatio = 0.85;
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
                    itemCount: AppConstants.projects.length,
                    itemBuilder: (context, index) {
                      return _ProjectCard(
                        project: AppConstants.projects[index],
                        isMobile: isMobile,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final ProjectItem project;
  final bool isMobile;

  const _ProjectCard({
    required this.project,
    required this.isMobile,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final imageHeight = widget.isMobile ? 140.0 : 160.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..translate(0.0, _isHovered ? -8.0 : 0.0),
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
            boxShadow: _isHovered ? AppTheme.glowShadow : AppTheme.cardShadow,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Project Image Placeholder
              Container(
                height: imageHeight,
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
                        size: widget.isMobile ? 32 : 40,
                        color: AppTheme.mutedText,
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          widget.project.imageUrl,
                          style: AppTheme.caption.copyWith(
                            color: AppTheme.mutedText,
                            fontSize: 10,
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
              // TODO: Replace with actual image
              // ClipRRect(
              //   borderRadius: const BorderRadius.only(
              //     topLeft: Radius.circular(AppTheme.radiusL),
              //     topRight: Radius.circular(AppTheme.radiusL),
              //   ),
              //   child: Image.asset(
              //     widget.project.imageUrl,
              //     height: imageHeight,
              //     width: double.infinity,
              //     fit: BoxFit.cover,
              //   ),
              // ),

              // Content
              Flexible(
                child: Padding(
                  padding: EdgeInsets.all(
                    widget.isMobile ? AppTheme.spacingS : AppTheme.spacingM,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Status & Category
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.success.withOpacity(0.2),
                              borderRadius:
                                  BorderRadius.circular(AppTheme.radiusS),
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
                                fontSize: 10,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryBlue.withOpacity(0.2),
                              borderRadius:
                                  BorderRadius.circular(AppTheme.radiusS),
                            ),
                            child: Text(
                              widget.project.category,
                              style: AppTheme.caption.copyWith(
                                color: AppTheme.primaryBlue,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: widget.isMobile ? 8 : AppTheme.spacingS),

                      // Title
                      Text(
                        widget.project.title,
                        style: AppTheme.headingMedium.copyWith(
                          color: AppTheme.lightText,
                          fontSize: widget.isMobile ? 18 : 20,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      SizedBox(height: widget.isMobile ? 6 : AppTheme.spacingS),

                      // Description - Always truncated to fit layout
                      Text(
                        widget.project.shortDescription,
                        style: AppTheme.bodyMedium.copyWith(
                          color: AppTheme.mutedText,
                          fontSize: widget.isMobile ? 12 : 13,
                          height: 1.4,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),

                      SizedBox(height: widget.isMobile ? 8 : AppTheme.spacingS),

                      // Technologies - Show first 4 only
                      Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: widget.project.technologies.take(4).map((tech) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryBlue.withOpacity(0.1),
                              borderRadius:
                                  BorderRadius.circular(AppTheme.radiusS),
                            ),
                            child: Text(
                              tech,
                              style: AppTheme.caption.copyWith(
                                color: AppTheme.primaryBlue,
                                fontSize: 9,
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      SizedBox(height: widget.isMobile ? 8 : AppTheme.spacingS),

                      // Action Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            _showProjectDetailsDialog(context);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: widget.isMobile ? 8 : 10,
                            ),
                          ),
                          child: Text(
                            'View Details',
                            style: TextStyle(fontSize: widget.isMobile ? 11 : 12),
                          ),
                        ),
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

  void _showProjectDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => _ProjectDetailsDialog(project: widget.project),
    );
  }
}

class _ProjectDetailsDialog extends StatelessWidget {
  final ProjectItem project;

  const _ProjectDetailsDialog({required this.project});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Dialog(
      backgroundColor: AppTheme.cardBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusL),
      ),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: isMobile ? double.infinity : 700,
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacingL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        project.title,
                        style: AppTheme.headingLarge.copyWith(
                          color: AppTheme.lightText,
                          fontSize: isMobile ? 24 : 32,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                      color: AppTheme.mutedText,
                    ),
                  ],
                ),

                SizedBox(height: AppTheme.spacingM),

                // Status & Category
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.success.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(AppTheme.radiusS),
                        border: Border.all(color: AppTheme.success),
                      ),
                      child: Text(
                        project.status,
                        style: AppTheme.caption.copyWith(
                          color: AppTheme.success,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryBlue.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(AppTheme.radiusS),
                      ),
                      child: Text(
                        project.category,
                        style: AppTheme.caption.copyWith(
                          color: AppTheme.primaryBlue,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: AppTheme.spacingL),

                // Description
                Text(
                  'About',
                  style: AppTheme.headingMedium.copyWith(
                    color: AppTheme.lightText,
                  ),
                ),
                SizedBox(height: AppTheme.spacingS),
                Text(
                  project.fullDescription,
                  style: AppTheme.bodyMedium.copyWith(
                    color: AppTheme.mutedText,
                  ),
                ),

                SizedBox(height: AppTheme.spacingL),

                // Technologies
                Text(
                  'Technologies',
                  style: AppTheme.headingMedium.copyWith(
                    color: AppTheme.lightText,
                  ),
                ),
                SizedBox(height: AppTheme.spacingS),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: project.technologies.map((tech) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppTheme.radiusS),
                        border: Border.all(
                          color: AppTheme.primaryBlue.withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        tech,
                        style: AppTheme.bodyMedium.copyWith(
                          color: AppTheme.primaryBlue,
                        ),
                      ),
                    );
                  }).toList(),
                ),

                SizedBox(height: AppTheme.spacingL),

                // Features
                Text(
                  'Key Features',
                  style: AppTheme.headingMedium.copyWith(
                    color: AppTheme.lightText,
                  ),
                ),
                SizedBox(height: AppTheme.spacingS),
                ...project.features.map((feature) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: AppTheme.success,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            feature,
                            style: AppTheme.bodyMedium.copyWith(
                              color: AppTheme.mutedText,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),

                SizedBox(height: AppTheme.spacingL),

                // Action Buttons
                Row(
                  children: [
                    if (project.demoUrl.isNotEmpty)
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
                          icon: const Icon(Icons.play_arrow),
                          label: const Text('View Demo'),
                        ),
                      ),
                    if (project.demoUrl.isNotEmpty &&
                        project.githubUrl.isNotEmpty)
                      const SizedBox(width: 12),
                    if (project.githubUrl.isNotEmpty)
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // TODO: Open GitHub URL
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('GitHub link coming soon!'),
                              ),
                            );
                          },
                          icon: const Icon(Icons.code),
                          label: const Text('View Code'),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
