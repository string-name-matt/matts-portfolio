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
  String _selectedCategory = 'All';

  List<ProjectItem> get _filteredProjects {
    if (_selectedCategory == 'All') {
      return AppConstants.projects;
    }
    return AppConstants.projects
        .where((p) => p.category == _selectedCategory)
        .toList();
  }

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

              // Category Filters
              Center(
                child: Wrap(
                  spacing: AppTheme.spacingS,
                  runSpacing: AppTheme.spacingS,
                  alignment: WrapAlignment.center,
                  children: AppConstants.projectCategories.map((category) {
                    final isSelected = _selectedCategory == category;
                    return FilterChip(
                      label: Text(category),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                      backgroundColor: AppTheme.cardBg,
                      selectedColor: AppTheme.primaryBlue,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : AppTheme.mutedText,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                      ),
                      side: BorderSide(
                        color: isSelected
                            ? AppTheme.primaryBlue
                            : AppTheme.primaryBlue.withOpacity(0.3),
                        width: isSelected ? 2 : 1,
                      ),
                    );
                  }).toList(),
                ),
              ),

              SizedBox(height: AppTheme.spacingXL),

              // Projects Grid
              LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = constraints.maxWidth > 1200
                      ? 3
                      : constraints.maxWidth > 768
                          ? 2
                          : 1;

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: AppTheme.spacingM,
                      mainAxisSpacing: AppTheme.spacingM,
                      childAspectRatio: 0.9,
                    ),
                    itemCount: _filteredProjects.length,
                    itemBuilder: (context, index) {
                      return _ProjectCard(
                        project: _filteredProjects[index],
                      );
                    },
                  );
                },
              ),

              if (_filteredProjects.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(AppTheme.spacingXL),
                    child: Column(
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: AppTheme.mutedText,
                        ),
                        SizedBox(height: AppTheme.spacingM),
                        Text(
                          'No projects found in this category',
                          style: AppTheme.bodyLarge.copyWith(
                            color: AppTheme.mutedText,
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
}

class _ProjectCard extends StatefulWidget {
  final ProjectItem project;

  const _ProjectCard({required this.project});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isExpanded = false;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
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
            children: [
              // Project Image Placeholder
              Container(
                height: 180,
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
                        size: 40,
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
              //     height: 180,
              //     width: double.infinity,
              //     fit: BoxFit.cover,
              //   ),
              // ),

              // Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(AppTheme.spacingM),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Status & Category
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
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
                              horizontal: 10,
                              vertical: 4,
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

                      SizedBox(height: AppTheme.spacingS),

                      // Title
                      Text(
                        widget.project.title,
                        style: AppTheme.headingMedium.copyWith(
                          color: AppTheme.lightText,
                          fontSize: 20,
                        ),
                      ),

                      SizedBox(height: AppTheme.spacingS),

                      // Description
                      Text(
                        _isExpanded
                            ? widget.project.fullDescription
                            : widget.project.shortDescription,
                        style: AppTheme.bodyMedium.copyWith(
                          color: AppTheme.mutedText,
                          fontSize: 13,
                        ),
                        maxLines: _isExpanded ? null : 2,
                        overflow: _isExpanded ? null : TextOverflow.ellipsis,
                      ),

                      if (widget.project.fullDescription.length > 100)
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _isExpanded = !_isExpanded;
                            });
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(0, 30),
                          ),
                          child: Text(
                            _isExpanded ? 'Read less' : 'Read more',
                            style: AppTheme.caption.copyWith(
                              color: AppTheme.primaryBlue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                      const Spacer(),

                      // Technologies
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: widget.project.technologies.map((tech) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
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
                                fontSize: 10,
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      SizedBox(height: AppTheme.spacingM),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                _showProjectDetailsDialog(context);
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                              ),
                              child: const Text(
                                'View Details',
                                style: TextStyle(fontSize: 12),
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
