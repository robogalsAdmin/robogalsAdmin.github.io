import 'package:flutter/material.dart';
import 'package:robogals/project_env.dart';

import '../models/level.dart';
import '../models/point.dart';
import 'item_page.dart';

/// This page displays the map of all the levels. It has some fairly
/// fiddley maths to align all the buttons, so this might be a little hard to follow
class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // Get the size of the screen
    Size size = MediaQuery.of(context).size;

    // Define the size of the image for the map
    const double imgH = 3256;
    const double imgW = 3780;

    // The width in pixels of the bubbles on the original image
    const double clickableSize = 170;

    // Get the ratios
    double widthOverHeight = imgW/imgH;
    double heightOverWidth = imgH/imgW;

    // Determine if we are fitting the image based on its height or width
    bool fitHeight = size.height*widthOverHeight < size.width;

    // The size of the map image once fitted to the screen
    late double mapHeight;
    late double mapWidth;

    // The offset from the edge of the screen to the map image
    double xOffset = 0;
    double yOffset = 0;

    if (fitHeight) {
      mapHeight = size.height;
      mapWidth = size.height * widthOverHeight;
      xOffset = (size.width - mapWidth) / 2;
    } else {
      mapHeight = size.width * heightOverWidth;
      mapWidth = size.width;
      yOffset = (size.height - mapHeight) / 2;
    }

    /// Scales the size of the clickable [Material] Widgets
    double w = fitHeight ? mapWidth * (clickableSize / imgW) : mapHeight * (clickableSize / imgH);

    // Iterate through each of the levels and place a positioned widget for each level
    List<Widget> levels = ProjectEnv.levels.map((Level level) {

      // As the level point is just a percentage, multiply with the size of the map
      // by the percentage point object in the level
      Point p =
          (level.point ?? Point(0.5, 0.5)).multX(mapWidth).multY(mapHeight);

      return Positioned(
        // offset the level by offsets
        top: p.y + yOffset - (w / 2),
        left: p.x + xOffset - (w / 2),
        width: w,
        height: w,
        child: Material(
          // Cut anything not in the circle border
          clipBehavior: Clip.hardEdge,
          color: Colors.transparent,
          // 1000 means it will always be circular unless you have a massive screen
          borderRadius: BorderRadius.circular(1000),
          // InkResponse is an interactable component that can be any shape
          child: InkResponse(
            radius: 100,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ItemPage(level: level))),
            child: Container(
              decoration: BoxDecoration(
                color: Color(
                  int.parse(
                      level.colorString.replaceFirst(
                          "#", ProjectEnv.showAlignmentGuide ? "55" : "00"),
                      radix: 16),
                ),
                borderRadius: BorderRadius.circular(1000),
                border: ProjectEnv.showAlignmentGuide
                    ? Border.all(color: Colors.red)
                    : null,
              ),
            ),
          ),
        ),
      );
    }).toList();

    List<Widget> children = [
      Image.asset(
        ProjectEnv.backgroundPath,
        fit: BoxFit.fill,
        width: size.width,
        height: size.height,
      ),
      Image.asset(
        ProjectEnv.mapPath,
        height: mapHeight,
        width: mapWidth,
        fit: BoxFit.contain,
      ),
    ];
    children.addAll(levels);

    if (ProjectEnv.showAlignmentGuide) {
      children.addAll(_gridLines(size, mapWidth, mapHeight, xOffset, yOffset));
    }

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: children,
      ),
    );
  }

  /// Draw the gridlines for the alignment
  List<Widget> _gridLines(Size size, double mapWidth, double mapHeight,
      double xOffset, double yOffset) {
    List<Widget> lines = [];
    for (int i = 0; i < 100; i++) {
      double x = (mapWidth * (i / 100)) + xOffset;
      double y = (mapHeight * (i / 100)) + yOffset;
      lines.add(
        Positioned(
          top: 0,
          left: x,
          child: Container(
            color: const Color(0x44000000),
            width: i % 10 == 0 ? 2 : 1,
            height: size.height,
          ),
        ),
      );
      lines.add(
        Positioned(
          top: y,
          left: 0,
          child: Container(
            color: Colors.black,
            height: i % 10 == 0 ? 2 : 1,
            width: size.width,
          ),
        ),
      );
    }
    return lines;
  }
}
