import 'package:flutter/material.dart';
import 'package:robogals/pages/splash_screen.dart';

void main() {
  runApp(const RobogalsApp());
}

class RobogalsApp extends StatelessWidget {
  const RobogalsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        themeMode: ThemeMode.light,
        title: "Robogals",
        theme: ThemeData(
          primarySwatch: Colors.blue
        ),
        home: const SplashScreenPage());
  }
}
