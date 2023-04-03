import 'package:fish_bowl_game/components/adjust_countdown_timer_button.dart';
import 'package:fish_bowl_game/components/pause_button.dart';
import 'package:fish_bowl_game/components/scoreboard.dart';
import 'package:fish_bowl_game/components/screen_base.dart';
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

    return ScreenBase(
      backgroundColor: gameModel.gameColor,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AdjustCountdownTimerButton(),
              PauseButton(onPause: () {}, onResume: () {}),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      gameModel.round,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      "${gameModel.team}'s turn",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                Text(
                  gameModel.rules,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Expanded(child: Center(child: ScoreBoard(model: gameModel))),
          Expanded(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    gameModel.showGameScreen(context, _resetTimer);
                  },
                  child: const Text("PLAY"),
                ),
                Consumer<CountdownTimer>(
                  builder: (context, model, child) {
                    return Text(
                      countdownTimer.time < countdownTimer.maxTime &&
                              countdownTimer.time > 0
                          ? "${model.time} seconds rolled over"
                          : "${model.time} seconds",
                      style: Theme.of(context).primaryTextTheme.bodySmall,
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
