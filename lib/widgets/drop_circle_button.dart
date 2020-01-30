import 'package:connect4/model/piece_state.dart';
import 'package:connect4/providers/board_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DropCircleButton extends StatelessWidget {
  final int columnNr;
  DropCircleButton({@required this.columnNr});

  @override
  Widget build(BuildContext context) {
    return Consumer<BoardModel>(builder: (context, boardModel, child) {
      var color = boardModel.playerTurn == PieceState.player1 ? Colors.red : Colors.yellow;
      return IconButton(
        icon: Icon(Icons.blur_circular, color: color),
        onPressed: () {
            boardModel.makeMove(columnNr);
        },
      );
    });
  }
}
