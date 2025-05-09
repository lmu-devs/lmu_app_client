// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'benefit_category_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BenefitCategoryDto _$BenefitCategoryDtoFromJson(Map<String, dynamic> json) => BenefitCategoryDto(
      title: json['title'] as String,
      emoji: json['emoji'] as String,
      benefits: (json['benefits'] as List<dynamic>).map((e) => BenefitDto.fromJson(e as Map<String, dynamic>)).toList(),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$BenefitCategoryDtoToJson(BenefitCategoryDto instance) => <String, dynamic>{
      'title': instance.title,
      'emoji': instance.emoji,
      'benefits': instance.benefits,
      'description': instance.description,
    };
