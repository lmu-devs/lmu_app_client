import 'package:core/api.dart';
import 'package:core_routes/wishlist.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../util/util.dart';

part 'wishlist_model.g.dart';

@JsonSerializable()
class WishlistModel extends RWishlistModel {
  final int id;
  final String title;
  final String description;
  @JsonKey(name: 'description_short')
  final String descriptionShort;
  final WishlistStatus status;
  @JsonKey(name: 'release_date')
  final String releaseDate;
  @JsonKey(name: 'prototype_url')
  final String prototypeUrl;
  @JsonKey(name: 'rating')
  final RatingModel ratingModel;
  @JsonKey(name: 'images')
  final List<ImageModel> imageModels;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  const WishlistModel({
    required this.id,
    required this.title,
    required this.description,
    required this.descriptionShort,
    required this.status,
    required this.releaseDate,
    required this.prototypeUrl,
    required this.ratingModel,
    required this.imageModels,
    required this.createdAt,
    required this.updatedAt,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) => _$WishlistModelFromJson(json);

  Map<String, dynamic> toJson() => _$WishlistModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        descriptionShort,
        status,
        releaseDate,
        prototypeUrl,
        ratingModel,
        imageModels,
        createdAt,
        updatedAt,
      ];
}
