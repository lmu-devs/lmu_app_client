// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LinkModel _$LinkModelFromJson(Map<String, dynamic> json) => LinkModel(
      title: json['title'] as String,
      description: json['description'] as String,
      url: json['url'] as String,
      faviconUrl: json['favicon_url'] as String?,
      types: (json['types'] as List<dynamic>).map((e) => e as String).toList(),
      aliases: (json['aliases'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$LinkModelToJson(LinkModel instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'favicon_url': instance.faviconUrl,
      'types': instance.types,
      'aliases': instance.aliases,
    };
