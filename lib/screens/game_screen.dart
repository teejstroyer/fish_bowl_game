import 'package:fish_bowl_game/components/countdown_clock.dart';
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
    var countdownTimer = Provider.of<CountdownTimer>(context, listen: false);

    return ScreenBase(
      backgroundColor: gameModel.gameColor,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              PauseButton(
                onPause: () {
                  countdownTimer.stopTimer(reset: false);
                },
                onResume: () {
                  gameModel.startTimer(context);
                },
              )
            ],
          ),
          Column(
            children: [
              Center(
                child: Text(
                  gameModel.team,
                  style: Theme.of(context).primaryTextTheme.headlineSmall,
                ),
              ),
              Center(
                child: Text(
                  gameModel.rules,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: Consumer<GameModel>(
                builder: (context, model, child) {
                  return Text(
                    model.currentThing,
                    style: Theme.of(context).primaryTextTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                var outer = constraints.biggest.shortestSide;
                var inner = outer * 0.85;
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    CountdownClock(
                      color: Colors.white,
                      diameter: outer,
                    ),
                    Container(
                      width: inner,
                      height: inner,
                      clipBehavior: Clip.hardEdge,
                      margin: const EdgeInsets.all(0),
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        color: gameModel.gameColor,
                        borderRadius: BorderRadius.circular(inner),
                      ),
                    ),
                    Container(
                      width: inner,
                      height: inner,
                      clipBehavior: Clip.hardEdge,
                      margin: const EdgeInsets.all(0),
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(inner),
                      ),
                      child: Material(
                        shape: const CircleBorder(),
                        color: Colors.black26,
                        child: InkWell(
                          onTap: () => gameModel.acceptThing(context),
                          child: Icon(
                            Icons.check,
                            size: inner * .80,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
