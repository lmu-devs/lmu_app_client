// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taste_profile_label_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TasteProfileLabelItem _$TasteProfileLabelItemFromJson(
        Map<String, dynamic> json) =>
    TasteProfileLabelItem(
      enumName: json['enum_name'] as String,
      text: Map<String, String>.from(json['text'] as Map),
      emojiAbbreviation: json['emoji_abbreviation'] as String?,
      textAbbreviation: json['text_abbreviation'] as String?,
    );

Map<String, dynamic> _$TasteProfileLabelItemToJson(
        TasteProfileLabelItem instance) =>
    <String, dynamic>{
      'enum_name': instance.enumName,
      'text': instance.text,
      'emoji_abbreviation': instance.emojiAbbreviation,
      'text_abbreviation': instance.textAbbreviation,
    };
