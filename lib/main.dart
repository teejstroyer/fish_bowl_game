import 'package:fish_bowl_game/game_model.dart';
import 'package:fish_bowl_game/new_game_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => GameModel())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
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
            ),
            bodyMedium: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
            bodyLarge: TextStyle(
              fontSize: 40,
              color: Colors.white,
            ),
            labelLarge: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          primaryTextTheme: const TextTheme(
            bodyLarge: TextStyle(
              fontSize: 40,
              color: Colors.white,
            ),
            labelLarge: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Colors.white,
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
                  fontSize: 28),
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.white)),
      home: const NewGameScreen(),
    );
  }
}
