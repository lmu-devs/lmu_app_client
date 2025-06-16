import 'package:core/api.dart';
import 'package:core_routes/wishlist.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../util/util.dart';

part 'wishlist_model.g.dart';

@JsonSerializable()
class WishlistModel extends RWishlistModel {
  const WishlistModel({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.status,
    this.releaseDate,
    this.prototypeUrl,
    required this.ratingModel,
    required this.imageModels,
    required this.updatedAt,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) => _$WishlistModelFromJson(json);

  final String id;
  final String title;
  final String description;
  final String content;
  final WishlistStatus status;
  @JsonKey(name: 'release_date')
  final String? releaseDate;
  @JsonKey(name: 'prototype_url')
  final String? prototypeUrl;
  @JsonKey(name: 'rating')
  final RatingModel ratingModel;
  @JsonKey(name: 'images')
  final List<ImageModel> imageModels;
  @JsonKey(name: 'date_updated')
  final String updatedAt;

  Map<String, dynamic> toJson() => _$WishlistModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        content,
        status,
        releaseDate,
        prototypeUrl,
        ratingModel,
        imageModels,
        updatedAt,
      ];
}
