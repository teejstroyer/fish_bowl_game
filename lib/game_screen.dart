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
              const Text("Rules:"),

              Center(
                child: Consumer<GameModel>(
                  builder: (context, model, child) {
                    return Text(
                      "${model.thingCount} total",
                      textAlign: TextAlign.right,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
