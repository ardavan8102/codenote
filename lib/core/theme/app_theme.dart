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


      // Bodies
      bodyMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500
      )

    ),

  );

}