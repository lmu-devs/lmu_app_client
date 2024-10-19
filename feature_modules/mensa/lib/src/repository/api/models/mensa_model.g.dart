// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mensa_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MensaModel _$MensaModelFromJson(Map<String, dynamic> json) => MensaModel(
      canteenId: json['id'] as String,
      name: json['name'] as String,
      location:
          MensaLocation.fromJson(json['location'] as Map<String, dynamic>),
      ratingModel: RatingModel.fromJson(json['rating'] as Map<String, dynamic>),
      openingHours: (json['opening_hours'] as List<dynamic>)
          .map((e) => MensaOpeningHours.fromJson(e as Map<String, dynamic>))
          .toList(),
      images: (json['images'] as List<dynamic>)
          .map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MensaModelToJson(MensaModel instance) =>
    <String, dynamic>{
      'id': instance.canteenId,
      'name': instance.name,
      'location': instance.location,
      'rating': instance.ratingModel,
      'opening_hours': instance.openingHours,
      'images': instance.images,
    };
