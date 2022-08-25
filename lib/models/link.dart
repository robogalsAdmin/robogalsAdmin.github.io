
import 'package:json_annotation/json_annotation.dart';

part 'link.g.dart';

/// Represents a url to an external Resource on the resources page.
/// Stores the actual url, and also a name to show
@JsonSerializable()
class Link {

  /// The name of this resource
  final String name;

  /// The url to this resource
  final String url;

  Link(this.name, this.url);

  factory Link.fromJson(Map<String, dynamic> json) => _$LinkFromJson(json);
  Map<String, dynamic> toJson() => _$LinkToJson(this);
}