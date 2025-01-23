import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'cinema_location_model.dart';
import 'description_model.dart';

part 'cinema_model.g.dart';

@JsonSerializable()
class CinemaModel extends Equatable {
  const CinemaModel({
    required this.id,
    required this.title,
    required this.descriptionModels,
    required this.externalLink,
    required this.instagramLink,
    required this.cinemaLocationModel,
  });

  final String id;
  final String title;
  @JsonKey(name: 'descriptions')
  final List<DescriptionModel> descriptionModels;
  @JsonKey(name: 'external_link')
  final String externalLink;
  @JsonKey(name: 'instagram_link')
  final String instagramLink;
  @JsonKey(name: 'location')
  final CinemaLocationModel cinemaLocationModel;

  @override
  List<Object> get props => [
    id,
    title,
    descriptionModels,
    externalLink,
    instagramLink,
    cinemaLocationModel,
  ];

  factory CinemaModel.fromJson(Map<String, dynamic> json) => _$CinemaModelFromJson(json);

  Map<String, dynamic> toJson() => _$CinemaModelToJson(this);
}