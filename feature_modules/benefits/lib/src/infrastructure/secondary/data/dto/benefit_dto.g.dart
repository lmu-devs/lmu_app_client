// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'benefit_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BenefitDto _$BenefitDtoFromJson(Map<String, dynamic> json) => BenefitDto(
      title: json['title'] as String,
      description: json['description'] as String,
      url: json['url'] as String,
      aliases: (json['aliases'] as List<dynamic>).map((e) => e as String).toList(),
      faviconUrl: json['favicon_url'] as String?,
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$BenefitDtoToJson(BenefitDto instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'aliases': instance.aliases,
      'favicon_url': instance.faviconUrl,
      'image_url': instance.imageUrl,
    };
