// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'benefit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BenefitModel _$BenefitModelFromJson(Map<String, dynamic> json) => BenefitModel(
      title: json['title'] as String,
      description: json['description'] as String,
      url: json['url'] as String,
      faviconUrl: json['favicon_url'] as String,
      imageUrl: json['image_url'] as String?,
      aliases:
          (json['aliases'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$BenefitModelToJson(BenefitModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'favicon_url': instance.faviconUrl,
      'image_url': instance.imageUrl,
      'aliases': instance.aliases,
    };
