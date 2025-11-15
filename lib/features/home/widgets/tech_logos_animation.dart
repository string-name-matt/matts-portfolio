import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matt_smith_portfolio/shared/theme.dart';

/// A stunning 3D orbital animation showcasing tech stack logos in a constellation pattern
class TechLogosAnimation extends StatefulWidget {
  const TechLogosAnimation({super.key});

  @override
  State<TechLogosAnimation> createState() => _TechLogosAnimationState();
}

/// Logo data model
class _LogoData {
  final String path;
  final Color color;
  ui.Image? image;
  bool isLoading = false;

  _LogoData(this.path, this.color);
}

class _TechLogosAnimationState extends State<TechLogosAnimation>
    with TickerProviderStateMixin {
  late AnimationController _orbitController;
  late AnimationController _pulseController;
  late AnimationController _entranceController;

  // List of tech logos to display - reduced to key technologies for better spacing
  final List<_LogoData> _logos = [
    _LogoData('assets/images/logos/flutter_logo.png', const Color(0xFF0175C2)),
    _LogoData('assets/images/logos/dart_logo.png', const Color(0xFF00D2B8)),
    _LogoData('assets/images/logos/firebase_logo.png', const Color(0xFFFFCA28)),
    _LogoData('assets/images/logos/node_logo.png', const Color(0xFF339933)),
    _LogoData('assets/images/logos/git_logo.png', const Color(0xFFF05032)),
    _LogoData('assets/images/logos/gemini_logo.png', const Color(0xFF886FBF)),
    _LogoData('assets/images/logos/openai_logo.png', const Color(0xFF10A37F)),
    _LogoData('assets/images/logos/riverpod_logo.png', const Color(0xFF00A3FF)),
    _LogoData('assets/images/logos/stripe_logo.png', const Color(0xFF635BFF)),
  ];

  @override
  void initState() {
    super.initState();

    // Orbital rotation animation
    _orbitController = AnimationController(
      duration: const Duration(seconds: 30),
      vsync: this,
    )..repeat();

    // Pulse animation for glow effect
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    // Entrance animation
    _entranceController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..forward();

    // Load all logo images
    _loadLogoImages();
  }

  Future<void> _loadLogoImages() async {
    for (var logoData in _logos) {
      if (!logoData.isLoading && logoData.image == null) {
        logoData.isLoading = true;
        try {
          final data = await rootBundle.load(logoData.path);
          final bytes = data.buffer.asUint8List();
          final codec = await ui.instantiateImageCodec(bytes);
          final frame = await codec.getNextFrame();
          if (mounted) {
            setState(() {
              logoData.image = frame.image;
            });
          }
        } catch (e) {
          // If image fails to load, just skip it
          debugPrint('Failed to load logo: ${logoData.path}');
        }
      }
    }
  }

  @override
  void dispose() {
    _orbitController.dispose();
    _pulseController.dispose();
    _entranceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 400,
      child: AnimatedBuilder(
        animation: Listenable.merge([
          _orbitController,
          _pulseController,
          _entranceController,
        ]),
        builder: (context, child) {
          return CustomPaint(
            painter: _LogosOrbitPainter(
              logos: _logos,
              orbitProgress: _orbitController.value,
              pulseProgress: _pulseController.value,
              entranceProgress: _entranceController.value,
            ),
            size: const Size(400, 400),
          );
        },
      ),
    );
  }
}

/// Custom painter that renders logos in a 3D orbital constellation pattern
class _LogosOrbitPainter extends CustomPainter {
  final List<_LogoData> logos;
  final double orbitProgress;
  final double pulseProgress;
  final double entranceProgress;

