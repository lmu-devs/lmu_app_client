// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cinema_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CinemaModel _$CinemaModelFromJson(Map<String, dynamic> json) => CinemaModel(
      id: json['id'] as String,
      title: json['title'] as String,
      images: (json['images'] as List<dynamic>?)?.map((e) => ImageModel.fromJson(e as Map<String, dynamic>)).toList(),
      descriptions: (json['descriptions'] as List<dynamic>)
          .map((e) => DescriptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      externalLink: json['external_link'] as String,
      instagramLink: json['instagram_link'] as String,
      location: LocationModel.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CinemaModelToJson(CinemaModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'images': instance.images,
      'descriptions': instance.descriptions,
      'external_link': instance.externalLink,
      'instagram_link': instance.instagramLink,
      'location': instance.location,
    };
