// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'benefit_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BenefitCategory _$BenefitCategoryFromJson(Map<String, dynamic> json) => BenefitCategory(
      title: json['title'] as String,
      description: json['description'] as String?,
      emoji: json['emoji'] as String,
      benefits:
          (json['benefits'] as List<dynamic>).map((e) => BenefitItem.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$BenefitCategoryToJson(BenefitCategory instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'emoji': instance.emoji,
      'benefits': instance.benefits,
    };
