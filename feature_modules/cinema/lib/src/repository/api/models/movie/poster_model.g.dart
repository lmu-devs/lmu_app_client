// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poster_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PosterModel _$PosterModelFromJson(Map<String, dynamic> json) => PosterModel(
      url: json['url'] as String,
      name: json['name'] as String,
      blurHash: json['blurhash'] as String?,
    );

Map<String, dynamic> _$PosterModelToJson(PosterModel instance) => <String, dynamic>{
      'url': instance.url,
      'name': instance.name,
      'blurhash': instance.blurHash,
    };
