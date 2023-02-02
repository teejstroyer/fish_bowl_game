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
      Provider.of<CountDownTimer>(context, listen: false).reset();
      Provider.of<CountDownTimer>(context, listen: false).startTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    Provider.of<GameModel>(context, listen: false).getRules(),
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
                          child:
                              Text("${model.thingsLeft}/${model.thingCount}"),
                        ),
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
              Consumer<CountDownTimer>(builder: (context, model, child) {
                return Center(
                  child: Text(model.time),
                );
              }),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Center(
                      child: IconButton(
                        onPressed: () => acceptThing(context),
                        icon: const Icon(Icons.check_circle),
                        iconSize: 200,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void acceptThing(BuildContext context) {
    var thingsLeft = Provider.of<GameModel>(
      context,
      listen: false,
    ).acceptThing();

    if (thingsLeft <= 0) {
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
