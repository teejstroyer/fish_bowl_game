import 'package:fish_bowl_game/components/scoreboard.dart';
import 'package:fish_bowl_game/providers/game_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameOverScreen extends StatelessWidget {
  const GameOverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var gameModel = Provider.of<GameModel>(context, listen: false);

    return Scaffold(
      body: Container(
        color: gameModel.gameColor,
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            gameModel.team1Score > gameModel.team2Score
                                ? "TEAM 1 WINS"
                                : "TEAM 2 WINS",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: ScoreBoard(model: gameModel)),
                  Expanded(
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            gameModel.showNewGameScreen(context);
                          },
                          child: const Text("NEW GAME"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
