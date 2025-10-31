import 'package:flutter/material.dart';
import 'package:matt_smith_portfolio/shared/theme.dart';
import 'package:matt_smith_portfolio/shared/constants.dart';

class ProcessSection extends StatelessWidget {
  const ProcessSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? AppTheme.spacingM : AppTheme.spacingXL),
      child: Column(
        children: [
          Text(
            'How I Work',
            style: AppTheme.displayMedium.copyWith(
              color: AppTheme.lightText,
              fontSize: isMobile ? 32 : 40,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppTheme.spacingS),
          Text(
            'A proven process from concept to deployment',
            style: AppTheme.bodyLarge.copyWith(
              color: AppTheme.mutedText,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: AppTheme.spacingXL),

          Container(
            constraints: const BoxConstraints(maxWidth: 900),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: AppConstants.workProcess.length,
              itemBuilder: (context, index) {
                final step = AppConstants.workProcess[index];
                final isLast = index == AppConstants.workProcess.length - 1;
                return _ProcessStepWidget(
                  step: step,
                  isLast: isLast,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ProcessStepWidget extends StatelessWidget {
  final ProcessStep step;
  final bool isLast;

  const _ProcessStepWidget({
    required this.step,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Step Number Circle
        Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppTheme.primaryGradient,
                boxShadow: AppTheme.glowShadow,
              ),
              child: Center(
                child: Text(
                  '${step.number}',
                  style: AppTheme.headingMedium.copyWith(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 120,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppTheme.primaryBlue,
                      AppTheme.primaryBlue.withOpacity(0.3),
                    ],
                  ),
                ),
              ),
          ],
        ),

        const SizedBox(width: AppTheme.spacingM),

        // Step Content
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: AppTheme.spacingL),
            padding: const EdgeInsets.all(AppTheme.spacingM),
            decoration: BoxDecoration(
              color: AppTheme.cardBg,
              borderRadius: BorderRadius.circular(AppTheme.radiusM),
              border: Border.all(
                color: AppTheme.primaryBlue.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        step.title,
                        style: AppTheme.headingMedium.copyWith(
                          color: AppTheme.lightText,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppTheme.radiusS),
                      ),
                      child: Text(
                        step.duration,
                        style: AppTheme.caption.copyWith(
                          color: AppTheme.primaryBlue,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppTheme.spacingS),
                Text(
                  step.description,
                  style: AppTheme.bodyMedium.copyWith(
                    color: AppTheme.mutedText,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
