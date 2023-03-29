import 'dart:math';

import 'package:fish_bowl_game/components/team_entry.dart';
import 'package:fish_bowl_game/providers/game_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TitleScreen extends StatelessWidget {
  const TitleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var gameModel = Provider.of<GameModel>(context, listen: false);

    var colors = gameModel.getGameColors().keys;
    var randomColor = colors.elementAt(Random().nextInt(colors.length));

    return Scaffold(
      body: Container(
        color: randomColor,
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Fish Bowl",
                        style: Theme.of(context).primaryTextTheme.headlineLarge
                      ),
                    ),
                  ),
                  TeamEntry(
                    getTeamName: () => gameModel.team1,
                    setTeamName: (val) => gameModel.setTeam1Name(val),
                    getColors: () => gameModel.getGameColors(),
                    getOtherTeamName: () => gameModel.team2,
                    getTeamColor: () => gameModel.team1Color,
                    setTeamColor: (val) => gameModel.setTeam1Color(val),
                  ),
                  TeamEntry(
                    getTeamName: () => gameModel.team2,
                    setTeamName: (val) => gameModel.setTeam2Name(val),
                    getColors: () => gameModel.getGameColors(),
                    getOtherTeamName: () => gameModel.team1,
                    getTeamColor: () => gameModel.team2Color,
                    setTeamColor: (val) => gameModel.setTeam2Color(val),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () => gameModel.showNewGameScreen(context),
                      child: const Text("New Game"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
