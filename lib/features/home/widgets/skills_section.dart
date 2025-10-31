import 'package:flutter/material.dart';
import 'package:matt_smith_portfolio/shared/theme.dart';
import 'package:matt_smith_portfolio/shared/constants.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Container(
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
              final crossAxisCount = constraints.maxWidth > 1200
                  ? 4
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
                  childAspectRatio: 1.2,
                ),
                itemCount: AppConstants.skills.length,
                itemBuilder: (context, index) {
                  final category = AppConstants.skills.keys.elementAt(index);
                  final skillItems = AppConstants.skills[category]!;
                  return _SkillCategoryCard(
                    category: category,
                    skills: skillItems,
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

class _SkillCategoryCard extends StatelessWidget {
  final String category;
  final List<SkillItem> skills;

  const _SkillCategoryCard({
    required this.category,
    required this.skills,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingM),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(AppTheme.radiusL),
        border: Border.all(
          color: AppTheme.primaryBlue.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category Title
          Text(
            category,
            style: AppTheme.headingMedium.copyWith(
              color: AppTheme.primaryBlue,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: AppTheme.spacingM),

          // Skills List
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: skills.length,
              itemBuilder: (context, index) {
                final skill = skills[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppTheme.spacingS),
                  child: _AnimatedSkillBar(skill: skill),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedSkillBar extends StatefulWidget {
  final SkillItem skill;

  const _AnimatedSkillBar({required this.skill});

  @override
  State<_AnimatedSkillBar> createState() => _AnimatedSkillBarState();
}

class _AnimatedSkillBarState extends State<_AnimatedSkillBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: widget.skill.level).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Start animation after a short delay
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // Display logo image
            widget.skill.icon.isNotEmpty
                ? Image.asset(
                    widget.skill.icon,
                    width: 20,
                    height: 20,
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback to text if image fails to load
                      return Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: AppTheme.primaryBlue.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(
                          Icons.code,
                          size: 14,
                          color: AppTheme.primaryBlue,
                        ),
                      );
                    },
                  )
                : Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryBlue.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(
                      Icons.code,
                      size: 14,
                      color: AppTheme.primaryBlue,
                    ),
                  ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                widget.skill.name,
                style: AppTheme.bodyMedium.copyWith(
                  color: AppTheme.lightText,
                  fontSize: 14,
                ),
              ),
            ),
            Text(
              '${(widget.skill.level * 100).toInt()}%',
              style: AppTheme.caption.copyWith(
                color: AppTheme.mutedText,
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: _animation.value,
                backgroundColor: AppTheme.darkBg,
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppTheme.primaryBlue,
                ),
                minHeight: 6,
              ),
            );
          },
        ),
      ],
    );
  }
}
