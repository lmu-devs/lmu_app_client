// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'benefits_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BenefitsDto _$BenefitsDtoFromJson(Map<String, dynamic> json) => BenefitsDto(
      benefitTypes: (json['benefit_types'] as List<dynamic>)
          .map((e) => BenefitTypeDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      benefits: (json['benefits'] as List<dynamic>).map((e) => BenefitDto.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$BenefitsDtoToJson(BenefitsDto instance) => <String, dynamic>{
      'benefit_types': instance.benefitTypes.map((e) => e.toJson()).toList(),
      'benefits': instance.benefits.map((e) => e.toJson()).toList(),
    };
