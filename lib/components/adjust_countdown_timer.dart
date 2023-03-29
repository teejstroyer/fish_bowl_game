import 'dart:ui';
import 'package:fish_bowl_game/providers/countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdjustCountdownTimer extends StatelessWidget {
  const AdjustCountdownTimer({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            border: Border.symmetric(
              vertical: BorderSide(
                color: Colors.white,
                width: 20,
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Round Time',
                style: Theme.of(context).primaryTextTheme.bodyLarge,
              ),
              timerUI(),
            ],
          ),
        ),
      ],
    );
  }

  Widget timerUI() {
    return Consumer<CountdownTimer>(builder: (context, timer, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            iconSize: 50,
            alignment: Alignment.centerLeft,
            onPressed: (() {
              timer.addTime(-1);
            }),
            icon: const Icon(Icons.remove),
          ),
          Text(
            timer.maxTime.toString().padLeft(3, '0'),
            style: Theme.of(context).primaryTextTheme.bodyLarge,
          ),
          IconButton(
            iconSize: 50,
            alignment: Alignment.centerRight,
            onPressed: () {
              timer.addTime(1);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      );
    });
  }
}
