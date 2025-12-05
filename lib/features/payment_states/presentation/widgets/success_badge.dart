import 'package:flutter/material.dart';

/// Success badge with green checkmark icon
class SuccessBadge extends StatelessWidget {
  const SuccessBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Success icon with green badge
        Stack(
          alignment: Alignment.center,
          children: [
            // Outer splash/sparkle effect
            CustomPaint(
              size: const Size(120, 120),
              painter: _SplashPainter(),
            ),
            // Green badge with checkmark
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                color: Color(0xFF2ECC71),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                size: 40,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        // Title
        const Text(
          'Payment successful',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Color(0xFF000000),
          ),
        ),
        const SizedBox(height: 8),
        // Subtitle
        const Text(
          'Your car rent Booking has been successfully',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Color(0xFF7F7F7F),
          ),
        ),
      ],
    );
  }
}

/// Custom painter for splash/sparkle effect
class _SplashPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF2ECC71).withValues(alpha: 0.2)
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);

    // Draw splash shapes around the center
    final path = Path();

    // Create star-like splash effect
    const numPoints = 8;
    const outerRadius = 55.0;
    const innerRadius = 45.0;

    for (int i = 0; i < numPoints * 2; i++) {
      final radius = i.isEven ? outerRadius : innerRadius;
      final angle = (i * 3.14159 / numPoints) - (3.14159 / 2);
      final x = center.dx + radius * (i.isEven ? 1.2 : 0.9) * 
          (angle == -3.14159 / 2 ? 0 : (i % 4 < 2 ? 1 : -1) * 
           (i % 2 == 0 ? 0.8 : 0.4));
      final y = center.dy + radius * (i.isEven ? 1.2 : 0.9) * 
          (i < 4 ? -0.8 : 0.8) * (i % 2 == 0 ? 1 : 0.5);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);

    // Draw some simple decorative dots
    final dotPaint = Paint()
      ..color = const Color(0xFF2ECC71).withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;

    // Top dots
    canvas.drawCircle(Offset(center.dx - 30, center.dy - 50), 4, dotPaint);
    canvas.drawCircle(Offset(center.dx + 35, center.dy - 45), 3, dotPaint);
    canvas.drawCircle(Offset(center.dx + 50, center.dy - 20), 5, dotPaint);
    
    // Bottom dots
    canvas.drawCircle(Offset(center.dx - 45, center.dy + 35), 4, dotPaint);
    canvas.drawCircle(Offset(center.dx + 40, center.dy + 40), 3, dotPaint);
    
    // Side dots
    canvas.drawCircle(Offset(center.dx - 55, center.dy - 10), 3, dotPaint);
    canvas.drawCircle(Offset(center.dx + 55, center.dy + 10), 4, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
