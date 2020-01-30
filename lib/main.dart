import 'package:connect4/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Connect 4',
      theme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}
