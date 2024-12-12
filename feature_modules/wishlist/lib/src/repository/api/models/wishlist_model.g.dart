// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WishlistModel _$WishlistModelFromJson(Map<String, dynamic> json) =>
    WishlistModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      status: json['status'] as String,
      releaseDate: json['release_date'] as String,
      prototypeUrl: json['prototype_url'] as String,
      ratingModel: RatingModel.fromJson(json['rating'] as Map<String, dynamic>),
      imageModels: (json['images'] as List<dynamic>)
          .map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );

Map<String, dynamic> _$WishlistModelToJson(WishlistModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'status': instance.status,
      'release_date': instance.releaseDate,
      'prototype_url': instance.prototypeUrl,
      'rating': instance.ratingModel,
      'images': instance.imageModels,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
