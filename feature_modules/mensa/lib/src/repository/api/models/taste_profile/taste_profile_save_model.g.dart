// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taste_profile_save_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TasteProfileStateModel _$TasteProfileStateModelFromJson(Map<String, dynamic> json) => TasteProfileStateModel(
      isActive: json['isActive'] as bool,
      selectedAllergiesPresets: (json['selectedPresets'] as List<dynamic>).map((e) => e as String).toSet(),
      selectedPreferencePreset: json['selectedPreferencePreset'] as String?,
      excludedLabels: (json['excludedLabels'] as List<dynamic>).map((e) => e as String).toSet(),
    );

Map<String, dynamic> _$TasteProfileStateModelToJson(TasteProfileStateModel instance) => <String, dynamic>{
      'isActive': instance.isActive,
      'selectedPresets': instance.selectedAllergiesPresets.toList(),
      'selectedPreferencePreset': instance.selectedPreferencePreset,
      'excludedLabels': instance.excludedLabels.toList(),
    };
