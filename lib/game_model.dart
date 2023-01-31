import 'package:flutter/material.dart';

class GameModel extends ChangeNotifier {
  final List<String> _words = [];
  List<String> _wordsLeftInRound = [];
  int get thingCount => _words.length;

  int _round = -1;
  final List<int> _team1Score = [];
  final List<int> _team2Score = [];

  bool _team1Turn = true;

  void newGame() {
    _words.clear();
    _wordsLeftInRound.clear();
    _round = 0;
    _team1Score.clear();
    _team2Score.clear();
    _team1Turn = true;
    notifyListeners();
  }

  void startRound() {
    _wordsLeftInRound = [..._words];
    _round++;
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
}
