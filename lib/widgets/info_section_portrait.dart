import 'package:connect4/providers/board_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class InfoSectionPortrait extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<BoardModel>(builder: (context, boardModel, child) {
      return Container(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Column(
                children: <Widget>[
                  Text(
                    'Luigi',
                     style: TextStyle(fontSize: 15.0, color: Colors.red)),
                  Text(boardModel.p1Points.toString(), style: TextStyle(fontSize: 30.0, color: Colors.red)),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Column(
                children: <Widget>[
                  Text(boardModel.statusText, style: TextStyle(fontSize: 15.0, color: Colors.blue)),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.blue.shade900)),
                    child: Text("Reset"),
                    onPressed: () {
                      boardModel.resetGame();
                    },
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Column(
                children: <Widget>[
                  Text(displayPlayerComputerName(boardModel.isAgainstComputer), style: TextStyle(fontSize: 15.0, color: Colors.yellow)),
                  Text(boardModel.p2Points.toString(), style: TextStyle(fontSize: 30.0, color: Colors.yellow)),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

String displayPlayerComputerName(bool isComputer) {
  if(isComputer) return "Computer";
  else return "Mario";
}