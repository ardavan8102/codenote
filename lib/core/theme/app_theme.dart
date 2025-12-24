import 'package:flutter/material.dart';

class AppTheme {

  static ThemeData mainTheme = ThemeData(

    fontFamily: 'Dana',
    
    

    textTheme: TextTheme(

      // Headlines
      headlineLarge: TextStyle(
        fontFamily: 'Meem',
        fontSize: 40,
        fontWeight: FontWeight.w700,
      ),


      // Titles
      titleLarge: TextStyle(
        fontSize: 24,
        fontWeight: .w700,
      ),

      titleMedium: TextStyle(
        fontSize: 22,
        fontWeight: .w700,
      ),
      
      titleSmall: TextStyle(
        fontSize: 20,
        fontWeight: .w600,
      ),


      // Bodies
      bodyMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500
      ),


      // Labels
      labelLarge: TextStyle(
        fontSize: 18,
        fontWeight: .w500
      ),
      labelMedium: TextStyle(
        fontSize: 16,
        fontWeight: .w400
      ),
      labelSmall: TextStyle(
        fontSize: 14,
        fontWeight: .w300
      )

    ),

  );

}