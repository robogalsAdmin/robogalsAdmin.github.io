
import 'package:json_annotation/json_annotation.dart';

part 'point.g.dart';

/// A 2d Point
@JsonSerializable()
class Point {
  double x;
  double y;

  Point(this.x, this.y);

  /// Returns a new [Point] where [x] has been multiplied by [v].
  Point multX(double v) {
    return Point(x*v, y);
  }

  /// Returns a new [Point] where [y] has been multiplied by [v].
  Point multY(double v) {
    return Point(x, y*v);
  }

  factory Point.fromJson(Map<String, dynamic> json) => _$PointFromJson(json);
  Map<String, dynamic> toJson() => _$PointToJson(this);
}
