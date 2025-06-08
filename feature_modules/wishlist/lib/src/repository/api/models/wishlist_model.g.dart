// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WishlistModel _$WishlistModelFromJson(Map<String, dynamic> json) => WishlistModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      content: json['content'] as String,
      status: $enumDecode(_$WishlistStatusEnumMap, json['status']),
      releaseDate: json['release_date'] as String?,
      prototypeUrl: json['prototype_url'] as String?,
      ratingModel: RatingModel.fromJson(json['rating'] as Map<String, dynamic>),
      imageModels:
          (json['images'] as List<dynamic>).map((e) => ImageModel.fromJson(e as Map<String, dynamic>)).toList(),
      updatedAt: json['date_updated'] as String,
    );

Map<String, dynamic> _$WishlistModelToJson(WishlistModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'content': instance.content,
      'status': _$WishlistStatusEnumMap[instance.status]!,
      'release_date': instance.releaseDate,
      'prototype_url': instance.prototypeUrl,
      'rating': instance.ratingModel,
      'images': instance.imageModels,
      'date_updated': instance.updatedAt,
    };

const _$WishlistStatusEnumMap = {
  WishlistStatus.none: 'NONE',
  WishlistStatus.hidden: 'HIDDEN',
  WishlistStatus.development: 'DEVELOPMENT',
  WishlistStatus.beta: 'BETA',
  WishlistStatus.done: 'DONE',
};
