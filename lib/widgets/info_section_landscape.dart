import 'package:connect4/providers/board_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class InfoSectionLandscape extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<BoardModel>(builder: (context, boardModel, child) {
      Widget getStatusText () {
        if(boardModel.statusText != "") {
          return Text(boardModel.statusText, style: TextStyle(fontSize: 15.0, color: Colors.blue));
        }
        else {
          return Wrap();
        }
      }
      return Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('Luigi: ' + boardModel.p1Points.toString(),
                    style: TextStyle(fontSize: 20.0, color: Colors.red)),
              ],
            ),
            Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
               getStatusText(),
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
                )
         
              ],
            ),
            Row(
              children: <Widget>[
                Text(displayPlayerComputerName(boardModel.isAgainstComputer) + ": " + boardModel.p2Points.toString(),
                    style: TextStyle(fontSize: 20.0, color: Colors.yellow)),
              ],
            ),
          ],
        ),
      );
    });
  }
}

String displayPlayerComputerName(bool isComputer) {
  if (isComputer)
    return "Computer";
  else
    return "Mario";
}
