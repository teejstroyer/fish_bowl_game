import 'package:fish_bowl_game/countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdjustCountdownTimer extends StatelessWidget {
  const AdjustCountdownTimer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: timerUI(),
    );
  }

  Consumer<CountDownTimer> timerUI() {
    return Consumer<CountDownTimer>(builder: (context, timer, child) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            IconButton(
              alignment: Alignment.centerLeft,
              onPressed: (() {
                timer.addTime(-1);
              }),
              icon: const Icon(Icons.remove),
            ),
            Text(timer.maxTime.toString()),
            IconButton(
              alignment: Alignment.centerRight,
              onPressed: () {
                timer.addTime(1);
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      );
    });
  }
}
