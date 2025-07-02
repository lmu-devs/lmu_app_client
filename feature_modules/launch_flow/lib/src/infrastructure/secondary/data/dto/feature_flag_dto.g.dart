// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature_flag_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeatureFlagDto _$FeatureFlagDtoFromJson(Map<String, dynamic> json) => FeatureFlagDto(
      id: json['id'] as String,
      isActive: json['enabled'] as bool,
    );

Map<String, dynamic> _$FeatureFlagDtoToJson(FeatureFlagDto instance) => <String, dynamic>{
      'id': instance.id,
      'enabled': instance.isActive,
    };
