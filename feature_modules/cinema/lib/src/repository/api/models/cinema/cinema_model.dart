import 'package:core/api.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../util/cinema_type.dart';
import 'description_model.dart';

part 'cinema_model.g.dart';

@JsonSerializable()
class CinemaModel extends Equatable {
  const CinemaModel({
    required this.id,
    required this.title,
    required this.images,
    required this.descriptions,
    required this.externalLink,
    required this.instagramLink,
    required this.location,
  });

  final String id;
  final String title;
  final List<ImageModel>? images;
  final List<DescriptionModel> descriptions;
  @JsonKey(name: 'external_link')
  final String externalLink;
  @JsonKey(name: 'instagram_link')
  final String instagramLink;
  final LocationModel location;

  @JsonKey(includeFromJson: false, includeToJson: false)
  CinemaType get type => CinemaTypeMapper.fromString(id);

  @override
  List<Object> get props => [
    id,
    type,
    title,
    images ?? [],
    descriptions,
    externalLink,
    instagramLink,
    location,
  ];

  factory CinemaModel.fromJson(Map<String, dynamic> json) => _$CinemaModelFromJson(json);

  Map<String, dynamic> toJson() => _$CinemaModelToJson(this);
}
