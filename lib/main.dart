import 'package:fish_bowl_game/config/game_theme.dart';
import 'package:fish_bowl_game/providers/countdown_timer.dart';
import 'package:fish_bowl_game/providers/game_model.dart';
import 'package:fish_bowl_game/screens/new_game_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => CountdownTimer()),
      ChangeNotifierProxyProvider<CountdownTimer, GameModel>(
        create: (_) => GameModel(),
        update: (_, countdownTimer, gameModel) {
          gameModel?.countdownTimer = countdownTimer;
          return gameModel ?? GameModel();
        },
      )
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
