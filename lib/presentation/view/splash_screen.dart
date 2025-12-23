import 'dart:math';
import 'package:code_note/core/models/splash_bubble.dart';
import 'package:code_note/gen/assets.gen.dart';
import 'package:code_note/page_handler.dart';
import 'package:code_note/features/splash/water_painter.dart';
import 'package:code_note/features/splash/bubble_painter.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  late AnimationController waterController;
  late AnimationController logoController;

  final List<SplashBubble> bubbles = [];
  double waterLevel = 0.0;

  @override
  void initState() {
    super.initState();

    final size = WidgetsBinding.instance.window.physicalSize / WidgetsBinding.instance.window.devicePixelRatio;

    for (int i = 0; i < 7; i++) {
      bubbles.add(SplashBubble.random(size));
    }

    waterController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
        updateBubbles(size);
        setState(() {
          waterLevel = waterController.value;
        });
      });

    logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    waterController.forward();

    waterController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        logoController.forward();
        Future.delayed(const Duration(seconds: 4), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const PageHandlerScreen()),
          );
        });
      }
    });
  }

  void updateBubbles(Size size) {
    for (final b in bubbles) {
      b.y -= b.speed;
      b.x += b.drift;

      if (b.y < -10) {
        b.y = size.height + b.size * 2;
        b.x = Random().nextDouble() * size.width;
      }
    }
  }

  @override
  void dispose() {
    waterController.dispose();
    logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [

          /// WATER + WAVES
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRect(
              child: Align(
                alignment: Alignment.bottomCenter,
                heightFactor: waterLevel,
                child: Stack(
                  children: [
                    Positioned(
                      top: 50,
                      left: 0,
                      right: 0,
                      child: CustomPaint(
                        size: Size(size.width, size.height),
                        painter: WaterPainter(waterController.value),
                      ),
                    ),

                    /// BUBBLES
                    RepaintBoundary(
                      child: CustomPaint(
                        size: Size(size.width, size.height),
                        painter: BubblePainter(bubbles),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// LOGO
          FadeTransition(
            opacity: logoController,
            child: ScaleTransition(
              scale: Tween(begin: 0.8, end: 1.0).animate(
                CurvedAnimation(
                  parent: logoController,
                  curve: Curves.easeOut,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    Assets.brand.logoTransparent.path,
                    width: 90,
                  ),

                  const SizedBox(height: 24),

                  Text(
                    'کُــــد نُتـــــ',
                    style: textTheme.headlineLarge!.copyWith(
                      color: Colors.white
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'تقدیم به برنامه نویس های خوب ایران',
                    style: textTheme.bodyMedium!.copyWith(
                      color: Colors.white
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}