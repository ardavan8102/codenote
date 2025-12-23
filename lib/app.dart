import 'package:code_note/core/theme/app_theme.dart';
import 'package:code_note/presentation/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Code Note',
      
      locale: const Locale('fa', 'IR'),

      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      supportedLocales: const [
        Locale('fa', 'IR'),
      ],

      theme: AppTheme.mainTheme,
      home: const SplashScreen(),
    );
  }
}
