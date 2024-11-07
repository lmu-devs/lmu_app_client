// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taste_profile_preset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TasteProfilePreset _$TasteProfilePresetFromJson(Map<String, dynamic> json) =>
    TasteProfilePreset(
      enumName: json['enum_name'] as String,
      text: Map<String, String>.from(json['text'] as Map),
      emojiAbbreviation: json['emoji_abbreviation'] as String?,
      exclude:
          (json['exclude'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$TasteProfilePresetToJson(TasteProfilePreset instance) =>
    <String, dynamic>{
      'enum_name': instance.enumName,
      'text': instance.text,
      'emoji_abbreviation': instance.emojiAbbreviation,
      'exclude': instance.exclude,
    };
