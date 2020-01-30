import 'package:connect4/widgets/info_section_landscape.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'circle.dart';
import 'drop_circle_button.dart';

class GameLandscape extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          InfoSectionLandscape(),
          AspectRatio(
            aspectRatio: 7 / 7,
            child: Container(
              color: Colors.blue.shade900,
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          DropCircleButton(
                            columnNr: 1,
                          ),
                          Circle(position: 5, columnNr: 1),
                          Circle(position: 4, columnNr: 1),
                          Circle(position: 3, columnNr: 1),
                          Circle(position: 2, columnNr: 1),
                          Circle(position: 1, columnNr: 1),
                          Circle(position: 0, columnNr: 1),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          DropCircleButton(
                            columnNr: 2,
                          ),
                          Circle(position: 11, columnNr: 2),
                          Circle(position: 10, columnNr: 2),
                          Circle(position: 9, columnNr: 2),
                          Circle(position: 8, columnNr: 2),
                          Circle(position: 7, columnNr: 2),
                          Circle(position: 6, columnNr: 2),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          DropCircleButton(
                            columnNr: 3,
                          ),
                          Circle(position: 17, columnNr: 3),
                          Circle(position: 16, columnNr: 3),
                          Circle(position: 15, columnNr: 3),
                          Circle(position: 14, columnNr: 3),
                          Circle(position: 13, columnNr: 3),
                          Circle(position: 12, columnNr: 3),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          DropCircleButton(
                            columnNr: 4,
                          ),
                          Circle(position: 23, columnNr: 4),
                          Circle(position: 22, columnNr: 4),
                          Circle(position: 21, columnNr: 4),
                          Circle(position: 20, columnNr: 4),
                          Circle(position: 19, columnNr: 4),
                          Circle(position: 18, columnNr: 4),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          DropCircleButton(
                            columnNr: 5,
                          ),
                          Circle(position: 29, columnNr: 5),
                          Circle(position: 28, columnNr: 5),
                          Circle(position: 27, columnNr: 5),
                          Circle(position: 26, columnNr: 5),
                          Circle(position: 25, columnNr: 5),
                          Circle(position: 24, columnNr: 5),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          DropCircleButton(
                            columnNr: 6,
                          ),
                          Circle(position: 35, columnNr: 6),
                          Circle(position: 34, columnNr: 6),
                          Circle(position: 33, columnNr: 6),
                          Circle(position: 32, columnNr: 6),
                          Circle(position: 31, columnNr: 6),
                          Circle(position: 30, columnNr: 6),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          DropCircleButton(
                            columnNr: 7,
                          ),
                          Circle(position: 41, columnNr: 7),
                          Circle(position: 40, columnNr: 7),
                          Circle(position: 39, columnNr: 7),
                          Circle(position: 38, columnNr: 7),
                          Circle(position: 37, columnNr: 7),
                          Circle(position: 36, columnNr: 7),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
