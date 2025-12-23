import 'package:code_note/core/models/splash_bubble.dart';
import 'package:flutter/material.dart';

class BubblePainter extends CustomPainter {
  final List<SplashBubble> bubbles;

  BubblePainter(this.bubbles);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.35)
      ..style = PaintingStyle.fill;

    for (final b in bubbles) {
      canvas.drawCircle(
        Offset(b.x, b.y),
        b.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}