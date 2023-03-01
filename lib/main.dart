import 'package:fish_bowl_game/countdown_timer.dart';
import 'package:fish_bowl_game/game_model.dart';
import 'package:fish_bowl_game/game_theme.dart';
import 'package:fish_bowl_game/new_game_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  var countdownTimer = CountDownTimer();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => countdownTimer),
      ChangeNotifierProvider(create: (context) => GameModel(countdownTimer)),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: GameTheme().theme,
      home: const NewGameScreen(),
    );
  }
}
