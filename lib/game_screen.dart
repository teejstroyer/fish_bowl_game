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
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Center(
                      child: IconButton(
                        onPressed: Provider.of<GameModel>(context, listen: false)
                            .acceptThing,
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
}
