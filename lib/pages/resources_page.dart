import 'package:flutter/material.dart';
import 'package:robogals/utils/pageutils.dart';
import '../models/level.dart';
import '../models/link.dart';

//This page shows the external resources for a level.
class ResourcesPage extends StatelessWidget {
  final Level level;
  const ResourcesPage({Key? key, required this.level}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    // Create the header and then add each resource from each section
    if (level.resources.sites.isNotEmpty) {
      children.add(sectionHeader("Sites",level.color));
      children.addAll(level.resources.sites.map((e) => _tile(e, context)));
    }

    if (level.resources.videos.isNotEmpty) {
      children.add(sectionHeader("Videos",level.color));
      children.addAll(level.resources.videos.map((e) => _tile(e, context)));
    }

    return children.isNotEmpty
        ? ListView.builder(
            itemCount: children.length,
            itemBuilder: ((context, index) {
              return children[index];
            }))
        : const Center(
            child: Text("No resources for this section!"),
          );
  }



  /// Creates the list tile for each link
  Widget _tile(Link link, BuildContext context) {
    return ListTile(
      trailing: const Icon(Icons.link),
      title: Text(link.name),
      onTap: () => launchExternal(link.url, context),
    );
  }
}
