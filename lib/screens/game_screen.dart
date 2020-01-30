import 'package:connect4/providers/board_model.dart';
import 'package:connect4/widgets/game_landscape.dart';
import 'package:connect4/widgets/game_portrait.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatelessWidget {
  final bool playerVsPC;
  GameScreen({@required this.playerVsPC});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game'),
      ),
      body: OrientationBuilder(builder: (context, orientation) {
        return ChangeNotifierProvider<BoardModel>(
          builder: (_) => BoardModel(isAgainstComputer: playerVsPC),
          child: orientation == Orientation.portrait ? GamePortrait() : GameLandscape(),
        );
      }),
    );
  }
}
