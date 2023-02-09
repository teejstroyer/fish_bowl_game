import 'package:flutter/material.dart';
import 'package:fish_bowl_game/game_model.dart';
import 'package:provider/provider.dart';

class GamePauseScreen extends StatelessWidget {
  const GamePauseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var gameModel = Provider.of<GameModel>(context, listen: false);

    return Scaffold(
      body: Container(
        color: gameModel.gameColor,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Column(children: [
                  Center(
                    child: Text(
                      gameModel.team,
                      style: Theme.of(context).primaryTextTheme.bodyLarge,
                    ),
                  )
                ]),
              ),
              Expanded(flex: 2, child: Text(gameModel.rules)),
              Expanded(
                flex: 3,
                child: Column(children: [
                  Center(
                    child: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  )
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showPauseScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const GamePauseScreen(),
      ),
    );
  }
}
