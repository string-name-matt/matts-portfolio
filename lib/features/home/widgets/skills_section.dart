import 'package:flutter/material.dart';
import 'package:matt_smith_portfolio/shared/theme.dart';
import 'package:matt_smith_portfolio/shared/constants.dart';
import 'package:matt_smith_portfolio/shared/widgets/scroll_reveal_animation.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  bool _isVisible = false;
  final GlobalKey _sectionKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // Start checking visibility after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkVisibility();
    });
  }

  void _checkVisibility() {
    if (_isVisible || !mounted) return;

    final RenderObject? renderObject = _sectionKey.currentContext?.findRenderObject();
    if (renderObject == null) {
      Future.delayed(const Duration(milliseconds: 100), _checkVisibility);
      return;
    }

    final RenderBox renderBox = renderObject as RenderBox;
    if (!renderBox.hasSize) {
      Future.delayed(const Duration(milliseconds: 100), _checkVisibility);
      return;
    }

    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    final screenHeight = MediaQuery.of(context).size.height;

    // Check if section is at least partially visible
    if (position.dy < screenHeight && position.dy + size.height > 0) {
      if (mounted) {
        setState(() => _isVisible = true);
      }
    } else {
      // Keep checking if not visible yet
      Future.delayed(const Duration(milliseconds: 200), _checkVisibility);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Container(
      key: _sectionKey,
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? AppTheme.spacingM : AppTheme.spacingXL),
      child: Column(
        children: [
          // Section Title
          Text(
            'Technical Skills',
            style: AppTheme.displayMedium.copyWith(
              color: AppTheme.lightText,
              fontSize: isMobile ? 32 : 40,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppTheme.spacingS),
          Text(
            'Technologies I work with daily',
            style: AppTheme.bodyLarge.copyWith(
              color: AppTheme.mutedText,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: AppTheme.spacingXL),

          // Skills Grid
          LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth > 1200;
              final isTablet = constraints.maxWidth > 768 && constraints.maxWidth <= 1200;
              final crossAxisCount = isDesktop ? 4 : (isTablet ? 2 : 1);

              // Adjust aspect ratio for mobile to give more vertical space
              final aspectRatio = isMobile ? 1.0 : (isTablet ? 1.1 : 1.2);

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: AppTheme.spacingM,
                  mainAxisSpacing: AppTheme.spacingM,
                  childAspectRatio: aspectRatio,
                ),
                itemCount: AppConstants.skills.length,
                itemBuilder: (context, index) {
                  final category = AppConstants.skills.keys.elementAt(index);
                  final skillItems = AppConstants.skills[category]!;
                  return ScrollRevealAnimation(
                    delay: index * 100,
                    child: _SkillCategoryCard(
                      category: category,
                      skills: skillItems,
                      isMobile: isMobile,
                      isVisible: _isVisible,
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SkillCategoryCard extends StatefulWidget {
  final String category;
  final List<SkillItem> skills;
  final bool isMobile;
  final bool isVisible;

  const _SkillCategoryCard({
    required this.category,
    required this.skills,
    required this.isMobile,
    required this.isVisible,
  });

  @override
  State<_SkillCategoryCard> createState() => _SkillCategoryCardState();
}

class _SkillCategoryCardState extends State<_SkillCategoryCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.02 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.all(
            widget.isMobile ? AppTheme.spacingS : AppTheme.spacingM,
          ),
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
                      color: AppTheme.primaryBlue.withOpacity(0.2),
                      blurRadius: 20,
                      spreadRadius: 0,
                    ),
                  ]
                : AppTheme.cardShadow,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Category Title
              Text(
                widget.category,
                style: AppTheme.headingMedium.copyWith(
                  color: AppTheme.primaryBlue,
                  fontSize: widget.isMobile ? 16 : 20,
                ),
              ),
              SizedBox(height: widget.isMobile ? AppTheme.spacingS : AppTheme.spacingM),

              // Skills List
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.skills.length,
                itemBuilder: (context, index) {
                  final skill = widget.skills[index];
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: widget.isMobile ? 10 : AppTheme.spacingS,
                    ),
                    child: _AnimatedSkillBar(
                      skill: skill,
                      delay: index * 100, // Stagger animations
                      isVisible: widget.isVisible,
                    ),
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

class _AnimatedSkillBar extends StatefulWidget {
  final SkillItem skill;
  final int delay;
  final bool isVisible;

  const _AnimatedSkillBar({
    required this.skill,
    required this.isVisible,
    this.delay = 0,
  });

  @override
  State<_AnimatedSkillBar> createState() => _AnimatedSkillBarState();
}

class _AnimatedSkillBarState extends State<_AnimatedSkillBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;
  late Animation<double> _checkmarkAnimation;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Progress bar fills to 100%
    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.8, curve: Curves.easeInOut),
      ),
    );

    // Checkmark appears after progress bar completes
    _checkmarkAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.8, 1.0, curve: Curves.elasticOut),
      ),
    );
  }

  @override
  void didUpdateWidget(_AnimatedSkillBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Trigger animation when visibility changes from false to true
    if (!oldWidget.isVisible && widget.isVisible) {
      _startAnimation();
    }
  }

  void _startAnimation() {
    if (!_hasAnimated && mounted) {
      _hasAnimated = true;
      // Start animation with delay
      Future.delayed(Duration(milliseconds: 500 + widget.delay), () {
        if (mounted) _controller.forward();
      });
    }
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

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              // Display logo image
              widget.skill.icon.isNotEmpty
                  ? Image.asset(
                      widget.skill.icon,
                      width: isMobile ? 18 : 20,
                      height: isMobile ? 18 : 20,
                      errorBuilder: (context, error, stackTrace) {
                        // Fallback icon if image fails to load
                        return Container(
                          width: isMobile ? 18 : 20,
                          height: isMobile ? 18 : 20,
                          decoration: BoxDecoration(
                            color: AppTheme.success.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Icon(
                            Icons.code,
                            size: isMobile ? 12 : 14,
                            color: AppTheme.success,
                          ),
                        );
                      },
                    )
                  : Container(
                      width: isMobile ? 18 : 20,
                      height: isMobile ? 18 : 20,
                      decoration: BoxDecoration(
                        color: AppTheme.success.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Icon(
                        Icons.code,
                        size: isMobile ? 12 : 14,
                        color: AppTheme.success,
                      ),
                    ),
              SizedBox(width: isMobile ? 8 : 12),
              Expanded(
                child: Text(
                  widget.skill.name,
                  style: AppTheme.bodyMedium.copyWith(
                    color: AppTheme.lightText,
                    fontSize: isMobile ? 12 : 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // Animated checkmark that appears when bar completes
              AnimatedBuilder(
                animation: _checkmarkAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _checkmarkAnimation.value,
                    child: Opacity(
                      opacity: _checkmarkAnimation.value,
                      child: Icon(
                        Icons.check_circle,
                        color: AppTheme.success,
                        size: isMobile ? 18 : 20,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: isMobile ? 6 : 8),
          AnimatedBuilder(
            animation: _progressAnimation,
            builder: (context, child) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: _progressAnimation.value,
                  backgroundColor: AppTheme.darkBg,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppTheme.success,
                  ),
                  minHeight: isMobile ? 4 : 6,
                ),
              );
            },
          ),
        ],
      );
  }
}
