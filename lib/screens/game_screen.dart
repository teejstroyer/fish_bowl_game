import 'package:fish_bowl_game/components/screen_base.dart';
import 'package:fish_bowl_game/components/pause_button.dart';
import 'package:fish_bowl_game/providers/countdown_timer.dart';
import 'package:fish_bowl_game/providers/game_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<GameModel>(context, listen: false).startTimer(context);
  }

  @override
  Widget build(BuildContext context) {
    var gameModel = Provider.of<GameModel>(context, listen: false);
    return ScreenBase(
      backgroundColor: gameModel.gameColor,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [PauseButton()],
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Center(
                  child: Text(
                    gameModel.team,
                    style: Theme.of(context).primaryTextTheme.bodyLarge,
                  ),
                ),
                Center(
                  child: Text(
                    gameModel.rules,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Consumer<GameModel>(
              builder: (context, model, child) {
                return Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          model.currentThing,
                          style: Theme.of(context).primaryTextTheme.bodyLarge,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Consumer<CountdownTimer>(
            builder: (context, model, child) {
              return AnimatedScale(
                scale: (model.time % 2 == 0) ? 1 : 5,
                duration: const Duration(milliseconds: 1500),
                child: Center(
                  child: Text(model.time.toString()),
                ),
              );
            },
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Center(
                  child: IconButton(
                    onPressed: () => acceptThing(
                      context,
                      gameModel,
                    ),
                    icon: const Icon(Icons.check_circle),
                    iconSize: 200,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void acceptThing(BuildContext context, GameModel gameModel) {
    gameModel.acceptThing(context);
  }
}
