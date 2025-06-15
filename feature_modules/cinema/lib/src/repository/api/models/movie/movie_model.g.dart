// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) => MovieModel(
      id: json['id'] as String,
      title: json['title'] as String,
      tagline: json['tagline'] as String?,
      overview: json['overview'] as String?,
      releaseYear: json['release_year'] as String?,
      budget: (json['budget'] as num?)?.toInt(),
      poster: json['poster'] == null ? null : PosterModel.fromJson(json['poster'] as Map<String, dynamic>),
      backdrop: json['backdrop'] == null ? null : PosterModel.fromJson(json['backdrop'] as Map<String, dynamic>),
      runtime: (json['runtime'] as num?)?.toInt(),
      genres: (json['genres'] as List<dynamic>).map((e) => e as String).toList(),
      ratings:
          (json['ratings'] as List<dynamic>).map((e) => MovieRatingModel.fromJson(e as Map<String, dynamic>)).toList(),
      trailers:
          (json['trailers'] as List<dynamic>).map((e) => TrailerModel.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$MovieModelToJson(MovieModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'tagline': instance.tagline,
      'overview': instance.overview,
      'release_year': instance.releaseYear,
      'budget': instance.budget,
      'poster': instance.poster,
      'backdrop': instance.backdrop,
      'runtime': instance.runtime,
      'genres': instance.genres,
      'ratings': instance.ratings,
      'trailers': instance.trailers,
    };
