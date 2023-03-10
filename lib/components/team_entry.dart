import 'package:fish_bowl_game/providers/game_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TeamEntry extends StatefulWidget {
  final String Function() getTeamName;
  final Function(String val) setTeamName;
  final String Function() getOtherTeamName;
  final Map<Color, bool> Function() getColors;
  final Color Function() getTeamColor;
  final Function(Color val) setTeamColor;

  const TeamEntry(
      {super.key,
      required this.getTeamName,
      required this.setTeamName,
      required this.getOtherTeamName,
      required this.getColors,
      required this.getTeamColor,
      required this.setTeamColor});

  @override
  State<StatefulWidget> createState() => _TeamEntryState();
}

class _TeamEntryState extends State<TeamEntry> {
  final TextEditingController _textController = TextEditingController();
  bool _validInput = false;
  bool validateInput(String newVal, String oldVal) {
    return newVal.toUpperCase() != oldVal.toUpperCase();
  }

  void setTeamName() {
    widget.setTeamName(_textController.text);
    setState(() {
      _validInput = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _textController.text = widget.getTeamName();
    _textController.addListener(() {
      _validInput = validateInput(_textController.text, widget.getTeamName());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    GameModel gameModel = Provider.of<GameModel>(context, listen: false);
    return Container(
      //Border white rounded
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: widget.getTeamColor(),
            foregroundColor: Colors.white,
          ),
          Expanded(
            child: TextField(
              controller: _textController,
              textAlign: TextAlign.center,
              style: Theme.of(context).inputDecorationTheme.labelStyle,
              textAlignVertical: TextAlignVertical.center,
              decoration: const InputDecoration(
                hintText: 'Team Name',
              ),
            ),
          ),
          IconButton(
            onPressed: _validInput ? setTeamName : null,
            icon: const Icon(Icons.check),
          ),
        ],
      ),
    );
  }
}
