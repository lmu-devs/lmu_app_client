// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taste_profile_label.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TasteProfileLabel _$TasteProfileLabelFromJson(Map<String, dynamic> json) =>
    TasteProfileLabel(
      enumCategory: json['enum_category'] as String,
      name: json['name'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => TasteProfileLabelItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TasteProfileLabelToJson(TasteProfileLabel instance) =>
    <String, dynamic>{
      'enum_category': instance.enumCategory,
      'name': instance.name,
      'items': instance.items,
    };
