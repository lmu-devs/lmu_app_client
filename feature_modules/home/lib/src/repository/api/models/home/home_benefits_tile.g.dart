// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_benefits_tile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeBenefitsTile _$HomeBenefitsTileFromJson(Map<String, dynamic> json) => HomeBenefitsTile(
      size: (json['size'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String?,
      data: json['data'] as String?,
    );

Map<String, dynamic> _$HomeBenefitsTileToJson(HomeBenefitsTile instance) => <String, dynamic>{
      'size': instance.size,
      'title': instance.title,
      'description': instance.description,
      'data': instance.data,
    };
