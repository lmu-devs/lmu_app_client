// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_featured.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeFeatured _$HomeFeaturedFromJson(Map<String, dynamic> json) => HomeFeatured(
      id: json['id'] as String,
      title: json['title'] as String,
      priority: (json['priority'] as num).toInt(),
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      url: json['url'] as String?,
      urlType: $enumDecodeNullable(_$HomeUrlTypeEnumMap, json['urlType']),
      startDate: json['startDate'] == null ? null : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null ? null : DateTime.parse(json['endDate'] as String),
    );

Map<String, dynamic> _$HomeFeaturedToJson(HomeFeatured instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'url': instance.url,
      'urlType': _$HomeUrlTypeEnumMap[instance.urlType],
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'priority': instance.priority,
    };

const _$HomeUrlTypeEnumMap = {
  HomeUrlType.interal: 'INTERNAL',
  HomeUrlType.external: 'EXTERNAL',
};
