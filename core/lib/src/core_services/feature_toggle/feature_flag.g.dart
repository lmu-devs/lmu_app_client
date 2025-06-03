// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature_flag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeatureFlag _$FeatureFlagFromJson(Map<String, dynamic> json) => FeatureFlag(
      id: json['id'] as String,
      isActive: json['enabled'] as bool,
    );

Map<String, dynamic> _$FeatureFlagToJson(FeatureFlag instance) => <String, dynamic>{
      'id': instance.id,
      'enabled': instance.isActive,
    };
