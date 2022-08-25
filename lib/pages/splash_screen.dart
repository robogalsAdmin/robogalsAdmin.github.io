import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:robogals/models/level.dart';
import 'package:robogals/pages/map_page.dart';
import 'package:robogals/project_env.dart';

/// Once all the assets are loaded, or 2 seconds have passed (Whichever happens SECOND), moves to the next page.
class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);
  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  /// Are we still loading assets?
  bool loading = true;

  /// Have two seconds passed?
  bool timerDone = false;

  @override
  void initState() {
    super.initState();
    Future<String> loadAsset() async {
      return await rootBundle.loadString(ProjectEnv.levelJson);
    }

    Timer(const Duration(seconds: 2), (() {
      /// If all assets are loaded, push to the next page
      if (!loading) _push(context);
      timerDone = true;
    }));

    /// Load the assets into [ProjectEnv.levels]
    loadAsset().then((file) async {
      List<Level> levels = [];
      for (var level in jsonDecode(file)["levels"]) {
        levels.add(Level.fromJson(level));
      }
      setState(() {
        ProjectEnv.levels = levels;
      });
      loading = false;

      /// if the timer is done, push to the next page
      if (timerDone) _push(context);
    });
  }

  /// Helper function for pushing to the map page
  void _push(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const MapPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Image.asset(
        ProjectEnv.splashscreenPath,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      ),
    );
  }
}
