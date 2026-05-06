// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClubDto _$ClubDtoFromJson(Map<String, dynamic> json) => ClubDto(
      id: json['id'] as String,
      universityId: json['university_id'] as String?,
      type: $enumDecode(_$ClubTypeEnumMap, json['type']),
      title: json['title'] as String,
      description: json['description'] as String,
      category: $enumDecode(_$ClubCategoryTypeEnumMap, json['category']),
      logoUrl: json['logo_url'] as String?,
      content: json['content'] as String?,
      url: json['url'] as String?,
      email: json['email'] as String?,
      instagramUrl: json['instagram_url'] as String?,
      linkedinUrl: json['linkedin_url'] as String?,
    );

Map<String, dynamic> _$ClubDtoToJson(ClubDto instance) => <String, dynamic>{
      'id': instance.id,
      'university_id': instance.universityId,
      'type': _$ClubTypeEnumMap[instance.type]!,
      'title': instance.title,
      'description': instance.description,
      'category': _$ClubCategoryTypeEnumMap[instance.category]!,
      'logo_url': instance.logoUrl,
      'content': instance.content,
      'url': instance.url,
      'email': instance.email,
      'instagram_url': instance.instagramUrl,
      'linkedin_url': instance.linkedinUrl,
    };

const _$ClubTypeEnumMap = {
  ClubType.fachschaft: 'FS',
  ClubType.hochschulgruppe: 'HG',
  ClubType.referat: 'RT',
  ClubType.verein: 'VN',
};

const _$ClubCategoryTypeEnumMap = {
  ClubCategoryType.academic: 'ACADEMIC',
  ClubCategoryType.artCulture: 'ART_CULTURE',
  ClubCategoryType.leisure: 'LEISURE',
  ClubCategoryType.sport: 'SPORT',
  ClubCategoryType.careerNetworking: 'CAREER_NETWORKING',
  ClubCategoryType.international: 'INTERNATIONAL',
};
