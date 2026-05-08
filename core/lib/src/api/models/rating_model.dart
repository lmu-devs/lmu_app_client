import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rating_model.g.dart';

@JsonSerializable()
class RatingModel extends Equatable {
  const RatingModel({
    required this.likeCount,
    this.isLiked = false,
  });

  factory RatingModel.placeholder() => const RatingModel(likeCount: -1);

  factory RatingModel.fromJson(Map<String, dynamic> json) => _$RatingModelFromJson(json);

  @JsonKey(name: 'like_count')
  final int likeCount;
  @JsonKey(name: 'is_liked')
  final bool isLiked;

  Map<String, dynamic> toJson() => _$RatingModelToJson(this);

  @override
  List<Object?> get props => [
        likeCount,
        isLiked,
      ];
}
