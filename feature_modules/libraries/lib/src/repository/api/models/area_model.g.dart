// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'area_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AreaModel _$AreaModelFromJson(Map<String, dynamic> json) => AreaModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      openingHours: json['opening_hours'] == null
          ? null
          : OpeningHoursModel.fromJson(
              json['opening_hours'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AreaModelToJson(AreaModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'opening_hours': instance.openingHours,
    };
