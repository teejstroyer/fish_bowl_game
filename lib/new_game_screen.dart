import 'package:fish_bowl_game/game_model.dart';
import 'package:fish_bowl_game/game_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewGameScreen extends StatefulWidget {
  const NewGameScreen({super.key});

  @override
  State<NewGameScreen> createState() => _NewGameScreenState();
}

class _NewGameScreenState extends State<NewGameScreen> {
  final List<String> _things = [];

  @override
  Widget build(BuildContext context) {
    var textController = TextEditingController();
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.pink,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  getPlayerThings(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          top: 0,
                          right: 20,
                          bottom: 0,
                        ),
                        child: TextField(
                          controller: textController,
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).inputDecorationTheme.labelStyle,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: const InputDecoration(
                            hintText: 'PERSON PLACE THING',
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          if (textController.text.isNotEmpty) {
                            setState(() {
                              _things.add(
                                  textController.text.trim().toUpperCase());
                              textController.clear();
                            });
                          }
                        },
                        child: const Text("ADD"),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: submitList,
                          child: const Text("NEXT PLAYER"),
                        ),
                        TextButton(
                          onPressed: startGame,
                          child: const Text("START GAME"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: SafeArea(
              child: Container(
                color: Colors.transparent,
                child: Consumer<GameModel>(
                  builder: (context, model, child) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("${model.thingCount} total",
                                textAlign: TextAlign.right),
                            Text("${_things.length}",
                                textAlign: TextAlign.right),
                          ]),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void submitList() {
    Provider.of<GameModel>(context, listen: false).addMany(_things);
    setState(() {
      _things.clear();
    });
  }

  void startGame() {
    submitList();
    Provider.of<GameModel>(context, listen: false).startRound();

    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const GameScreen()),
    );

  }

  Widget getPlayerThings() {
    return Expanded(
      child: ShaderMask(
        shaderCallback: (rect) {
          return LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black,
              Colors.black.withOpacity(.5),
              Colors.black.withOpacity(.1),
              Colors.transparent,
            ],
          ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
        },
        blendMode: BlendMode.dstIn,
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 20,
                height: (MediaQuery.of(context).size.height) / 2.8,
              ),
              ..._things.map((i) => createPlayerThing(i))
            ],
          ),
        ),
      ),
    );
  }

  Widget createPlayerThing(String text) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            IconButton(
              onPressed: () => setState(() {
                _things.remove(text);
              }),
              icon: const Icon(Icons.close),
            ),
            Flexible(
              child: Text(
                text,
                textAlign: TextAlign.left,
                style: Theme.of(context).primaryTextTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
