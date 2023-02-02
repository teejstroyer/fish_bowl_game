import 'dart:async';

import 'package:flutter/material.dart';

class CountDownTimer extends ChangeNotifier {
  static const countdownDuration = Duration(seconds: 60);
  Duration duration = const Duration();
  Timer? timer;

  void reset() {
    duration = countdownDuration;
    notifyListeners();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void addTime() {
    final seconds = duration.inSeconds - 1;
    if (seconds < 0) {
      timer?.cancel();
    } else {
      duration = Duration(seconds: seconds);
    }
    notifyListeners();
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    timer?.cancel();
    notifyListeners();
  }

  String get time => duration.inSeconds.toString();
  bool get isTimerRunning => timer == null ? false : timer!.isActive;
}
