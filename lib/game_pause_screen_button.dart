import 'package:flutter/material.dart';
import 'package:fish_bowl_game/game_model.dart';
import 'package:provider/provider.dart';
import 'package:fish_bowl_game/countdown_timer.dart';

class GamePauseScreenButton extends StatelessWidget {
  const GamePauseScreenButton({super.key});

  @override
  Widget build(BuildContext context) {
    var gameModel = Provider.of<GameModel>(context, listen: false);
    var countDownTimer = Provider.of<CountDownTimer>(context, listen: false);
    var textColor = gameModel.gameColor;

    return IconButton(
      icon: const Icon(Icons.pause),
      onPressed: () {
        countDownTimer.stopTimer(reset: false);
        showDialog(
          context: context,
          builder: ((context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: Text(
                gameModel.team,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 32.0,
                ),
              ),
              content: Text(
                gameModel.rules,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 28.0,
                ),
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      color: textColor,
                      iconSize: 48.0,
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            );
          }),
        ).then((value) {
          Provider.of<GameModel>(context, listen: false).startTimer(context);
        });
      },
    );
  }
}
