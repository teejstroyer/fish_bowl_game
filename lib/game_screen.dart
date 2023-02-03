import 'package:fish_bowl_game/countdown_timer.dart';
import 'package:fish_bowl_game/game_model.dart';
import 'package:fish_bowl_game/round_results_screen.dart';
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
      Provider.of<CountDownTimer>(context, listen: false).resetTimer();
      Provider.of<CountDownTimer>(context, listen: false).startTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    var gameModel = Provider.of<GameModel>(context, listen: false);
    var countDownTimer = Provider.of<CountDownTimer>(context, listen: false);
    return Stack(
      children: [
        Scaffold(
          body: Container(
            color: Colors.red,
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        gameModel.getRules(),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Consumer<GameModel>(
                      builder: (context, model, child) {
                        return Column(
                          children: [
                            Center(
                              child: Text(
                                "${model.thingsLeft}/${model.thingCount}",
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  model.currentThing,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyLarge,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Consumer<CountDownTimer>(builder: (context, model, child) {
                    return Center(
                      child: Text(model.time.toString()),
                    );
                  }),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Center(
                          child: IconButton(
                            onPressed: () =>
                                acceptThing(gameModel, countDownTimer),
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
        ),
        buildIgnorePointer()
      ],
    );
  }

  Widget buildIgnorePointer() {
    return Consumer<CountDownTimer>(builder: (context, model, child) {
      int trigger = 20;
      var color = (model.time < trigger) ? Colors.white : Colors.transparent;
      double width = (model.time % 2 == 0) ? 15 : 10;

      return IgnorePointer(
        ignoring: true,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: color,
              width: width,
            ),
            //color: Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(50)),
          ),
        ),
      );
    });
  }

  void acceptThing(GameModel gameModel, CountDownTimer timer) {
    var thingsLeft = gameModel.acceptThing();

    if (thingsLeft <= 0) {
      timer.stopTimer();
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const RoundResultsScreeen(),
        ),
      );
    }
  }
}
