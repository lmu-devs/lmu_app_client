// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AreaModel _$AreaModelFromJson(Map<String, dynamic> json) => AreaModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      openingHours: (json['opening_hours'] as List<dynamic>?)
          ?.map((e) => OpeningHoursModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AreaModelToJson(AreaModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'opening_hours': instance.openingHours,
    };
