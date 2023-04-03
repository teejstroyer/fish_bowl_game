import 'package:fish_bowl_game/providers/countdown_timer.dart';
import 'package:fish_bowl_game/providers/game_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdjustCountdownTimerButton extends StatelessWidget {
  const AdjustCountdownTimerButton({super.key});

  @override
  Widget build(BuildContext context) {
    var gameModel = Provider.of<GameModel>(context, listen: false);

    return IconButton(
      icon: const Icon(Icons.timer),
      onPressed: () => showDialog(
        context: context,
        builder: ((context) {
          return buildAlertDialog(gameModel, context);
        }),
      ),
    );
  }

  AlertDialog buildAlertDialog(GameModel gameModel, BuildContext context) {
    var color = gameModel.gameColor;
    return AlertDialog(
      title: Center(
        child: Text("Adjust Round Time",
            style: Theme.of(context)
                .primaryTextTheme
                .bodyLarge!
                .copyWith(color: color)),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              color: gameModel.gameColor,
              iconSize: 48.0,
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ],
      content: Container(
        constraints: const BoxConstraints(
          maxHeight: 400,
          maxWidth: 400,
          minWidth: 200,
          minHeight: 200,
        ),
        //height: MediaQuery.of(context).size.height * 0.9,
        width: MediaQuery.of(context).size.width * 0.9,
        color: Colors.white,
        child: Consumer<CountdownTimer>(builder: (context, timer, child) {
          return Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  iconSize: 50,
                  alignment: Alignment.centerLeft,
                  onPressed: (() {
                    timer.addTime(-1);
                  }),
                  icon: Icon(Icons.remove, color: color),
                ),
                Text(
                  timer.maxTime.toString().padLeft(3, '0'),
                  style: Theme.of(context)
                      .primaryTextTheme
                      .bodyLarge!
                      .copyWith(
                        color: color,
                      ),
                ),
                IconButton(
                  iconSize: 50,
                  alignment: Alignment.centerRight,
                  onPressed: () {
                    timer.addTime(1);
                  },
                  icon: Icon(Icons.add, color: color),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
