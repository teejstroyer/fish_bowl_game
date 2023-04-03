import 'dart:math';

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
    var randomColor = gameColors.elementAt(Random().nextInt(gameColors.length));

    return Row(
      children: [
        Container(
          height: Theme.of(context).inputDecorationTheme.labelStyle!.fontSize,
          width: Theme.of(context).inputDecorationTheme.labelStyle!.fontSize,
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.all(0),
          padding: const EdgeInsets.all(0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(width: 2, color: Colors.white)),
          child: Material(
            shape: const CircleBorder(),
            color: widget.getTeamColor(),
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: ((context) {
                    return AlertDialog(
                      actions: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              color: randomColor,
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
                        constraints: const BoxConstraints(
                          maxHeight: 400,
                          maxWidth: 400,
                          minWidth: 200,
                          minHeight: 200,
                        ),
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
                                  borderRadius: BorderRadius.circular(5),
                                  color:
                                      isNotUsed ? color : color.withOpacity(.4),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: color,
                                        width: 3,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
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
          ),
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
