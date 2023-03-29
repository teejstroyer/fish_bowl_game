import 'package:fish_bowl_game/providers/game_model.dart';
import 'package:flutter/material.dart';

class ScoreBoard extends StatelessWidget {
  const ScoreBoard({
    super.key,
    required this.model,
  });

  final GameModel model;

  @override
  Widget build(BuildContext context) {
    int team1Total = 0;
    int team2Total = 0;

    final style = Theme.of(context).primaryTextTheme.bodyLarge;
    const padding = 6.0;

    List<Widget> scores = [];

    for (int i = 0; i < 3; i++) {
      int t1 = model.roundScore(true, i);
      int t2 = model.roundScore(false, i);

      team1Total += t1;
      team2Total += t2;

      scores.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: padding),
          child: Column(
            children: [
              Text(t1.toString(), style: style),
              Text(t2.toString(), style: style),
            ],
          ),
        ),
      );
    }

    return Wrap(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(children: [
              Text(model.team1, style: style),
              Text(model.team2, style: style),
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: padding),
              child: Container(
                decoration: const BoxDecoration(
                  border: Border.symmetric(
                    vertical: BorderSide(
                      width: padding,
                      color: Colors.white,
                    ),
                  ),
                ),
                child: Row(
                  children: [...scores],
                ),
              ),
            ),
            Column(
              children: [
                Text(team1Total.toString(), style: style),
                Text(team2Total.toString(), style: style),
              ],
            )
          ],
        ),
      ],
    );
  }
}
