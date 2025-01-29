import 'package:cinema/src/repository/api/models/movie/trailer_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'movie_rating_model.dart';
import 'poster_model.dart';

part 'movie_model.g.dart';

@JsonSerializable()
class MovieModel extends Equatable {
  const MovieModel({
    required this.id,
    required this.title,
    this.tagline,
    this.overview,
    this.releaseYear,
    this.budget,
    required this.poster,
    this.backdrop,
    required this.runtime,
    required this.genres,
    required this.ratings,
    required this.trailers,
  });

  final String id;
  final String title;
  final String? tagline;
  final String? overview;
  @JsonKey(name: 'release_year')
  final String? releaseYear;
  final int? budget;
  final PosterModel? poster;
  final PosterModel? backdrop;
  final int? runtime;
  final List<String> genres;
  final List<MovieRatingModel> ratings;
  final List<TrailerModel> trailers;

  @override
  List<Object?> get props => [
    id,
    title,
    tagline,
    overview,
    releaseYear,
    budget,
    poster,
    backdrop,
    runtime,
    genres,
    ratings,
    trailers,
  ];

  factory MovieModel.fromJson(Map<String, dynamic> json) => _$MovieModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieModelToJson(this);
}