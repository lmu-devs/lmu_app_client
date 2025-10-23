// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sports_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SportsModel _$SportsModelFromJson(Map<String, dynamic> json) => SportsModel(
      sportTypes: (json['sport_types'] as List<dynamic>)
          .map((e) => SportsType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SportsModelToJson(SportsModel instance) =>
    <String, dynamic>{
      'sport_types': instance.sportTypes,
    };
