import 'dart:math';

import 'package:fish_bowl_game/countdown_timer.dart';
import 'package:fish_bowl_game/game_screen.dart';
import 'package:fish_bowl_game/round_results_screen.dart';
import 'package:flutter/material.dart';

class GameModel extends ChangeNotifier {
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

  GameModel() {
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

  int acceptThing() {
    if (thingsLeft > 0) {
      _wordsInRound.removeAt(0);

      if (_team1Turn) {
        _team1Score[_round]++;
      } else {
        _team2Score[_round]++;
      }
      notifyListeners();
    }
    return thingsLeft;
  }

  void showRoundResults(
    BuildContext context,
    CountDownTimer timer, {
    bool newRound = false,
  }) {
    timer.stopTimer();
    if (newRound) {
      _round++;
      _wordsInRound = [..._words];
      _wordsInRound.shuffle();
    }

    nextColor();
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const RoundResultsScreen()),
    );
  }

  void showGameScreen(BuildContext context, CountDownTimer timer) {
    nextColor();
    timer.resetTimer();
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const GameScreen()),
    );
  }

  void nextTeam(BuildContext context) {
    nextColor();
    _team1Turn = !_team1Turn;
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const RoundResultsScreen(),
      ),
    );
  }
}
