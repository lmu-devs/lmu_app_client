// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'benefit_type_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BenefitTypeDto _$BenefitTypeDtoFromJson(Map<String, dynamic> json) => BenefitTypeDto(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      emoji: json['emoji'] as String,
      benefitIds: (json['benefit_ids'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$BenefitTypeDtoToJson(BenefitTypeDto instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'emoji': instance.emoji,
      'benefit_ids': instance.benefitIds,
    };
