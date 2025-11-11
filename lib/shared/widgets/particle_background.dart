import 'dart:math';
import 'package:flutter/material.dart';
import '../theme.dart';

/// Animated floating particles background effect
/// Demonstrates custom painting and physics-based animations in Flutter
class ParticleBackground extends StatefulWidget {
  final Widget child;
  final int particleCount;
  final Color particleColor;
  final double maxParticleSize;

  const ParticleBackground({
    super.key,
    required this.child,
    this.particleCount = 30,
    this.particleColor = AppTheme.primaryBlue,
    this.maxParticleSize = 4.0,
  });

  @override
  State<ParticleBackground> createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Particle> particles;

  @override
  void initState() {
    super.initState();
    particles = [];
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    _controller.addListener(() {
      setState(() {
        for (var particle in particles) {
          particle.update();
        }
      });
    });
  }

  void _initializeParticles(Size size) {
    if (particles.isEmpty && size.width > 0 && size.height > 0) {
      final random = Random();
      particles = List.generate(
        widget.particleCount,
        (index) => Particle(
          x: random.nextDouble() * size.width,
          y: random.nextDouble() * size.height,
          size: random.nextDouble() * widget.maxParticleSize + 1,
          speedX: (random.nextDouble() - 0.5) * 0.5,
          speedY: (random.nextDouble() - 0.5) * 0.5,
          opacity: random.nextDouble() * 0.3 + 0.1,
          maxWidth: size.width,
          maxHeight: size.height,
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        _initializeParticles(size);

        return Stack(
          children: [
            CustomPaint(
              size: size,
              painter: ParticlePainter(
                particles: particles,
                color: widget.particleColor,
              ),
            ),
            widget.child,
          ],
        );
      },
    );
  }
}

class Particle {
  double x;
  double y;
  final double size;
  final double speedX;
  final double speedY;
  final double opacity;
  final double maxWidth;
  final double maxHeight;

  Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speedX,
    required this.speedY,
    required this.opacity,
    required this.maxWidth,
    required this.maxHeight,
  });

  void update() {
    x += speedX;
    y += speedY;

    // Wrap around edges
    if (x < 0) x = maxWidth;
    if (x > maxWidth) x = 0;
    if (y < 0) y = maxHeight;
    if (y > maxHeight) y = 0;
  }
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final Color color;

  ParticlePainter({
    required this.particles,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particles) {
      final paint = Paint()
        ..color = color.withOpacity(particle.opacity)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(
        Offset(particle.x, particle.y),
        particle.size,
        paint,
      );

      // Draw subtle connections between nearby particles
      for (var other in particles) {
        if (particle == other) continue;

        final distance = sqrt(
          pow(particle.x - other.x, 2) + pow(particle.y - other.y, 2),
        );

        if (distance < 100) {
          final linePaint = Paint()
            ..color = color.withOpacity((1 - distance / 100) * 0.1)
            ..strokeWidth = 0.5;

          canvas.drawLine(
            Offset(particle.x, particle.y),
            Offset(other.x, other.y),
            linePaint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
