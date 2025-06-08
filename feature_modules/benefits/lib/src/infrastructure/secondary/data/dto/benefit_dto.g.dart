// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'benefit_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BenefitDto _$BenefitDtoFromJson(Map<String, dynamic> json) => BenefitDto(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      url: json['url'] as String,
      faviconUrl: json['favicon_url'] as String,
      image: json['image'] == null ? null : ImageDto.fromJson(json['image'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BenefitDtoToJson(BenefitDto instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'favicon_url': instance.faviconUrl,
      'image': instance.image?.toJson(),
    };
