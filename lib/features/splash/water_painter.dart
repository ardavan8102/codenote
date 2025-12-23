import 'dart:math';
import 'package:flutter/material.dart';
import 'package:code_note/const/colors.dart';

class WaterPainter extends CustomPainter {
  final double progress;

  WaterPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    _drawWave(
      canvas,
      size,
      phase: progress * 2 * pi,
      amplitude: 26,
      opacity: 0.95,
      speed: 1.0,
    );

    _drawWave(
      canvas,
      size,
      phase: progress * 2 * pi + pi / 2,
      amplitude: 18,
      opacity: 0.7,
      speed: 1.3,
    );

    _drawWave(
      canvas,
      size,
      phase: progress * 2 * pi + pi,
      amplitude: 12,
      opacity: 0.45,
      speed: 1.6,
    );
  }

  void _drawWave(
    Canvas canvas,
    Size size, {
    required double phase,
    required double amplitude,
    required double opacity,
    required double speed,
  }) {
    final paint = Paint()
      ..shader = _waterGradient(size)
      ..style = PaintingStyle.fill
      ..color = Colors.white.withValues(alpha: opacity);

    final path = Path();
    final baseHeight = size.height * (1 - progress);
    final waveLength = size.width / speed;

    path.moveTo(0, baseHeight);

    for (double x = 0; x <= size.width; x++) {
      final edgeFade = sin(pi * x / size.width);

      final y = baseHeight +
          sin((x / waveLength * 2 * pi) + phase) *
              amplitude *
              edgeFade;

      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  Shader _waterGradient(Size size) {
    return const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: AppGradientColors.waterColors,
    ).createShader(
      Rect.fromLTWH(0, 0, size.width, size.height),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}