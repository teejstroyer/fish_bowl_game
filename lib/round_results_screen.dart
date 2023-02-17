import 'package:fish_bowl_game/countdown_timer.dart';
import 'package:fish_bowl_game/game_model.dart';
import 'package:fish_bowl_game/scoreboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoundResultsScreeen extends StatelessWidget {
  const RoundResultsScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    var gameModel = Provider.of<GameModel>(context, listen: false);
    var countDownTimer = Provider.of<CountDownTimer>(context, listen: false);
    String roundMessage = "";
    if (countDownTimer.time < countDownTimer.maxTime &&
        countDownTimer.time > 0) {
      roundMessage =
          "It is STILL ${gameModel.team}'s turn, they have ${countDownTimer.time} seconds left to start the new round";
    }

    return Scaffold(
      body: Container(
        color: gameModel.gameColor,
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        gameModel.round,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(roundMessage),
                    ],
                  ),
                ),
                Expanded(child: ScoreBoard(model: gameModel)),
                Expanded(
                  child: Column(
                    children: [
                      const Text("DA RULES"),
                      Text(gameModel.rules),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(gameModel.team),
                      TextButton(
                        onPressed: () {
                          gameModel.showGameScreen(context);
                        },
                        child: const Text("PLAY"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
