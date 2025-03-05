// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sports_favorites.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SportsFavorites _$SportsFavoritesFromJson(Map<String, dynamic> json) => SportsFavorites(
      category: json['category'] as String,
      favorites: (json['favorites'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$SportsFavoritesToJson(SportsFavorites instance) => <String, dynamic>{
      'category': instance.category,
      'favorites': instance.favorites,
    };
