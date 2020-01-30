import 'package:connect4/model/piece_state.dart';
import 'package:connect4/providers/board_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Circle extends StatelessWidget {
  final int position;
  final int columnNr;
  Circle({@required this.position, @required this.columnNr});

  @override
  Widget build(BuildContext context) {
    return Consumer<BoardModel>(builder: (context, boardModel, child) {
      var state = boardModel.getPositionState(position);
      return Expanded(
        child: GestureDetector(
          onTap: () {
              boardModel.makeMove(columnNr);
          },
          child: Container(
            margin: EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: getBackgroundColor(state),
              border: getBorder(state),
            ),
          ),
        ),
      );
    });
  }

  Color getBackgroundColor(PieceState state) {
    switch (state) {
      case PieceState.player1:
        return Colors.red;
      case PieceState.player2:
        return Colors.yellow;
      case PieceState.winner1:
         return Colors.red;
      case PieceState.winner2:
       return Colors.yellow;
      case PieceState.empty:
        return Colors.black87;
      default:
        return Colors.black87;
    }
  }

  Border getBorder(PieceState state) {
    switch (state) {
      case PieceState.winner1:
        return Border.all(
          color: Colors.red.shade100,
          width: 5.0,
        );
      case PieceState.winner2:
        return Border.all(
          color: Colors.white,
          width: 5.0,
        );
      default:
        return Border.all(
          color: Colors.white38,
          width: 1.0,
        );
    }
  }
}
