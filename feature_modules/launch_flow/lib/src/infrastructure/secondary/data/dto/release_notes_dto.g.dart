// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'release_notes_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RelaseNotesDto _$RelaseNotesDtoFromJson(Map<String, dynamic> json) =>
    RelaseNotesDto(
      highlights: (json['highlights'] as List<dynamic>)
          .map((e) =>
              ReleaseNotesHighlightDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      showPrivacyPolicy: json['show_privacy_policy'] as bool? ?? false,
    );

Map<String, dynamic> _$RelaseNotesDtoToJson(RelaseNotesDto instance) =>
    <String, dynamic>{
      'highlights': instance.highlights,
      'show_privacy_policy': instance.showPrivacyPolicy,
    };
