import 'package:flutter/material.dart';
import 'package:matt_smith_portfolio/shared/constants.dart';
import 'package:matt_smith_portfolio/shared/theme.dart';

class ImpactMetricsSection extends StatelessWidget {
  const ImpactMetricsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Container(
      width: double.infinity,
      padding:
          EdgeInsets.all(isMobile ? AppTheme.spacingM : AppTheme.spacingXL),
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
      ),
      child: Column(
        children: [
          Text(
            'Real Impact',
            style: AppTheme.displayMedium.copyWith(
              color: Colors.white,
              fontSize: isMobile ? 32 : 40,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppTheme.spacingS),
          Text(
            'Measurable results from production applications',
            style: AppTheme.bodyLarge.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: AppTheme.spacingXL),

          // Metrics Grid
          Wrap(
            spacing: AppTheme.spacingM,
            runSpacing: AppTheme.spacingM,
            alignment: WrapAlignment.center,
            children: AppConstants.impactMetrics.map((metric) {
              return _MetricCard(metric: metric);
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final ImpactMetric metric;

  const _MetricCard({required this.metric});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;
    return Container(
      width: 220,
      height: isMobile ? 300 : 350,
      padding: const EdgeInsets.all(AppTheme.spacingL),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppTheme.radiusL),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            metric.icon,
            color: Colors.white,
            size: 40,
          ),
          SizedBox(height: AppTheme.spacingM),
          Text(
            metric.value,
            style: AppTheme.displayMedium.copyWith(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: AppTheme.spacingS),
          Text(
            metric.label,
            style: AppTheme.headingMedium.copyWith(
              color: Colors.white,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppTheme.spacingXS),
          Text(
            metric.description,
            style: AppTheme.caption.copyWith(
              color: Colors.white.withOpacity(0.8),
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
