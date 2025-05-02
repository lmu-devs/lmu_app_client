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
    required this.contact,
    required this.openingHours,
    required this.services,
    required this.equipment,
    required this.subjects,
    required this.rating,
  });

  final String id;
  final String name;
  final String hash;
  final String url;
  final List<ImageModel> images;
  final LocationModel location;
  final ContactModel contact;
  @JsonKey(name: 'opening_hours')
  final OpeningHoursModel openingHours;
  final List<ServiceModel> services;
  final List<EquipmentModel> equipment;
  @JsonKey(name: 'subject_areas')
  final List<String> subjects;
  final RatingModel rating;

  factory LibraryModel.fromJson(Map<String, dynamic> json) => _$LibraryModelFromJson(json);

  Map<String, dynamic> toJson() => _$LibraryModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        hash,
        url,
        images,
        location,
        contact,
        openingHours,
        services,
        equipment,
        subjects,
        rating,
      ];
}
