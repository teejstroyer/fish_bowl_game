import 'package:fish_bowl_game/providers/game_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PauseButton extends StatelessWidget {
  final Function() onPause;
  final Function() onResume;
  const PauseButton({
    super.key,
    required this.onPause,
    required this.onResume,
  });

  @override
  Widget build(BuildContext context) {
    var gameModel = Provider.of<GameModel>(context, listen: false);
    var textColor = gameModel.gameColor;

    return IconButton(
      icon: const Icon(Icons.pause),
      onPressed: () {
        onPause();
        showDialog(
          context: context,
          builder: ((context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: Text(
                gameModel.team,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: textColor,
                    ),
              ),
              content: Text(
                gameModel.rules,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: textColor,
                    ),
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      style: Theme.of(context).textButtonTheme.style!.copyWith(
                          textStyle: MaterialStateProperty.all<TextStyle>(
                              Theme.of(context)
                                  .primaryTextTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: textColor,
                                  )),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(textColor)),
                      onPressed: () {
                        gameModel.showTitleScreen(context);
                      },
                      child: const Text("QUIT"),
                    ),
                    TextButton(
                      style: Theme.of(context).textButtonTheme.style!.copyWith(
                          textStyle: MaterialStateProperty.all<TextStyle>(
                              Theme.of(context)
                                  .primaryTextTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: textColor,
                                  )),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(textColor)),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: const Text("RESUME"),
                    )
                  ],
                ),
              ],
            );
          }),
        ).then((value) {
          if (value == true) {
            onResume();
          }
        });
      },
    );
  }
}
