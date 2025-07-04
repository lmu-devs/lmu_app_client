// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'release_notes_highlight_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReleaseNotesHighlightDto _$ReleaseNotesHighlightDtoFromJson(
        Map<String, dynamic> json) =>
    ReleaseNotesHighlightDto(
      emoji: json['emoji'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$ReleaseNotesHighlightDtoToJson(
        ReleaseNotesHighlightDto instance) =>
    <String, dynamic>{
      'emoji': instance.emoji,
      'title': instance.title,
      'description': instance.description,
    };
