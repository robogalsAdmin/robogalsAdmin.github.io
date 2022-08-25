import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:robogals/models/point.dart';
import 'package:robogals/models/resource.dart';
part 'level.g.dart';

/// Represents a "Level" on the map.
/// Stores the level's Color information, name, position on the map
/// and activities/resources/video.
@JsonSerializable()
class Level {

  /// The id of the level. Really only used to
  /// identify the general STEM level
  final int id;

  /// An actual [Color] object representing the
  /// string stored in [colorString]
  @JsonKey(ignore: true)
  late final Color color;

  /// Defines where the interactable [InkResponse] object
  /// sits on the map page. This should be treated as percentages, so (x:0.3,y:0.5) means
  /// 30% across the map, %50 down.
  /// <br/>
  /// If null, defaults to (0.5,0.5)
  final Point? point;

  /// The name of the level
  final String label;

  /// A string representation of the Colour of the level,
  /// in the format #RRGGBB
  final String colorString;

  /// The name of the icon png displayed on the top right
  /// of the item screen
  final String iconString;

  /// A youtube video id for the video for this page
  final String video;

  /// Stores the [Link]s for the external Resource and Videos on the Resources page
  final Resource resources;

  /// A list of the pdf files that should show up as activities for this page.
  final List<String> activities;


  Level(this.id, this.label, this.colorString, this.iconString, this.video, this.resources, this.activities, this.point) {
    /// Convert [colorString] to an actual [Color] object
    color = Color(int.parse( colorString.replaceFirst("#", "ff"), radix:16));
  }

  factory Level.fromJson(Map<String, dynamic> json) => _$LevelFromJson(json);
  Map<String, dynamic> toJson() => _$LevelToJson(this);
}
