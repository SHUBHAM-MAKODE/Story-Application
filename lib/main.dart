import 'package:app27/AnimatedSplashScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(StoryApp());
}

class StoryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Story App',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: FirstScreen(),
    );
  }
}
