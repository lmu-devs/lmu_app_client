// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sports_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SportsModel _$SportsModelFromJson(Map<String, dynamic> json) => SportsModel(
      baseUrl: json['base_url'] as String,
      basicTicket: SportsType.fromJson(json['basic_ticket'] as Map<String, dynamic>),
      sportTypes:
          (json['sport_types'] as List<dynamic>).map((e) => SportsType.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$SportsModelToJson(SportsModel instance) => <String, dynamic>{
      'base_url': instance.baseUrl,
      'basic_ticket': instance.basicTicket,
      'sport_types': instance.sportTypes,
    };
