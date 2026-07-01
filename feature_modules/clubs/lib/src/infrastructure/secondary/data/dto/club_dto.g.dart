// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClubDto _$ClubDtoFromJson(Map<String, dynamic> json) => ClubDto(
      id: json['id'] as String,
      universityId: json['university_id'] as String?,
      type: json['type'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      category: $enumDecode(_$ClubCategoryTypeEnumMap, json['category']),
      image: json['image'] == null ? null : ImageModel.fromJson(json['image'] as Map<String, dynamic>),
      content: json['content'] as String?,
      url: json['url'] as String?,
      email: json['email'] as String?,
      instagramUrl: json['instagram_url'] as String?,
      linkedinUrl: json['linkedin_url'] as String?,
      foundingYear: (json['founding_year'] as num?)?.toInt(),
      location: json['location'] == null ? null : LocationModel.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClubDtoToJson(ClubDto instance) => <String, dynamic>{
      'id': instance.id,
      'university_id': instance.universityId,
      'type': instance.type,
      'title': instance.title,
      'description': instance.description,
      'category': _$ClubCategoryTypeEnumMap[instance.category]!,
      'image': instance.image,
      'content': instance.content,
      'url': instance.url,
      'email': instance.email,
      'instagram_url': instance.instagramUrl,
      'linkedin_url': instance.linkedinUrl,
      'founding_year': instance.foundingYear,
      'location': instance.location,
    };

const _$ClubCategoryTypeEnumMap = {
  ClubCategoryType.academic: 'ACADEMIC',
  ClubCategoryType.artCulture: 'ART_CULTURE',
  ClubCategoryType.leisure: 'LEISURE',
  ClubCategoryType.sport: 'SPORT',
  ClubCategoryType.careerNetworking: 'CAREER',
  ClubCategoryType.international: 'INTERNATIONAL',
};
