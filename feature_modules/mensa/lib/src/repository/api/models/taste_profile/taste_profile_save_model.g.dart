// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taste_profile_save_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TasteProfileSaveModel _$TasteProfileSaveModelFromJson(Map<String, dynamic> json) => TasteProfileSaveModel(
      isActive: json['isActive'] as bool,
      selectedPresets: (json['selectedPresets'] as List<dynamic>).map((e) => e as String).toSet(),
      excludedLabels: (json['excludedLabels'] as List<dynamic>).map((e) => e as String).toSet(),
    );

Map<String, dynamic> _$TasteProfileSaveModelToJson(TasteProfileSaveModel instance) => <String, dynamic>{
      'isActive': instance.isActive,
      'selectedPresets': instance.selectedPresets.toList(),
      'excludedLabels': instance.excludedLabels.toList(),
    };
