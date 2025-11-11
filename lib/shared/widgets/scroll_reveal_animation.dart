import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// A widget that reveals its child with animation when it becomes visible
/// Showcases Flutter's advanced animation patterns and visibility detection
class ScrollRevealAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final double offset;
  final int delay;

  const ScrollRevealAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.curve = Curves.easeOut,
    this.offset = 50.0,
    this.delay = 0,
  });

  @override
  State<ScrollRevealAnimation> createState() => _ScrollRevealAnimationState();
}

class _ScrollRevealAnimationState extends State<ScrollRevealAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, widget.offset / 100),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _checkVisibility() {
    if (_hasAnimated) return;

    final RenderObject? renderObject = context.findRenderObject();
    if (renderObject == null) return;

    final RenderAbstractViewport? viewport =
        RenderAbstractViewport.of(renderObject);
    if (viewport == null) return;

    final double vpHeight = viewport.paintBounds.height;
    final RevealedOffset offsetToRevealTop =
        viewport.getOffsetToReveal(renderObject, 0.0);

    // Check if widget is visible in viewport
    final double topPosition = offsetToRevealTop.offset;
    final bool isVisible = topPosition < vpHeight * 0.85;

    if (isVisible && !_hasAnimated) {
      _hasAnimated = true;
      Future.delayed(Duration(milliseconds: widget.delay), () {
        if (mounted) {
          _controller.forward();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Trigger visibility check after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkVisibility();
    });

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        _checkVisibility();
        return false;
      },
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: widget.child,
        ),
      ),
    );
  }
}

/// A convenience widget for staggered animations
class StaggeredScrollReveal extends StatelessWidget {
  final List<Widget> children;
  final int staggerDelayMs;
  final Axis direction;

  const StaggeredScrollReveal({
    super.key,
    required this.children,
    this.staggerDelayMs = 100,
    this.direction = Axis.vertical,
  });

  @override
  Widget build(BuildContext context) {
    return direction == Axis.vertical
        ? Column(
            children: _buildStaggeredChildren(),
          )
        : Row(
            children: _buildStaggeredChildren(),
          );
  }

  List<Widget> _buildStaggeredChildren() {
    return List.generate(
      children.length,
      (index) => ScrollRevealAnimation(
        delay: index * staggerDelayMs,
        child: children[index],
      ),
    );
  }
}
