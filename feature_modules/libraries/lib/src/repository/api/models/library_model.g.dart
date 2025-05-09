// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LibraryModel _$LibraryModelFromJson(Map<String, dynamic> json) => LibraryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      hash: json['hash'] as String,
      url: json['url'] as String,
      images: (json['images'] as List<dynamic>)
          .map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      location:
          LocationModel.fromJson(json['location'] as Map<String, dynamic>),
      phones: (json['phones'] as List<dynamic>?)
          ?.map((e) => PhoneModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      areas: (json['areas'] as List<dynamic>)
          .map((e) => AreaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      services: (json['services'] as List<dynamic>)
          .map((e) => ServiceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      equipment: (json['equipment'] as List<dynamic>)
          .map((e) => EquipmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      subjects: (json['subject_areas'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      rating: RatingModel.fromJson(json['rating'] as Map<String, dynamic>),
      externalUrl: json['external_url'] as String?,
      reservationUrl: json['reservation_url'] as String?,
    );

Map<String, dynamic> _$LibraryModelToJson(LibraryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'hash': instance.hash,
      'url': instance.url,
      'external_url': instance.externalUrl,
      'reservation_url': instance.reservationUrl,
      'images': instance.images,
      'location': instance.location,
      'phones': instance.phones,
      'areas': instance.areas,
      'services': instance.services,
      'equipment': instance.equipment,
      'subject_areas': instance.subjects,
      'rating': instance.rating,
    };
