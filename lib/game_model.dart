import 'dart:math';

import 'package:flutter/material.dart';

class GameModel extends ChangeNotifier {
  final List<String> _words = [];
  List<String> _wordsInRound = [];

  int _round = -1;
  List<int> _team1Score = [0, 0, 0];
  List<int> _team2Score = [0, 0, 0];
  bool _team1Turn = true;

  String get currentThing => thingsLeft > 0 ? _wordsInRound.first : "EMPTY";
  int get thingsLeft => _wordsInRound.length;
  int get thingCount => _words.length;
  String get team => _team1Turn ? "Team 1" : "Team 2";
  String get round => "Round ${_round + 1}";

  String get rules {
    switch (_round) {
      case 2:
        return "You can say only word. Words like " "Um" " counts!";
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

  final List<Color> _gameColors = [
    Colors.red,
    Colors.blue,
    Colors.pink,
    Colors.purple,
    Colors.orange,
  ];

  int _gameColorIndex = Random().nextInt(5);
  Color get gameColor => _gameColors[_gameColorIndex];

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

  void startRound() {
    _round++;
    _wordsInRound = [..._words];
    _wordsInRound.shuffle();
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
}
