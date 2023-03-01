import 'dart:async';
import 'package:flutter/material.dart';

class CountdownTimer extends ChangeNotifier {
  Duration _maxDuration = const Duration(seconds: 60);
  Duration _duration = const Duration();
  Timer? _timer;

  int get time => _duration.inSeconds;
  int get maxTime => _maxDuration.inSeconds;
  bool get isTimerRunning => _timer == null ? false : _timer!.isActive;

  void startTimer(Function onTimerEnd) {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _timerTick(onTimerEnd),
    );

    //Prvents lag when timer starts;
    final seconds = _duration.inSeconds - 1;
    _duration = Duration(seconds: seconds);
    notifyListeners();
  }

  void _timerTick(Function onTimerEnd) {
    final seconds = _duration.inSeconds - 1;
    if (seconds < 0) {
      _timer?.cancel();
      onTimerEnd.call();
      _duration = _maxDuration;
    } else {
      _duration = Duration(seconds: seconds);
    }

    notifyListeners();
  }

  void resetTimer() {
    _duration = _maxDuration;
    notifyListeners();
  }

  void stopTimer({bool reset = false}) {
    if (reset) {
      resetTimer();
    }
    _timer?.cancel();
  }

  void addTime(int seconds) {
    _maxDuration = Duration(
      seconds: (_maxDuration.inSeconds + seconds).clamp(0, 999),
    );

    //If we are adjusting total time, we should up current time on the clock
    _duration = Duration(seconds: _maxDuration.inSeconds);
    notifyListeners();
  }
}
