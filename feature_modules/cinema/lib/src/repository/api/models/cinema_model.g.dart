// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cinema_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CinemaModel _$CinemaModelFromJson(Map<String, dynamic> json) => CinemaModel(
      id: json['id'] as String,
      title: json['title'] as String,
      descriptionModels: (json['descriptions'] as List<dynamic>)
          .map((e) => DescriptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      externalLink: json['external_link'] as String,
      instagramLink: json['instagram_link'] as String,
      cinemaLocationModel: CinemaLocationModel.fromJson(
          json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CinemaModelToJson(CinemaModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'descriptions': instance.descriptionModels,
      'external_link': instance.externalLink,
      'instagram_link': instance.instagramLink,
      'location': instance.cinemaLocationModel,
    };
