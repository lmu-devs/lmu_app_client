// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_rating_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieRatingModel _$MovieRatingModelFromJson(Map<String, dynamic> json) => MovieRatingModel(
      source: json['source'] as String,
      normalizedRating: (json['normalized_rating'] as num).toDouble(),
      rawRating: json['raw_rating'] as String,
    );

Map<String, dynamic> _$MovieRatingModelToJson(MovieRatingModel instance) => <String, dynamic>{
      'source': instance.source,
      'normalized_rating': instance.normalizedRating,
      'raw_rating': instance.rawRating,
    };
