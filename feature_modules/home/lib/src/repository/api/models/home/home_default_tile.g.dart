// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_default_tile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeDefaultTile _$HomeDefaultTileFromJson(Map<String, dynamic> json) => HomeDefaultTile(
      size: (json['size'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String?,
      data: json['data'] as List<dynamic>?,
      type: $enumDecode($HomeTileTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$HomeDefaultTileToJson(HomeDefaultTile instance) => <String, dynamic>{
      'size': instance.size,
      'title': instance.title,
      'description': instance.description,
      'data': instance.data?.map((e) => e is HomeTile ? e.toJson() : e).toList(),
      'type': $HomeTileTypeEnumMap[instance.type],
    };
