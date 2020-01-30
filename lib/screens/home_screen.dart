import 'package:connect4/screens/game_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                'CONNECT 4',
                style: TextStyle(fontSize: 40),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: RaisedButton(
                child: Text('Player vs Player'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GameScreen(playerVsPC: false,)),
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: RaisedButton(
                child: Text('Player vs Computer'),
                onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GameScreen(playerVsPC: true,)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
