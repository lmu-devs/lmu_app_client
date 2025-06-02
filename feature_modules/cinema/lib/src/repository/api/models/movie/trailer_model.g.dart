// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trailer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrailerModel _$TrailerModelFromJson(Map<String, dynamic> json) => TrailerModel(
      id: json['id'] as String,
      title: json['title'] as String,
      publishedAt: DateTime.parse(json['published_at'] as String),
      url: json['url'] as String,
      thumbnail: PosterModel.fromJson(json['thumbnail'] as Map<String, dynamic>),
      site: json['site'] as String,
    );

Map<String, dynamic> _$TrailerModelToJson(TrailerModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'published_at': instance.publishedAt.toIso8601String(),
      'url': instance.url,
      'thumbnail': instance.thumbnail,
      'site': instance.site,
    };
