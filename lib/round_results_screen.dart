import 'package:fish_bowl_game/game_model.dart';
import 'package:fish_bowl_game/game_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoundResultsScreeen extends StatelessWidget {
  const RoundResultsScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: const SafeArea(
          child: Text("ROUND RESULTS"),
        ),
      ),
    );
  }
}
