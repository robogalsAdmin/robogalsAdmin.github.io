import 'package:flutter/material.dart';
import 'package:robogals/project_env.dart';
import 'package:robogals/utils/pageutils.dart';
import '../models/level.dart';

/// Displays the activites for level
class ActivitiesPage extends StatelessWidget {
  final Level level;

  const ActivitiesPage({Key? key, required this.level}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (level.activities.isEmpty) {
      return const Center(child: Text("No activities for this section!"));
    } else {
      List<Widget> children = [];
      int index = 1;
      for (String activity in level.activities) {
        children.add(ListTile(
          leading: Text(
            "${index++}",
            style: Theme.of(context).textTheme.headline4,
          ),
          title: Text(_formatTitle(activity)),
          onTap: () async => launchExternal(
            "${ProjectEnv.pdfUrl}$activity",
            context,
          ),
        ));
      }

      return ListView.builder(
        itemCount: children.length,
        itemBuilder: ((context, index) => children[index]),
      );
    }
  }

  /// Format the filename into a level title
  String _formatTitle(String filename) {
    return filename
        .replaceAll(".pdf", "")
        .replaceAll("_", " ")
        .replaceAll(RegExp(r".*?[0-9]{1}\-{1}"), "");
  }
}
