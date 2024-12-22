import 'package:core/models.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../util/util.dart';

part 'wishlist_model.g.dart';

@JsonSerializable()
class WishlistModel extends Equatable {
  final int id;
  final String title;
  final String description;
  @JsonKey(fromJson: _statusFromJson)
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
    required this.status,
    required this.releaseDate,
    required this.prototypeUrl,
    required this.ratingModel,
    required this.imageModels,
    required this.createdAt,
    required this.updatedAt,
  });

  static WishlistStatus _statusFromJson(String status) => WishlistStatusMapper.fromString(status);

  factory WishlistModel.fromJson(Map<String, dynamic> json) => _$WishlistModelFromJson(json);

  Map<String, dynamic> toJson() => _$WishlistModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        status,
        releaseDate,
        prototypeUrl,
        ratingModel,
        imageModels,
        createdAt,
        updatedAt,
      ];
}
