
import 'package:json_annotation/json_annotation.dart';

import 'link.dart';
part 'resource.g.dart';

/// Stores a list of [Link]s to all the vidoes and sites
/// used on the resources page.
@JsonSerializable()
class Resource {
  final List<Link> videos;
  final List<Link> sites;
  Resource(this.videos, this.sites);

  factory Resource.fromJson(Map<String, dynamic> json) => _$ResourceFromJson(json);
  Map<String, dynamic> toJson() => _$ResourceToJson(this);
}