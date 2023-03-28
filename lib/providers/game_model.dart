import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:fish_bowl_game/providers/countdown_timer.dart';
import 'package:fish_bowl_game/screens/game_over_screen.dart';
import 'package:fish_bowl_game/screens/game_screen.dart';
import 'package:fish_bowl_game/screens/new_game_screen.dart';
import 'package:fish_bowl_game/screens/round_results_screen.dart';
import 'package:fish_bowl_game/screens/title_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GameModel extends ChangeNotifier {
  //Populated by proxy provider
  CountdownTimer countdownTimer = CountdownTimer();
  final AudioPlayer _audioPlayer = AudioPlayer();
  final List<String> _words = [];
  List<String> _wordsInRound = [];

  bool _team1Turn = true;
  int _round = -1;
  List<int> _team1Score = [0, 0, 0];
  List<int> _team2Score = [0, 0, 0];
  String _team1 = "Team 1";
  String _team2 = "Team 2";
  Color _team1Color = Colors.red;
  Color _team2Color = Colors.blue;

  final List<Color> _gameColors = [
    Colors.red,
    Colors.blue,
    Colors.pink,
    Colors.purple,
    Colors.orange,
  ];

  String get currentThing => thingsLeft > 0 ? _wordsInRound.first : "EMPTY";
  int get thingsLeft => _wordsInRound.length;
  int get thingCount => _words.length;
  String get team1 => _team1;
  String get team2 => _team2;
  String get team => _team1Turn ? _team1 : _team2;
  Color get team1Color => _team1Color;
  Color get team2Color => _team2Color;
  String get round => "Round ${_round + 1}";
  Color get gameColor => _team1Turn ? _team1Color : _team2Color;
  int get team1Score => _team1Score.fold(0, (prev, cur) => prev + cur);
  int get team2Score => _team2Score.fold(0, (prev, cur) => prev + cur);
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

  bool setTeam1Name(String name) {
    if (_team2.toUpperCase() == name.toUpperCase()) {
      return false;
    }
    _team1 = name;
    notifyListeners();
    return true;
  }

  bool setTeam2Name(String name) {
    if (_team1.toUpperCase() == name.toUpperCase()) {
      return false;
    }
    _team2 = name;
    notifyListeners();
    return true;
  }

  bool setTeam1Color(Color color) {
    if (_team2Color == color) {
      return false;
    }
    _team1Color = color;
    notifyListeners();
    return true;
  }

  bool setTeam2Color(Color color) {
    if (_team1Color == color) {
      return false;
    }
    _team2Color = color;
    notifyListeners();
    return true;
  }

  Map<Color, bool> getGameColors() {
    return {for (var c in _gameColors) c: c != _team1Color && c != _team2Color};
  }

  int roundScore(bool team1, int round) {
    return team1 ? _team1Score[round] : _team2Score[round];
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
    if (thingsLeft > 0 && _round < _team1Score.length) {
      _wordsInRound.removeAt(0);

      _audioPlayer.stop();
      _audioPlayer.play(AssetSource('audio/AcceptThing.mp3'));

      if (_team1Turn) {
        _team1Score[_round]++;
      } else {
        _team2Score[_round]++;
      }

      if (thingsLeft <= 0) {
        //Nothing left and round score < 0. GAME OVER
        if (_team1Score.last + _team2Score.last > 0) {
          showGameOverScreen(context);
        } else if (countdownTimer.time < 1) {
          nextTeam(context);
        } else {
          showRoundResultsScreen(context, false, true);
        }
      } else {
        notifyListeners();
      }
    }
  }

  void startTimer(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      countdownTimer.startTimer(
        () {
          nextTeam(context);
          countdownTimer.resetTimer();
        },
      );
    });
  }

  Future<String> getRandomWord(int? seed) async {
    String dictionary = await rootBundle.loadString('assets/dictionary.txt');
    var list = dictionary.split(' ');
    var random = Random(seed);

    var word = list[random.nextInt(list.length)];
    return word;
  }

  Future<void> preventEvenThingCount() async {
    if (thingCount % 2 == 0) {
      await getRandomWord(null).then((word) {
        add(word);
        notifyListeners();
      });
    }
  }

  void updateRound() {
    preventEvenThingCount().then((_) {
      _round++;
      _wordsInRound = [..._words];
      _wordsInRound.shuffle();
    });
  }

  void nextTeam(BuildContext context) {
    _team1Turn = !_team1Turn;
    showRoundResultsScreen(context, true, false);
  }

  void showGameOverScreen(BuildContext context) {
    countdownTimer.stopTimer(reset: true);

    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const GameOverScreen()),
    );
  }

  void showNewGameScreen(BuildContext context) {
    newGame();
    countdownTimer.resetTimer();

    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const NewGameScreen()),
    );
  }

  void showRoundResultsScreen(
      BuildContext context, bool resetTimer, bool newRound) {
    countdownTimer.stopTimer(reset: resetTimer);

    if (newRound) {
      updateRound();
    }

    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RoundResultsScreen(resetTimer),
      ),
    );
  }

  void showGameScreen(BuildContext context, bool resetTimer) {
    if (resetTimer) {
      countdownTimer.resetTimer();
    }

    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const GameScreen()),
    );
  }

  void showTitleScreen(BuildContext context) {
    newGame();
    countdownTimer.resetTimer();

    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const TitleScreen()),
    );
  }
}
