import 'package:core/api.dart';
import 'package:core_routes/libraries.dart';
import 'package:json_annotation/json_annotation.dart';

import './models.dart';

part 'library_model.g.dart';

@JsonSerializable()
class LibraryModel extends RLibraryModel {
  const LibraryModel({
    required this.id,
    required this.name,
    required this.hash,
    required this.url,
    required this.images,
    required this.location,
    required this.phones,
    required this.areas,
    required this.services,
    required this.equipment,
    required this.subjects,
    required this.rating,
    this.externalUrl,
    this.reservationUrl,
  });

  factory LibraryModel.fromJson(Map<String, dynamic> json) => _$LibraryModelFromJson(json);

  final String id;
  final String name;
  final String hash;
  final String url;
  @JsonKey(name: 'external_url')
  final String? externalUrl;
  @JsonKey(name: 'reservation_url')
  final String? reservationUrl;
  final List<ImageModel> images;
  final LocationModel location;
  final List<PhoneModel>? phones;
  final List<AreaModel> areas;
  final List<ServiceModel> services;
  final List<EquipmentModel> equipment;
  @JsonKey(name: 'subject_areas')
  final List<String> subjects;
  final RatingModel rating;

  Map<String, dynamic> toJson() => _$LibraryModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        hash,
        url,
        externalUrl,
        reservationUrl,
        images,
        location,
        phones,
        areas,
        services,
        equipment,
        subjects,
        rating,
      ];
}
