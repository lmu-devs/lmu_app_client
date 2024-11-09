// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taste_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TasteProfileModel _$TasteProfileModelFromJson(Map<String, dynamic> json) =>
    TasteProfileModel(
      version: (json['version'] as num).toInt(),
      presets: (json['presets'] as List<dynamic>)
          .map((e) => TasteProfilePreset.fromJson(e as Map<String, dynamic>))
          .toList(),
      sortedLabels: (json['sorted_labels'] as List<dynamic>)
          .map((e) => TasteProfileLabel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TasteProfileModelToJson(TasteProfileModel instance) =>
    <String, dynamic>{
      'version': instance.version,
      'presets': instance.presets,
      'sorted_labels': instance.sortedLabels,
    };
