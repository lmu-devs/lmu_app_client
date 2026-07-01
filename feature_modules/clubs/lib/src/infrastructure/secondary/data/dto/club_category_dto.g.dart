// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_category_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClubCategoryDto _$ClubCategoryDtoFromJson(Map<String, dynamic> json) =>
    ClubCategoryDto(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      emoji: json['emoji'] as String,
      clubIds:
          (json['club_ids'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ClubCategoryDtoToJson(ClubCategoryDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'emoji': instance.emoji,
      'club_ids': instance.clubIds,
    };
