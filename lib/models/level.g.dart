// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Level _$LevelFromJson(Map<String, dynamic> json) => Level(
      json['id'] as int,
      json['label'] as String,
      json['colorString'] as String,
      json['iconString'] as String,
      json['video'] as String,
      Resource.fromJson(json['resources'] as Map<String, dynamic>),
      (json['activities'] as List<dynamic>).map((e) => e as String).toList(),
      json['point'] == null
          ? null
          : Point.fromJson(json['point'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LevelToJson(Level instance) => <String, dynamic>{
      'point': instance.point,
      'label': instance.label,
      'colorString': instance.colorString,
      'iconString': instance.iconString,
      'video': instance.video,
      'resources': instance.resources,
      'id': instance.id,
      'activities': instance.activities,
    };
