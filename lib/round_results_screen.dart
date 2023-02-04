import 'package:fish_bowl_game/countdown_timer.dart';
import 'package:fish_bowl_game/game_model.dart';
import 'package:fish_bowl_game/game_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoundResultsScreeen extends StatelessWidget {
  const RoundResultsScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    var gameModel = Provider.of<GameModel>(context, listen: false);
    var countDownTimer = Provider.of<CountDownTimer>(context, listen: false);
    String roundMessage = "";
    if (countDownTimer.time < countDownTimer.maxTime &&
        countDownTimer.time > 0) {
      roundMessage =
          "It is STILL ${gameModel.team}'s turn, they have ${countDownTimer.time} seconds left to start the new round";
    }

    return Scaffold(
      body: Container(
        color: gameModel.gameColor,
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Text(gameModel.round),
                Text(roundMessage),
                scoreBoard(gameModel),
                const Text("DA RULES"),
                Text(gameModel.rules),
                Expanded(
                  child: TextButton(
                    onPressed: () => startRound(gameModel, context),
                    child: const Text("START GAME"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row scoreBoard(GameModel model) {
    int team1Total = 0;
    int team2Total = 0;

    List<Widget> scores = [];

    scores.add(Column(children: const [
      Text("Team 1"),
      Text("Team 2"),
    ]));

    scores.add(const VerticalDivider(
      width: 10,
      thickness: 1,
      indent: 2,
      endIndent: 2,
      color: Colors.white,
    ));

    for (int i = 0; i < 3; i++) {
      int t1 = model.roundScore(true, i);
      int t2 = model.roundScore(false, i);

      team1Total += t1;
      team2Total += t2;

      scores.add(Column(children: [
        Text(t1.toString()),
        Text(t2.toString()),
      ]));

      scores.add(const VerticalDivider(
        width: 5,
        thickness: 1,
        indent: 2,
        endIndent: 2,
        color: Colors.transparent,
      ));
    }

    scores.add(const VerticalDivider(
      width: 10,
      thickness: 1,
      indent: 2,
      endIndent: 2,
      color: Colors.white,
    ));

    scores.add(Column(children: [
      Text(team1Total.toString()),
      Text(team2Total.toString()),
    ]));

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: scores,
    );
  }

  void startRound(GameModel gameModel, BuildContext context) {
    gameModel.startRound();
    gameModel.nextColor();

    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const GameScreen()),
    );
  }
}
