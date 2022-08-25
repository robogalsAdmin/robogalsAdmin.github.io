import 'dart:math';

import 'package:robogals/pages/resources_page.dart';
import 'package:robogals/pages/video_page.dart';
import 'package:flutter/material.dart';
import 'package:robogals/models/level.dart';
import 'package:robogals/project_env.dart';
import 'package:robogals/utils/pageutils.dart';

import 'activities_page.dart';

/// This page contains the [TabController] for each level,
/// and handles swapping between the video, resources, and activities page
class ItemPage extends StatefulWidget {
  final Level level;
  const ItemPage({Key? key, required this.level}) : super(key: key);
  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [_tab("Resources")];
    List<Widget> pages = [_page(ResourcesPage(level: widget.level))];
    int tabCount = 1;

    /// As general stem only has resources, if it is not general stem,
    /// add the other pages and tabs
    if (widget.level.id != ProjectEnv.generalStemId) {
      tabCount = 3;
      tabs.insert(0, _tab("Video"));
      tabs.add(_tab("Activities"));
      pages.insert(0, VideoPage(level: widget.level));
      pages.add(_page(ActivitiesPage(level: widget.level)));
    }

    return DefaultTabController(
      length: tabCount,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: widget.level.color,
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: tabs,
          ),
          title: Text(widget.level.label),
          actions: [
            Image.asset("${ProjectEnv.imagePath}${widget.level.iconString}")
          ],
        ),
        body: TabBarView(
          children: pages,
        ),
      ),
    );
  }

  /// Helper function to make the tabs
  Widget _tab(String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Text(name),
    );
  }

  Widget _page(Widget p) {
    return Column(
      children: [
        Expanded(child:p),
        SizedBox(
          height: max(MediaQuery.of(context).size.height*0.1,120),
          child: governmentAck(context),
        ),
      ],
    );
  }
}
