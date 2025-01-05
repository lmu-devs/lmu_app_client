// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taste_profile_save_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TasteProfileStateModel _$TasteProfileStateModelFromJson(Map<String, dynamic> json) => TasteProfileStateModel(
      isActive: json['isActive'] as bool,
      selectedPresets: (json['selectedPresets'] as List<dynamic>).map((e) => e as String).toSet(),
      excludedLabels: (json['excludedLabels'] as List<dynamic>).map((e) => e as String).toSet(),
    );

Map<String, dynamic> _$TasteProfileStateModelToJson(TasteProfileStateModel instance) => <String, dynamic>{
      'isActive': instance.isActive,
      'selectedPresets': instance.selectedPresets.toList(),
      'excludedLabels': instance.excludedLabels.toList(),
    };
