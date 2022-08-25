import 'dart:math';

import 'package:flutter/material.dart';
import 'package:robogals/project_env.dart';
import 'package:url_launcher/url_launcher.dart';

/// Tries to open [url] in a new tab. Displays a snackbar if it fails
void launchExternal(String url, BuildContext context) async {
  if (!await launchUrl(Uri.parse(url))) {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to load url!\nTry again later")));
  }
}

/// Renders a section header, used for resources and activity pages
Widget sectionHeader(String title, Color color) {
  return ListTile(
    tileColor: color,
    textColor: Colors.white,
    title: Text(
      title,
      textAlign: TextAlign.center,
    ),
  );
}

/// Creates the government acknowledgement displayed on the activities and resources page
Widget governmentAck(BuildContext context) {
  const double pad = 12.0;
  const double space = 12.0;

  double width = MediaQuery.of(context).size.width;
  double height = width >= 530 ? max(MediaQuery.of(context).size.height * 0.1, 200) : width * 0.15;
  double ackWidth = width * 0.5;

  Widget out = Container(
    color: Colors.grey[200],
    padding: const EdgeInsets.all(pad),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: space),
              child: Image.asset(
                ProjectEnv.governmentStackedPath,
                height: height,
              ),
            ),
            Container(
              constraints: BoxConstraints(maxWidth: ackWidth),
              child: const FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  ProjectEnv.acknowledgement,
                  style: TextStyle(fontSize: 17),
                ),
              ),
            )
          ],
        ),
        Material(
          color: Colors.grey[200],
          child: InkWell(
            child: Image.asset(
              ProjectEnv.logoPath,
              height: height,
            ),
            onTap: (() => launchExternal("https://robogals.org", context)),
          ),
        ),
      ],
    ),
  );

  return out;
}
