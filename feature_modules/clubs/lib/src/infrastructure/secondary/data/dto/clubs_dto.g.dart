// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clubs_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClubsDto _$ClubsDtoFromJson(Map<String, dynamic> json) => ClubsDto(
      clubCategories: (json['club_categories'] as List<dynamic>)
          .map((e) => ClubCategoryDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      clubs: (json['clubs'] as List<dynamic>)
          .map((e) => ClubDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ClubsDtoToJson(ClubsDto instance) => <String, dynamic>{
      'club_categories':
          instance.clubCategories.map((e) => e.toJson()).toList(),
      'clubs': instance.clubs.map((e) => e.toJson()).toList(),
    };
