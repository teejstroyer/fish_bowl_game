import 'package:fish_bowl_game/providers/countdown_timer.dart';
import 'package:fish_bowl_game/providers/game_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PauseButton extends StatelessWidget {
  const PauseButton({super.key});

  @override
  Widget build(BuildContext context) {
    var gameModel = Provider.of<GameModel>(context, listen: false);
    var countdownTimer = Provider.of<CountdownTimer>(context, listen: false);
    var textColor = gameModel.gameColor;

    return IconButton(
      icon: const Icon(Icons.pause),
      onPressed: () {
        countdownTimer.stopTimer(reset: false);
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
