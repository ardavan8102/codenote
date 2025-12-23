import 'dart:math';
import 'package:flutter/material.dart';

class SplashBubble {
  double x;
  double y;
  double size;
  double speed;
  double drift;

  SplashBubble({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.drift,
  });

  factory SplashBubble.random(Size size) {
    final rnd = Random();
    return SplashBubble(
      x: rnd.nextDouble() * size.width,
      y: rnd.nextDouble() * size.height,
      size: rnd.nextDouble() * 4 + 2,
      speed: rnd.nextDouble() * 0.6 + 0.3,
      drift: rnd.nextDouble() * 0.6 - 0.3,
    );
  }
}