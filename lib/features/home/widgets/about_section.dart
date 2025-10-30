import 'package:flutter/material.dart';
import 'package:matt_smith_portfolio/shared/theme.dart';
import 'package:matt_smith_portfolio/shared/constants.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

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
            AppConstants.aboutTitle,
            style: AppTheme.displayMedium.copyWith(
              color: AppTheme.lightText,
              fontSize: isMobile ? 32 : 40,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: AppTheme.spacingXL),

          // About Content Card
          Container(
            constraints: const BoxConstraints(maxWidth: 900),
            padding: EdgeInsets.all(
              isMobile ? AppTheme.spacingM : AppTheme.spacingXL,
            ),
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
              children: [
                // Description
                Text(
                  AppConstants.aboutDescription,
                  style: AppTheme.bodyLarge.copyWith(
                    color: AppTheme.lightText,
                    fontSize: isMobile ? 16 : 18,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: AppTheme.spacingL),

                // Highlight Stats
                Wrap(
                  spacing: AppTheme.spacingL,
                  runSpacing: AppTheme.spacingM,
                  alignment: WrapAlignment.center,
                  children: [
                    _StatBox(
                      icon: Icons.people_outline,
                      value: '2000+',
                      label: 'Users Served',
                    ),
                    _StatBox(
                      icon: Icons.apps,
                      value: '2+',
                      label: 'Major Projects',
                    ),
                    _StatBox(
                      icon: Icons.cloud_outlined,
                      value: '15+',
                      label: 'Cloud Functions',
                    ),
                    _StatBox(
                      icon: Icons.code,
                      value: '10+',
                      label: 'Technologies',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _StatBox({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingM),
      decoration: BoxDecoration(
        color: AppTheme.darkBg,
        borderRadius: BorderRadius.circular(AppTheme.radiusM),
        border: Border.all(
          color: AppTheme.primaryBlue.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: AppTheme.primaryBlue,
            size: 32,
          ),
          const SizedBox(height: AppTheme.spacingS),
          Text(
            value,
            style: AppTheme.headingMedium.copyWith(
              color: AppTheme.primaryBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTheme.caption.copyWith(
              color: AppTheme.mutedText,
            ),
          ),
        ],
      ),
    );
  }
}
