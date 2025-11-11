import 'package:flutter/material.dart';
import '../theme.dart';

/// An animated button with scale and shimmer effects
/// Showcases advanced button interactions and micro-animations
class AnimatedButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  final IconData? icon;
  final bool isSmall;

  const AnimatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    this.icon,
    this.isSmall = false,
  });

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  bool _isPressed = false;
  late AnimationController _shimmerController;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _shimmerAnimation = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(
        parent: _shimmerController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  void _onHoverChanged(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
    if (isHovered) {
      _shimmerController.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return MouseRegion(
      onEnter: (_) => _onHoverChanged(true),
      onExit: (_) => _onHoverChanged(false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          widget.onPressed();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedScale(
          scale: _isPressed ? 0.95 : (_isHovered ? 1.05 : 1.0),
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(
              horizontal: widget.isSmall
                  ? (isMobile ? AppTheme.spacingS : AppTheme.spacingM)
                  : (isMobile ? AppTheme.spacingM : AppTheme.spacingL),
              vertical: widget.isSmall
                  ? (isMobile ? AppTheme.spacingXS : AppTheme.spacingS)
                  : (isMobile ? AppTheme.spacingS : AppTheme.spacingS + 4),
            ),
            decoration: BoxDecoration(
              gradient: widget.isPrimary
                  ? AppTheme.primaryGradient
                  : LinearGradient(
                      colors: [
                        AppTheme.cardBg,
                        AppTheme.cardBg,
                      ],
                    ),
              borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
              border: widget.isPrimary
                  ? null
                  : Border.all(
                      color: _isHovered
                          ? AppTheme.primaryBlue
                          : AppTheme.primaryBlue.withOpacity(0.3),
                      width: 2,
                    ),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: widget.isPrimary
                            ? AppTheme.primaryBlue.withOpacity(0.3)
                            : AppTheme.primaryBlue.withOpacity(0.2),
                        blurRadius: 20,
                        spreadRadius: 0,
                      ),
                    ]
                  : [],
            ),
            child: Stack(
              children: [
                // Shimmer effect
                if (_isHovered && widget.isPrimary)
                  AnimatedBuilder(
                    animation: _shimmerAnimation,
                    builder: (context, child) {
                      return Positioned.fill(
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(AppTheme.borderRadiusM),
                          child: Transform.translate(
                            offset: Offset(
                              _shimmerAnimation.value * 100,
                              0,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    Colors.white.withOpacity(0.2),
                                    Colors.transparent,
                                  ],
                                  stops: const [0.0, 0.5, 1.0],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                // Button content
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.icon != null) ...[
                      Icon(
                        widget.icon,
                        color: AppTheme.lightText,
                        size: widget.isSmall ? 16 : (isMobile ? 18 : 20),
                      ),
                      SizedBox(width: AppTheme.spacingXS),
                    ],
                    Text(
                      widget.text,
                      style: widget.isSmall
                          ? AppTheme.bodyMedium.copyWith(
                              color: AppTheme.lightText,
                              fontWeight: FontWeight.w600,
                            )
                          : AppTheme.bodyLarge.copyWith(
                              color: AppTheme.lightText,
                              fontWeight: FontWeight.w600,
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