  _LogosOrbitPainter({
    required this.logos,
    required this.orbitProgress,
    required this.pulseProgress,
    required this.entranceProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final baseRadius = size.width * 0.35;

    // Draw each logo in orbital pattern
    for (int i = 0; i < logos.length; i++) {
      _drawLogoOrbit(canvas, center, baseRadius, i, logos.length);
    }
  }

  void _drawLogoOrbit(
    Canvas canvas,
    Offset center,
    double baseRadius,
    int index,
    int totalLogos,
  ) {
    // Calculate unique orbital parameters for each logo with better distribution
    final double angleOffset = (index / totalLogos) * 2 * math.pi;

    // Each logo gets a unique speed using golden ratio distribution for better spacing
    // This prevents bunching that occurs with only 3 different speeds
    final double orbitSpeed = 0.8 + (index * 0.137) % 0.6; // Varies from 0.8 to 1.4
    final double currentAngle = angleOffset + (orbitProgress * 2 * math.pi * orbitSpeed);

    // Give each logo a different orbit radius for layered, stable orbits
    // Use 3 distinct orbital rings to keep logos in predictable paths
    final double orbitRingIndex = (index % 3).toDouble();
    final double logoRadius = baseRadius * (0.9 + orbitRingIndex * 0.1); // 0.9x, 1.0x, 1.1x

    // Calculate 3D depth based on vertical position for scale/opacity only
    // Don't use depth to vary radius - keeps orbits stable and visible
    final double depthPhase = (currentAngle + math.pi / 2) % (2 * math.pi);
    final double depth = (math.cos(depthPhase) + 1) / 2; // 0 to 1

    // Calculate position with stable circular/elliptical motion
    final double x = center.dx + math.cos(currentAngle) * logoRadius;
    final double y = center.dy + math.sin(currentAngle) * logoRadius * 0.5; // Elliptical

    // Scale based on depth (closer = larger)
    final double entranceScale = Curves.elasticOut.transform(
      (entranceProgress * 1.5 - (index / totalLogos)).clamp(0.0, 1.0),
    );
    final double depthScale = 0.6 + (depth * 0.4); // Reduced variation for more consistent sizing
    final double pulseScale = 1.0 + (math.sin(pulseProgress * 2 * math.pi + angleOffset) * 0.08);
    final double finalScale = entranceScale * depthScale * pulseScale;

    // Improved opacity with higher minimum to prevent popping
    // Smoothly transitions between 0.75 and 1.0 based on depth
    final double depthOpacity = 0.75 + (depth * 0.25);
    final double opacity = entranceScale * depthOpacity;

    // Logo size
    final double logoSize = 50 * finalScale;

    // Draw glow effect
    final glowPaint = Paint()
      ..color = AppTheme.primaryBlue.withOpacity(opacity * 0.3 * pulseProgress)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 15 * finalScale);

    canvas.drawCircle(
      Offset(x, y),
      logoSize * 0.6,
      glowPaint,
    );

    // Draw connecting orbital trail (subtle) - only for select logos to reduce clutter
    if (index > 0 && index % 3 == 0 && depth > 0.6) {
      final prevIndex = index - 1;
      final prevAngleOffset = (prevIndex / totalLogos) * 2 * math.pi;
      final prevOrbitSpeed = 0.8 + (prevIndex * 0.137) % 0.6;
      final prevAngle = prevAngleOffset + (orbitProgress * 2 * math.pi * prevOrbitSpeed);
      final prevDepth = (math.cos((prevAngle + math.pi / 2) % (2 * math.pi)) + 1) / 2;
      final prevOrbitRingIndex = (prevIndex % 3).toDouble();
      final prevLogoRadius = baseRadius * (0.9 + prevOrbitRingIndex * 0.1);

      final prevX = center.dx + math.cos(prevAngle) * prevLogoRadius;
      final prevY = center.dy + math.sin(prevAngle) * prevLogoRadius * 0.5;

      final trailPaint = Paint()
        ..color = Colors.white.withOpacity(0.08 * depth)
        ..strokeWidth = 0.8
        ..style = PaintingStyle.stroke;

      canvas.drawLine(Offset(prevX, prevY), Offset(x, y), trailPaint);
    }

    // Draw logo container with depth shadow
    final containerPaint = Paint()
      ..color = Colors.white.withOpacity(opacity * 0.9)
      ..style = PaintingStyle.fill;

    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(opacity * 0.3 * (1 - depth))
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    // Shadow (appears more when logo is in front)
    canvas.drawCircle(
      Offset(x + 2, y + 2),
      logoSize * 0.5,
      shadowPaint,
    );

    // Container background
    canvas.drawCircle(
      Offset(x, y),
      logoSize * 0.5,
      containerPaint,
    );

    // Rotating border effect
    final borderPaint = Paint()
      ..color = AppTheme.primaryBlue.withOpacity(opacity * 0.6)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(
      Offset(x, y),
      logoSize * 0.5,
      borderPaint,
    );

    // Draw the actual logo image if loaded, otherwise draw colored circle
    final logoData = logos[index];
    if (logoData is _LogoData && logoData.image != null) {
      // Draw the actual logo image
      canvas.save();
      canvas.translate(x, y);
      canvas.scale(finalScale);

      final imageSize = logoSize * 0.7;
      final srcRect = Rect.fromLTWH(
        0,
        0,
        logoData.image!.width.toDouble(),
        logoData.image!.height.toDouble(),
      );
      final dstRect = Rect.fromLTWH(
        -imageSize / 2,
        -imageSize / 2,
        imageSize,
        imageSize,
      );

      final imagePaint = Paint()
        ..filterQuality = FilterQuality.high
        ..color = Colors.white.withOpacity(opacity);

      canvas.drawImageRect(
        logoData.image!,
        srcRect,
        dstRect,
        imagePaint,
      );

      canvas.restore();
    } else {
      // Fallback: draw colored circle
      final iconPaint = Paint()
        ..color = _getLogoColor(index).withOpacity(opacity)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(
        Offset(x, y),
        logoSize * 0.35,
        iconPaint,
      );
    }

    // Add sparkle effect for logos in front
    if (depth > 0.7 && pulseProgress > 0.8) {
      final sparklePaint = Paint()
        ..color = Colors.white.withOpacity((pulseProgress - 0.8) * 5 * opacity)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(x - logoSize * 0.3, y - logoSize * 0.3), 2, sparklePaint);
      canvas.drawCircle(Offset(x + logoSize * 0.3, y - logoSize * 0.3), 2, sparklePaint);
    }
  }

  Color _getLogoColor(int index) {
    // Use the color from logoData
    return logos[index].color;
  }

  @override
  bool shouldRepaint(_LogosOrbitPainter oldDelegate) {
    return oldDelegate.orbitProgress != orbitProgress ||
        oldDelegate.pulseProgress != pulseProgress ||
        oldDelegate.entranceProgress != entranceProgress;
  }
}
