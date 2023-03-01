import 'package:fish_bowl_game/components/adjust_countdown_timer.dart';
import 'package:fish_bowl_game/components/scoreboard.dart';
import 'package:fish_bowl_game/providers/countdown_timer.dart';
import 'package:fish_bowl_game/providers/game_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoundResultsScreen extends StatelessWidget {
  final bool _resetTimer;
  const RoundResultsScreen(this._resetTimer, {super.key});

  @override
  Widget build(BuildContext context) {
    var gameModel = Provider.of<GameModel>(context, listen: false);
    var countdownTimer = Provider.of<CountdownTimer>(context, listen: false);
    String roundMessage = "${gameModel.team}'s turn";
    if (countdownTimer.time < countdownTimer.maxTime &&
        countdownTimer.time > 0) {
      roundMessage =
          "It is STILL ${gameModel.team}'s turn, they have ${countdownTimer.time} seconds left to start the new round";
    }

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
                        Text(
                          "DA RULES",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          gameModel.rules,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  countdownTimer.time == countdownTimer.maxTime
                      ? const Expanded(
                          child: Center(
                            child: AdjustCountdownTimer(),
                          ),
                        )
                      : Expanded(child: Container()),
                  Expanded(
                    child: Column(
                      children: [
                        Text(roundMessage),
                        TextButton(
                          onPressed: () {
                            gameModel.showGameScreen(context, _resetTimer);
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
      ),
    );
  }
}
