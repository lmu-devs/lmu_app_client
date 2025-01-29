import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_rating_model.g.dart';

@JsonSerializable()
class MovieRatingModel extends Equatable {
  const MovieRatingModel({
    required this.source,
    required this.normalizedRating,
    required this.rawRating,
  });

  final String source;
  @JsonKey(name: 'normalized_rating')
  final double normalizedRating;
  @JsonKey(name: 'raw_rating')
  final String rawRating;

  @override
  List<Object?> get props => [
        source,
        normalizedRating,
        rawRating,
      ];

  factory MovieRatingModel.fromJson(Map<String, dynamic> json) => _$MovieRatingModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieRatingModelToJson(this);
}
