import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../util/cinema_type.dart';
import 'cinema_location_model.dart';
import 'description_model.dart';

part 'cinema_model.g.dart';

@JsonSerializable()
class CinemaModel extends Equatable {
  const CinemaModel({
    required this.id,
    required this.title,
    required this.descriptions,
    required this.externalLink,
    required this.instagramLink,
    required this.cinemaLocation,
  });

  final String id;
  final String title;
  final List<DescriptionModel> descriptions;
  @JsonKey(name: 'external_link')
  final String externalLink;
  @JsonKey(name: 'instagram_link')
  final String instagramLink;
  @JsonKey(name: 'location')
  final CinemaLocationModel cinemaLocation;

  @JsonKey(includeFromJson: false, includeToJson: false)
  CinemaType get type => CinemaTypeMapper.fromString(id);

  @override
  List<Object> get props => [
    id,
    type,
    title,
    descriptions,
    externalLink,
    instagramLink,
    cinemaLocation,
  ];

  factory CinemaModel.fromJson(Map<String, dynamic> json) => _$CinemaModelFromJson(json);

  Map<String, dynamic> toJson() => _$CinemaModelToJson(this);
}
