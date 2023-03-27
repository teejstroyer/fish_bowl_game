import 'package:fish_bowl_game/components/gridview_item.dart';
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
    var gameColors = gameModel.getGameColors().keys;
    var isNotUsedValues = gameModel.getGameColors();
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.circle),
          color: widget.getTeamColor(),
          iconSize: 40,
          onPressed: () {
            showDialog(
              context: context,
              builder: ((context) {
                return AlertDialog(
                  actions: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          color: Colors.black,
                          iconSize: 48.0,
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ],
                  content: Container(
                    height: MediaQuery.of(context).size.height * 0.9,
                    width: MediaQuery.of(context).size.width * 0.9,
                    color: Colors.white,
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: gameColors.length,
                      itemBuilder: (BuildContext context, index) {
                        var isNotUsed =
                            (isNotUsedValues[gameColors.elementAt(index)] ??
                                false);
                        var color = gameColors.elementAt(index);
                        return SizedBox(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Material(
                              color: isNotUsed ? color : color.withOpacity(.4),
                              child: InkWell(
                                onTap: isNotUsed
                                    ? () {
                                        widget.setTeamColor(color);
                                        Navigator.of(context).pop();
                                      }
                                    : null,
                              ),
                            ),
                          ),
                        );
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                    ),
                  ),
                );
              }),
            ).then((value) => setState(() {}));
          },
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
    );
  }
}
