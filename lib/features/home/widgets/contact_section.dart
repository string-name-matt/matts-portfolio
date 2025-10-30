import 'package:flutter/material.dart';
import 'package:matt_smith_portfolio/shared/theme.dart';
import 'package:matt_smith_portfolio/shared/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? AppTheme.spacingM : AppTheme.spacingXL),
      child: Column(
        children: [
          // CTA Card
          Container(
            constraints: const BoxConstraints(maxWidth: 800),
            padding: EdgeInsets.all(
              isMobile ? AppTheme.spacingM : AppTheme.spacingXL,
            ),
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              borderRadius: BorderRadius.circular(AppTheme.radiusXL),
              boxShadow: AppTheme.glowShadow,
            ),
            child: Column(
              children: [
                Text(
                  AppConstants.ctaTitle,
                  style: AppTheme.displayMedium.copyWith(
                    color: Colors.white,
                    fontSize: isMobile ? 28 : 40,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: AppTheme.spacingM),

                Text(
                  AppConstants.ctaDescription,
                  style: AppTheme.bodyLarge.copyWith(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: isMobile ? 16 : 18,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: AppTheme.spacingXL),

                // Contact Button
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Open email client or contact form
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Email me at: ${AppConstants.email}'),
                        backgroundColor: AppTheme.darkBg,
                        action: SnackBarAction(
                          label: 'Copy',
                          textColor: AppTheme.primaryBlue,
                          onPressed: () {
                            // TODO: Copy email to clipboard
                          },
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.email),
                  label: const Text('Get In Touch'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppTheme.primaryBlue,
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 32 : 48,
                      vertical: isMobile ? 16 : 20,
                    ),
                    textStyle: AppTheme.headingMedium.copyWith(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: AppTheme.spacingXL),

          // Social Links
          Text(
            'Connect With Me',
            style: AppTheme.headingMedium.copyWith(
              color: AppTheme.lightText,
            ),
          ),

          SizedBox(height: AppTheme.spacingM),

          Wrap(
            spacing: AppTheme.spacingM,
            runSpacing: AppTheme.spacingM,
            alignment: WrapAlignment.center,
            children: [
              _SocialButton(
                icon: Icons.code,
                label: 'GitHub',
                onPressed: () {
                  // TODO: Update URL in constants.dart
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('TODO: Update GitHub URL in constants.dart'),
                    ),
                  );
                  // _launchUrl(AppConstants.githubUrl);
                },
              ),
              _SocialButton(
                icon: Icons.work,
                label: 'LinkedIn',
                onPressed: () {
                  // TODO: Update URL in constants.dart
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('TODO: Update LinkedIn URL in constants.dart'),
                    ),
                  );
                  // _launchUrl(AppConstants.linkedinUrl);
                },
              ),
              _SocialButton(
                icon: Icons.email,
                label: 'Email',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Email: ${AppConstants.email}'),
                    ),
                  );
                },
              ),
            ],
          ),

          SizedBox(height: AppTheme.spacingXL),

          // Footer
          Text(
            '© 2024 ${AppConstants.name}. Built with Flutter & Firebase.',
            style: AppTheme.caption.copyWith(
              color: AppTheme.mutedText,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppTheme.primaryBlue,
        side: BorderSide(
          color: AppTheme.primaryBlue.withOpacity(0.5),
          width: 1,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
      ),
    );
  }
}
