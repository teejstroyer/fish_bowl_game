import 'dart:ui';
import 'package:flutter/material.dart';

class GameTheme {
  ThemeData get theme {
    const fontFeatures = [FontFeature.tabularFigures()];
    const primaryColor = Colors.white;
    const fontFamily = 'TeamB';

    const textTheme = TextTheme(
      headlineLarge: TextStyle(
        color: primaryColor,
        fontSize: 80,
        fontWeight: FontWeight.bold,
        fontFeatures: fontFeatures,
      ),
      headlineMedium: TextStyle(
        color: primaryColor,
        fontSize: 60,
        fontWeight: FontWeight.bold,
        fontFeatures: fontFeatures,
      ),
      headlineSmall: TextStyle(
        color: primaryColor,
        fontSize: 40,
        fontWeight: FontWeight.bold,
        fontFeatures: fontFeatures,
      ),
      bodySmall: TextStyle(
        color: primaryColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFeatures: fontFeatures,
      ),
      bodyMedium: TextStyle(
        color: primaryColor,
        fontSize: 28,
        fontWeight: FontWeight.bold,
        fontFeatures: fontFeatures,
      ),
      bodyLarge: TextStyle(
        color: primaryColor,
        fontSize: 34,
        fontWeight: FontWeight.bold,
        fontFeatures: fontFeatures,
      ),
      labelLarge: TextStyle(
        color: primaryColor,
        fontSize: 34,
        fontWeight: FontWeight.bold,
        fontFeatures: fontFeatures,
      ),
    );

    return ThemeData(
      fontFamily: fontFamily,
      primaryColor: primaryColor,
      inputDecorationTheme: const InputDecorationTheme(
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        hintStyle: TextStyle(color: Colors.black38, fontSize: 34),
        labelStyle: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: primaryColor,
        selectionColor: Colors.white54,
        selectionHandleColor: primaryColor,
      ),
      primaryTextTheme: textTheme,
      textTheme: textTheme,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
          disabledForegroundColor: Colors.black38,
          disabledIconColor: Colors.black38,
          textStyle: const TextStyle(
            fontFamily: fontFamily,
            fontWeight: FontWeight.bold,
            decorationColor: primaryColor,
            fontSize: 60,
          ),
        ),
      ),
      iconTheme: const IconThemeData(color: primaryColor),
    );
  }
}
