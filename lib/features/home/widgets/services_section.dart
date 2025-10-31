import 'package:flutter/material.dart';
import 'package:matt_smith_portfolio/shared/theme.dart';
import 'package:matt_smith_portfolio/shared/constants.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

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
            'Services I Offer',
            style: AppTheme.displayMedium.copyWith(
              color: AppTheme.lightText,
              fontSize: isMobile ? 32 : 40,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppTheme.spacingS),
          Text(
            'Full-stack development expertise to bring your ideas to life',
            style: AppTheme.bodyLarge.copyWith(
              color: AppTheme.mutedText,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: AppTheme.spacingXL),

          // Services Grid
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
                  childAspectRatio: 0.85,
                ),
                itemCount: AppConstants.services.length,
                itemBuilder: (context, index) {
                  return _ServiceCard(
                    service: AppConstants.services[index],
                  );
                },
              );
            },
          ),

          SizedBox(height: AppTheme.spacingXL),

          // CTA Button
          ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Email me at: ${AppConstants.email}'),
                  backgroundColor: AppTheme.darkBg,
                  action: SnackBarAction(
                    label: 'Close',
                    textColor: AppTheme.primaryBlue,
                    onPressed: () {},
                  ),
                ),
              );
            },
            icon: const Icon(Icons.email),
            label: const Text('Get a Quote'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 32 : 48,
                vertical: isMobile ? 16 : 20,
              ),
              textStyle: AppTheme.headingMedium.copyWith(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatefulWidget {
  final ServiceOffering service;

  const _ServiceCard({required this.service});

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()
          ..translate(0.0, _isHovered ? -8.0 : 0.0),
        child: Container(
          padding: const EdgeInsets.all(AppTheme.spacingL),
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
              // Icon
              Container(
                padding: const EdgeInsets.all(AppTheme.spacingM),
                decoration: BoxDecoration(
                  color: AppTheme.primaryBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusM),
                ),
                child: Icon(
                  widget.service.icon,
                  color: AppTheme.primaryBlue,
                  size: 32,
                ),
              ),

              SizedBox(height: AppTheme.spacingM),

              // Title
              Text(
                widget.service.title,
                style: AppTheme.headingMedium.copyWith(
                  color: AppTheme.lightText,
                  fontSize: 20,
                ),
              ),

              SizedBox(height: AppTheme.spacingS),

              // Description
              Text(
                widget.service.description,
                style: AppTheme.bodyMedium.copyWith(
                  color: AppTheme.mutedText,
                  fontSize: 14,
                ),
              ),

              SizedBox(height: AppTheme.spacingM),

              // Deliverables
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.service.deliverables.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: AppTheme.success,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              widget.service.deliverables[index],
                              style: AppTheme.caption.copyWith(
                                color: AppTheme.mutedText,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const Divider(color: AppTheme.mutedText),

              SizedBox(height: AppTheme.spacingS),

              // Price
              Text(
                widget.service.startingPrice,
                style: AppTheme.headingMedium.copyWith(
                  color: AppTheme.primaryBlue,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
