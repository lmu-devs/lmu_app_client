// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taste_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TasteProfileModel _$TasteProfileModelFromJson(Map<String, dynamic> json) => TasteProfileModel(
      allergiesPresets: (json['alergies_presets'] as List<dynamic>)
          .map((e) => TasteProfilePreset.fromJson(e as Map<String, dynamic>))
          .toList(),
      preferencesPresets: (json['preferences_presets'] as List<dynamic>)
          .map((e) => TasteProfilePreset.fromJson(e as Map<String, dynamic>))
          .toList(),
      sortedLabels: (json['sorted_labels'] as List<dynamic>)
          .map((e) => TasteProfileLabel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TasteProfileModelToJson(TasteProfileModel instance) => <String, dynamic>{
      'alergies_presets': instance.allergiesPresets,
      'preferences_presets': instance.preferencesPresets,
      'sorted_labels': instance.sortedLabels,
    };
