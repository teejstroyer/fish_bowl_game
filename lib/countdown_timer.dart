import 'dart:async';

import 'package:flutter/material.dart';

class CountDownTimer extends ChangeNotifier {
  static const _countdownDuration = Duration(seconds: 60);
  Duration _duration = const Duration();
  Timer? _timer;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _timerTick());
  }

  void _timerTick() {
    final seconds = _duration.inSeconds - 1;
    if (seconds < 0) {
      _timer?.cancel();
    } else {
      _duration = Duration(seconds: seconds);
    }
    notifyListeners();
  }

  void resetTimer() {
    _duration = _countdownDuration;
    notifyListeners();
  }

  void stopTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }
    _timer?.cancel();
    notifyListeners();
  }

  int get time => _duration.inSeconds;
  bool get isTimerRunning => _timer == null ? false : _timer!.isActive;
}
