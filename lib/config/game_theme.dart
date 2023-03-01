import 'dart:ui';
import 'package:flutter/material.dart';

class GameTheme {
  ThemeData get theme {
    return ThemeData(
      primaryColor: Colors.white,
      inputDecorationTheme: const InputDecorationTheme(
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white54, fontSize: 34),
        labelStyle: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      textTheme: const TextTheme(
        bodySmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w900,
          color: Colors.white,
          fontFeatures: [FontFeature.tabularFigures()],
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w900,
          color: Colors.white,
          fontFeatures: [FontFeature.tabularFigures()],
        ),
        bodyLarge: TextStyle(
          fontSize: 40,
          color: Colors.white,
          fontFeatures: [FontFeature.tabularFigures()],
        ),
        labelLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w900,
          color: Colors.white,
          fontFeatures: [FontFeature.tabularFigures()],
        ),
      ),
      primaryTextTheme: const TextTheme(
        bodyLarge: TextStyle(
          fontSize: 40,
          color: Colors.white,
          fontFeatures: [FontFeature.tabularFigures()],
        ),
        labelLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w900,
          color: Colors.white,
          fontFeatures: [FontFeature.tabularFigures()],
        ),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: Colors.white,
        disabledColor: Colors.white54,
        focusColor: Colors.white,
        hoverColor: Colors.white,
        highlightColor: Colors.white,
        splashColor: Colors.transparent,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          textStyle: const TextStyle(
            decorationColor: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 28,
          ),
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }
}
