// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equipment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EquipmentModel _$EquipmentModelFromJson(Map<String, dynamic> json) =>
    EquipmentModel(
      title: json['title'] as String,
      type: json['type'] as String,
      url: json['url'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$EquipmentModelToJson(EquipmentModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'url': instance.url,
      'type': instance.type,
      'description': instance.description,
    };
