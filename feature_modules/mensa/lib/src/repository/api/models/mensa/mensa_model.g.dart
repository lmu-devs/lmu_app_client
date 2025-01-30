// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mensa_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MensaModel _$MensaModelFromJson(Map<String, dynamic> json) => MensaModel(
      canteenId: json['id'] as String,
      name: json['name'] as String,
      location: MensaLocation.fromJson(json['location'] as Map<String, dynamic>),
      ratingModel: RatingModel.fromJson(json['rating'] as Map<String, dynamic>),
      openingHours: MensaOpeningHours.fromJson(json['opening_hours'] as Map<String, dynamic>),
      images: (json['images'] as List<dynamic>).map((e) => ImageModel.fromJson(e as Map<String, dynamic>)).toList(),
      type: $enumDecode(_$MensaTypeEnumMap, json['type']),
      status: MensaStatus.fromJson(json['status'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MensaModelToJson(MensaModel instance) => <String, dynamic>{
      'id': instance.canteenId,
      'name': instance.name,
      'location': instance.location,
      'rating': instance.ratingModel,
      'opening_hours': instance.openingHours,
      'images': instance.images,
      'type': _$MensaTypeEnumMap[instance.type]!,
      'status': instance.status,
    };

const _$MensaTypeEnumMap = {
  MensaType.mensa: 'MENSA',
  MensaType.stuBistro: 'STUBISTRO',
  MensaType.stuCafe: 'STUCAFE',
  MensaType.lounge: 'STULOUNGE',
  MensaType.cafeBar: 'ESPRESSOBAR',
  MensaType.none: 'NONE',
};
