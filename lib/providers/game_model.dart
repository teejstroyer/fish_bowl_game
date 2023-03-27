import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:fish_bowl_game/providers/countdown_timer.dart';
import 'package:fish_bowl_game/screens/game_over_screen.dart';
import 'package:fish_bowl_game/screens/game_screen.dart';
import 'package:fish_bowl_game/screens/new_game_screen.dart';
import 'package:fish_bowl_game/screens/round_results_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GameModel extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final List<String> _words = [];
  List<String> _wordsInRound = [];

  int _round = -1;
  List<int> _team1Score = [0, 0, 0];
  List<int> _team2Score = [0, 0, 0];
  String _team1 = "Team 1";
  String _team2 = "Team 2";
  Color _team1Color = Colors.red;
  Color _team2Color = Colors.blue;

  bool _team1Turn = true;
  int _gameColorIndex = 0;

  final List<Color> _gameColors = [
    Colors.red,
    Colors.blue,
    Colors.pink,
    Colors.purple,
    Colors.orange,
  ];

  //Populated by proxy provider
  CountdownTimer countdownTimer = CountdownTimer();

  GameModel() {
    _gameColorIndex = Random().nextInt(_gameColors.length);
  }

  String get currentThing => thingsLeft > 0 ? _wordsInRound.first : "EMPTY";
  int get thingsLeft => _wordsInRound.length;
  int get thingCount => _words.length;
  String get team1 => _team1;
  String get team2 => _team2;
  String get team => _team1Turn ? _team1 : _team2;
  Color get team1Color => _team1Color;
  Color get team2Color => _team2Color;
  //Instead of hardcoding team 1/2 pull the user defined team name.

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

  bool setTeamName(String name, bool isTeam1) {
    if (isTeam1 && _team2.toUpperCase() == name.toUpperCase()) {
      return false;
    }
    if (!isTeam1 && _team1.toUpperCase() == name.toUpperCase()) {
      return false;
    }

    if (isTeam1) {
      _team1 = name;
    } else {
      _team2 = name;
    }
    notifyListeners();
    return true;
  }

  bool setTeamColor(Color color, bool isTeam1) {
    if (isTeam1 && _team2Color == color) {
      return false;
    }
    if (!isTeam1 && _team1Color == color) {
      return false;
    }

    if (isTeam1) {
      _team1Color = color;
    } else {
      _team2Color = color;
    }
    notifyListeners();
    return true;
  }

  Map<Color, bool> getGameColors() {
    return {for (var c in _gameColors) c: c != _team1Color && c != _team2Color};
  }

  int get team1Score => _team1Score.fold(0, (prev, cur) => prev + cur);
  int get team2Score => _team2Score.fold(0, (prev, cur) => prev + cur);
  int roundScore(bool team1, int round) {
    return team1 ? _team1Score[round] : _team2Score[round];
  }

  void nextColor() {
    _gameColorIndex++;
    if (_gameColorIndex >= _gameColors.length) _gameColorIndex = 0;
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
          showRoundResults(context, false, true);
        }
      } else {
        notifyListeners();
      }
    }
  }

  void updateRound() {
    preventEvenThingCount().then((_) {
      _round++;
      _wordsInRound = [..._words];
      _wordsInRound.shuffle();
    });
  }

  void showRoundResults(BuildContext context, bool resetTimer, bool newRound) {
    countdownTimer.stopTimer(reset: resetTimer);

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
      countdownTimer.resetTimer();
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
}
