import 'package:fish_bowl_game/countdown_timer.dart';
import 'package:fish_bowl_game/game_model.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CountDownTimer>(context, listen: false).startTimer(() {
        Provider.of<GameModel>(context, listen: false).nextTeam(context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var gameModel = Provider.of<GameModel>(context, listen: false);
    var countDownTimer = Provider.of<CountDownTimer>(context, listen: false);

    return Scaffold(
      body: Container(
        color: gameModel.gameColor,
        child: SafeArea(
          child: Column(
            children: [
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
                      child: Text(gameModel.rules),
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
                              style:
                                  Theme.of(context).primaryTextTheme.bodyLarge,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Consumer<CountDownTimer>(
                builder: (context, model, child) {
                  return AnimatedScale(
                    scale: (model.time % 2 == 0) ? 1 : 5,
                    duration: const Duration(seconds: 1),
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
                        onPressed: () => acceptThing(gameModel, countDownTimer),
                        icon: const Icon(Icons.check_circle),
                        iconSize: 200,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void acceptThing(GameModel gameModel, CountDownTimer timer) {
    var thingsLeft = gameModel.acceptThing();
    if (thingsLeft <= 0) {
      gameModel.showRoundResults(context, timer, newRound: true);
    }
  }
}
