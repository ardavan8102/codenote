import 'package:code_note/core/theme/app_theme.dart';
import 'package:code_note/presentation/view/splash_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Code Note',
      theme: AppTheme.mainTheme,
      home: const SplashScreen(),
    );
  }
}
