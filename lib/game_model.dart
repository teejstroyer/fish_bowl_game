import 'dart:math';
import 'package:fish_bowl_game/countdown_timer.dart';
import 'package:fish_bowl_game/game_screen.dart';
import 'package:fish_bowl_game/round_results_screen.dart';
import 'package:flutter/material.dart';

class GameModel extends ChangeNotifier {
  final CountDownTimer _countDownTimer;

  final List<String> _words = [];
  List<String> _wordsInRound = [];

  int _round = -1;
  List<int> _team1Score = [0, 0, 0];
  List<int> _team2Score = [0, 0, 0];
  bool _team1Turn = true;
  int _gameColorIndex = 0;
  final List<Color> _gameColors = [
    Colors.red,
    Colors.blue,
    Colors.pink,
    Colors.purple,
    Colors.orange,
  ];

  GameModel(this._countDownTimer) {
    _gameColorIndex = Random().nextInt(_gameColors.length);
  }

  String get currentThing => thingsLeft > 0 ? _wordsInRound.first : "EMPTY";
  int get thingsLeft => _wordsInRound.length;
  int get thingCount => _words.length;
  String get team => _team1Turn ? "Team 1" : "Team 2";
  String get round => "Round ${_round + 1}";
  Color get gameColor => _gameColors[_gameColorIndex];

  String get rules {
    switch (_round) {
      case 2:
        return "You can say only one word. Words like \"Um\" count! NO FILLER WORDS OR SOUNDS!";
      case 1:
        return "No speaking, act it out";
      case 0:
      default:
        return "Say anything but the word";
    }
  }

  int roundScore(bool team1, int round) {
    return team1 ? _team1Score[round] : _team2Score[round];
  }

  void nextColor() {
    _gameColorIndex++;
    if (_gameColorIndex >= _gameColors.length) _gameColorIndex = 0;
  }

  void newGame() {
    _words.clear();
    _round = -1;
    _team1Score = [0, 0, 0];
    _team2Score = [0, 0, 0];
    _team1Turn = true;
    notifyListeners();
  }

  void add(String word) {
    _words.add(word.toUpperCase().trim());
    notifyListeners();
  }

  void addMany(List<String> words) {
    for (var word in words) {
      _words.add(word.toUpperCase().trim());
    }
    notifyListeners();
  }

  void acceptThing(BuildContext context) {
    if (thingsLeft > 0) {
      _wordsInRound.removeAt(0);

      if (_team1Turn) {
        _team1Score[_round]++;
      } else {
        _team2Score[_round]++;
      }

      if (thingsLeft <= 0) {
        showRoundResults(context, false, true);
      } else {
        notifyListeners();
      }
    }
  }

  void updateRound() {
    _round++;
    _wordsInRound = [..._words];
    _wordsInRound.shuffle();
  }

  void showRoundResults(BuildContext context, bool resetTimer, bool newRound) {
    _countDownTimer.stopTimer(reset: resetTimer);

    if (newRound) {
      updateRound();
    }
    nextColor();

    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RoundResultsScreen(resetTimer),
      ),
    );
  }

  void showGameScreen(BuildContext context, bool resetTimer) {
    nextColor();
    if (resetTimer) {
      _countDownTimer.resetTimer();
    }

    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const GameScreen()),
    );
  }

  void nextTeam(BuildContext context) {
    nextColor();
    _team1Turn = !_team1Turn;
    showRoundResults(context, true, false);
  }

  void startTimer(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _countDownTimer.startTimer(
        () {
          nextTeam(context);
          _countDownTimer.resetTimer();
        },
      );
    });
  }
}
